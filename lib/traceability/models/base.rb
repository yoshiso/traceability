require 'yaml/store'
require 'digest/md5'
require 'forwardable'

module Traceability

  module Collections
    class Base
      extend Forwardable
      def_delegators :collection, :first, :first!, :last, :each, :map, :to_a, :size, :sort_by, :reverse

      def initialize enumrator
        @collection = enumrator
      end

      def collection
        @collection
      end

    end
  end

  module Models
    class Base


      @@keys = []

        def self.define_accessor attribute
          class_eval <<-EOF
def #{attribute}
  @#{attribute}
end

def #{attribute}= val
  @#{attribute} = val
end
@@keys << :#{attribute}
          EOF
        end
        def self.define_reader attribute
          class_eval <<-EOF
def #{attribute}
  @#{attribute}
end
@@keys << :#{attribute}
          EOF
        end

      define_accessor :created_at
      define_reader   :uid

      def initialize attrs = {}
        self.attributes = attrs
      end

      def uid
         Digest::MD5.hexdigest(hash_key)
      end

      def save!
        self.created_at ||= DateTime.now.to_s
        self.class.store.transaction do
          self.class.store[uid] = attributes
        end
      end
      alias_method :save, :save!

      def destroy!
        self.class.store.transaction do
          self.class.store.delete(uid)
        end
        true
      end
      alias_method :destroy, :destroy!

      def attributes
        Hash[@@keys.map{ |key|
          [key, (self.send key.to_sym)]
        }]
      end

      def attributes= attrs
        filter_attributes(attrs).each do |k,v|
          self.send "#{k.to_s}=".to_sym, v
        end
      end

      class << self
        extend Forwardable
        def_delegators :all, :first, :first!, :last, :each, :map, :to_a, :size

        def create attrs
          self.new(attrs).save!
        end

        def all
          self.store.transaction do
            Traceability::Collections::Base.new(self.store.roots.map{ |k| new(self.store[k]) })
          end
        end

        def find_by options
          result = self.all.to_a
          options.each { |k,v|
            result = result.select{|request| request.send(k) == v }
          }
          result.first
        end

        def truncate
          FileUtils.rm self.store_file_path; true
        end

      end

      protected

        def hash_key
          created_at
        end

      private

        def self.store
          @@store ||= YAML::Store.new self.store_file_path
        end

        def self.store_file_path
          FileUtils.mkdir_p Traceability.configuration.store_file_path unless Dir.exist? Traceability.configuration.store_file_path
          Traceability.configuration.store_file_path + "/#{model_name}.yml"
        end

        def filter_attributes attrs
          attrs.select { |key,_|  @@keys.include?(key) && key != :uid }
        end

        def self.model_name
          self.name.gsub(/::/, '/').
            gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
            gsub(/([a-z\d])([A-Z])/,'\1_\2').
            tr("-", "_").
            downcase.
            split('/').
            slice(2..-1).
            join('/')
        end

    end

  end

  include Models

end