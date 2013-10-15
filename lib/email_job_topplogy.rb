require 'red_storm'
require 'lib/email_job_queue_spout'
require 'lib/email_job_bolt'
require 'mail'
module RedstormEmailJob
 
  class EmailJobTopology < RedStorm::SimpleTopology
    spout EmailJobQueueSpout do

      output_fields :tweet
    end
        
    bolt EmailJobBolt, :parallelism => 3 do

      source EmailJobQueueSpout, :shuffle
      output_fields :message_id
    end
    # bolt SortedTweetBolt, :parallelism => 3 do
    #   source ExtractMessageBolt, :shuffle
    #   output_fields :hashtag
    # end
    # bolt ExtractHashtagsBolt, :parallelism => 3 do
    #   source ExtractMessageBolt, :shuffle
    #   output_fields :hashtag
    # end

    # bolt RollingCountBolt, :parallelism => 3 do
    #   source ExtractHashtagsBolt, :fields => ["hashtag"]
    #   output_fields :hashtag, :count
    # end

    # bolt RankBolt, :parallelism => 3 do
    #   source RollingCountBolt, :fields => ["hashtag"]
    #   output_fields :json_rankings
    # end

    # bolt MergeBolt, :parallelism => 1 do
    #   source RankBolt, :global
    #   output_fields :json_rankings
    # end

    configure do |env|
      debug false
      case env
      when :local
        max_task_parallelism 10
      when :cluster
        num_workers 20
        max_spout_pending 5000
      end
    end

    on_submit do |env|
        if env == :local
          # sleep(5)
          # cluster.shutdown
        end
      end
  end
end