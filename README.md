# Remind Me There

## About the app

This is an app developed by me initially for a university project, but then expanded upon as a side project afterwards. It serves for setting location-based reminders. These can be in the form of simple text notifications, like reminding you to `call Susan` when you get to work, or reminders containing photos, like an image of your shopping list popping up when you reach the supermarket.


## Using the app

The iOS app is ready for use. You will need Xcode to deploy it onto your phone. You will also need your own Google Cloud Platform account. Create a new project and generate an API key for it. This key then should be added to the `AppDelegate.m` file for both the `GMSServices` and the `GMSPlacesClient` variables.