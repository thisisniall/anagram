# psuedo

# python method, checks for anagrams, deals with whitespaces in strings

# def are_anagrams(s1, s2):
#      return sorted(s1.replace(' ', '')) == sorted(s2.replace(' ', ''))

def are_anagrams (s1,s2)
	# add in case-sensitivity later
	return s1.split(' ').sort.join == s2.split(' ').sort.join
end

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
if are_anagrams("nam","neam") == true
	puts "true"
else
	puts "false"
end
if are_anagrams("lots of things","of lots things") == true
	puts "true"
else
	puts "false"
end

#import dictionary array instead of this
dictionaryarray = ["lots", "of", "things"]

