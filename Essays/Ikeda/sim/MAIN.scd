(
/* Data */
var numGames, numMoves, tactic, winRateX;

/* Fuctions */
var getTactic;

~path = thisProcess.nowExecutingPath.dirname;
(~path +/+ "func.scd").load;


/* Verify two players separately */
2.do{|pl|

	/* Select a game matrix to verify */
	// ~setup.({~xmat = ~matWell});	// Well-tuned 7x7 matrix
	~setup.({~xmat = ~matDuel});	// Game matrix from Xenakis' Duel

	numGames = 1000;
	numMoves = 21;	// Number of moves resulting in points + 1
	~xWon = 0;
	("\nPlayer" + pl + "first").postln;

	numGames.do{|n|
		~player = pl;
		~opponent = 1 - ~player;

		~prevTactics = [nil, nil];
		~scores = [0, 0];

		numMoves.do{|move|

			/* Choose a strategy */
			// getTactic = ~getMaxval;
			getTactic = ~miniMax;

			tactic = getTactic.(move);
			~calcProfit.(tactic);
			~prevTactics[~player] = tactic;
			~switchPlayers.();
			~addCell.(move);

			/* Display the moves and the scores */
			if ( numGames == 1 ) { ~prevTactics.post; ~scores.postln };
		};

		/* Move the total number of moves * 0.07 points from Y to X */
		// ~applyGamevalue.(0.07, numMoves);

		~countXwin.();
	};

	/* Display the frequency of occurrence of cells */
	~countCells.(0).postln;

	/* Let's call it fair game if X wins 40-60% of the time */
	winRateX = ~xWon / numGames;
	a = (winRateX - 0.5).abs < 0.1;
	// b = ~countCells.() > 24;
	c = ~checkUnusedTactic.(~freq);
	[winRateX, a, c].postln;
};
)

