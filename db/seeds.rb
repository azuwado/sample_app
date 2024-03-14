# create main user
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobarbaz",
             password_confirmation: "foobarbaz",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

# create a lot of users all together
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end