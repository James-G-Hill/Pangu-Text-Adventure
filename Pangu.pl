/* Pangu: The Myth of Creation, by James Hill.
Dynamic variables. */

i_am_at(chaos).

/* Instructions for the game. */

instructions :-
	nl,
	write('Enter commands using standard Prolog syntax. Available commands are:'), nl, nl,
	write('	start.					-- to start the game.'), nl,
	write('	n.	s.	e.	w.		-- to go in that direction.'), nl,
	write('	take(Object).				-- to pick up an object.'), nl,
	write('	drop(Object).				-- to drop an object.'), nl,
	write('	swing(Object).				-- to swing an object.'), nl,
	write('	lead(Object).				-- to lead an object.'), nl,
	write('	look.					-- to look around you again.'), nl,
	write('	examine(Object).			-- to examine something in more detail.'), nl,
	write('	instructions.				-- to see this message again.'), nl,
	write('	halt.					-- to end the game and quit.'), nl,
	nl.

/* Start the game, show instructions, and describe immediate environment. */

start :-
	instructions,
	look.

/* Explore the environment */

look :-
	i_am_at(Place),
	describe(Place), nl,
	notice_objects_at(Place), nl.

describe(chaos) :-
	write('You stand in the midst of swirling chaos.'), nl,
	write('Yin spirals and twirls around Yang.'), nl,
	write('Yang spirals and twirls around Yin.'), nl.

describe(worldCenter) :-
	write('You stand between the Yin and Yang.'), nl,
	write('Murky Yin forms a ground beneath your feet.'), nl,
	write('Clear Yang forms a sky above your head.'), nl,
	write('But the Yin and Yang are starting to mix again.'), nl.

describe(worldNorth) :-
	describe(worldCenter).

describe(worldSouth) :-
	describe(worldCenter).

describe(worldEast) :-
	describe(worldCenter).

describe(worldWest) :-
	describe(worldCenter).

/* Describe the objects in the environment */

notice_objects_at(Place) :-
	at(X, Place),
	write('Nearby is a '), write(X), write('.'), nl,
	fail.

notice_objects_at(_).

at('cosmic Egg with a hole on the top', chaos).
at('giant Turtle with a beard', worldNorth).
at('scaly Qilin with hooves', worldSouth).
at('multi-coloured Phoenix with the tail of a fish', worldEast).
at('coiling dragon with long nostril hairs', worldWest).

/* Examine objects in more detail */

examine(Object) :-
	detail(Object, X),
	write(X).

detail(egg, 'The cosmic Egg has the hole that you climbed out of on the top. Inside the hole is an Axe.').
detail(axe, 'The Axe is enormous; it has a wooden handle and stone head.').
detail(turtle, 'The giant Turtle has a beard that shows he is very wise.').
detail(qilin, 'The Qilin has hooves and what looks like fire all over its body.').
detail(phoenix, 'The Phoenix has the beak of a rooster, neck of a snake, and tail of a fish.').
detail(dragon, 'The coiling scaly dragon has 4 legs and the head of a lion.').
detail(myself, 'You are an enormous hairy giant with horns on your head.').
