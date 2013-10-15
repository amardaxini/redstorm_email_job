# Installation

		rvm install jruby
		export JRUBY_OPTS=--1.9
		bundle install
		bundle exec redstorm install
		bundle exec redstorm bundle topology
		# Local
		bundle exec redstorm local lib/email_job_topology.rb

# Configure SMTP/SEND MAIL and Enqueue Job

 Add your SMTP configuration `lib/email_job_bolt.rb`
 
		 rvm use ruby-1.9.3
		 bundle install
		 ruby email_job.rb
		 # or Manually Enqueue Job
		 params ={:from=>"foo@bar.com",:to=>["foo+1@bar.com"],:subject=>"Test Email",:body=>"<h1>Tes Content</h1>"}
		 RedstormEmailJob::EmailJob.enqueue(params)