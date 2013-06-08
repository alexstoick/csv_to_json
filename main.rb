require 'json'

file = open( 'file.csv')

props = file.first.gsub( /\"/ , '' ).gsub(/\n/,'').split(',')

puts props.count

entries = []
count = 0

file.each do |line|

	entry = {}

	i=0

	current_line = line.gsub( /\"/ , '' ).gsub(/\n/,'').split(',')

	current_line.each do |property|
		entry[props[i]] = property
		i+=1
	end
	entries.push( entry )
	count += 1
	printf( "completed %6d\n" , count.to_s )

	if count % 50000 == 0
		File.open( count.to_s + '.json' , 'w' ) { |file| file.puts ( entries.to_json ) }
		printf( "WROTE TO FILE \n")
	end
end

File.open( 'final.json' , 'w') { |file| file.puts ( entries.to_json ) }