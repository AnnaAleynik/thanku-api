module Orders
  class Create
    include Interactor::Organizer
    include TransactionalInteractor

    delegate :order, to: :context

    organize Orders::PrepareParams,
             Orders::ChangeProductQuantity,
             Orders::DebitBonus,
             Orders::Save

    after do
      OrderCreatedNotificationJob.perform_later(order.id)
    end
  end
end
