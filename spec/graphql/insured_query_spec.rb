# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::PoliciesQuery, type: :graphql do
  # subject(query_result) { MySchema.execute(query, context: context).as_json }
  let(:query) do
    <<~GQL
      query getPolicies{
        policies {
          id
          insuredAt
          insuredUntil
          insured {
            id
            name
            cpf
          }
          vehicle {
            id
            plate
            brand
            model
            year
          }
        }
      }
    GQL
  end

  xit 'is successful' do
    result = execute_graphql(query)

    expect(result).to eq(query)
  end
end
