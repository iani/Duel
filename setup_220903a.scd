// ~path = thisProcess.nowExecutingPath.dirname;
// (~path +/+ "func.scd").load;
Duel.func;

~setup.();

// (~path +/+ "display.scd").load;
Duel.display;

~player = 1;
~opponent = 1 - ~player;
~turn = -1;

~prevTactics = [nil, nil];
~scores = [0, 0];
~labelPlayers.();

~tactic = {|tactic, func|
	~turn = ~turn + 1;
	("Turn" + ~turn).postln;
	// TODO !!!!!!!!!!!  ============
	\duel.changed(\turnText, format("%:%", ~total, ~length - ~turn));
	// ~turnTxt.string = ~length - ~turn;
	~calcProfit.(tactic);
	~colMatrix.(tactic);
	~prevTactics[~player] = tactic;
	~switchPlayers.();

	t = ["PHOENIX", "ALBATROSS"][~game + ~turn % 2] + "chose Tactic" + tactic;
	t.postln;
	o = ~scores.rotate(~game + 1);
	(o[0] + ":" + o[1]).postln;
	// TODO !!!!!!!!!!!  ============
	\duel.changed(\score, [o]);
	2.do{|i| ~scoTxt[i].string = o[i] };
	// TODO !!!!!!!!!!!  ============
	~playerTxt[~turn + ~game - 1 % 2].background = Color.new(1, 0.8, 0);
	// TODO !!!!!!!!!!!  ============
	~playerTxt[~turn + ~game % 2].background = Color.white;

	// Finish the game
	if(~turn == ~length, {

	// TODO !!!!!!!!!!!  ============
		~payTxt.do{|e| e.background = Color.white };
	// TODO !!!!!!!!!!!  ============
		2.do{|i| ~playerTxt[i].background = Color.white };
		if(o[0] == o[1], {
			"DRAW".postln;
	// TODO !!!!!!!!!!!  ============
			2.do{|i| ~winnerTxt[i].string = "DRAW" };
		}, {
			if(o[0] > o[1], {
				"PHOENIX WINS".postln;
	// TODO !!!!!!!!!!!  ============
				~winnerTxt[0].string = "WINNER";
			}, {
				"ALBATROSS WINS".postln;
	// TODO !!!!!!!!!!!  ============
				~winnerTxt[1].string = "WINNER";
			});
		});
	});

	{ ~wd.front; }.defer;
	// Evaluate the synth code
	func.value;
};

t = "ROUND " ++ ~total;
t.postln;

t = ["PHOENIX", "ALBATROSS"][~game];
t = "FIRST ATTACK : " ++ t;
~playerTxt[~game].background = Color.new(1, 0.8, 0);
t.postln;

// OscGroups.enable;