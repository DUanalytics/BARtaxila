#Data Structures - Array and List


#List
listL1 = list('dhiraj', v1, students, mymatrix, myarray)
listL1


#?ls
ls()
rm(list=ls())
ls()


(mylist1 = list( 1, df, v4))

#--
(myarray = array(101:124, dim=c(4,3,2)))

(myarray = array(1:24, dim=c(3,2,4)))


(myarray = array(1:24, dim=c(4,3,2), dimnames = list(c('S1','S2','S3','S4'), c('Sub1','Sub2','Sub3'), c('Dept1','Dept2'))))
myarray
apply(myarray,3,sum)
apply(myarray,2,mean)
apply(myarray,3,sum)
apply(myarray,c(2,3),mean)
apply(myarray,c(1,3),sd)
apply(myarray,c(1,2),max)

