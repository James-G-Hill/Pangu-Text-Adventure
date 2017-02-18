/* Pangu: The Myth of Creation, by James Hill. */

/* The instructions for the game */

instructions :-
	nl,
	write('Enter commands using standard Prolog syntax'), nl,
	write('Available commands are:'), nl,
	write(' start.			-- to start the game.'), nl,
	write('	n.	s.	e.	w.	-- to go in that direction.'), nl,
	write('	take(Object).	-- to pick up an object.'), nl,
	write('	drop(Object).	-- to drop an object.'), nl,
	write('	swing(Object).	-- to swing an object.'), nl,
	write('	lead(Object).	-- to lead an object.'), nl,
	write('	look.			-- to look around you again.'), nl,
	write('	instructions.	-- to see this message again.'), nl,
	write('	halt.			-- to end the game and quit.'), nl,
	nl.

/* Start the game, show instructions, and  */

start :-
	instructions,
	look.

/* Explore the environment */

look :-
	describe(Place),
	nl,
	notice_objects_at(Place),
	nl.

describe(chaos) :-
	write('You stand in the midst of swirling chaos.'), nl,
	write('Yin spirals and twirls around Yang.'), nl,
	write('Yang spirals and twirls around Yin.'), nl,
	write('Beside you is your broken Cosmic Egg.'), nl,
	write('The broken Cosmic Egg has the hole from you climbed on the top.'), nl.

describe(worldCenter) :-
	write('You stand between the Yin and Yang.'), nl,
	write('Murky Yin forms a ground beneath your feet.'), nl,
	write('Clear Yang forms a sky above your head.'), nl,
	write('But the Yin and Yang are starting to mix again.'), nl.

/* These rules describe the objects in the environment */

notice_objects_at(Place) :-
	at(X, Place),
	write('There is a '), write(X), write(' here.') nl,
	fail.