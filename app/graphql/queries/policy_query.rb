module Queries
  class PolicyQuery < Queries::BaseQuery
    type Types::PolicyType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      uri = URI("http://policy-service:3001/v1/policies/#{id}")
      response = Net::HTTP.get_response(uri.host, uri.path, uri.port)
      JSON.parse(response.body)
    end
  end
end
