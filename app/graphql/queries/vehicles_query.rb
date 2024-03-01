module Queries
  class VehiclesQuery < Queries::BaseQuery
    type [Types::VehicleType], null: false

    def resolve
      uri = URI("http://policy-service:3001/v1/vehicles")
      response = Net::HTTP.get_response(uri.host, uri.path, uri.port)
      JSON.parse(response.body)
    end
  end
end
