module Validation
  module Rules
    def validates_required(data, field)
      !([nil, '', [], {}].include? data[field])
    end

    def validates_match(data, field, regex) 
      data[field] =~ Regexp.new(regex)
    end
  end
end
