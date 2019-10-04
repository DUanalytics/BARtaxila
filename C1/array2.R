#arrays

#Manipulate Arrays

#Management Institute - 3 Depts, 2 batches, 2 Genders  
set.seed(123)
(studentnos = sample.int(n=30:40, size=3*2*2, replace=T))
length(studentnos)
(institute2 = array(data=studentnos, dim=c(2,2,3), dimnames = list(c('Year1','Year2'), c('Male','Female'), c('Dept1','Dept2', 'Dept3'))))

addmargins(A=institute2)
#sum in the end
addmargins(A=institute2, margin = 2)
dimnames(institute2)
apply(X=institute2, MARGIN=1, FUN=sum)  #Yearwise sum
apply(X=institute2, MARGIN=2, FUN=sum) #Genderwise sum
apply(X=institute2, MARGIN=3, FUN=sum) #Deptwise sum
apply(X=institute2, MARGIN=c(1,2), FUN=sum)  #Year-Gender wise sum
apply(X=institute2, MARGIN=c(1,3), FUN=sum) #Year-Dept wise sum
apply(X=institute2, MARGIN=c(2,3), FUN=sum) #Gender-Dept wise sum



