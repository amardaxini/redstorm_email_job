require 'redis'
require 'json'
$redis = Redis.new
module RedstormEmailJob
	class EmailJob
		# Pramams
		# {:to=>[],:cc=>[],:bcc=>[],:subject=>"",:body=>""}
		def self.enqueue(params={})
			 $redis.rpush("email_job_queue",params.to_json)
		end
	end
end
(1...1000).to_a.each do |i|
	params ={:from=>"amar@idyllic-software.com",:to=>["amar+#{i}@idyllic-software.com"],:subject=>"TEst Email  #{i}",:body=>"Test Content #{i}"}
	puts "Enqueue #{i}"
	RedstormEmailJob::EmailJob.enqueue(params)
end	
# Mail.deliver do
#    from    params[:from]
#    to      params[:to]
#    subject params[:subject]
#    html_part do
#     content_type 'text/html; charset=UTF-8'
#     body  params[:body]
#   end
# end