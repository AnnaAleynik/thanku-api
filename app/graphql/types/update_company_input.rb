module Types
  class UpdateCompanyInput < Types::BaseInputObject
    argument :name, String, required: false
    argument :description, String, required: false
    argument :hashtags, Types::HashtagListInput, required: false
  end
end
