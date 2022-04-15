module Types
  class SignUpInput < Types::BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true

    argument :login, String, required: false

    argument :avatar, Types::ImageUploaderType, required: false
  end
end
