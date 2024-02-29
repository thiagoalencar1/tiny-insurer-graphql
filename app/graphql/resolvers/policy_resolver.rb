# frozen_string_literal: true

module Resolvers
  class PolicyResolver < Resolvers::BaseResolver
    type ::Types::PolicyType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      uri = URI("http://policy-service:3001/policies/#{id}")
      response = Net::HTTP.get_response(uri.host, uri.path, uri.port)
      puts response.body
      JSON.parse(response.body)
    rescue StandardError => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
