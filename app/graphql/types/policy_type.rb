# frozen_string_literal: true

module Types
  class PolicyType < Types::BaseObject
    description 'Policy'

    field :id,            ID,                 null: false
    field :status,        String,             null: false
    field :payment_id,    String,             null: true
    field :payment_link,  String,             null: true
    field :insured_at,    String,             null: false
    field :insured_until, String,             null: false
    field :insured,       Types::InsuredType, null: false
    field :vehicle,       Types::VehicleType, null: false
  end
end
