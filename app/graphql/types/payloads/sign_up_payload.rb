module Types
  module Payloads
    class SignUpPayload < Types::BaseObject
      field :access_token, String, null: false
      field :refresh_token, String, null: false
      field :me, Types::CurrentUserType, null: true, method: :user
      field :company, Types::CompanyType, null: false
    end
  end
end
