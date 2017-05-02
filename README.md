# PANGU: THE MYTH OF CREATION README #

In this game the player acts out the role of the Chinese mythical creature Pangu during the time when he supposedly created the world.

Pangu appears floating in a cosmic egg between mixed up yin and yang.  He uses an axe to sunder the yin and yang.  He then gathers the four magical creatures: dragon, phoenix, qilin and turtle, and with their help pushes the yin and yang apart.  He then dies and his body becomes the universe.

### How does the game satisfy the requirements of the brief? ###

# The locked door #

The locked door is symbolised by the swirling void of yin and yang.
The player will find that they cannot go anywhere until they swing an axe to cut the yin and yang.
Cutting the yin and yang changes the environment, representing a movement from one to another, just as a locked door would.
This is implemented by a rule for holding an axe to be modified by the players actions, and for them to perform the 'swing' action.

# Hidden object #

The hidden object is the axe with which Pangu cuts the ying and yang.
The axe is hidden inside the remnants of the egg from which Pangu climbed.
The axe is hidden from the player until they 'examine' the egg.

# Incomplete object #

After the yin and yang is cut 4 creatures appear in the world:

	- The Turtle
	- The Qilin
	- The Phoenix
	- The Dragon
	
Pangue must bring the creatures together as a team to push the earth and sky apart.
The creatures are entered into a list when the player 'takes' them.
When the list is complete the player can end the game via the 'push(yin)' or 'push(yang)' commands.

# Limited resource #

The limited resource is time.
After 18,000 years Pangu will die.
Each movement between environments in the game represents 1000 years.
If Pangu dies before the earth and sky are separated then the yin and yang will mix together again.
The number of years remaining is contained in a fact that re-asserted with arithmetic after each movement.

### What is this repository for? ###

A prolog program for the coursework 2 of the Programming Paradigms module academic year 2016/2017.

### Who do I talk to? ###

Contact James Hill on j.g.hill@zoho.com