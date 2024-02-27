module Types
  class PolicyInputType < Types::BaseInputObject
    argument :insured_at,     String,                  required: true
    argument :insured_until,  String,                  required: true
    argument :insured,        Types::InsuredInputType, required: true
    argument :vehicle,        Types::VehicleInputType, required: true
  end
end
