/* 29 Aug 2022 22:39
New version by Takumi Ikeda
*/

var col, row, wb, cv, cb;
col = ~xmat[0].size;
row = ~xmat.size;

r = Window.availableBounds;
~wd = Window(\display, Rect(10, r.height-600, 500, 500)).front;
~wd.background = Color.white;
~wd.alwaysOnTop = true;
wb = ~wd.bounds;

// Score board
~playerTxt = Array.fill(2, {|i|
	var txt;
	txt = StaticText(~wd, Rect(wb.width/2*i, wb.height-180, wb.width/2, 45));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 25);
	txt.align = \center;
	txt.string = ["PHOENIX", "ALBATROSS"][i];
});

~scoTxt = Array.fill(2, {|i|
	var txt;
	txt = StaticText(~wd, Rect(wb.width/2*i, wb.height-135, wb.width/2, 90));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 100);
	txt.align = \center;
	txt.addNotifier(\duel, \score, { | n, score, morestuff |
		"debugging score arguments.".postln;
		postln("n is" + n);
		postln("score is" + score);
		postln("morestuff is" + morestuff);
		txt.string = score[i];
	})
});

~winnerTxt = Array.fill(2, {|i|
	var txt;
	txt = StaticText(~wd, Rect(wb.width/2*i, wb.height-45, wb.width/2, 45));
	txt.stringColor = Color.red;
	txt.font = Font("Arial", 30);
	txt.align = \center;
});

// Payoff Matrix
cv = CompositeView(~wd, ~wd.view.bounds.insetAll(40, 40, 0, 180));
cb = cv.bounds;

~payTxt = Array.fill(~xmat.flatten.size, {|i|
	var txt;
	txt = StaticText(cv, Rect(cb.width/(col+1)*(i%col+1), cb.height/(row+1)*((i/row).floor+1), cb.width/(col+1), cb.height/(row+1)));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 30);
	txt.align = \center;
	txt.string = ~xmat.flatten[i];
});

// Change color of cells
~colMatrix = {|tactic|
	~payTxt.do{|e,i|
		e.background = Color.white;
		if(~player == 1, {
			if(i%col == tactic, { e.background = Color.new(0.8, 1, 0) });
		}, {
			if((i/row).floor == tactic, { e.background = Color.new(0.8, 1, 0) });
		});
	};
};

// Labels of tactics
col.do{|i|
	var txt;
	txt = StaticText(cv, Rect(cb.width/(col+1)*(i%col+1), 0, cb.width/(col+1), cb.height/(row+1)));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 20);
	txt.align = \center;
	txt.string = i;
};

row.do{|i|
	var txt;
	txt = StaticText(cv, Rect(0, cb.height/(row+1)*(i+1), cb.width/(col+1), cb.height/(row+1)));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 20);
	txt.align = \center;
	txt.string = i;
};

// Labels of players
~labelY = StaticText(~wd, Rect(40, 0, cb.width, 40));
~labelY.background = Color.gray(0.9);
~labelY.stringColor = Color.black;
~labelY.font = Font("Arial", 20);
~labelY.align = \center;

~labelX = StaticText(~wd, Rect(0, 40, 40, cb.height));
~labelX.background = Color.gray(0.9);
~labelX.stringColor = Color.black;
~labelX.font = Font("Arial", 20);
~labelX.align = \center;

~labelPlayers = {
	t = ["PHOENIX", "ALBATROSS"].rotate(~game);
	~labelY.string = t[0];
	a = "";
	d = t[1].ascii;
	d.do{|e,i|
		if(i < (d.size - 1), {
			a = a ++ e.asAscii ++ "\n";
		}, {
			a = a ++ e.asAscii;
		});
	};
	~labelX.string = a;
};

~turnTxt = StaticText(~wd, Rect(0, 0, 80, 40));
~turnTxt.stringColor = Color.black;
~turnTxt.font = Font("Arial", 30);
~turnTxt.align = \center;
~turnTxt.addNotifier(\duel, \turnText, { | n, value |
	"Explaining how we communicate turnText to the display: ".post;
	[n, value].postln;
	n.listener.string = value;
})