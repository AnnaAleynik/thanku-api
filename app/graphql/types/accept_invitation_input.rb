module Types
  class AcceptInvitationInput < Types::BaseInputObject
    argument :invitation_token, String, required: true
    argument :login, String, required: true
    argument :password, String, required: true
    argument :confirm_password, String, required: true
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :avatar, Types::ImageUploaderType, required: false
    argument :birthdate, GraphQL::Types::ISO8601Date, required: false
  end
end
