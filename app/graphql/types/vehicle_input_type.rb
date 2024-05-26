module Types
  class VehicleInputType < Types::BaseInputObject
    argument :plate, String,  required: true
    argument :brand, String,  required: true
    argument :model, String,  required: true
    argument :year,  Integer, required: true
  end
end
