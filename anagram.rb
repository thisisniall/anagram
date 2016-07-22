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
	puts missingchars.join
	puts missingchars.length
	return missingchars
end

findmissingchars("there is no cow level")


# File.open("/usr/share/dict/words", "r") do |file|
#   while line = file.gets
#     word = line.chomp
#     words[word.split('').sort!.join('')] += [word]
#   end
# end

# File.open("word_hash", "w") do |file|
#   Marshal.dump(words, file)
# end
# The second program loads the serialized hash from disk to solve anagrams that we type at the console:

# words = nil

# File.open("word_hash", "r") do |file|
#   words = Marshal.load(file)
# end

# while true
#   print "Enter word: "
#   anagram = gets.chomp
#   sorted_anagram = anagram.split('').sort!.join('')
#   p  words[sorted_anagram]
# end

#import dictionary array instead of this
dictionaryarray = ["lots", "of", "things"]


