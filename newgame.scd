if (~wd.notNil) { ~wd.close };
~length = 16;			// Length of game (must be an even number for fairness)
~chef = 1 - ~chef;		// Switch the first attacker
~round = ~round + 1;
Duel.setup;
