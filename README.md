namegame
========

Cheesy little game where defeating an opponent rewards an additional name

To run it:
  ruby nameGame.rb

Command list(to date: 4-14-13)

help - lists available commands

new - creates a new hero

list - lists living heroes

fallen - lists dead heroes

spar - initiates combat w/ no deaths and no name rewards

fight - initiates combat w/ death and name rewards

save - saves heroes and fallen to like .txt files *will overwrite indescriminately at the moment*

load - loads heroes and fallen *will overwrite current games creations*

*here is my disclaimer about the code at the moment... it's pretty messy.*
*as I figured out how things worked I sortof just plowed on and as a result it's not yet... pretty, but that will change soon.*

*post script disclaimer - I've forgotten any and all things about markdown*

enjoy

functionality goals
-------------------

improved saving and loading - currently overwrites existing files

* check start of program for options to load or just do it automatically

* throw a catch in for saving over existing info (this will be less important if prtevious option is done)

combatant selection is based of an integer choice pointing at the list, I'd like to have it so it parses input and compares it against available heroes.

* this may involve a revamp of the Hero class to make it viable.

weapons would be amusing, and there is already a start.

combat could use a bit more depth.

* revamp how it deals with close calls and potentially make them blocks or parries?

* expand health?

* this could be going to far for such a silly program...

Future translation into something that could be run on a website would be awesome.
