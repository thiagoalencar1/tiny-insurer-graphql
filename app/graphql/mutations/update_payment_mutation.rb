# frozen_string_literal: true

module Mutations
  class UpdatePaymentMutation < Mutations::BaseMutation
    argument :payment_data, Types::PaymentInputType, required: true

    field :success, String, null: false

    def resolve(payment_data:)
      p '==============='
      p payment_data
      p '==============='
      conn = Bunny.new(hostname: 'tiny-insurer-rabbitmq', username: 'admin', password: 'admin').start
      ch = conn.create_channel
      queue = ch.queue('payment-update', durable: true)
      queue.publish(payment_data.to_json)
      conn.close
      {'success' => 'OK'}
    rescue StandardError => exception
      raise GraphQL::ExecutionError.new(exception.message)
    end
  end
end
