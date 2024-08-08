require_relative 'bowling_score'

RSpec.describe BowlingScore do
  let(:game) { BowlingScore.new }

  it 'scores a gutter score as 0' do
    20.times { game.roll(0) }
    expect(game.score).to eq(0)
  end

  it 'scores a score of all ones as 20' do
    20.times { game.roll(1) }
    expect(game.score).to eq(20)
  end

  it 'scores a spare followed by three pins as 16' do
    game.roll(5)
    game.roll(5)  # Spare
    game.roll(3)
    17.times { game.roll(0) }
    expect(game.score).to eq(16)
  end

  it 'scores a strike followed by three and four pins as 24' do
    game.roll(10)  # Strike
    game.roll(3)
    game.roll(4)
    16.times { game.roll(0) }
    expect(game.score).to eq(24)
  end

  it 'scores a perfect score as 300' do
		12.times { game.roll(10) }
		expect(game.score).to eq(300)
  end

  it 'returns the correct score state' do
		game.roll(10)  # Strike
		game.roll(7)
		game.roll(3)   # Spare
		game.roll(9)
		game.roll(0)
		game.roll(10)  # Strike
		game.roll(0)
		game.roll(8)
		game.roll(8)
		game.roll(2)   # Spare
		game.roll(0)
		game.roll(6)
		game.roll(10)  # Strike
		game.roll(10)  # Strike
		game.roll(10)  # Strike
		game.roll(8)
		game.roll(1)
		expect(game.game_state).to eq('|| X || 7 / || 9 0 || X || 0 8 || 8 / || 0 6 || X || X || X 8 1 ||')
		expect(game.score).to eq(167)
  end

	it 'returns the correct score with spare at the end' do
		game.roll(10)  # Strike
		game.roll(7)
		game.roll(3)   # Spare
		game.roll(9)
		game.roll(0)
		game.roll(10)  # Strike
		game.roll(0)
		game.roll(8)
		game.roll(8)
		game.roll(2)   # Spare
		game.roll(0)
		game.roll(6)
		game.roll(10)  # Strike
		game.roll(10)  # Strike
		game.roll(9)
		game.roll(1)	 # Spare
		game.roll(1)
		expect(game.game_state).to eq('|| X || 7 / || 9 0 || X || 0 8 || 8 / || 0 6 || X || X || 9 / 1 ||')
		expect(game.score).to eq(150)
	end

	it 'returns the correct score with open game at the end' do
		game.roll(10)  # Strike
		game.roll(7)
		game.roll(3)   # Spare
		game.roll(9)
		game.roll(0)
		game.roll(10)  # Strike
		game.roll(0)
		game.roll(8)
		game.roll(8)
		game.roll(2)   # Spare
		game.roll(0)
		game.roll(6)
		game.roll(10)  # Strike
		game.roll(10)  # Strike
		game.roll(7)
		game.roll(2)
		expect(game.game_state).to eq('|| X || 7 / || 9 0 || X || 0 8 || 8 / || 0 6 || X || X || 7 2 ||')
		expect(game.score).to eq(145)
	end
end
