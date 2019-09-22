scans = []

File.readlines('/Users/rosendi/Downloads/111111stat/09221034.csv').each do |line|
  scans.push line.split('~')[2]
end

puts scans.uniq.size
