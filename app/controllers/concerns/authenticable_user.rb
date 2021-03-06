module AuthenticableUser
  private

  def current_user
    return unless token && payload && active_refresh_token?

    @current_user ||= User.find_by(id: payload["sub"])
  end

  def current_company
    return unless current_user

    current_user.company
  end

  def token
    @token ||= request.headers["Authorization"].to_s.match(/Bearer (.*)/).to_a.last
  end

  def payload
    @payload ||= JWT.decode(token, ENV.fetch("AUTH_SECRET_TOKEN"), true, algorithm: "HS256").first
  rescue JWT::DecodeError
    {}
  end

  def jti
    payload["jti"]
  end

  def active_refresh_token?
    RefreshToken.active.exists?(jti: jti)
  end
end
