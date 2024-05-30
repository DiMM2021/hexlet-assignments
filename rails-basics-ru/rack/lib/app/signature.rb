# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    status, headers, response = @app.call(env)
    response_body = response.map(&:dup).join
    sha256_hash = Digest::SHA256.hexdigest(response_body)
    response_body += "\n#{sha256_hash}"
    headers['Content-Length'] = response_body.bytesize.to_s
    [status, headers, [response_body]]
    # END
  end
end
