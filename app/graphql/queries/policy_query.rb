module Queries
  class PolicyQuery < Queries::BaseQuery
    type Types::PolicyType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      JSON.parse(policy_request.body)
    end

    def policy_request
      token = context[:token]
      headers = {'Authorization' => "#{token}", 'Content-Type' => 'application/json'}

      uri = URI("http://policy-service:3001/v1/policies/#{id}")
      conn = Net::HTTP.new(uri.host, uri.port)
      conn.get(uri.path, headers)
    end
  end
end
