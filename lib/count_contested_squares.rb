class CountContestedSquares
  def execute(input)
    claims = input[:claims]

    return 0 if claims.count < 2

    if overlap?(claims[0], claims[1])
      1
    else
      0
    end
  end

  def overlap?(one, two)
    x_overlap?(one, two) &&
    y_overlap?(one, two)
  end

  def x_overlap?(one, two)
    one_range = one[:from_left]
    two_range = two[:from_left]
    one_range == two_range
  end

  def y_overlap?(one, two)
    one[:from_top] == two[:from_top]
  end
end
