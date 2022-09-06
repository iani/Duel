Duel.func;

~setup.();

Duel.display;

~player = ~chef;	// PHOENIX : ALBATROSS = Chef X : Y
~opponent = 1 - ~player;
~turn = -1;

~prevTactics = [nil, nil];
~scores = [0, 0];
~labelPlayers.();

~tactic = {|tactic, func|
	~turn = ~turn + 1;
	("Turn" + ~turn).postln;
	\duel.changed(\turnText, format("%(%)", ~round, ~length - ~turn));
	~calcProfit.(tactic);
	~colMatrix.(tactic);
	~prevTactics[~player] = tactic;
	~switchPlayers.();

	t = ["PHOENIX", "ALBATROSS"][~chef + ~turn % 2] + "chose Tactic" + tactic;
	t.postln;

	o = ~scores;
	// o = ~scores.rotate(~chef);
	("Score" + o[0] + ":" + o[1]).postln;
	\duel.changed(\score, [o]);
	\duel.changed(\changePlayer, ~chef + ~turn + 1);

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

t = "ROUND " ++ ~round;
t.postln;

t = ["PHOENIX", "ALBATROSS"][~chef];
t = "FIRST ATTACK : " ++ t;

\duel.changed(\changePlayer, ~chef);
t.postln;