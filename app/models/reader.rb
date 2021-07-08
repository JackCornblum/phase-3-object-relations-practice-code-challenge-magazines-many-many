class Reader < ActiveRecord::Base
    has_many :subscriptions
    has_many :magazines, through: :subscriptions

    def subscribe(magazine, price)
        Subscription.create(magazine_id: magazine.id, price: price, reader_id: self.id)
    end

    def total_subscription_price
        self.subscriptions.map {|subscription| subscription.price }.sum
    end

    def cancel_subscription(magazine)
        Subscription.where(magazine_id: magazine.id, reader_id: self.id).destroy_all
    end

end