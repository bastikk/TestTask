# spec/rate_limiter_spec.rb

require './app/rate_limiter'
require 'timecop'

RSpec.describe RateLimiter do
  let(:limiter) { described_class.new(5) } # 5 requests per second

  it 'allows requests within the rate limit' do
      expect(limiter.allow_request?).to be true
      expect(limiter.allow_request?).to be true
      expect(limiter.allow_request?).to be true
      expect(limiter.allow_request?).to be true
      expect(limiter.allow_request?).to be true
  end

  it 'enforces the rate limit' do
    5.times do
      expect(limiter.allow_request?).to be true
    end

    expect(limiter.allow_request?).to be false
  end

  it 'resets the rate limit after one second' do
    5.times do
      expect(limiter.allow_request?).to be true
    end

    # Timecop is used to travel one second into the future
    Timecop.travel(Time.now + 1)

    expect(limiter.allow_request?).to be true
  end

  after do
    Timecop.return
  end
end
