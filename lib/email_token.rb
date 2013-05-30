class EmailToken
  class << self
    def for(user)
      new Digest::MD5.hexdigest(user.email) + user.id.to_i.to_s(16)
    end
  end

  def initialize(token)
    @token = token
  end

  def user_id
    @token[32, @token.size].to_i(16)
  end

  def to_s
    @token
  end

  def ==(token)
    token.to_s == @token
  end
end

