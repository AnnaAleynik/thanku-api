module Types
  class CompanyInput < Types::BaseInputObject
    argument :name, String, required: true
    argument :description, String, required: false
    argument :bonus_amount, Int, required: true
  end
end
