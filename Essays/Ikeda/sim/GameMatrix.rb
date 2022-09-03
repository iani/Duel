class GameMatrix
  attr_accessor :scores, :freq

  def initialize (_xmat, _first)
    @xmat = _xmat
    @ymat = @xmat.transpose.map{|e| e.map{|f| -1*f}}
    @mat = [@xmat, @ymat]
    @freq = [0] * @xmat.size * @ymat.size
    @prevTactics = [nil, nil]
    @scores = [0, 0]
    @player = _first
    @move = 0
    @cells = []
  end

  def maxVal
    xpl = @mat[@player].map{|e|
      @move == 0 ? 0 : e[@prevTactics[1 - @player]]
    }
    xpl = xpl.map.with_index{|e,i| e == xpl.max ? i : nil} - [nil]
    xpl.shuffle[0]
  end

  def miniMax
    xpl = @mat[@player].map{|e|
      x = @move == 0 ? 0 : e[@prevTactics[1 - @player]]
      x + e.min
    }
    xpl = xpl.map.with_index{|e,i| e == xpl.max ? i : nil} - [nil]
    xpl.shuffle[0]
  end

  def calcProfit (tactic)
    if @prevTactics[1 - @player] != nil
      profit = @mat[@player][tactic][@prevTactics[1 - @player]]
      @scores[@player] += profit
    end
  end

  def switchPlayers (tactic)
    @prevTactics[@player] = tactic
    @player = 1 - @player
    if @move > 0
      cellIdx = @prevTactics[0] * @xmat.size + @prevTactics[1];
      @cells << cellIdx;
    end
    @move += 1
  end

  def xWin
    @scores[0] > @scores[1] ? 1 : 0
  end

  def calcFreq
    @cells.each{|e| @freq[e] += 1}
  end

  def aGame (tactic, numMoves)
  	numMoves.times{|i|
  		ta = tactic == 0 ? self.maxVal : self.miniMax
  		self.calcProfit(ta)
  		self.switchPlayers(ta)
  	}
    self.calcFreq
  end
end

class Array
  def deepcopy
    Marshal.load(Marshal.dump(self))
  end

  def to_mat (dim)
    self.each_slice(dim).to_a
  end

  def showMtx
    self.each{|e|
      e.each{|f| print "#{f}\t" }
      puts ""
    }
  end

  def unusedTactic? (dim)
    freq = self.to_mat(dim)
    x = freq.map(&:sum).include?(0)
    freq = freq.transpose
    y = freq.map(&:sum).include?(0)
    x || y
  end
end
