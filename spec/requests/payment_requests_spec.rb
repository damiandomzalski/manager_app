# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/payment_requests', type: :request do
  let(:valid_attributes) do
    {
      amount: 123,
      currency: 'EUR',
      description: 'some desc',
      status: 0
    }
  end

  describe 'POST /accept_payment_request' do
    it 'publish an event' do
      payment_request = Contractor::PaymentRequest.create! valid_attributes
      expect(Publisher).to(receive(:publish))
      post payment_request_accept_payment_request_url(payment_request)
    end

    it 'redirects to the list of payment requests' do
      payment_request = Contractor::PaymentRequest.create! valid_attributes
      post payment_request_accept_payment_request_url(payment_request)
      expect(response).to redirect_to(root_url)
    end

    it 'change status to accepted' do
      payment_request = Contractor::PaymentRequest.create! valid_attributes
      post payment_request_accept_payment_request_url(payment_request)
      expect(Contractor::PaymentRequest.last.status).to eq('accepted')
    end
  end

  describe 'POST /reject_payment_request' do
    it 'publish an event' do
      payment_request = Contractor::PaymentRequest.create! valid_attributes
      expect(Publisher).to(receive(:publish))
      post payment_request_reject_payment_request_url(payment_request)
    end

    it 'redirects to the list of payment requests' do
      payment_request = Contractor::PaymentRequest.create! valid_attributes
      post payment_request_reject_payment_request_url(payment_request)
      expect(response).to redirect_to(root_url)
    end

    it 'change status to rejected' do
      payment_request = Contractor::PaymentRequest.create! valid_attributes
      post payment_request_reject_payment_request_url(payment_request)
      expect(Contractor::PaymentRequest.last.status).to eq('rejected')
    end
  end
end
