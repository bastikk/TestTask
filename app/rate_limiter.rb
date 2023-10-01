class RateLimiter
  def initialize(requests_per_second)
    @requests_per_second = requests_per_second
    @request_history = []
  end

  def allow_request?
    current_time = Time.now
    @request_history.unshift(current_time)
    @request_history.pop while current_time - @request_history.last >= 1.0 / @requests_per_second
    @request_history.size <= @requests_per_second
  end
end
