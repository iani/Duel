// ===== STRATEGIES =====

~miniMax = {|move|
	var xpl, xProfit, xLoss, oddment;

	xpl = ~mat[~player].collect{|e|				// Expected profit and loss
		if(move > 0, {
			xProfit = e.at(~prevTactics[~opponent]);	// Player's own gain for this move
		}, {
			xProfit = 0;						// Because ~prevTactics[~opponent] == nil
		});
		xLoss = e.minItem;						// Opponent's gain for the next move
		xProfit + xLoss;
	};
	oddment = xpl.collect{|e| (e == xpl.maxItem).binaryValue};
	if((move > 1) && (oddment.sum > 1), {
		oddment[~prevTactics[~player]] = 0;		// Avoid repetition of the same tactic
	});
	oddment = oddment.normalizeSum;
	(0..~dim-1).wchoose(oddment);
};

~getMaxval = {|move|
	var xpl, xProfit, oddment;

	xpl = ~mat[~player].collect{|e|				// Expected profit and loss
		if(move > 0, {
			xProfit = e.at(~prevTactics[~opponent]);	// Player's own gain for this move
		}, {
			xProfit = 0;						// Because ~prevTactics[~opponent] == nil
		});
		xProfit;
	};
	oddment = xpl.collect{|e| (e == xpl.maxItem).binaryValue};
	if((move > 1) && (oddment.sum > 1), {
		oddment[~prevTactics[~player]] = 0;		// Avoid repetition of the same tactic
	});
	oddment = oddment.normalizeSum;
	(0..~dim-1).wchoose(oddment);
};


// ===== FUNCTIONS =====

~setup = {
	// ~xmat = [];
	//
	// 7.do{
	// 	a = [];
	// 	7.do{
	// 		b = [-1,1].choose * [3,5,7].choose;
	// 		a = a.add(b);
	// 	};
	// 	~xmat = ~xmat.add(a);
	// };

	~xmat = [
		[-1, 1, 3, -1, 1, -1],
		[1, -1, 3, -1, 1, -1],
		[2, -1, -3, 3, 1, -3],
		[-1, 3, 1, -2, -3, -1],
		[-1, 1, 2, 1, 1, -1],
		[-2, -2, -5, 1, -2, 3]
	];

	// ~xmat.postln;

	~ymat = ~xmat.flop.neg;
	~mat = [~xmat, ~ymat];
	~cells = [];
	~xWon = 0;
	~dim = ~xmat.size;
};

~calcProfit = {|tactic|
	~prevTactics[~opponent] !? {
		var profit = ~mat[~player][tactic].at(~prevTactics[~opponent]);
		~scores[~player] = ~scores[~player] + profit;
	};
};

~switchPlayers = {
	~player = 1 - ~player;
	~opponent = 1 - ~player;
};

~addCell = {|move|
	if(move > 0, {
		var cellIndex = ~prevTactics[0] * ~dim + ~prevTactics[1];
		~cells = ~cells.add(cellIndex);
	});
};

~countXwin = {
	if(~scores[0] > ~scores[1], { ~xWon = ~xWon + 1 });
};

~countCells = {
	var freq = Array.fill2D(~dim, ~dim, {|row, col| row * ~dim + col});
	freq = freq.collect{|f| f.collect{|e| ~cells.count{|c| c == e }}};
	freq.do{|f| f.do{|e| (e+"\t").post}; "".postln };
};

~applyGamevalue = {|gameValue, numMoves|
	var gv = gameValue * numMoves;
	~scores = [~scores[0] + gv, ~scores[1] - gv];
};