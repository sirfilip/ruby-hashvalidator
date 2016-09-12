module Validation
  module Rules
    def validates_required(data, field)
      !([nil, '', [], {}].include? data[field])
    end
  end
end
