# frozen_string_literal: true

class PaymentRequestsWorker
  include Sneakers::Worker
  from_queue 'manager_app.payment_requests', env: nil

  def work(raw_payment_request)
    parsed_params = JSON.parse(raw_payment_request)

    Contractor::PaymentRequest.where(id: parsed_params['id']).first_or_initialize.tap do |payment_request|
      payment_request.amount = parsed_params['amount']
      payment_request.currency = parsed_params['currency']
      payment_request.description = parsed_params['description']
      payment_request.status = parsed_params['status']
      payment_request.save!
    end

    ack!
  end
end
