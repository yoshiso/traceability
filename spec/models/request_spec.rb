require 'spec_helper'
require 'traceability/models/request'

describe Traceability::Models::Request do

  it 'has a version number' do
    Traceability::Models::Request.create(id:1)
  end

end
