module Queries
  class InsuredsQuery < Queries::BaseQuery
    type [Types::InsuredType], null: false

    def resolve
      uri = URI("http://policy-service:3001/v1/insureds")
      response = Net::HTTP.get_response(uri.host, uri.path, uri.port)
      JSON.parse(response.body)
    end
  end
end
