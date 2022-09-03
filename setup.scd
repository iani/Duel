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
	\duel.changed(\turnText, format("%(%)", ~total, ~length - ~turn));
	~calcProfit.(tactic);
	~colMatrix.(tactic);
	~prevTactics[~player] = tactic;
	~switchPlayers.();

	t = ["PHOENIX", "ALBATROSS"][~game + ~turn % 2] + "chose Tactic" + tactic;
	t.postln;
	o = ~scores.rotate(~game + 1);
	("Score" + o[0] + ":" + o[1]).postln;
	\duel.changed(\score, [o]);
	\duel.changed(\changePlayer, ~game + ~turn + 1);

	// Finish the game
	if(~turn == ~length, {

		\duel.changed(\clearPay);
		\duel.changed(\clearPlayer);
		if(o[0] == o[1], {
			"DRAW".postln;
			\duel.changed(\draw);
		}, {
			if(o[0] > o[1], {
				"PHOENIX WINS".postln;
				\duel.changed(\winner, 0);
			}, {
				"ALBATROSS WINS".postln;
				\duel.changed(\winner, 1);
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
// ~playerTxt[~game].background = Color.new(1, 0.8, 0);
\duel.changed(\changePlayer, ~game);
t.postln;

// OscGroups.enable;