#arrays
#are like matrix/vectors but with more than 2 dimensions
#all elements of same data type
#built in arrays
UCBAdmissions
class(UCBAdmissions)
dim(UCBAdmissions)
#3 dimensions : 2 rows(Admit), 2 cols(Gender), 6 Matrix (Depts)

#create Arrays
#Management Institute - 3 Depts, 2 batches, 2 Genders  
set.seed(123)
(studentnos = sample.int(n=30:40, size=3*2*2, replace=T))
length(studentnos)
(institute1 = array(data=studentnos, dim=c(2,2,3)))
(institute2 = array(data=studentnos, dim=c(2,2,3), dimnames = list(c('Year1','Year2'), c('Male','Female'), c('Dept1','Dept2', 'Dept3'))))

dim(institute2)
#multi dim storage improves readability

#access array elements
institute2
institute2[1,1,1] #Year1, Male, Dept1
institute2[1,1,]  #Year1, Male, All Depts
institute2[2,,2] #Year2, All Genders, Dept2
institute2[,,2]  #Dept2

institute2[-1, ,1]  #skip Year1(ie only Year2), All Genders, Dept2
institute2[,-1 ,] #all Females from each Year & Dept
institute2

institute2[c(1,2),c(1) ,-c(2) ] #what is this

#sum of Dept1 & Dept2
(mat1 = institute1[,,1])
(mat3 = institute1[,,3])
(mat1 + mat3)
institute2[, , c(1,3)]
apply(institute2[, , c(1,3)], MARGIN=c(1,2), sum)

#end
