# frozen_string_literal: true

namespace :users do
  desc 'Create users'
  task create: :environment do
    puts "User.count before: #{User.count}"
    User.create_some_items_in_transaction(20, 3)
    puts "User.count after: #{User.count}"
  end
end
