class EmailToken
  class << self
    def for(user)
      new Digest::MD5.hexdigest(user.email) + user.id.to_i.to_s(16)
    end

    def user_id(token)
      new(token).user_id
    end
  end

  def initialize(token)
    @token = token.to_s
  end

  def user_id
    id_part = @token[32, @token.size]
    return 0 if id_part.to_i == 0
    id_part.to_i(16)
  end

  def to_s
    @token
  end

  def ==(token)
    token.to_s == @token
  end
end

