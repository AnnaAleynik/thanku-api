Activity.destroy_all
User.destroy_all

company = Company.create!(
  name: "SuperTeam",
  description: "The best team thanks жцрпо",
  bonus_amount: 500
)

owner = User.create!(
  email: "john.doe@example.com",
  first_name: "John",
  last_name: "Doe",
  password: "123456",
  login: "john.doe",
  bonus_allowance: 500,
  bonus_balance: 500,
  role: "owner",
  company: company
)
Activity.create!(
  user: owner,
  title: "User registered",
  body: "New user registered with the next attributes: First Name - John, Last Name - Doe",
  event: :user_registered
)

darth_vader = User.create!(
  email: "darth.vader@example.com",
  first_name: "Darth",
  last_name: "Vader",
  password: "123456",
  login: "star_war",
  bonus_allowance: 500,
  bonus_balance: 500,
  role: "employee",
  invited_by: owner,
  company: company
)
Activity.create!(
  user: darth_vader,
  title: "User registered",
  body: "New user registered with the next attributes: First Name - Darth, Last Name - Vader",
  event: :user_registered
)
