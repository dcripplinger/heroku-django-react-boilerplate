# heroku-django-react-boilerplate

Boilerplate code for a SaaS application hosted on heroku, with a django backend, and a react front end.

I copy this code when starting a new application with this kind of setup, to save time.

## Copying Instructions

1. Create a new github repo for your project and copy the contents of this repo into it.
1. Replace this README.md file with something appropriate for your app. Contents below this section may be useful to retain in the new README.md.
1. In backend/settings.py, update allowed hosts with domains appropriate for your app. For example, you may want to replace dcr-boilerplate-django-react.herokuapp.com with <my-heroku-app>.herokuapp.com.
1. Create a new heroku app and choose the option to have it deploy automatically after merges in your github repo.
1. In your heroku app's settings, go to the Buildpacks section. Add heroku/nodejs and then heroku/python. The order matters so that yarn builds the build/static folder before django goes looking for that folder when setting up static files to be served.
1. If the app deploys correctly, you should see on the app's homepage the message "Edit src/App.js and save to reload." typical of an app made with create-react-app.

## Setup

### System requirements

This project is meant to be developed and locally run on Ubuntu 16.04 or later. It might also be fine on Windows with the Ubuntu subsystem or other Unix-like systems (e.g. MacOS, Fedora), but there are a few commands in setup scripts that use `apt` to install things on a Debian system (e.g. Ubuntu) that you'd probably have to skip and do manually with whatever installation package makes sense for your system. If you don't have Ubuntu installed natively and you don't want to try running this project on a different system, try installing an Ubuntu virtual machine and working in there.

Your OS must already have the following installed independently before doing anything with this project:
- Current version of postgres (I think it's already included in Ubuntu and macOS distributions). The project uses the default postgres port 5432 to connect to the local database, unless that setting is changed.
- Some version of python and pip, for installing pipenv. The actual version of python needed for running this app will be installed by pyenv automatically, if necessary, and enforced by pipenv.

### Setting up localdev backend

After you have cloned the repo to your local machine, you will need to run `./setup.sh`. The very first time you run it, it will attempt to install a few system-level applications needed and set up the virtual environment. It may need to break early and have you restart the terminal or leave and return the project directory, after which you should re-run `./setup.sh`. The script itself should guide you through it.

The project uses pipenv and direnv to set up the local virtual environment. This means that pipenv commands are available to you in lieu of pip commands, and the project uses `Pipfile` and `Pipfile.lock` instead of `requirements.txt` to version control packages. However, you don't need to run `pipenv shell` every time you open a terminal because direnv enters and exits the virtual environment automatically.

`./setup.sh` also handles installing and updating all Python packages within the virtual environment according to `Pipfile` and `Pipfile.lock`, and it handles database migrations and any other backend configurations. After the initial setup, subsequent runs of `./setup.sh` should be idempotent and just handle updates to the codebase.

Meanwhile, to prepare the frontend code to run, you will need to run `yarn` to install all the javascript packages and `yarn start` to run the frontend code in the browser in dev mode, where it updates and refreshes automatically whenever changes are detected in the frontend code.
