class User < ApplicationRecord
  def self.create_some_items_in_transaction(number = 10, time = 2)
    ApplicationRecord.transaction do
      number.times do |i|
        puts i
        User.create!(
          name: Faker::Name.first_name,
          lastname: Faker::Name.last_name
        )
        sleep(time)
      end
    end
    nil
  end
end
