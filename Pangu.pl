/* Pangu: The Myth of Creation, by James Hill.
Dynamic variables. */

:- dynamic holding/1, i_am_at/1, object_at/2.

holding(nothing).

i_am_at(chaos).

object_at(egg, chaos).
object_at(egg, worldCenter).
object_at(axe, chaos).
object_at(dragon, worldNorth).
object_at(phoenix, worldSouth).
object_at(qilin, worldEast).
object_at(turtle, worldWest).
object_at(_, _).

/* Instructions for the game. */

instructions :-
	nl,
	write('Enter commands using standard Prolog syntax. Available commands are:'), nl, nl,
	write('	start.					-- to start the game.'), nl,
	write('	n.	s.	e.	w.		-- to go in that direction.'), nl,
	write('	take(Object).				-- to pick up an object.'), nl,
	write('	swing(Object).				-- to swing an object.'), nl,
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
	nl, describe(Place), nl,
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
	write('Nearby is a '), write(X), write('.'), nl, fail.

notice_objects_at(_).

at('cosmic Egg with a hole on the top', chaos).
at('giant Turtle with a beard', worldNorth).
at('scaly Qilin with hooves', worldSouth).
at('multi-coloured Phoenix with the tail of a fish', worldEast).
at('coiling dragon with long nostril hairs', worldWest).

/* Examine objects in more detail */

examine(Object) :-
	detail(Object, X),
	nl, write(X), !, nl, nl.

detail(axe, 'The Axe is enormous; it has a wooden handle and stone head.').
detail(dragon, 'The coiling scaly Dragon has 4 legs and the head of a lion.').
detail(egg, 'The cosmic Egg has the hole that you climbed out of on the top. Inside the hole is an Axe.').
detail(myself, 'You are an enormous hairy giant with horns on your head.').
detail(phoenix, 'The Phoenix has the beak of a rooster, neck of a snake, and tail of a fish.').
detail(qilin, 'The Qilin has hooves and what looks like fire all over its body.').
detail(turtle, 'The giant Turtle has a beard that shows he is very wise.').
detail(yin, 'The Yin is very murky.').
detail(yang, 'The Yang is very clear.').
detail(_, 'There is nothing with that name to examine.').

/* Move through the environment. */

n :- go(n).
s :- go(s).
e :- go(e).
w :- go(w).

go(Direction) :-
	i_am_at(Here),
	location(Here),
	!, look.

location(chaos) :-
	nl,
	write('You travel for some time.'), nl,
	write('Up ahead you see something in the mist: the cosmic Egg.'), nl,
	write('It seems you have returned to where you started.'), nl, nl.

location(-) :-
	path(Here, Direction, There),
	retract(i_am_at(Here)),
	assert(i_am_at(There)).

path(worldCenter, n, worldNorth).
path(worldCenter, s, worldSouth).
path(worldCenter, e, worldEast).
path(worldCenter, w, worldWest).

path(worldNorth, s, worldCenter).
path(worldSouth, n, worldCenter).
path(worldEast, w, worldCenter).
path(worldWest, e, worldCenter).

/* Taking objects */

take(Object) :-
	i_am_at(Here),
	object_at(Object, Here),
	holding(Something),
	nl,
	canTake(Object, Here, Something), !,
	nl, nl.

canTake(egg, _, _) :-
	write('The Egg is floating amongst the Yin and Yang and cannot be taken.').

canTake(axe, chaos, _) :-
	retract(object_at(axe, chaos)),
	retract(holding(nothing)),
	assert(holding(axe)),
	write('The Axe is now in your hands.').

canTake(axe, _, axe) :-
	write('You already have the Axe.').

canTake(dragon, worldNorth, _) :-
	write('You beckon to the Dragon to follow you.'), nl,
	write('The Dragon snorts fire from his nostrils, then twists and coils to follow you.').

canTake(phoenix, worldSouth, _) :-
	write('You beckon to the Phoenix to follow you.'), nl,
	write('The Phoenix starts to flap her wings, lifts up, and flies after you.').

canTake(qilin, worldEast, _) :-
	write('You beckon to the Qilin to follow you.'), nl,
	write('The Qilin climbs up onto her hooves and trots over to follow you.').

canTake(turtle, worldWest, _) :-
	write('You beckon to the Turtle to follow you.'), nl,
	write('The Turtle stands up, shakes his shell, and trundles over to follow you.').

canTake(_, _, _) :-
	write('That cannot be taken.').

/* Swinging objects */

swing(Object) :-
	i_am_at(Here),
	holding(Holds),
	nl,
	swingResult(Object, Here, Holds),
	nl, look.

swingResult(axe, chaos, axe) :-
	write('You swing the axe and cut apart the Yin and the Yang, separating them.'),
	retract(i_am_at(chaos)),
	assert(i_am_at(worldCenter)).

swingResult(axe, _, axe) :-
	write('You swing the axe but nothing happens.').

swingResult(Something, _, _) :-
	write('You are not holding a '), write(Something), write('.').

swingResult(dragon, _, dragon) :-
	write('The Dragon twists out of your hands and cannot be swung.').

swingResult(phoenix, _, _) :-
	write('The Phoenix flies from between your hands and lands nearby.').

swingResult(qilin, _, _) :-
	write('The Qilin leaps from between your hands.').

swingResult(turtle, _, _) :-
	write('The Turtle is too heavy to lift!').