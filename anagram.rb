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
	puts "the following characters are not present in the string and are being removed: #{list.join}"
	# for each key in words, 
	h = filetohash("wordlist")
	puts "keys in hash before reduction: #{h.length}"
	# for sorter strings, drop all words that are too long first
	h.delete_if{|key, value| key.length > string.length}
	# now iterate through the array elements, delete keys that include characters not in the string
	i = 0
	while i<list.length
		h.delete_if{|key, value| key.include?(list[i])}
		i+=1
	end
	## testing
	# puts h
	puts "keys in hash after reductions: #{h.length}"
	return h
end

# reduction("poultry outwits ants")

#the below is a partially-working method for two word combinations.

# the values associated with the keys still need to be properly extracted and stored into a format that allows people to see plausible options. e.g. using "blue mean" i should get some kind of output that saves possible output combinations (name blue, blue name, mean blue, name lube) etc.

# right now it uses a double-loop structure to look for 2-word combinations, but i would need a triple-loop structure to look for 3-word combinations, etc. what i would like to do is make it somehow recursive or use an internal helper function so that i could add "maximum number of words" as an additional argument. this would make testing for 3 and 4-word anagrams significantly easier.

# more importantly that the current construction is only using keys - i need to extract and save the values related to those keys somehow for each match - perhaps for each match generating an array with all values

def permutations(string)
	h = reduction(string)
	var = h.keys
	match = 0
	n = 0
	perm = 0
	solutions = []
	while n < var.length
		# check for single-word anagrams
		if are_anagrams(var[n],string)
			puts "These could be an anagram for the entered string: #{h.values[n]}"
		end
		# setting i to n means that if there are say 3000 keys after the reduction, the inner loop will run 3000 times the first time, then 2999 times, etc. this prevents us from running the same thing twice and restricts us to unique matches (previous construction used an exterior each loop which resulted in duplication)
		i = n
		while i < var.length
			perm +=1
			# preliminary length check
			if var[n].length+var[i].length == string.length
				# test, not recommended for actual-length
				# puts "length match at x: #{x} i: #{var[i]}"
				if are_anagrams((var[n]+var[i]),string)
					puts "These could be an anagram for the entered string: #{h.values[i]} + #{h.values[n]}"
					#{var[n]+var[i]}: 
					# print h.values[i]
					# print h.values[n]
					match +=1
				end
			end
			i+=1
		end
		n+=1
	end
	puts "total permutations run: #{perm}"
	puts "total number of possible key-combination matches: #{match}"
	puts solutions
end

#permutations("poultry")

# this is a two-loop construction, i'd like to get something that effectively runs a single loop, then runs a double loop, then runs a triple loop,

# def countdown(n)
#   return if n.zero? # base case
#   puts n
#   countdown(n-1)    # getting closer to base case 
# end  

# # i need a flexible definition of lookup that can handle this
# def recursion (string, levels)
# 	h = reduction(string)
# 	match = 0
# 	i = 0
# 	# the idea here is that the outermost loop should be the number of levels of the search itself
# 	while i < levels
# 		n = 0
# 		while n < h.length
# 			# define lookup universally? is this even possible?
# 			if lookup.length == string.length
# 				if are_anagrams(lookup, string)
# 					puts "This could be a #{i}-word anagram for the entered string: #{lookup}"
# 					match +=1
# 				end
# 			end
# 			n+=1
# 		end
# 		i+=1
# 	end
# end


# this is something like keys^3 number of operations, which even for a reduced set of keys (say, down to 2000 from the original 88k) gets us up into insanely high numbers of operations very quickly. (2k keys = 8billion tests). in short, I don't think a brute force solution is going to be viable given current processing power limitations. I'll look into different search algorithms later this week.
def triple(string)
	# h = reduction(string)
	h = {"duck" => "trouble", "blue" => ["sky", "blue"], "james" => "hello", "orange" => "the new black", "alpha" => ["omega", "ruby"]}
	var = h.keys
	match = 0
	i = 0
	perm = 0
	while i < var.length
		m = 0
		while m < var.length
			n = 0
			while n < var.length
				perm +=1
				if var[i].length+var[m].length+var[n].length == string.length
					if are_anagrams((var[i]+var[m]+var[n]),string)
						puts "These could be an anagram for the entered string: #{h.values[i]} + #{h.values[m]}+ #{h.values[n]}"
						match +=1
					end
				end
				n+=1
			end
			m+=1
		end
		i+=1
	end
	puts "for #{string}:"
	puts "total permutations run: #{perm}"
	puts "total number of possible key-combination matches: #{match}"

end
triple("duck blue orange")