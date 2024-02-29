# frozen_string_literal: true

module Mutations
  class CreatePolicyMutation < Mutations::BaseMutation
    argument :policy, Types::PolicyInputType, required: true

    field :success, String, null: false

    def resolve(policy:)
      conn = Bunny.new(hostname: "rabbitmq", username: "admin", password: "admin").start
      ch = conn.create_channel
      queue = ch.queue("create_policy", durable: true)
      queue.publish(policy.to_json)
      conn.close
      { "success" => "OK" }
    rescue StandardError => e
      raise GraphQL::ExecutionError, e.message
    end
  end
end
