path = File.absolute_path('box_ids.txt')
box_ids = IO.readlines(path, chomp: true)


def letter_count(string)
  two_count = Proc.new { |letter, count| count == 2 }
  three_count = Proc.new { |letter, count| count == 3 }
  counts = Hash.new(0)
  string.each_char { |char| counts[char] += 1 }
  if counts.any?(&two_count) && counts.any?(&three_count)
    return [2, 3]
  elsif counts.any?(&two_count)
    return [2]
  elsif counts.any?(&three_count)
    return [3]
  end
end

def count_file(box_ids)
  twos = 0
  threes = 0
  box_ids.each do |box_id|
    case letter_count(box_id)
    when [2, 3]
      twos += 1
      threes += 1
    when [2]
      twos += 1
    when [3]
      threes += 1
    end
  end
  return twos * threes
end

p count_file(box_ids)
