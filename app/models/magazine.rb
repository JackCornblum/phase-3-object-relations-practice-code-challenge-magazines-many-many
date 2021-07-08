class Magazine < ActiveRecord::Base
    has_many :subscriptions
    has_many :readers, through: :subscriptions

    def email_list
        self.readers.map {|reader| reader.email}.join(";")
    end

    def self.most_popular
       magazine_ids = Subscription.all.map {|subscription| subscription.magazine_id}

       freq = magazine_ids.inject(Hash.new(0)) {|h,v| h[v] += 1; h}
       id = magazine_ids.max_by {|v| freq[v]}
       Magazine.find(id)
    end

end