module Resolvers
  class Base < GraphQL::Schema::Resolver
    include ActionPolicy::GraphQL::Behaviour
    include ExecutionErrorResponder
    include TriggerableEvents

    argument_class Types::BaseArgument

    def resolve(**options)
      @options = options
      append_trigger_event(trigger_event) if trigger_event.present?
      fetch_data
    end

    private

    attr_reader :options

    def fetch_data
      raise NotImplementedError
    end

    def current_user
      @current_user ||= context[:current_user]
    end

    def current_company
      @current_company ||= context[:current_company]
    end

    def trigger_event
    end
  end
end
