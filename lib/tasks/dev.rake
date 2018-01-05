
namespace :dev do

  task fake_restaurant: :environment do
    Restaurant.destroy_all

    500.times do |i|

      Restaurant.create!(
        name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample,
        favorites_count: 0,
        like_count: 0,
        )
    end

    puts 'have created fake restaurants'
    puts "now you have #{Restaurant.count} restaurants data"

  end

  task fake_user: :environment do
    User.destroy_all

    User.create!(name:"admin", email: "admin@example.com", password: "password", role: "admin")
    User.create!(name:"guest", email: "guest@email.com", password: "password" ) 

    20.times do |i|
        user_name = FFaker::Name.first_name
        User.create!(
            name: user_name, 
            email: "#{user_name}@email.com",
            password: "password",
            followers_count: 0
        )
    end

    puts "have created fake user"
    puts "now you have #{User.count} user data"
    puts "Default admin created! ( email: admin@example.com, password: password )"
    puts "Default user created! ( email: guest@email.com, password: password )"

  end

  task fake_comment: :environment do
    Comment.destroy_all

    Restaurant.all.each do |restaurant|
        3.times do |i|
            restaurant.comments.create!(
                content: FFaker::Lorem.sentence,
                user: User.all.sample
            )
        end

        puts "have created fake commit"
        puts "now you have #{Comment.count} comment data"
    end
  end  

end