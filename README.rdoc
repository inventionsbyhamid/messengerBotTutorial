Facebook recently released the Messenger Bot API. Using the API we can automate our page repllies. Here I will guide you to create your own Facebook Messenger bot.
We will create a Messenger bot for a college page.

####Step 1
* Create a [Facebook App](https://developers.facebook.com/apps/)
* Go to the App Dashboard and in the bottom left select "Messenger" tab. Then lick on "Get Started" on the right. If you don't see anything on the right after clicking "Messenger" wait for few hours and try again. 
* Select your page and generate access token. You will have something like this by now. <br>
![Access Token](https://s3-ap-southeast-1.amazonaws.com/javaforever/accesstoken.PNG)

####Step 2
* [Deploy App to Heroku](https://heroku.com/deploy?template=https://github.com/inventionsbyhamid/messengerBotTutorial)
* Finish heroku signup/login and add your Facebook Pages Access Token created above and some random string. Wait for build to finish.
* Click on "View" and copy the url of your app. You should see something like this but with different url <appname>.herokuapp.com<br>
![JavaForEverBot](https://s3-ap-southeast-1.amazonaws.com/javaforever/javaforverbot.PNG)

####Step 3
* Go back to the page where you generate Page access token. Click on "Setup Webhooks"
* Enter your app url
* Enter VERIFY_TOKEN as entered during creating app on heroku
* Select all options, Confirm and verify 

####Step 3
* Install the Chrome extension "Postman" to easily send post requests from your browser.
* Copy this https://graph.facebook.com/v2.6/me/subscribed_apps?access_token=<token> and replace <token> with your access token then paste in Postman tab and select "POST". You should see the following as response.
<br>
![Postman response](https://s3-ap-southeast-1.amazonaws.com/javaforever/postman1.PNG)

Now your bot is functional. Message your page "/help" and you'll see the help menu I have already configured. I will tell you further how to customize it.
![Finish bot](https://s3-ap-southeast-1.amazonaws.com/javaforever/finishbot.PNG)

####Step 4
* Now when you messaged your page in above step you had no idea what commands I have setup. To show a welcome screen follow these steps.
* Open Postman select "Import" then paste the following code. Replace <PAGE_ID> with your page id and <PAGE_ACCESS_TOKEN> with your access token. To get your page Id go to your page About-> See botton for Facebook Page ID. If you want to customize welcome screen change the "text" now or you can change this later.

```
curl -X POST -H "Content-Type: application/json" -d '{
  "setting_type":"call_to_actions",
  "thread_state":"new_thread",
  "call_to_actions":[
    {
      "message":{
        "text":"Welcome to My College Bot\nI respond to the following commands\n/address To get the college address\n/contact To get college contact details\n/timings To get regular college hours\n/help To get these instructions again"
      }
    }
  ]
}' "https://graph.facebook.com/v2.6/<PAGE_ID>/thread_settings?access_token=<PAGE_ACCESS_TOKEN>"
```

* Click "Send"
* You should see the following response.<br>
![Postman response](https://s3-ap-southeast-1.amazonaws.com/javaforever/welcome.PNG)

####How to customize responses?
* Download and install the [Heroku toolbelt](https://toolbelt.heroku.com/)
* If you haven't already, log in to your Heroku account and follow the prompts to create a new SSH public key.

```
$ heroku login
```
* Use Git to cloneyour apps source code to your local machine.

```
$ heroku git:clone -a yourappname<br>
$ cd yourappname
```

* Make some changes to the code you just cloned and deploy them to Heroku using Git. Most probably you want to edit the app->controllers->webhooks_controller.rb file. If you know how to program notice the if else and edit the response accordingly.

```
$ git add . 
$ git commit -am "make it better"
$ git push heroku master
```
