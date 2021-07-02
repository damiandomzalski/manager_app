# frozen_string_literal: true

class PaymentRequestsController < ApplicationController
  before_action :set_payment_request, only: %i[accept_payment_request reject_payment_request]

  def index
    @payment_requests = Contractor::PaymentRequest.all
  end

  def accept_payment_request
    if @payment_request.update(status: :accepted)
      Publisher.publish('payment_requests', @payment_request.attributes)
      redirect_to root_path, notice: 'Payment request was successfully accepted.'
    end
  end

  def reject_payment_request
    if @payment_request.update(status: :rejected)
      Publisher.publish('payment_requests', @payment_request.attributes)
      redirect_to root_path, notice: 'Payment request was successfully rejected.'
    end
  end

  private

  def set_payment_request
    @payment_request = Contractor::PaymentRequest.find(params[:payment_request_id])
  end
end
