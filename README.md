# Werewolf! The multiplayer party game.

![Slack Badge](http://santa-monica-elixir-slackin.herokuapp.com/badge.svg)
[![Stories in Ready](https://badge.waffle.io/SantaMonicaElixir/werewolf.svg?label=ready&title=Stories%20In%20Ready)](http://waffle.io/SantaMonicaElixir/werewolf)
[![Build Status](https://travis-ci.org/SantaMonicaElixir/werewolf.svg?branch=master)](https://travis-ci.org/SantaMonicaElixir/werewolf)

__Project Board__: https://waffle.io/SantaMonicaElixir/werewolf

__Meetup Group__: http://www.meetup.com/Santa-Monica-Elixir/

__Group Home Page__: http://santamonicaelixir.github.io/

## Goals:

This project will take our group through the parts of building out a Web-based, multiplayer party game. Our objectives as a group are to build a game that demonstrates Erlang and Elixir concepts through hands-on exercises!

### Rules:

The rules of Werewolf are very similar to the game Mafia. See them: http://www.eblong.com/zarf/werewolf.html

## Running the app:

### Setup

    $ mix deps.get
    $ npm install

### Development Process

Developers work on a feature on a feature branch, branched off of
`master` branch.

At the end of their feature work, they submit a Github Pull Request back
to the `master` branch.

Other teammates review the code and make code review comments. As soon
as another teammate gives their approval (often through a "+1" or "LGTM"
(Looks Good To Me) comment, the PR submitter may click the Merge button
on the Github PR user interface.

#### TDD

It helps to run tests with the `mix test.watch` runner, which runs
tests when files change.

### Deployment Process

This project deploys off of the `master` branch.

We use [Travis CI](https://travis-ci.org/SantaMonicaElixir/werewolf) to
run our tests and deploy the build to [Heroku](http://www.heroku.com).

Travis will run tests on all branches. If a build passes on the `master`
branch, Travis will perform the necessary actions to get the build
deployed to Heroku.

