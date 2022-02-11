# 2110 JASON OBSTACLE COURSE
## Setup, Features, and Creation

### Setup
- This project was built using `Ruby 2.7.2`.
  - If you do not have a version of Ruby installed on your computer you can check out [this guide](https://www.ruby-lang.org/en/documentation/installation/)
- Clone down the repository to your local machine.
  - `$ git clone git@github.com:jbreit88/2110_json_obstacle_course.git`
- This project uses the following gems:
  - Matrix: This should come standard with your installation of Ruby 2.7.2. If you are getting `require errors` try installing this gem.
- That's it! You should be good to go!

### Feature
1. Check out our cohort norms!
  - By running `$ ruby norms.rb` as a terminal command inside the repo's local directory you can see a pretty printed list of our cohort norms. Look fmailiar? IT SHOULD!! This is all about JSON!
    - If you'd like to listen to them too, run `$ ruby norms_english_serializer.rb` 
2. Let's play a game!
  - From your terminal, run `$ ruby json_game_runner.rb` while inside the repo's local directory to boot up JASON BINGO!
    - Press `P` to play or `Q` to quit.
    - Follow the on-screen game-play instructions
    - When you see a JASON from your game board, type in their name and hit `return`.
    - You win when you have three `X` in a row.
    
### Creation
- This app was created as a scalable bingo board for anyone to use. Feel free to fork/clone this repo and repurpose for your own uses. 
  - To make it your own:
  1. In `json_game.rb` adjust the game board size to an integer of your choosing. (With odd numbers the free space is in the middle of the board, with even numbers it is placed randomly)
  2. In the `make_board` method in that same file change the `jasons` variable to be an array of strings, integers, or whatever you would like your game board to be populated with.
  3. Start up the game using the instructions above and have a blast.
- Much of this game could stand a refactor to abstract some of the code to different classes or module. On the to-do list for future free time.
- The particular challenge of this game was creating an end game function that was dynamic and functional. In a future refactor I hope to use the Matrix logic for all of the `check_game_end?` logic.

