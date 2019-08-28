require 'nokogiri'
require 'pry'
require 'open-uri'
require 'rb-readline'
require "net/https"
require "uri"

class WebScraper
  def initialize(semaphore: Mutex.new, increment_semaphore: Mutex.new, crawl_delay: 0)
    @crawl_delay = crawl_delay
    @semaphore = semaphore
    @increment_semaphore = increment_semaphore
    @last_request = Time.now
    @completed = 0
    @all = 0
  end

  def reset_counter
    @completed = 0
    @all = 0
  end

  def get_raw_page(uri)
    @increment_semaphore.synchronize do
      @all += 1
    end
    @semaphore.synchronize do
      while @crawl_delay > (Time.now - @last_request) do
      end
      @last_request = Time.now
      @completed += 1
      print "\r#{@completed}/#{@all}"
    end
    Nokogiri::HTML(open(uri, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE, 'User-Agent' => random_user_agent))
  end

private
  def random_user_agent
    [
      "Bingbot",
      "msnbot",
      "Clickagy Intelligence Bot v2",
      "Yandex",
      "Firefox",
      "Chrome",
      "IE",
    ].sample
  end
end

