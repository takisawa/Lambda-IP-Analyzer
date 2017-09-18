# frozen_string_literal: true

require 'dotenv'
require 'mechanize'

class LambdaIpAnalyer

  def initialize(lambda_apis, therad_count, loop_count)
    @lambda_apis = lambda_apis
    @therad_count = therad_count
    @loop_count = loop_count
    @lambda_api_mutex = Mutex.new
    @result_mutex = Mutex.new
    @result = []
  end

  def run
    threads = @therad_count.times.map do |thread_index|
      Thread.new(thread_index) do |thread_idx|
        thread_main(thread_idx)
      end
    end

    threads.each(&:join)

    @result.each do |thread_idx, loop_idx, ip|
      STDOUT.puts "Thread:#{thread_idx}, Loop:#{loop_idx}, IP:#{ip}"
    end
  end

  private

  def thread_main(thread_idx)
    api = lambda_api(thread_idx)
    @loop_count.times do |loop_idx|
      http_client = Mechanize.new
      ip = http_client.get(api).body
      add_result(thread_idx, loop_idx, ip)
    end
  end

  def lambda_api(idx)
    @lambda_api_mutex.synchronize do
      @lambda_apis[idx % @lambda_apis.size]
    end
  end

  def add_result(thread_idx, loop_idx, ip)
    @result_mutex.synchronize do
      @result << [thread_idx, loop_idx, ip]
    end
  end
end

def main
  Dotenv.load

  lambda_apis = ENV['LAMBDA_APIS'].split(',')
  therad_count = ENV['THREAD_COUNT'].to_i
  loop_count = ENV['LOOP_COUNT'].to_i

  analyzer = LambdaIpAnalyer.new(lambda_apis, therad_count, loop_count)
  analyzer.run
end

main
