#  Dance Trix iOS App

## Set up

### Mailgun Account

Mailgun is the email provider the app uses to send emails to you when bookings, orders and payments are made.

1. Register for a Mailgun account:
   1. Go to http://www.mailgun.com, select _"Sign Up"_ and enter the company details
   1. On the second page, skip the _"Get More By Adding A Credit Card"_ step
   1. On the third page, ignore the _"Try Sending An Email From Your Sandbox Server Now"_ step, but select _"Add a domain"_
   1. On the fourth page, enter `dancetrix.co.uk` as the Domain Name
   1. On the fifth page, ignore the _"Now Follow These Steps To Verify Your Domain"_ step and select _"Continue to Domain Overview"_
1. Add an _"Authorized recipient"_, this is the email address you want emails to be sent to when booking/order/payment is made:
   1. Go to: https://app.mailgun.com/app/account/authorized
   1. Select _"Invite New Recipient"_
   1. Enter the email address you want emails to be sent to and select _"Invite Recipient"_
   1. Go to the email inbox of that email address, open the email sent to you by Mailgun and follow the steps to verify your account (enter your mobile number, get sent a code, enter the code on the website to verify)
1. Get your Mailgun API key:
   1. Go to: https://app.mailgun.com/app/dashboard
   1. In the bottom right of the page there is a section call "API Keys", select the eye symbol next to "Secret API Key" and make a copy of the value in the box - this will be needed later. For example:

```key-0123456789abcdef0123456789abcdef```

### Google Firebase Account

Google Firebase is a service for managing mobile apps, for example it provides analytics, and provides a place to store files and settings that the app can use so you can update the app without releasing a new app version.

_The following steps assume you have a Google account, if not, you will need to register for one._

1. Create the Dance Trix app in Firebase:
   1. Go to: https://firebase.google.com/ and select _"GO TO CONSOLE"_ in the top right of the page
   1. Click _"Add project"_, enter a _"Dance Trix"_ as the name for the project and _"United Kingdom"_ as the country, then click _"Create Project"_
   1. On the Overview page you are taken to, select _"Add Firebase to your iOS app"_
   1. Enter `uk.co.dancetrix` as the iOS bundle ID, _"Dance Trix iOS App"_ as the app nickname, and leave the app store ID blank, then select _"REGISTER APP"_
   1. Select the _"Skip to the console"_ link under "Already added the pod and initialisation code?" in the bottom left
1. Enable Storage in Firebase:
   1. Select _"Storage"_ in the left-hand menu
   1. Select _"Get Started"_ and then _"Got It"_
   1. Upload all the files `Dance Trix > Resources > Mock Data` to this page - these files will be edited later in **Managing the app**
1. Enable Remote Config in Firebase:
   1. Select _"Remote Config"_ in the left-hand menu
   1. Enter the following parameters:
   
   | Parameter Key | Value |
   | --- | --- |
   | email_address_payment_from | Dance Trix Payments \<payments@dancetrix.co.uk> |
   | email_address_booking_from  | Dance Trix Bookings \<bookings@dancetrix.co.uk> |
   | email_address_uniform_from | Dance Trix Uniforms \<uniforms@dancetrix.co.uk> |
   | email_address_to | _enter the same email address from step 2.3 in Mailgun set-up_ |
   | dancetrix_uniform_catalog | http://dancetrix.co.uk/wp-content/uploads/2016/05/Dance-Trix-Catalogue.pdf |
   | dancetrix_website | http://www.dancetrix.co.uk |
   | mailgun_domain | dancetrix.co.uk |
   | mailgun_api_key | _enter the "Secret API Key" from step 3.2 in Mailgun set-up_  |
   
1. Download the config file:
   1. Select the cog next to _"Overview"_ in the left-hand menu and then _"Project settings"_
   1. Click on the "GoogleServices-Info.plist" button next to _"Download the latest config file"_

I need to put this file in the app, so send this file to me.

## Managing the app

### Viewing analytics

The app records some basic analytics such as how many people are using it, where they are using it and on which types of phones. Plus which screens people are viewing and for how long.

You can see this information in Firebase in _"Analytics"_.

### Setting up classes

The classes that people can book are in the `classes.csv` file uploaded in the _"Storage"_ section of Firebase.

To make changes to this, download the file, edit it in Excel, and re-upload it.

The file has 6 columns:

1. Format: Leave this as `V1`
1. Name: This is the main name of the class, e.g. Tiny Trixies, it can be anything you like
1. Menu Structure: This is the levels of menus that the user will go through to find the class, each level is separated by a `|` character, for example `Adults|Tap` means there will be an "Adults" option on the first screen, then a "Tap" option on the second screen if they select "Adults" - there can be as many levels as you like
1. Dates File Location: This is the name of another CSV file which contains a list of dates for the class - there will probably be a different file for each class
1. Description File Location: This is the name of a text file which contains the description of the class to be displayed in the app
1. Individual Date Booking: This can be yes or no. Yes means that people can book individual dates, No means they must book the whole block (all the dates that are listed in the "Dates File Location")

Once you have created all the classes, you will need to create all the dates files and description files you have referenced in this first file.

The dates files are also CSV files which can be edited in Excel, once you have created each one you need, upload them to _"Storage"_ in Firebase. When creating a new file, it is probably easiest to download an existing, modify it and re-name it.

The dates file has 4 columns:

1. Format: Leave this as `V1`
1. Date: The date of the class in the format: `dd/MM/yyyy`, e.g. 19/10/2017
1. Start Time: The start time (24 hour clock) of the class in the format: `HH:mm`, e.g. 19:30
1. Duration: The duration of the class in minutes, e.g. 60

The description files are a text file which just contain plain text describing the class. You can enter anything you like here, and it can be any length.

### Other changes

If you need to change the email address that emails go to, you will need to add a new "Authorized Recipient" in Mailgun, and then update the Remote Config in Firebase (the `email_payment_to` parameter).

The email addresses that emails are sent from (e.g. payments@dancetrix.co.uk) can be anything, and can be changed in Remote Config in Firebase.

The app uses 2 pages from the dancetrix.co.uk website:

1. The home page
1. The uniform catalog PDF file

If the address of either if these changes, then they should be updated in Remote Config in Firebase (`dancetrix_website` and `dancetrix_uniform_catalog` properties)
