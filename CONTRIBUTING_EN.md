:mega: Pull requests are welcome on GitHub at https://github.com/shinosakarb/tebukuro :mega:  
Regardless of your programming level, anyone is welcome to join :smiley:
Here's a primer for how to contribute to the project for those who would like to help out.

###Contents

- ####[Before Getting Started](#before-getting-started-1)

- ####[How to Contribute](#how-to-contribute-1)

- ####[Styleguides](#styleguides-1)


###Before Getting Started

- ####About Tebukuro

  Tebukuro is a "Mobile Friendly" service for managing events. Read details here: [README](https://github.com/shinosakarb/tebukuro/blob/master/README_EN.md)
  This project's core members are a part of the Ruby community in Kansai.
  Everyone's here to up their skills, so don't be afraid of making mistakes or trying out the latest
  architectures and tools! :fist:

  >_*Failure seldom stops you. What stops you is the fear of failure.*_ -Jack Lemmon

- ####How to join the project

  Join the project from Github!

    - **At [Github](https://github.com/shinosakarb/tebukuro)**:octocat:

      If there's an issue that you'd like to help out with, start a pull request!
      Feel free to create a new issue if you'd like to try out any new functionalities.
      We'll take a look at it, and if it works then we'll merge your work!

    - **Related communities**:two_men_holding_hands:

      There are a number of people from different communities who have helped to create tebukuro, and we hold events and study sessions regularly.
      Feel free to ask about event details through Slack!

- ####Communities related to Tebukuro

  Here are a few communities that members from this project are a part of.
  Please join these too :satisfied:

  - [Shinosaka.rb](https://shinosakarb.doorkeeper.jp/) - The central community of Tebukuro located in Shin Osaka

  - [Rails follow up Osaka](https://rails-follow-up-osaka.doorkeeper.jp) - A study group for beginners to Ruby and Rails located in Osaka

  - [Cherry.rb](https://cherryrb.doorkeeper.jp/) - A community for those who have just started out with or want to begin using Ruby and Rails

  - [Ruby関西](https://rubykansai.doorkeeper.jp/) - The main community which holds Ruby related events in Kansai

###How to Contribute

- ####Environment construction

  - **Forking and cloning repositories**

    Click the "Fork" button at the top right of the [The project's Github page](https://github.com/shinosakarb/tebukuro) and fork the project to your own account.
    Next, clone the repository locally and make changes.
    Follow steps [1-3 at "Develop Tips" on the wiki page](https://github.com/shinosakarb/tebukuro/wiki/Develop-tips#how-to-merge-pull-request) to find out which command to use when cloning.

  - **Install the expansion functionality Zenhub**

    Tebukuro uses the Scrum method to advance the project, like using the Zenhub's board functionality on a Github page.
    Check out [this page](https://seleck.cc/670) to find out how to install/use Zenhub.

  - **Development environment construction with Docker**

    Docker provides a development environment so that local environment construction can be done easily.
    Please look at this page: [How to construct a development environment with Docker](https://github.com/shinosakarb/tebukuro/wiki/Setup#setup-for-development)

- ####Introducing/Adding the latest functionalities

  If there's a new framework or tool that you're interested in trying out but can't at work, or if there are services in place that you'd like to change, give it a try on tebukuro :rocket:
  If you let us know with an issue and we think it's good, we'll add it on the next release's Roadmap.

- ####Implementation of functionalities on the Sprint Backlog and the Product Backlog

  Any functionalities that have been discussed and are to be implemented will be added to the Product Backlog on Github's board.
  Functionalities that are higher up in priority will be added to the Sprint Backlog.
  Please open pull requests especially for functionalities that are in the Backlog :grin:

- ####Pull Request

    - **Creating a work branch**

      Please create a different branch from the master branch and make changes there after cloning the repository.

    - **Group commits together with your changes**

      Use commands like the rebase command below before opening a pull request of your changes so that all of the commits can be grouped together. Use squash on the all of the commits besides the highest one on the first page, and please edit the commit message when prompted.  

      `$ git rebase -i`  

    - **Incorporating the newest version**

      Use the commands written below to incorporate the newest version of the repository in the branch you're working in.

      ```
      $ git fetch upstream
      $ git rebase upstream/master
      ```

    - **Opening a pull request**

      Click the "New pull request" button on the top left of the screen to open a pull request.
      Enter in all the fields on the template and send it to us. :email:

    - **Automatic tests and reviews**

      An automatic test by the CI tool will start after you open your pull request.
      If all of the tests pass and we don't find any problems with your code after reviewing it, we'll merge it as it is, or write comments to show which sections we'd like for you to change :writing_hand:

    - **Making revisions**

      If any of the automatic tests failed or if you were requested to make some revisions, then please make the changes, commit, and then push them.
      You don't need to rebase anything for commits that you make when revising your code.
      If the revisions have been made and the tests pass, then rebase and group all of the commits together.

      :tada: **Merged functionalities will be implemented in tebukuro** :clap:  

###Styleguides
  :construction:Under Construction:construction_worker:

  - Ruby
  - javascript
  - commit messages

###Addtional Notes
  Below is some useful information concerning the project.

  - ####[Tables](https://github.com/shinosakarb/tebukuro/wiki/Tables)

  - ####[Troubleshooting](https://github.com/shinosakarb/tebukuro/wiki/Troubleshooting)
