class WebhooksController < ApplicationController
	skip_before_action :verify_authenticity_token

  def index

  	 url = "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['PAGE_TOKEN']}"

  	if request.get?
  		if params['hub.verify_token'] == "cMfuqRvoMTLjM47A"
  			render plain: params['hub.challenge']
  		else
  			render plain: 'Error, wrong validation token'
  		end

  	elsif request.post?
  		begin
  			request.body.rewind
    		body = JSON.parse(request.body.read)
    		puts "Body"
    		puts body
    		entries = body['entry']
    		puts "entries"
    		puts entries

    		entries.each do |entry|
      			entry['messaging'].each do |message|
        			text   = message['message']['text'].to_s
        			sender = message['sender']['id']

        			if text.casecmp("/address").zero?
        				reply(sender , "212, Okhla Phase III, Okhla Industrial Area, New Delhi, Delhi 110020\nNearest Metro station Govind Puri.",url)
        			elsif text.casecmp("/contact").zero?
        				reply(sender ,"inventionsbyhamid@gmail.com",url)
        			elsif text.casecmp("/timings").zero?
        				reply(sender , "9:15 AM to 5:00 PM",url)
        			elsif text.casecmp("/help").zero?
        				reply(sender , "Welcome to My College Bot\nI respond to the following commands\n/address To get the college address\n/contact To get college contact details\n/timings To get regular college hours\n/help To get these instructions again",url)	
        			end

      			end
    		end
    	rescue => e
    		puts e.message
  		end
  	end

  end


  def reply(sender,text,url)
  body = { 
    recipient: { 
      id: sender 
    },
    message: { 
      text: text
    }
  }

  HTTParty.post(url, body: body)
end

end
