module Types
  class HashtagListInput < Types::BaseInputObject
    argument :id, ID, required: false
    argument :name, String, required: false
    argument :destroy, Boolean, required: false
  end
end
