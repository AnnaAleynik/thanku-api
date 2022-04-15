class ExistingPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if record.model.authenticate(value)

    record.errors[attribute].push("is incorrect")
  end
end
