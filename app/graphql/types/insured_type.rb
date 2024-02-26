# frozen_string_literal: true

module Types
  class InsuredType < Types::BaseObject
    description 'Insured'

    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :id,    ID,     null: false
    field :name,  String, null: false
    field :cpf,   String, null: false
  end
end
