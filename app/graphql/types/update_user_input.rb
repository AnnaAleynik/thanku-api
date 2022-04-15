module Types
  class UpdateUserInput < Types::BaseInputObject
    argument :email, String, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :current_password, String, required: false
    argument :avatar, Types::ImageUploaderType, required: false
    argument :login, String, required: false
    argument :birthdate, GraphQL::Types::ISO8601Date, required: false
  end
end
