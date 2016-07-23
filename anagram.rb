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
		# puts "keys in hash: #{words.count}"
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
	## testing
	# puts h
	# puts "keys in hash: #{h.length}"
	return h
end

reduction("there is no cow level")


#this is a partially-working method for two word combinations.

# the values associated with the keys still need to be properly extracted and stored into a format that allows people to see plausible options. e.g. using "blue mean" i should get some kind of output that saves possible output combinations (name blue, blue name, mean blue, name lube) etc.

# right now it uses a double-loop structure to look for 2-word combinations, but i would need a triple-loop structure to look for 3-word combinations, etc. what i would like to do is make it somehow recursive or use an internal helper function so that i could add "maximum number of words" as an additional argument. this would make testing for 3 and 4-word anagrams significantly easier.

# more importantly that the current construction is only using keys - i need to extract and save the values related to those keys somehow for each match - perhaps for each match generating an array with all values

def permutations(string)
	h = reduction(string)
	var = h.keys
	# print var
	match = 0
	n = 0
	while n < var.length
		# setting i to n means that if there are say 3000 keys after the reduction, the inner loop will run 3000 times the first time, then 2999 times, etc. this prevents us from running the same thing twice and restricts us to unique matches (previous construction used an exterior each loop which resulted in duplication)
		i = n
		while i < var.length
			# preliminary length check
			if var[n].length+var[i].length == string.length
				# test, not recommended for actual-length
				# puts "length match at x: #{x} i: #{var[i]}"
				if are_anagrams((var[n]+var[i]),string)
					puts "#{var[n]+var[i]}: these could be an anagram for the entered string!"
					match +=1
				end
			end
			i+=1
		end
		n+=1
	end
	puts "total number of possible matches: #{match}"
end

# notes: current algorithm

permutations("name")