class ViewAllClaims
  def execute(input)
    all_squares = {}

    input[:claims].each do |claim|
      x_start = claim[:from_left]
      y_start = claim[:from_top]

      p "processing #{claim[:id]}"

      claim[:width].times do |x|
        claim[:height].times do |y|
          coords = [x_start + x, y_start + y]
          if all_squares.keys.include?(coords)
            all_squares[coords] << claim[:id]
          else
            all_squares[coords] = [claim[:id]]
          end
        end
      end
    end

    all_squares
  end
end
