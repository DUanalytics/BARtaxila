#list
#object which contains elements of different types – like strings, numbers, vectors and another list inside it. 
#create List
?list

(v1 = 1:5)
(v2 = month.abb[4:10])
(v3 = c(T,F, TRUE, FALSE))
(combinedV = c(v1, v2, v3))  #all converted to character

list1 = list(v1, v2, v3)
list1

lapply(X=list1, class)  #class of each list item
lapply(X=list1, length)  #length of each list item



#