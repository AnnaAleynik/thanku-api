class OrderCreatedNotificationJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    managers_emails = order.company.managers.pluck(:email)
    ApplicationMailer.order_created(order, managers_emails).deliver_now
  end
end
