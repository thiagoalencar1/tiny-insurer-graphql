# frozen_string_literal: true

class WebhooksController < ApplicationController
  ENDPOINT_SECRET = ENV.fetch('WEBHOOK_PAYMENT_SECRET', nil)

  def update # rubocop:disable all
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']

    event = Stripe::Webhook.construct_event(
      payload, sig_header, ENDPOINT_SECRET
    )

    # Handle the event
    case event.type
    when 'checkout.session.async_payment_failed'
      session = event.data.object
    when 'checkout.session.async_paymenceeded'
      session = event.data.object
    when 'checkout.session.completed'
      session = event.data.object
      @payment_id = session.id
      @payment_status = session.status
      send_request(payment_update)

      status 200
    when 'checkout.session.expired'
      session = event.data.object
    # ... handle other event types
    else
      puts "Unhandled event type: #{event.type}"
    end

    status 200
  end

  def payment_update
    {
      query: "mutation updatePaymentMutation(
        $payment_id: String!
        $status: String!
      ) {
        updatePayment (
          input: {
            paymentData:{
              paymentId: $payment_id
              status: $status
            }
          }
        ) { success }
      }",
      variables: {
        payment_id: @payment_id,
        status: 'active'
      }
    }
  end

  def send_request(payment_update)
    url = URI('http://localhost:3003/graphql')
    header = {'Content-Type': 'application/json'}
    Net::HTTP.post(url, payment_update.to_json, header)
  end
end
