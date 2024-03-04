# README

## Introduction

Application Description, see example in lab 6

## Requirements

This code has been run and tested on:

- Ruby - 3.1.2p20
- Rails - 7.0.8
- Ruby Gems - Listed in `Gemfile`
- PostgreSQL - 13.3
- Docker (Latest Container)


## External Deps

- Docker - Download latest version at https://www.docker.com/products/docker-desktop
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
- Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
- GitHub Desktop (Not needed, but HELPFUL) at https://desktop.github.com/

## Installation

Download this code repository by using git:

`git clone https://github.com/CSCE431-Software-Engineering/sprint-1-kappaupsilonchi`

## Tests

An RSpec test suite is available and can be ran using:

`rspec spec/`

You can run all the test cases by running. This will run both the unit and integration tests.
`rspec .`

## Execute Code

Run the following code in Powershell if using windows or the terminal using Linux/Mac

`cd sprint-1-kappaupsilonchi`

`docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 dmartinez05/ruby_rails_postgresql:latest`


Install the app

`bundle install && rails webpacker:install && rails db:create && db:migrate`


Run the app
`rails server --binding:0.0.0.0`


The application can be seen using a browser and navigating to http://localhost:3000/


## Environmental Variables/Files

We have environment variables setup for Authentication. The tutorial can be found here: https://medium.com/craft-academy/encrypted-credentials-in-ruby-on-rails-9db1f36d8570

The tutorial above will help you understand now we encrypted the admin page's username and password!


## Deployment
lab 6

## CI/CD



## Support



## Extra Helps

Please contact Pauline Wade paulinewade@tamu.edu for help on Lab assignments which will teach you in more depth.