class BowlingScore
  def initialize
    @rolls = []
    @score = 0
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    frame_index = 0
    10.times do
      if strike?(frame_index)
        @score += 10 + strike_bonus(frame_index)
        frame_index += 1
      elsif spare?(frame_index)
        @score += 10 + spare_bonus(frame_index)
        frame_index += 2
      else
        @score += sum_of_balls_in_frame(frame_index)
        frame_index += 2
      end
    end
    @score
  end

  def game_state
    state = ''
    frame_index = 0
    9.times do
      state += "|| #{frame_state(frame_index)} "
      frame_index += strike?(frame_index) ? 1 : 2
    end

    state += tenth_frame_state(frame_index)
    state.strip
  end

  private

  def strike?(frame_index)
    @rolls[frame_index] == 10
  end

  def strike_bonus(frame_index)
    @rolls[frame_index + 1] + @rolls[frame_index + 2]
  end

  def spare?(frame_index)
    @rolls[frame_index] + @rolls[frame_index + 1] == 10
  end

  def spare_bonus(frame_index)
    @rolls[frame_index + 2]
  end

  def sum_of_balls_in_frame(frame_index)
    @rolls[frame_index] + @rolls[frame_index + 1]
  end

  def frame_state(frame_index)
    if strike?(frame_index)
      'X'
    elsif spare?(frame_index)
      "#{@rolls[frame_index]} /"
    else
      "#{@rolls[frame_index]} #{@rolls[frame_index + 1]}"
    end
  end

  def tenth_frame_state(frame_index)
    if strike?(frame_index)
      "|| X #{@rolls[frame_index + 1]} #{@rolls[frame_index + 2]} ||"
    elsif spare?(frame_index)
      "|| #{@rolls[frame_index]} / #{@rolls[frame_index + 2]} ||"
    else
      "|| #{@rolls[frame_index]} #{@rolls[frame_index + 1]} ||"
    end
  end
end
