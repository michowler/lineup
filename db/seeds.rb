User.create(name:"employee",email:"employee@gmail.com",position: "Employee",department: 1,manager_id: 3, private_token: "employee",total_leafe_id:1,remaining_leafe_id:1,password: "abc")
User.create(name:"hr",email:"hr@gmail.com",position: "Employee",department: 0,manager_id: 3, private_token: "hr",total_leafe_id:2,remaining_leafe_id:2,password: "abc")

ActiveRecord::Base.transaction do
  40.times do |t|
  	user = User.new
  	user[:name] = Faker::Name.name
  	user[:email] = Faker::Internet.email
  	user[:department] = rand(0..2)
    user[:position] = rand(0..1)
  	user[:manager_id] = rand(3..42)
  	user[:phone_no] = Faker::PhoneNumber.cell_phone
  	user[:address] = Faker::Address.street_address
  	user[:private_token] = user[:email]
  	user[:total_leafe_id] = t+3
    user[:remaining_leafe_id] = t+3
  	user.save
  	user.update(password: "abc")
  end
end

ActiveRecord::Base.transaction do
  42.times do |t|
  	total_leafe = TotalLeafe.new
  	total_leafe[:user_id] = t+1
  	total_leafe[:annual] = 10
  	total_leafe[:maternity] = 10
  	total_leafe[:non_paid] = 10
  	total_leafe[:study] = 10
  	total_leafe[:sick] = 10
  	total_leafe[:emergency] = 10
  	total_leafe.save
    RemainingLeafe.create(total_leafe.attributes)
  end
end

ActiveRecord::Base.transaction do
  100.times do |t|
    leafe = Leafe.new
    leafe[:user_id] = rand(1..42)
    leafe[:manager_id] = User.find(leafe[:user_id]).manager_id
    leafe[:leave_type] = rand(0..5)
    leafe[:leave_reason] = Faker::Hipster.sentence
    leafe[:status] = rand(0..2)
    leafe[:rejection_reason] = Faker::Hipster.sentence
    leafe[:start_date] = Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today)
    leafe[:end_date] = leafe[:start_date]+rand(2..5)
    if leafe.has_remaining?
      leafe.total_days = leafe.weekdays
      leafe.save
      if leafe.status == "Approved"
        leafe.deduct_leave
      end
    else
      next
    end
  end
end
