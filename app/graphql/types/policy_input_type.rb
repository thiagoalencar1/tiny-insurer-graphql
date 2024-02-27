module Types
  class PolicyInputType < Type::BaseInputObject
    argument :insured_at,     String,           required: true
    argument :insured_until,  String,           required: true
    argument :insured,        InsuredInputType, required: true
    argument :vehicle,        VehicleInputType, required: true
  end
end
