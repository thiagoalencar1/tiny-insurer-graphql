# frozen_string_literal: true

module Types
  class VehicleType < Types::BaseObject
    description 'Vehicle'

    field :id,      ID,       null: false
    field :plate,   String,   null: false
    field :brand,   String,   null: false
    field :model,   String,   null: false
    field :year,    Integer,  null: false
  end
end
