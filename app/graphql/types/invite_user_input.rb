module Types
  class InviteUserInput < Types::BaseInputObject
    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :role, Types::RoleType, required: true
  end
end
