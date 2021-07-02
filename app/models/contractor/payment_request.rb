# frozen_string_literal: true

module Contractor
  class PaymentRequest < ApplicationRecord
    self.table_name = 'contractor_payment_requests'

    enum status: %i[pending accepted rejected]
  end
end
