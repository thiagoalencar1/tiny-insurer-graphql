# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :policy,    resolver: Queries::PolicyQuery
    field :policies,  resolver: Queries::PoliciesQuery
  end
end
