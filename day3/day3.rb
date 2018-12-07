path = File.absolute_path('fabric_placements.txt')
fabric_placements = IO.readlines(path, chomp: true)


def get_axes(axes_string)
  xy = axes_string[0..-2]
  return xy.split(',').map(&:to_i)
end

def parse_placement(fabric_placement)
  placement_info = Hash.new
  info = fabric_placement[1..-1].split(' ')
  axes =  get_axes(info[2])
  coverages = info[3].split('x')
  placement_info[:id] = info[0].to_i
  placement_info[:column] = axes[0]
  placement_info[:row] = axes[1]
  placement_info[:width] = coverages[0].to_i
  placement_info[:height] = coverages[1].to_i
  return placement_info
end

def parse_all_placements(fabric_placements)
  fabric_placements.map { |placement| parse_placement(placement) }
end

def sew_fabric(fabric_placements)
  overlaps = 0
  fabric = Array.new(1000) { Array.new(1000) { 0 } }
  placements = parse_all_placements(fabric_placements)
  placements.each do |place|
    x = place[:row]
    height = x + place[:height]
    while x < height
      y = place[:column]
      width = y + place[:width]
      while y < width
        if fabric[x][y] == :X
          nil
        elsif fabric[x][y] != 0
          fabric[x][y] = :X
          overlaps += 1
        else
          fabric[x][y] = place[:id]
        end
        y += 1
      end
      x += 1
    end
  end
  return overlaps
end

p sew_fabric(fabric_placements)
