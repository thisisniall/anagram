

# i = 0 #(outer loop)
# n = 0 #(inner loop)
# while i < h.length
# 	# if are_anagrams((h[i]+h[n]).split('').sort.join),string)
# 	# puts
# 	i +=1
# end

def are_anagrams (s1,s2)
	# add in case-sensitivity later
	return s1.split('').sort.join == s2.split('').sort.join
end

#this is a mostly-working method using a sample-array for two-word combinations
def permutations(string)
	h = {"duck" => "trouble", "blue" => ["sky", "blue"], "james" => "hello", "orange" => "the new black"}
	var = h.keys
	print var
	var.each do |x|
		i = 0
		while i < var.length
			if x.length+var[i].length == string.length
				puts "length match at x: #{x} i: #{var[i]}"
				if are_anagrams((x+var[i]),string)
					puts "these could be an anagram"
				else
					puts "not an anagram!"
				end
			end
			i+=1
		end
	end
end
		

permutations("jamesblue")


# note: this is a brute-force approach.

# def permutations(string, numwords)

# end

# #iterate through h, adding keys to each other
# #it should start with 2 counters
# # start with adding duck to blue into "duckblue"
# # then check if this is the same length as the string we're looking for, otherwise advance
# 	unless temp.length = string.length
# 	n+=1
# # NO NEED TO re-sort duckblue into alphabetical order, is_anagram will do this if they make the length check. NOW run is_anagram from anagram.rb comparing the tempvariable assigned to duckblue to the input
# 	if is_anagram(temp,string) == true
# 		# store the combination to a hash somehow
# # then it'll increase the counter of the inner loop and run every combination
# # if 
