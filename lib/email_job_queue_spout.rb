require 'redis'
require 'thread'
module RedstormEmailJob

  class EmailJobQueueSpout < RedStorm::SimpleSpout
    

    on_init do
      @q = Queue.new
      @redis_reader = detach_redis_reader
    end
    
    on_send  do
      @q.pop if @q.size > 0
    end  

    
    private

    def detach_redis_reader
      Thread.new do
        Thread.current.abort_on_exception = true

        redis = Redis.new(:host => "localhost", :port => 6379)
        loop do
          if data = redis.blpop("email_job_queue", 0)
            @q << data[1]
          end
        end
      end
    end
    
  end
end