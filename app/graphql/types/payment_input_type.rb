# frozen_string_literal: true

module Types
  class PaymentInputType < Types::BaseInputObject
    argument :status,        String,         required: true
    argument :payment_id,    String,         required: true
  end
end
