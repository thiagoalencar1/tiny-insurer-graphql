# frozen_string_literal: true

module Types
  class InsuredType < Types::BaseObject
    description 'Insured'

    field :id,    ID,     null: false
    field :name,  String, null: false
    field :cpf,   String, null: false
  end
end
