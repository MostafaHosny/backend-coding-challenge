module RequestHelpers
  def json_headers
    {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json'
    }
  end

  def json
    return if response.body.blank?

    JSON.parse(response.body, symbol_keys: true)
  end

  def json_post(url, params: {}, headers: {}, auth: false, auth_user: nil)
    post url, params:, as: :json, headers: prepare_headers(headers, auth, auth_user)
  end

  def json_get(url, params: {}, headers: {}, auth: false, auth_user: nil)
    get url, params:, headers: prepare_headers(headers, auth, auth_user)
  end

  def prepare_headers(spec_headers, _auth, _auth_user)
    spec_headers.reverse_merge(json_headers)
  end
end
