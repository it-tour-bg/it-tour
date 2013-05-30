class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[A-Z0-9_\.%\+\-\']+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i
      record.errors.add attribute, :invalid
    end
  end
end

