# frozen_string_literal: true

require_relative 'config/application'
require 'sneakers/tasks'

Rails.application.load_tasks

namespace :rabbitmq do
  desc 'Setup routing'
  task :setup do
    require 'bunny'

    conn = Bunny.new
    conn.start

    ch = conn.create_channel

    x = ch.fanout('manager_app.payment_requests')

    queue = ch.queue('contractor_app.payment_requests', durable: true)

    queue.bind('manager_app.payment_requests')

    conn.close
  end
end
