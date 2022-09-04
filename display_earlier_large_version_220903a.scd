var col, row, wd, wb, cv, cb;
col = ~xmat[0].size;
row = ~xmat.size;

r = Window.availableBounds;
wd = Window(\display, Rect(10, r.height-800, 800, 800)).front;
~wd = wd;
wd.background = Color.white;
wd.alwaysOnTop = true;
wb = wd.bounds;

cv = CompositeView(wd, wd.view.bounds.insetAll(100, 50, 100, 300));
cb = cv.bounds;

~scoTxt = Array.fill(2, {|i|
	var txt;
	txt = StaticText(wd, Rect(wb.width/2*i, wb.height-200, wb.width/2, 150));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 100);
	txt.align = \center;
});

~playerTxt = Array.fill(2, {|i|
	var txt;
	txt = StaticText(wd, Rect(wb.width/2*i, wb.height-250, wb.width/2, 50));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 40);
	txt.align = \center;
	txt.string = ["PHOENIX", "ALBATROSS"][i];
});

~winnerTxt = Array.fill(2, {|i|
	var txt;
	txt = StaticText(wd, Rect(wb.width/2*i, wb.height-50, wb.width/2, 50));
	txt.stringColor = Color.red;
	txt.font = Font("Arial", 40);
	txt.align = \center;
});


// Payoff Matrix
~payTxt = Array.fill(~xmat.flatten.size, {|i|
	var txt;
	txt = StaticText(cv, Rect(cb.width/(col+1)*(i%col+1), cb.height/(row+1)*((i/row).floor+1), cb.width/(col+1), cb.height/(row+1)));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 40);
	txt.align = \center;
	txt.string = ~xmat.flatten[i];
});

// Change color
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

// Labels of players
~labelY = StaticText(wd, Rect(100, 0, cb.width, 50));
~labelY.stringColor = Color.black;
~labelY.font = Font("Arial", 30);
~labelY.align = \center;
~labelY.string = "1st player";
~labelY.background = Color.gray(0.9);

~labelX = StaticText(wd, Rect(0, 50, 100, cb.height));
~labelX.stringColor = Color.black;
~labelX.font = Font("Arial", 30);
~labelX.align = \center;
~labelX.string = "2nd player";
~labelX.background = Color.gray(0.9);

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

// Labels of tactics
col.do{|i|
	var txt;
	txt = StaticText(cv, Rect(cb.width/(col+1)*(i%col+1), 0, cb.width/(col+1), cb.height/(row+1)));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 30);
	txt.align = \center;
	txt.string = i;
};

row.do{|i|
	var txt;
	txt = StaticText(cv, Rect(0, cb.height/(row+1)*(i+1), cb.width/(col+1), cb.height/(row+1)));
	txt.stringColor = Color.black;
	txt.font = Font("Arial", 30);
	txt.align = \center;
	txt.string = i;
};
