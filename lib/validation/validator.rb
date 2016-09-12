require File.expand_path('../rules', __FILE__)

module Validation
  class Validator
    include Rules

    attr_reader :rules
    attr_reader :errors

    def initialize
      @rules = {}
      @errors = {}
    end

    def add_rule(field, rule, message)
      @rules[field] ||= []
      @rules[field].push({'rule' => rule, 'message' => message})
    end

    def validate(params)
      reset_errors
      @rules.each do |field, rules|
        rules.each do |rule|
          method, *args = rule['rule'].split(',')
          args = [params, field] + args
          unless send("validates_#{method}", *args)
            @errors[field] ||= []
            @errors[field].push(rule['message'])
          end
        end
      end
      valid?
    end

    def valid?
      @errors.empty?
    end

    def reset_errors
      @errors = {}
    end
  end
end
