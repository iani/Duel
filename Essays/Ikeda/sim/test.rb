require_relative 'GameMatrix'

duel =
[[-1, 1, 3, -1, 1, -1], [1, -1, 3, -1, 1, -1], [2, -1, -3, 3, 1, -3], [-1, 3, 1, -2, -3, -1], [-1, 1, 2, 1, 1, -1], [-2, -2, -5, 1, -2, 3]]

duel.showMtx
puts ""

numGames = 100;
numMoves = 17;

2.times{|ply|
  2.times{|tac|
    freq = [0] * 36
    xwin = 0

    numGames.times{|n|
      g = GameMatrix.new(duel, ply)
      g.aGame(tac, numMoves)
      xwin += g.xWin
      freq = freq.zip(g.freq).map(&:sum)
    }

    p [ply, tac]
    freq.to_mat(6).showMtx
    p freq.count{|e| e > 0}
    p freq.unusedTactic? (duel.size)
    p xwin / numGames.to_f
    puts ""
  }
}
