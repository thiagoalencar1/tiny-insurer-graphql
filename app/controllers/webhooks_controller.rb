# frozen_string_literal: true

class WebhooksController < ApplicationController
  # include Rails.application.routes.url_helpers

  # server.rb
  #
  # Use this sample code to handle webhook events in your integration.
  #
  # 1) Paste this code into a new file (server.rb)
  #
  # 2) Install dependencies
  #   gem install sinatra
  #   gem install stripe
  #
  # 3) Run the server on http://localhost:4242
  #   ruby server.rb

  # The library needs to be configured with your account's secret key.
  # Ensure the key is kept out of any version control system you might be using.
  # Stripe.api_key = 'sk_test_...'

  # This is your Stripe CLI webhook secret for testing your endpoint locally.
  ENDPOINT_SECRET = 'whsec_IcXAvcyWkUliyCPncX6qddPsxNBIo7hy'
  # set :port, 4242

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
