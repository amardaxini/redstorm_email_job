require 'json'
require 'redis'
require 'mail'
require 'pry'
module RedstormEmailJob
  class EmailJobBolt < RedStorm::SimpleBolt
  	on_init do
  		@redis = Redis.new(:host => "localhost", :port => 6379)
  		options = { :address => "localhost", :port => 1025}
			Mail.defaults do
			  delivery_method :smtp, options
			end
  	end

    on_receive do |tuple| 
      json = tuple.getString(0)

      params = JSON.parse(json)
      puts params
      Mail.deliver do
			  from    params[:from] || params["from"] || 'amar@idyllic-software.com'
			  to      params[:to] ||  params["to"] || 'amar@idyllic-software.com'
			  subject params[:subject] || params["subject"] || "sss"
			  html_part do
    			content_type 'text/html; charset=UTF-8'
    			body  params[:body] || params["body"] || "ssssss"
				end
			end

      
    end
  end
end
