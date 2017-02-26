/* Pangu: The Myth of Creation, by James Hill. */

/* Loading */

:- use_module(library(lists), [ member/2, append/2 ]).

/* Dynamic variables. */

:- dynamic foundAxe/1, holding/1, i_am_at/1, object_at/2, years/1, creatures/1, at/3.

foundAxe(no).

holding(nothing).

i_am_at(chaos).

years(18000).

creatures([]).

object_at(egg, chaos).
object_at(egg, worldCenter).
object_at(axe, chaos).
object_at(dragon, worldNorth).
object_at(phoenix, worldSouth).
object_at(qilin, worldEast).
object_at(turtle, worldWest).
object_at(_, _).

at('cosmic Egg with a hole on the top', egg, chaos).
at('cosmic Egg with a hole on the top', egg, worldCenter).
at('coiling Dragon with long nostril hairs', dragon, worldNorth).
at('large flaming Pearl', pearl, worldNorth).
at('multi-coloured Phoenix with the tail of a fish', phoenix, worldSouth).
at('enormous Gemstone', gemstone, worldSouth).
at('scaly Qilin with hooves', qilin, worldEast).
at('long flowing Scroll', scroll, worldEast).
at('giant Turtle with a beard', turtle, worldWest).
at('massive bronze Coin', coin, worldWest).

/* Instructions for the game. */

instructions :-
	nl,
	write('Enter commands using standard Prolog syntax. Available commands are:'), nl,
	nl,
	write('	start.					-- to start the game.'), nl,
	write('	n.	s.	e.	w.		-- to go in that direction.'), nl,
	write('	take(Object).				-- to take an object.'), nl,
	write('	swing(Object).				-- to swing an object.'), nl,
	write('	look.					-- to look around you again.'), nl,
	write('	examine(Object).			-- to examine something in more detail.'), nl,
	write('	instructions.				-- to see this message again.'), nl,
	write('	halt.					-- to end the game and quit.'), nl,
	nl,
	write('You have 18000 years to create the world, each direction move takes 1000 years.'), nl.

/* Start the game, show instructions, and describe immediate environment. */

start :-
	instructions,
	look.

/* Explore the environment */

look :-
	i_am_at(Place), nl,
	describe(Place), nl,
	nl,
	followed_by,
	notice_objects_at(Place), nl,
	nl,
	nl.

describe(chaos) :-
	write('You stand in the midst of swirling chaos.'), nl,
	write('Yin spirals and twirls around Yang.'), nl,
	write('Yang spirals and twirls around Yin.').

describe(worldCenter) :-
	write('You stand between the Yin and Yang.'), nl,
	write('Murky Yin forms a ground beneath your feet.'), nl,
	write('Clear Yang forms a sky above your head.'), nl,
	write('But the Yin and Yang are starting to mix again.'), nl,
	nl,
	write('To the north you can see a flickering light.'), nl,
	write('To the south you can see a glinting blue figure.'), nl,
	write('To the east you can see a long white paper billowing and twisting.'), nl,
	write('To the west you can see a round dull object.').

describe(worldNorth) :-
	write('You stand between the Yin and Yang.'), nl,
	write('Murky Yin forms a ground beneath your feet.'), nl,
	write('Clear Yang forms a sky above your head.'), nl,
	write('But the Yin and Yang are starting to mix again.'), nl,
	nl,
	write('To the south you can see the cosmic Egg.').

describe(worldSouth) :-
	write('You stand between the Yin and Yang.'), nl,
	write('Murky Yin forms a ground beneath your feet.'), nl,
	write('Clear Yang forms a sky above your head.'), nl,
	write('But the Yin and Yang are starting to mix again.'), nl,
	nl,
	write('To the north you can see the cosmic Egg.').

describe(worldEast) :-
	write('You stand between the Yin and Yang.'), nl,
	write('Murky Yin forms a ground beneath your feet.'), nl,
	write('Clear Yang forms a sky above your head.'), nl,
	write('But the Yin and Yang are starting to mix again.'), nl,
	nl,
	write('To the west you can see the cosmic Egg.').

describe(worldWest) :-
	write('You stand between the Yin and Yang.'), nl,
	write('Murky Yin forms a ground beneath your feet.'), nl,
	write('Clear Yang forms a sky above your head.'), nl,
	write('But the Yin and Yang are starting to mix again.'), nl,
	nl,
	write('To the east you can see the cosmic Egg.').

/* Describe the objects in the environment */

notice_objects_at(Place) :-
	at(X, Object, Place),
	write('Nearby is a '), write(X), write('.'), nl, fail.

/* Examine objects in more detail */

examine(Object) :-
	i_am_at(Location), nl,
	detail(Object, Location),
	!, nl, look.

detail(axe, _) :-
	(foundAxe(yes)
	->
		write('The Axe is enormous; it has a wooden handle and stone head.')
	;
		write('There is nothing here with that name to examine.')).

detail(egg, chaos) :-
	(foundAxe(no)
	->
		retract(foundAxe(no)),
		assert(foundAxe(yes)),
		write('The cosmic Egg has the hole that you climbed out of on the top.'), nl,
		write('Inside the hole is an Axe.')
	;
		write('The cosmic Egg has the hole that you climbed out of on the top.')).

detail(egg, worldCenter) :-
	write('The cosmic Egg has the hole that you climbed out of on the top.').

detail(myself, _) :-
	write('You are an enormous hairy giant with horns on your head.').

detail(dragon, worldNorth) :-
	write('The coiling scaly Dragon has 4 legs and the head of a lion.').

detail(phoenix, worldSouth) :-
	write('The Phoenix has the beak of a rooster, neck of a snake, and tail of a fish.').

detail(qilin, worldEast) :-
	write('The Qilin has hooves and what looks like fire all over its body.').

detail(turtle, worldWest) :-
	write('The giant Turtle has a beard that shows he is very wise.').

detail(pearl, worldNorth) :-
	write('The massive Pearl is flaming brightly.').

detail(gemstone, worldSouth) :-
	write('The enormous Gemstone is sparkling blue and oval in shape.').

detail(scroll, worldEast) :-
	write('The long Scroll has magical characters that you cannot read written on it.').

detail(coin, worldWest) :-
	write('The humongous Coin is bronze and has a square hole in the centre.').

detail(yin, _) :-
	write('The Yin is very murky.').

detail(yang, _) :-
	write('The Yang is very clear.').

detail(_, _) :-
	write('There is nothing here with that name to examine.').

/* Move through the environment. */

n :- go(n).
s :- go(s).
e :- go(e).
w :- go(w).

go(Direction) :-
	years(Age),
	X is Age - 1000,
	(X == 0
	->
		nl,
		write('The Yin and Yang mix together for eternity.'), nl,
		write('For 1000 years you float in this void.'), nl,
		write('Slowly, you disintegrate as the Yin and Yang pull you apart.'), nl,
		nl,
		write('GAME OVER LOSER'),
		finish
	;
		retract(years(Age)),
		assert(years(X)),
		i_am_at(Here),
		location(Here, Direction),
		!,
		look,
		nl,
		write('You have '), write(X), write(' years left'), nl,
		nl
	).

location(chaos, _) :-
	nl,
	write('You travel for some time.'), nl,
	write('Up ahead you see something in the mist: the cosmic Egg.'), nl,
	write('It seems you have returned to where you started.'), nl.

location(_, Direction) :-
	i_am_at(Here),
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

path(worldNorth, _, worldNorth) :-
	nl,
	write('You walk some distance through the Yin and Yang but turn back in fear of getting lost.'), nl.

path(worldSouth, _, worldSouth) :-
	nl,
	write('You walk some distance through the Yin and Yang but turn back in fear of getting lost.'), nl.

path(worldEast, _, worldEast) :-
	nl,
	write('You walk some distance through the Yin and Yang but turn back in fear of getting lost.'), nl.

path(worldWest, _, worldWest) :-
	nl,
	write('You walk some distance through the Yin and Yang but turn back in fear of getting lost.'), nl.

/* Taking objects */

take(Object) :-
	i_am_at(Here),
	object_at(Object, Here), !, nl,
	canTake(Object, Here), !, nl,
	look.

canTake(egg, chaos) :-
	write('The Egg is floating amongst the Yin and Yang and cannot be taken.').

canTake(egg, worldCenter) :-
	write('The Egg is floating amongst the Yin and Yang and cannot be taken.').

canTake(axe, chaos) :-
	(foundAxe(yes)
	->	
		(holding(axe)
		->
			write('You already hold the axe.')
		;
			retract(object_at(axe, chaos)),
			retract(holding(nothing)),
			assert(holding(axe)),
			write('The Axe is now in your hands.')
		)
	; 	
		write('There is nothing called that to be taken.')
	).
	
canTake(dragon, worldNorth) :-
	(creaturesCheck(dragon)
	->
		write('The Dragon already follows you.')
	;
		creaturesAppend(dragon),
		retract(object_at(dragon, worldNorth)),
		retract(at(_, dragon, worldNorth)),
		write('You beckon to the Dragon to follow you.'), nl,
		write('The Dragon snorts fire from his nostrils, then twists and coils to follow you.')
	).

canTake(phoenix, worldSouth) :-
	(creaturesCheck(phoenix)
	->
		write('The Phoenix already follows you.')
	;
		creaturesAppend(phoenix),
		retract(object_at(phoenix, worldSouth)),
		retract(at(_, phoenix, worldSouth)),
		write('You beckon to the Phoenix to follow you.'), nl,
		write('The Phoenix starts to flap her wings, lifts up, and flies after you.')
	).

canTake(qilin, worldEast) :-
	(creaturesCheck(qilin)
	->
		write('The Qilin already follows you.')
	;
		creaturesAppend(qilin),
		retract(object_at(qilin, worldEast)),
		retract(at(_, qilin, worldEast)),
		write('You beckon to the Qilin to follow you.'), nl,
		write('The Qilin climbs up onto her hooves and trots over to follow you.')
	).

canTake(turtle, worldWest) :-
	(creaturesCheck(turtle)
	->
		write('The Turtle already follows you.')
	;
		creaturesAppend(turtle),
		retract(object_at(turtle, worldWest)),
		retract(at(_, turtle, worldWest)),
		write('You beckon to the Turtle to follow you.'), nl,
		write('The Turtle stands up, shakes his shell, and trundles over to follow you.')
	).

canTake(pearl, worldNorth) :-
	write('You reach for the Pearl but the flames burn your hand.').

canTake(gemstone, worldSouth) :-
	write('The enormous Gemstone is too heavy to lift').

canTake(scroll, worldEast) :-
	write('You try to gather the long Scroll into your arms but it blows too quickly between Ying and Yan.').

canTake(coin, worldWest) :-
	write('You try to lift the massive Coin but it is too heavy.').

canTake(_, _) :-
	write('There is nothing here with that name that can be taken.').

/* Swinging objects */

swing(Object) :-
	i_am_at(Here),
	holding(Holds),
	nl,
	swingResult(Object, Here, Holds),
	!,
	nl,
	look.

swingResult(axe, chaos, axe) :-
	write('You swing the Axe and cut apart the Yin and the Yang, separating them.'),
	retract(i_am_at(chaos)),
	assert(i_am_at(worldCenter)).

swingResult(axe, _, axe) :-
	write('You swing the Axe but nothing happens.').

swingResult(Something, _, _) :-
	write('You are not holding a '), write(Something), write('.').

swingResult(dragon, _, _) :-
	write('The Dragon twists out of your hands and cannot be swung.').

swingResult(phoenix, _, _) :-
	write('The Phoenix flies from between your hands and lands nearby.').

swingResult(qilin, _, _) :-
	write('The Qilin leaps from between your hands.').

swingResult(turtle, _, _) :-
	write('The Turtle is too heavy to lift!').

/* Check whether the player is being followed by any creatures and list them. */

followed_by :-
	followed_by_dragon,
	followed_by_phoenix,
	followed_by_qilin,
	followed_by_turtle,
	( (creaturesCheck(dragon); creaturesCheck(phoenix); creaturesCheck(qilin); creaturesCheck(turtle))
	->
		nl
	;
		true
	).

followed_by_dragon :-
	(creaturesCheck(dragon)
	->
		write('You are being followed by the Dragon.'), nl
	;
		true
	).

followed_by_phoenix :-
	(creaturesCheck(phoenix)
	->
		write('You are being followed by the Phoenix.'), nl
	;
		true
	).

followed_by_qilin :-
	(creaturesCheck(qilin)
	->
		write('You are being followed by the Qilin.'), nl
	;
		true
	).

followed_by_turtle :-
	(creaturesCheck(turtle)
	->
		write('You are being followed by the Turtle.'), nl
	;
		true
	).
	
/* Functions for checking and manipulating the Creatures list. */

creaturesCheck(Creature) :-
	creatures(PriorList),
	member(Creature, PriorList).

creaturesAppend(Creature) :-
	retract(creatures(PriorList)),
	append([Creature], PriorList, NewList),
	assert(creatures(NewList)).

/* Check that the player can finish the game. */

push(yin) :-
	( (creaturesCheck(dragon), creaturesCheck(phoenix), creaturesCheck(qilin), creaturesCheck(turtle) )
	->
		nl,
		write('You and your fellow creatures all push against the Yin.'), nl,
		write('The Yin moves away from the Yang,'), nl,
		gameWin
	;
		nl,
		write('You do not currently have enough strength to push against the Yin.'), nl,
		write('You strain but you cannot move the Yang.'), nl,
		write('Maybe you need more creatures to help.'), nl,
		nl, !
	).

push(yang) :-
	( (creaturesCheck(dragon), creaturesCheck(phoenix), creaturesCheck(qilin), creaturesCheck(turtle) )
	->
		nl,
		write('You and your fellow creatures all push against the Yang.'), nl,
		write('The Yang moves away from the Yin,'), nl,
		gameWin
	;
		nl,
		write('You do not currently have enough strength to push against the Yang.'), nl,
		write('You strain but you cannot move the Yin.'), nl,
		write('Maybe you need more creatures to help.'), nl,
		nl, !
	).

push(_) :-
	nl,
	write('You cannot push that.'), nl,
	nl.

gameWin :-
	write('The Yin and Yang are now separated.'), nl,
	nl,
	write('The Dragon flies away to the north.'), nl,
	write('The Phoenix flies away to the south.'), nl,
	write('The Qilin trots away to the east.'), nl,
	write('The Turtle plods away to the west.'), nl,
	nl,
	write('After 18000 years elapse you die.'), nl,
	write('Your breath becomes the wind, mist and cloud.'), nl,
	write('Your voice becomes the thunder.'), nl,
	write('Your left eye becomes the sun.'), nl,
	write('Your right eye becomes the moon.'), nl,
	write('Your head becomes mountains and extremes of the world.'), nl,
	write('Your blood becomes the rivers of the world.'), nl,
	write('Your muscles become the fertile lands.'), nl,
	write('Your facial hair becomes the stars an Milky Way.'), nl,
	write('Your fur becomes the bushes and forests.'), nl,
	write('Your bones become valuable minerals.'), nl,
	write('Your bone marrow becomes sacred diamonds.'), nl,
	write('Your sweat becomes the rain.'), nl,
	write('Your fleas on your fur become the animals.'), nl,
	nl,
	write('The world has formed and you will forever be remembered as the creator.'), nl,
	nl,
	write('THE END'), !.