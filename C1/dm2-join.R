#DM 2 : Join in DF

#join two DFs
(rollno = paste('S',1:5,sep=''))
(name = paste('Student',1:5, sep='_'))
(gender = c(rep('M',3), rep('F',2)))
(student = data.frame(rollno, name, gender))

grades = c('A','B','C')
(subject1 = sample(grades, size=5, replace=T))
(subject2 = sample(grades, size=5, replace=T))

(marks = data.frame(rollno, subject1, subject2))
student
marks
(studentmarks = merge(student, marks, by='rollno'))

#add another row in marks
(ID = paste('S',1:7,sep=''))
(subject1B = sample(grades, size=7, replace=T))
(subject2B = sample(grades, size=7, replace=T))
(marks2 = data.frame(ID, subject1B, subject2B))

(rollno = paste('S',c(1:5,8),sep=''))
(name = paste('Student',c(1:5,8), sep='_'))
(gender = c(rep('M',3), rep('F',3)))
(student2 = data.frame(rollno, name, gender))
marks2
marks2$subject1B = factor(marks2$subject1B, levels=grades)
marks2$subject2B = factor(marks2$subject2B, levels=grades)

(studentmarks2 = merge(student2, marks2, by.x='rollno', by.y='ID')) #only those which exist in both DFs

(studentmarks2 = merge(student2, marks2, by.x='rollno', by.y='ID', all.x=T))  # all students in slist

(studentmarks2 = merge(student2, marks2, by.x='rollno', by.y='ID', all.y=T))  #with missing data in student list


#types of join : outer, inner, left, right, full
library(dplyr)
names(student2); names(marks2)
# left join() - student2
?left_join
student2 %>% left_join(marks2, by = c('rollno'='ID'))
#warning due to different factor levels

# right_join() - marks2
student2 %>% right_join(marks2, by = c('rollno'='ID'))

# inner_join() - only common
student2 %>% inner_join(marks2, by = c('rollno'='ID'))

# full_join()
student2 %>% full_join(marks2, by = c('rollno'='ID'))
full_join(student2, marks2, by = c('rollno'='ID'))






#end--------
