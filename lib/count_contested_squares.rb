class CountContestedSquares
  def execute(input)
    all_squares = []

    input[:claims].each do |claim|
      x_start = claim[:from_left]
      y_start = claim[:from_top]

      claim[:width].times do |x|
        claim[:height].times do |y|
          square = [x_start + x, y_start + y]
          all_squares << square
        end
      end
    end

    all_squares
      .group_by(&:itself)
      .count{ |_, value| value.count > 1 }
  end
end
