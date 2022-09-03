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
	// if((move > 1) && (oddment.sum > 1), {
	// 	oddment[~prevTactics[~player]] = 0;		// Avoid repetition of the same tactic
	// });
	oddment = oddment.normalizeSum;
	(0..(~mat[~player].size-1)).wchoose(oddment);
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
	// if((move > 1) && (oddment.sum > 1), {
	// 	oddment[~prevTactics[~player]] = 0;		// Avoid repetition of the same tactic
	// });
	oddment = oddment.normalizeSum;
	(0..(~mat[~player].size-1)).wchoose(oddment);
};


// ===== FUNCTIONS =====

~setup = {|func|

	// Laysan Albatross' matrix
	~matWell = [
		[5, -3, 5, -3, 7, 7, 3],
		[5, -5, 5, 5, 7, -5, -5],
		[5, 5, -7, 5, -7, 7, -7],
		[-3, 5, -3, -3, 7, 7, 3],
		[-7, 5, 5, -7, 7, 7, -7],
		[-7, 5, 5, -7, 7, -7, -7],
		[5, -7, 5, 5, -7, 7, -7],
	];

	// Matrix from Xenakis' Duel
	~matDuel = [
		[-1, 1, 3, -1, 1, -1],
		[1, -1, -1, -1, 1, -1],
		[3, -1, -3, 5, 1, -3],
		[-1, 3, 3, -1, -1, -1],
		[1, -1, 1, 1, -1, -1],
		[-1, -1, -3, -1, -1, 3],
	];

	func.value;

	~ymat = ~xmat.flop.neg;
	~mat = [~xmat, ~ymat];
	~cells = [];
	~xWon = 0;
};

~showMatrix = {|mat|
	mat.do{|x| x.do{|y| (y + "\t").post}; "".postln };
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
		var dim, cellIndex;
		dim = ~xmat.size;
		cellIndex = ~prevTactics[0] * dim + ~prevTactics[1];
		~cells = ~cells.add(cellIndex);
	});
};

~countXwin = {
	if(~scores[0] > ~scores[1], { ~xWon = ~xWon + 1 });
};

~countCells = {|disp|
	var dim, freq;
	dim = ~xmat.size;
	~freq = Array.fill2D(dim, dim, {|row, col| row * dim + col});
	~freq = ~freq.collect{|f| f.collect{|e| ~cells.count{|c| c == e }}};
	disp !? { ~showMatrix.(~freq) };
	~freq.flatten.count{|e| e > 0};
};

~applyGamevalue = {|gameValue, numMoves|
	var gv = gameValue * numMoves;
	~scores = [~scores[0] + gv, ~scores[1] - gv];
};

~checkUnusedTactic = {|mat|
	var ans = true;
	mat.collect{|e| e.sum}.indexOf(0) !? { ans = false };
	mat = mat.flop;
	mat.collect{|e| e.sum}.indexOf(0) !? { ans = false };
	ans;
}