# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'payment_requests#index'

  resources :payment_requests do
    post 'accept_payment_request'
    post 'reject_payment_request'
  end
end
