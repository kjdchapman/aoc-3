require './lib/view_all_claims'

formatted_input = File.read("input.txt").split("\n").map do |line|
  id, details = line.split(' @ ')
  start_position, size = details.split(': ')

  from_left, from_top = start_position.split(',')
  width, height = size.split('x')

  {
    id: id,
    from_left: from_left.to_i,
    from_top: from_top.to_i,
    width: width.to_i,
    height: height.to_i
  }
end

p ViewAllClaims.new
  .execute(claims: formatted_input)
  .group_by(&:itself)
  .count{ |_, value| value.count > 1 }
