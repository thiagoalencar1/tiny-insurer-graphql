# frozen_tring_literal: true

module Queries
  class PoliciesQuery < Queries::BaseQuery
    type [Types::PolicyType], null: false

    def resolve
      JSON.parse(policies_request.body)
    end

    def policies_request
      token = context[:token]
      headers = {'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json'}

      uri = URI("http://tiny-insurer-rest:3001/v1/policies")
      conn = Net::HTTP.new(uri.host, uri.port)
      conn.get(uri.path, headers)
    end
  end
end
