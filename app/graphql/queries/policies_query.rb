module Queries
  class PoliciesQuery < Queries::BaseQuery
    type [Types::PolicyType], null: false

    def resolve
      uri = URI("http://policy-service:3001/policies")
      response = Net::HTTP.get_response(uri.host, uri.path, uri.port)
      JSON.parse(response.body)
    rescue StandardError => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end