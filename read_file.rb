class HashTable
  def initialize
    @size = 200
    @table = Array.new(@size)
  end

  def hash(key, i)
    (key.to_s.bytes.sum + i) % @size
  end

  def insert(key, value)
    i = 0
    index = hash(key, i)

    while @table[index]
      i += 1
      index = hash(key, i)
    end

    @table[index] = { key => value }
  end

  def search(key)
    i = 0
    index = hash(key, i)

    while @table[index] && @table[index].keys.first != key
      i += 1
      index = hash(key, i)
    end
    @table[index][key]
  end

  def compare_simple_vs_sorted(file)
    simple_table = HashTable.new
    sorted_table = SortedList.new

    simple_ops = 0
    sorted_ops = 0

    File.foreach(file) do |line|
      key, value = line.chomp.split(' ')
      simple_start_time = Time.now
      simple_table.insert(key, value)
      simple_end_time = Time.now
      simple_ops += (simple_end_time - simple_start_time) * 1000000

      sorted_start_time = Time.now
      sorted_table.insert(key, value)
      sorted_end_time = Time.now
      sorted_ops += (sorted_end_time - sorted_start_time) * 1000000
    end

    s = sorted_table.search('apple')
    h = hash_table.search('apple')
    puts "Hash search result: #{h}"
    puts "Sorted search result: #{s}"

    simple_average_ops = simple_ops / File.foreach(file).count
    sorted_average_ops = sorted_ops / File.foreach(file).count

    puts "Simple HashTable average: #{simple_average_ops}"
    puts "Sorted HashTable average: #{sorted_average_ops}"
  end
end

class SortedList
  def initialize
    @list = []
  end

  def insert(key, value)
    i = 0
    while i < @list.size && @list[i][0] < key
      i += 1
    end
    @list.insert(i, [key, value])
  end

  def search(key)
    i = 0
    while i < @list.size && @list[i][0] < key
      i += 1
    end
    i < @list.size && @list[i][0] == key ? @list[i][1] : nil
  end
end

hash_table = HashTable.new
sorted_table = SortedList.new

hash_table.insert("key2", "value2")
sorted_table.insert("key1", "value1")

hash_result = hash_table.search("key2")
sorted_result = sorted_table.search("key1")

puts "HashTable search result: #{hash_result}"
puts "SortedList search result: #{sorted_result}"
