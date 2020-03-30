# heroku-django-react-boilerplate

Boilerplate code for a SaaS application hosted on heroku, with a django backend, and a react front end.

I copy this code when starting a new application with this kind of setup, to save time.

## Instructions

1. Create a new github repo for your project and copy the contents of this repo into it.
1. Replace this README.md file with something appropriate for your app.
1. In backend/settings.py, update allowed hosts with domains appropriate for your app. For example, you may want to replace dcr-boilerplate-django-react.herokuapp.com with <my-heroku-app>.herokuapp.com.
1. Create a new heroku app and choose the option to have it deploy automatically after merges in your github repo.
1. In your heroku app's settings, go to the Buildpacks section. Add heroku/nodejs and then heroku/python. The order matters so that yarn builds the build/static folder before django goes looking for that folder when setting up static files to be served.
1. If the app deploys correctly, you should see on the app's homepage the message "Edit src/App.js and save to reload." typical of an app made with create-react-app.
