def are_anagrams (s1,s2)
	# add in case-sensitivity later
	return s1.split('').sort.join == s2.split('').sort.join
end

#test cases
if are_anagrams("mean","mean") == true 
	puts "true"
else
	puts "false"
end
if are_anagrams("mean","neam") == true
	puts "true"
else
	puts "false"
end
if are_anagrams("naem","neam") == true
	puts "true"
else
	puts "false"
end
if are_anagrams("lots of things","of lots things") == true
	puts "true"
else
	puts "false"
end
if are_anagrams("owl","law") == false
	puts "true"
else
	puts "false"
end

# this is a function designed to see if there are any characters -not- included in our string that we can later use to reduce the size of the dictionary hash; this should make it easier to compare multi-word anagrams later
def missing(string)
normalchars = "abcdefghijklmnopqrstuvwxyz".split('')
# .squeeze removes duplicate characters
sortstring = string.split('').sort.join.squeeze
	missingchars = []
	i = 0
	while i < normalchars.length
		if sortstring.include?(normalchars[i]) == false
			missingchars.push(normalchars[i])
		end
		i+=1
	end
	# puts missingchars.join
	return missingchars
end
missing("there is no cow level")

# def filetoarray
# 	File.open("wordlist") do |f|
# 		words = []
# 		while line = f.gets
# 			word=line.chomp
# 			words = words.push(word)
# 		end
# 		puts words.length
# 	end
# end

# this is the core function that turns the dictionary into an sorted anagram hash
def filetohash(dictionary)
	words = Hash.new([])
	File.open(dictionary) do |f|
		# puts words
		while line = f.gets
			word = line.chomp
			thisword = { word.split('').sort!.join => word }
			# thisword appears to correctly create a hash with a single key-value pair (tested with puts)
			# h1.merge!(h2) { |key, v1, v2| [v1,v2] } by using an array construction as the argument for merge it seems to correctly sort rather than replace as usual
			words.merge!(thisword) {|key, v1, v2|[v1,v2]}
		end
		# testing
		# puts words["aemn"]
		puts words.count
		return words
	end
end
filetohash("wordlist")

# with our dictionary and anagram hash, we are now able to run the permutations. still, we'll want to really cut this number down.

def reduction(string)
	list = missing(string)
	puts list.join
	# for each key in words, 
	h = filetohash("wordlist")
	# iterates through the array elements, deletes keys that include characters not in the string
	i = 0
	while i<list.length
		h.delete_if{|key, value| key.include?(list[i])}
		i+=1
	end
	puts h.length
	puts h["no"]
	return h
end

reduction("there is no cow level")
