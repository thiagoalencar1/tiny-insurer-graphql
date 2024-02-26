# frozen_string_literal: true

module Types
  class VehicleType < Types::BaseObject
    description 'Vehicle'

    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :id,        ID,       null: false
    field :plate,     String,   null: false
    field :brand,     String,   null: false
    field :model,     String,   null: false
    field :year,      Integer,  null: false
  end
end
