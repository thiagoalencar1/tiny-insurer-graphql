# frozen_string_literal: true

module Mutations
  class CreatePolicyMutation < Mutations::BaseMutation
    argument :policy, Types::PolicyInputType, required: true

    field :success, String, null: false

    def resolve(policy:)
      conn = Bunny.new(hostname: "rabbitmq", username: "admin", password: "admin").start
      ch = conn.create_channel
      queue = ch.queue("policy_created", durable: true)
      queue.publish(parse_policy(policy.to_h))
      conn.close
      { "success" => "OK" }
    rescue StandardError => e
      raise GraphQL::ExecutionError, e.message
    end

    private

    def parse_policy(policy)
      {
        insured_at: policy[:insured_at],
        insured_until: policy[:insured_until],
        insured: {
          name: policy[:insured][:name],
          cpf: policy[:insured][:cpf]
        },
        vehicle: {
          plate:policy[:vehicle][:plate],
          brand:policy[:vehicle][:brand],
          model:policy[:vehicle][:model],
          year:policy[:vehicle][:year],
        }
      }.to_json
    end
  end
end
