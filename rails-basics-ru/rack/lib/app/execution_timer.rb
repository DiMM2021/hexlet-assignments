# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Time.now
    status, headers, response = @app.call(env)
    end_time = Time.now
    execution_time = ((end_time - start_time) * 1_000_000).to_i
    response_body = response.map(&:dup).join
    new_response_body = "Execution time: #{execution_time}µs\n" + response_body
    headers['Content-Length'] = new_response_body.bytesize.to_s
    [status, headers, [new_response_body]]
  end
end
