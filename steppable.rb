module Steppable

  extend ActiveSupport::Concern

  included do
    cattr_accessor :step_names
    attr_writer :valid_steps, :current_step
  end

  module ClassMethods
    def step(step_number, step_name)
      self.step_names ||= {}
      self.step_names[step_number] = step_name
    end
  end


  module InstanceMethods
    
    def valid_steps
      @valid_steps || []
    end

    def current_step
      @current_step || 1
    end

    def step_name(step_number)
      self.step_names[step_number]
    end

    def firts_step?(step_number)
      self.current_step == 1
    end

    def last_step?(step_number)
      self.step_names.count == step_number
    end

    def mark_step_as_valid(step_number)
      self.valid_steps = (self.valid_steps << step_number).uniq
    end

    def valid_step?(step_number)
      self.valid_steps.include? step_number
    end

    def steps_count
      self.step_names.count
    end

    def show_step?(step_number)
      self.firts_step? || self.current_step >= step_number
    end

    def increase_current_step(step_number)
      self.current_step = step_number if step_number > self.current_step
    end

  end
end