if (~wd.notNil) { ~wd.close };
~length = 16;			// Length of game (must be an even number for fairness)
~game = 1 - ~game;		// Change the first attacker every time
~total = ~total + 1;
Duel.setup;
