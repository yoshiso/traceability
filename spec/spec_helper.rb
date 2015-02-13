RSpec.configure do |c|

  c.before(:all) do
    if Dir.exist? Traceability.configuration.store_file_path
      FileUtils.remove_entry_secure Traceability.configuration.store_file_path
    end
  end

end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'traceability'
