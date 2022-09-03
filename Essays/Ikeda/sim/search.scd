(
/* Data */
var numGames, numMoves, tactic, winRateX;

/* Fuctions */
var getTactic;

~path = thisProcess.nowExecutingPath.dirname;
(~path +/+ "func.scd").load;

/* Tries multiple random matrices */
1000.do{

	/* Randomly generate a matrix */
	~matRand = [];

	6.do{
		a = [];
		6.do{
			b = [-3,-1,1,3].choose;
			a = a.add(b);
		};
		~matRand = ~matRand.add(a);
	};

	numGames = 100;
	numMoves = 17;	// Number of moves resulting in points + 1

	/* Try about both players */
	~cond = true;
	2.do{|pl|
		~setup.({ ~xmat = ~matRand });

		numGames.do{
			var move = 0;
			var cond = true;

			~player = pl;
			~opponent = 1 - ~player;

			~prevTactics = [nil, nil];
			~scores = [0, 0];

			while ({ (move < numMoves) && cond }, {

				/* Choose a strategy */
				getTactic = ~getMaxval;
				// getTactic = ~miniMax;

				tactic = getTactic.(move);
				~calcProfit.(tactic);
				~prevTactics[~player] = tactic;
				~switchPlayers.();
				~addCell.(move);

				/* Interrupt when the score difference is too large */
				if((~scores[0] - ~scores[1]).abs > 10) { cond = false };

				move = move + 1;
			});

			~countXwin.();
		};

		winRateX = ~xWon / numGames;
		a = (winRateX - 0.5).abs < 0.1;
		// b = ~checkUnusedTactic.(~freq);
		if(a == false, { ~cond = false });
	};

	if(~cond, {
		~xmat.postln;
		// ~countCells.(0).postln;
	});
};
)

