module RequestHelpers
  def json_headers
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
  end

  def auth_headers(user)
    token = JsonWebToken.encode({ user_id: user.id })
    {
      'Authorization' => "Bearer #{token}"
    }
  end

  def json
    return if response.body.blank?

    JSON.parse(response.body, symbol_keys: true)
  end

  def json_post(url, params: {}, headers: {}, auth_user: nil)
    post url, params:, as: :json, headers: prepare_headers(headers, auth_user)
  end

  def json_get(url, params: {}, headers: {}, auth_user: nil)
    get url, params:, headers: prepare_headers(headers, auth_user)
  end

  def prepare_headers(spec_headers, auth_user)
    spec_headers.reverse_merge(json_headers)
    spec_headers.reverse_merge(auth_headers(auth_user)) if auth_user
  end
end
