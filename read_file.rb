source_code = File.read(__FILE__)

def condition
  if x > 5
    puts "x is greater than 5"
  else
    puts "x is less than or equal to 5"
  end
end

def condition_2
  if x < 5
    puts "x is less than or equal to 5"
  else
    puts "x is greater than 5"
  end
end

modified_code = source_code.gsub(/if\s+(.+?)\s+[\n\s]+(.+?)\s+[\n\s]+else\s+[\n\s]+(.+?)\s+[\n\s]+end/m) do |match|
  condition = Regexp.last_match(1)
  if_branch = Regexp.last_match(2)
  else_branch = Regexp.last_match(3)
  "unless #{condition}\n    #{else_branch}\n  else\n    #{if_branch}\n  end"
end


File.open('modified_code.txt', 'w') { |file| file.write(modified_code) }

File.open('modified_code.txt', 'r+') do |f|
  lines = f.readlines

  lines.slice!(0, 2)
  lines.slice!(-22, 22)

  f.rewind
  f.truncate(0)

  f.write(lines.join)
end
