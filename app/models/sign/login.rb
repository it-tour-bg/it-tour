module Sign
  class Login
    include ActiveModel::Model
    attr_accessor :email, :password

    validate :credentials

    def user_id
      user.id if valid?
    end

    private

    def credentials
      errors.add(:email, 'is required') if email.blank?
      errors.add(:password, 'is required') if password.blank?

      if errors.empty? and !user.try(:authenticate, password)
        errors.add(:email, "doesn't match password")
      end
    end

    def user
      @user ||= User.find_by email: email
    end
  end
end
