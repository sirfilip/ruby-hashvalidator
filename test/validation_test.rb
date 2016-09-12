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
      it 'fails if the field is missing' do 
        v.add_rule('fieldname', 'required', '')
        v.validate({})
        v.wont_be :valid?
      end

      it 'fails if the field is empty' do 
        v.add_rule('fieldname', 'required', '')
        ['', nil, [], {}, 1].each do |value| 
          v.validate({'fieldname' => value})
          v.wont_be :valid?
        end
      end

    end
  end
    
end
