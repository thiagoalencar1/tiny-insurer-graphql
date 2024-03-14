# frozen_tring_literal: true

module Queries
  class PoliciesQuery < Queries::BaseQuery
    type [Types::PolicyType], null: false

    def resolve
      uri = URI('http://policy-service:3001/v1/policies')
      response = Net::HTTP.get_response(uri.host, uri.path, uri.port)
      JSON.parse(response.body)
    end
  end
end
