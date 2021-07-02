# frozen_string_literal: true

class CreateContractorPaymentRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :contractor_payment_requests do |t|
      t.float :amount
      t.string :currency
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
