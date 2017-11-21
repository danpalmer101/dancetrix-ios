#  Dance Trix iOS App

## Set up

### Mailgun Account

Mailgun is the email provider the app uses to send emails to you when bookings, orders and payments are made.

Once a Mailgun account is created, the domain (e.g. `mg.dancetrix.co.uk`), API key (e.g. `key-0123456789abcdef0123456789abcdef`) and authorized recipient address need to be set up in Firebase Remote Config (see below).

### Google Firebase Account

Google Firebase is a service for managing mobile apps, for example it provides analytics, and provides a place to store files and settings that the app can use so you can update the app without releasing a new app version.

The Dance Trix app should be set up within Firebase, and then Storage and Remote Config can be set up.

In _"Storage"_ set the following on the _"Rules"_ tab:
   
      ```
      service firebase.storage {
        match /b/{bucket}/o {
          match /{allPaths=**} {
            allow read, write;
          }
        }
      }
      ```
      
Then upload all the files from `Dance Trix > Resources > Mock Data` to the _"Files"_ tab - these files will be edited later in **Managing the app**

In _"Remote Config"_, enter the following parameters:
   
   | Parameter Key | Value |
   | --- | --- |
   | email_address_payment_from | Dance Trix Payments \<payments@dancetrix.co.uk> |
   | email_address_booking_from  | Dance Trix Bookings \<bookings@dancetrix.co.uk> |
   | email_address_uniform_from | Dance Trix Uniforms \<uniforms@dancetrix.co.uk> |
   | email_address_to | _enter the same email address from step 2.3 in Mailgun set-up_ |
   | dancetrix_uniform_catalog | http://dancetrix.co.uk/wp-content/uploads/2016/05/Dance-Trix-Catalogue.pdf |
   | dancetrix_website | http://www.dancetrix.co.uk |
   | mailgun_domain | mg.dancetrix.co.uk |
   | mailgun_api_key | _enter the "Secret API Key" from step 3.2 in Mailgun set-up_  |
   
The Firebase config file _"GoogleServices-Info.plist"_ included in the app is downloaded from the Firebase console in _"Project Settings"_.

## Managing the app

### Viewing analytics

The app records some basic analytics such as how many people are using it, where they are using it and on which types of phones. Plus which screens people are viewing and for how long.

You can see this information in Firebase in _"Analytics"_.

### Setting up classes

The classes that people can book are in the `classes.csv` file uploaded in the _"Storage"_ section of Firebase.

To make changes to this, download the file, edit it in Excel, and re-upload it.

The file has 6 columns:

1. **Format**: Leave this as `V1`
1. **Name**: This is the main name of the class, e.g. Tiny Trixies, it can be anything you like
1. **Menu Structure**: This is the levels of menus that the user will go through to find the class, each level is separated by a `|` character, for example `Adults|Tap` means there will be an "Adults" option on the first screen, then a "Tap" option on the second screen if they select "Adults" - there can be as many levels as you like
1. **Dates File Location**: This is the name of another CSV file which contains a list of dates for the class - there will probably be a different file for each class
1. **Description File Location**: This is the name of a text file which contains the description of the class to be displayed in the app
1. **Individual Date Booking**: This can be yes or no. Yes means that people can book individual dates, No means they must book the whole block (all the dates that are listed in the _"Dates File Location"_)

Once you have created all the classes, you will need to create all the dates files and description files you have referenced in this first file.

The dates files are also CSV files which can be edited in Excel, once you have created each one you need, upload them to _"Storage"_ in Firebase. When creating a new file, it is probably easiest to download an existing, modify it and re-name it.

The dates file has 4 columns:

1. **Format**: Leave this as `V1`
1. **Date**: The date of the class in the format: `dd/MM/yyyy`, e.g. 19/10/2017
1. **Start Time**: The start time (24 hour clock) of the class in the format: `HH:mm`, e.g. 19:30
1. **Duration**: The duration of the class in minutes, e.g. 60

The description files are a text file which just contain plain text describing the class. You can enter anything you like here, and it can be any length.

### Hiding features

Each menu item on the home page can be hidden.

Go to the Remote Config section in Firebase and you will see a number of parameters like `feature_xxxx`. Setting these to `no` turns off the feature in the app and hides it from users.

Note that it can take up to 12 hours for the changes to appear in the app as the app does not check the remote config every time it opens.

### Other changes

If you need to change the email address that emails go to, you will need to add a new "Authorized Recipient" in Mailgun, and then update the Remote Config in Firebase (the `email_payment_to` parameter).

The email addresses that emails are sent from (e.g. payments@dancetrix.co.uk) can be anything, and can be changed in Remote Config in Firebase.

The app uses 2 pages from the dancetrix.co.uk website:

1. The home page
1. The uniform catalog PDF file

If the address of either if these changes, then they should be updated in Remote Config in Firebase (`dancetrix_website` and `dancetrix_uniform_catalog` properties)

### Sending Notifications

In order to send a push notification to the app, you can use the Notifications section in Google Firebase.

1. In the Notifications section of the Firebase console, select "New message".
1. Enter the message text
1. Select "User Segment" as the Target
1. Select the iOS app as the app in the row under "Target user if"
1. (optional) Under the "Advanced" options, you can set a title for the message
1. (optional) Under the "Advanced" options, you can a set a `type` under Custom Data, valid values are `success`, `info`, `warning`,  `error`. This just determines the color of the notification bar that appears in the app if the user has the app open when the notification is sent
1. Select "Send Message"

If the user has the app open at the time you send the message, it will appear at the top of the screen, under the navigation bar.

If the user does not have the app open at the time you send the message, it will be displayed as a normal iOS notification.

Once you have sent a message, you can send the same message again in the future by selecting the "Duplicate" option from the options menu next to the message on the Notifications screen, then clicking "Send Message" again.
