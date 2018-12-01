path = File.absolute_path('frequencies.txt')
changes = IO.readlines(path, chomp: true).map(&:to_i)
COLLECTION = Hash.new(0)
changes.each { |change| COLLECTION[change] += 1 }

def process_collection(collection_hash)
  result = 0
  collection_hash.each { |change, frequency| result += (change * frequency) }
  result
end

puts process_collection(COLLECTION)
