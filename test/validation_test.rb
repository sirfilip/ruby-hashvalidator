require 'minitest/autorun'
require File.expand_path('../../lib/validation/validation', __FILE__)

describe Validation::Validator do 
  let(:v) { Validation::Validator.new }

  it 'can validate a hash' do
    v.validate({}).must_equal true
  end

  it 'accepts rules for validation' do 
    v.add_rule('fieldname', 'required', 'message')
    v.validate({}).must_equal false
  end

  it 'has errors if validation failed' do 
    v.add_rule('fieldname', 'required', 'message')
    v.validate({})
    v.errors['fieldname'].must_equal ['message']
  end

  describe 'validation rules' do 
    describe 'required' do 
      it 'fails if the field is empty' do 
        v.add_rule('fieldname', 'required', '')
        ['', nil, [], {}].each do |value| 
          v.validate({'fieldname' => value})
          v.wont_be :valid?
        end
      end
    end
    describe 'matches' do
      it 'fails if the field does not match a given format' do 
        v.add_rule('fieldname', "match, \\Aabc\\z", 'fieldname must match "abc"')
        v.validate({'fieldname' => 'abc'}).must_equal true
        v.validate({'fieldname' => 'bcs'}).must_equal false
        v.errors['fieldname'].must_include 'fieldname must match "abc"'
      end
    end
  end
    
end
