require_relative 'GameMatrix'

duel = [
		[-1, 1, 3, -1, 1, -1],
		[1, -1, -1, -1, 1, -1],
		[3, -1, -3, 4, 1, -3],		# 5 -> 4
		[-1, 3, 3, -1, -1, -1],
		[1, -1, 1, 1, -1, -1],
		[-1, -1, -3, -1, -1, 3],
]

class Array
  def variant (id)
		dim = self.size
		len = dim ** 2
    ary = self.deepcopy.flatten
    a = id / len < 1 ? -1 : 1
    ary[id % len] += a
    ary[id % len] += a if ary[id % len] == 0
    ary.to_mat(dim)
  end
end


numGames = 200
numMoves = 17
numGenerations = 30
numVariant = duel.flatten.size * 2

numGenerations.times{
  dat = []

  numVariant.times{|id|
    du = duel.variant(id)
		xWinRtDev = []
		zeroCell = []
		unusedTac = []

		2.times{|ply|
			2.times{|tac|
				freq = [0] * 36
	    	xwin = 0

	    	numGames.times{|n|
					g = GameMatrix.new(du, ply)
					g.aGame(tac, numMoves)
		      xwin += g.xWin
		      freq = freq.zip(g.freq).map(&:sum)
		    }

				xWinrate = xwin / numGames.to_f
				deviation = (0.5 - xWinrate).abs
				xWinRtDev << deviation
				zeroCell << freq.count(0)
				unusedTac << a = freq.unusedTactic?(6) ? 1 : 0
			}
		}
		zeroCellDev = zeroCell.map{|e| (e - zeroCell.sum / 4.0).abs}
		dat << [id, unusedTac, xWinRtDev, zeroCell, zeroCellDev]
  }

	dat = dat.sort{|a,b|
		(a[1].sum <=> b[1].sum).nonzero? ||
		(a[2].sum <=> b[2].sum).nonzero? ||
		(a[3].sum <=> b[3].sum).nonzero? ||
		(a[4].sum <=> b[4].sum)
	}

	p dat[0]

  id = dat[0][0]
  duel = duel.variant(id)
}

p duel
