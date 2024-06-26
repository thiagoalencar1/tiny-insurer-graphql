# frozen_string_literal: true

module Mutations
  class CreatePolicyMutation < Mutations::BaseMutation
    argument :policy, Types::PolicyInputType, required: true

    field :success, String, null: false

    def resolve(policy:)
      p '==============='
      p policy
      p '==============='
      conn = Bunny.new(hostname: 'tiny-insurer-rabbitmq', username: 'admin', password: 'admin').start
      ch = conn.create_channel
      queue = ch.queue('create-policy', durable: true)
      queue.publish(policy.to_json)
      conn.close
      {'success' => 'OK'}
    rescue StandardError => exception
      raise GraphQL::ExecutionError.new(exception.message)
    end
  end
end
