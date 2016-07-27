def are_anagrams (s1,s2)
	# add in case-sensitivity later
	return s1.split('').sort.join == s2.split('').sort.join
end

#test cases
# if are_anagrams("mean","mean") == true 
# 	puts "true"
# else
# 	puts "false"
# end
# if are_anagrams("mean","neam") == true
# 	puts "true"
# else
# 	puts "false"
# end
# if are_anagrams("naem","neam") == true
# 	puts "true"
# else
# 	puts "false"
# end
# if are_anagrams("lots of things","of lots things") == true
# 	puts "true"
# else
# 	puts "false"
# end
# if are_anagrams("owl","law") == false
# 	puts "true"
# else
# 	puts "false"
# end

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
# missing("there is no cow level")

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
#filetohash("wordlist")

# with our dictionary and anagram hash, we are now able to run the permutations. still, we'll want to really cut this number down.

# note that h is a hash
def reduction(string, hash)
	list = missing(string)
	puts "the following characters are not present in the string and are being removed: #{list.join}"
	# for each key in words, 
	hash = filetohash("wordlist")
	puts "keys in hash before reduction: #{hash.length}"
	# for sorter strings, drop all words that are too long first
	hash.delete_if{|key, value| key.length > string.length}
	# now iterate through the array elements, delete keys that include characters not in the string
	i = 0
	while i<list.length
		hash.delete_if{|key, value| key.include?(list[i])}
		i+=1
	end
	## testing
	# puts h
	puts "keys in hash after reduction: #{hash.length}"
	return hash
end

reduction("poultry outwits ants", filetohash("wordlist"))

#the "permutations" below is a partially-working method for two word combinations.

# the values associated with the keys still need to be properly extracted and stored into a format that allows people to see plausible options. e.g. using "blue mean" i should get some kind of output that saves possible output combinations (name blue, blue name, mean blue, name lube) etc.

# right now it uses a double-loop structure to look for 2-word combinations, but i would need a triple-loop structure to look for 3-word combinations, etc. what i would like to do is make it somehow recursive or use an internal helper function so that i could add "maximum number of words" as an additional argument. this would make testing for 3 and 4-word anagrams significantly easier. I would also prefer not to have to manually code out additional loops within loops for every word - complexity is going to continue to increase even with superior pruning techniques.

# also the current construction is only using keys - i need to extract and save the values related to those keys somehow for each match - perhaps for each match generating an array with all values

# however this will still be useful as we can check the number of permutations run for a non-pruned versus pruned search. we will have to keep in mind that the pruning itself takes a fair number of operations - it probably won't actually function as a net complexity reduction until we're reaching higher orders of m where n^m, as at its core it runs n times to reduce n to n- some number - in short the higher m the more the "linear" reductions applied by the pruning mechanism will help.

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

# revelation - for the three and four-word possibilities, rather than brute forcing, maybe creating a pruning algorithm - basically a variant of reduction - that will constantly prune at every stage
# e.g. i use "aaaabbbbcccc" as my string, while iterating through the sortstring it uses "aaaa" as the key, reduction gets run on the remaining string without those 4 letters, etc, so now it's checking for the hash keys generated by "bbbbcccc"

# ok so let's write a method that takes a word out of another word

#eg our string is foursquaredtimestwo
# the word we want to take out is fourtimes (note - we must allow for nonlinear / unordered removal like this) for this to be effective in the larger anagram function - remember a 3 word phrase may have a four word anagram where the total non-space characters are equal but the order of words etc is vastly different.

# so first we will take the large_string and the partial_string to get a remaining_string

def remaining_string(full_string, partial_string)
	# breaks each string into sorted arrays
	remaining_string = full_string.split('').sort
	partial_string = partial_string.split('').sort
	# note that we explicitly want to allow duplicate letters to remain in the string
	partial_string.each do |x|
		i = 0
		while i < remaining_string.length
			if x == remaining_string[i]
				remaining_string.delete_at(i)
				break
			end
			i +=1
		end
	end
		# tests to make sure is functioning properly... it is.
		print " this is the partial string: #{partial_string.join}"
		puts ""
		print " this is the full string: #{full_string}"
		puts ""
		print " this is the remaining string: #{remaining_string.join}"
		puts ""
		return remaining_string
end

remaining_string("poultry outwits ants", "poultry outwits")

# ok now that we have gotten a remaining string we can feed the remaining string into ye olde reduction method... except i realized i needed to switch the reduction method to have 2 inputs (string reduces a hash) rather than working from the word list every time. so that's done.

# we should now be able to chain the remaining_string and reduction methods in ways that drastically reduce the search permutations.















# _____ OLD & PROBABLY USELESS SECTION ______ #


# Brute Force Method for 3-word anagram

# this is something like keys^3 number of operations, which even for a reduced set of keys (say, down to 3000 from the original 88k) gets us up into insanely high numbers of operations very quickly. (3k keys = 27billion tests). in short, I don't think a brute force solution is going to be viable given current processing power limitations. I'll look into different search algorithms later this week.
def BFtriple(string)
	# h = reduction(string) # don't even try using this, without further pruning at each state we're at n^m complexity where m is the number of words
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
#BFtriple("duck blue orange")
