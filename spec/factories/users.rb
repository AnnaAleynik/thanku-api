FactoryBot.define do
  factory :user do
    company
    email { "user_#{SecureRandom.base64(12)}@example.com" }
    password { "password" }
    first_name { FFaker::Name.first_name }
    last_name  { FFaker::Name.last_name }
    login { "#{first_name}.#{last_name}" }
    bonus_allowance { 500 }
    bonus_balance { 230 }

    trait :with_reset_token do
      password_reset_token { "reset_token" }
      password_reset_sent_at { Time.zone.now }
    end

    trait :with_data do
      email { "adam@serwer.com" }
      first_name { "Adam" }
      last_name { "Serwer" }
      birthdate { 21.years.ago }
    end

    trait :owner do
      email { "sherlock@holmes.com" }
      first_name { "Sherlock" }
      last_name { "Holmes" }
      role { "owner" }
    end

    trait :invited_not_accepted do
      login { nil }
      email { "invited@example.com" }
      invitation_token { "invitation_token" }
      bonus_balance { 0 }
    end

    trait :employee do
      email { "johann_sebastian@bach.com" }
      first_name { "Johann Sebastian" }
      last_name { "Bach" }
      role { "employee" }
    end
  end
end
