# psuedo

# python method, checks for anagrams, deals with whitespaces in strings

# def are_anagrams(s1, s2):
#      return sorted(s1.replace(' ', '')) == sorted(s2.replace(' ', ''))

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

# string = "there is no cow level"
# sortstring = string.split('').sort.join
# puts sortstring
# puts sortstring.length
# # .squeeze should remove duplicates
# # e.g. ailnooprssttttuuwy -> ailnoprstuwy
# puts sortstring.squeeze
# puts sortstring.squeeze.length

# normalchars = "abcdefghijklmnopqrstuvwxyz"
# puts normalchars.length

# ok so now that we have 13 vs. 26 characters we generate a function that will remove the duplicates
def findmissingchars(string)
normalchars = "abcdefghijklmnopqrstuvwxyz".split('')
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
	# puts missingchars.length
	return missingchars
end

findmissingchars("there is no cow level")

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

# filetoarray

def filetohash(dictionary)
	words = Hash.new([])
	File.open(dictionary) do |f|
		puts words
		while line = f.gets
			word = line.chomp
			thisword = { word.split('').sort!.join => word }
			# thisword appears to correctly create a hash with a single key-value pair (tested with puts)
			# h1.merge!(h2) { |key, v1, v2| [v1,v2] } by using an array construction as the argument for merge it seems to correctly sort rather than replace as usual
			words.merge!(thisword) {|key, v1, v2|[v1,v2]}
		end
		# testing
		puts words["ah"]
		puts words["aemn"]
		return words
	end
end

filetohash("wordlist")


