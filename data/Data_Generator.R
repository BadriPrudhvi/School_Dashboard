s <- read.csv("~/Documents/git_dir/School_Dashboard/data/students.csv")
e <- read.csv("~/Documents/git_dir/School_Dashboard/data/exam.csv")
sub <- read.csv("~/Documents/git_dir/School_Dashboard/data/subjects.csv")

s1 <- s[rep(seq_len(nrow(s)), each=30),]

library(dplyr)

d1 <- data.frame(exam = rep("sprs_508207_exam_1",times=6))
d2 <- data.frame(exam = rep("sprs_508207_exam_2",times=6))
d3 <- data.frame(exam = rep("sprs_508207_exam_3",times=6))
d4 <- data.frame(exam = rep("sprs_508207_exam_4",times=6))
d5 <- data.frame(exam = rep("sprs_508207_exam_5",times=6))

m <- data.frame(exam = rbind(d1,d2,d3,d4,d5)) %>% mutate(exam = as.character(exam))

m1 <- data.frame()
for (i in 1:100){
  m1 <- rbind(m1,m)
}

l1 <- data.frame(subject = c("sprs_508207_subject_3","sprs_508207_subject_2"
                             ,"sprs_508207_subject_5","sprs_508207_subject_4"
                             ,"sprs_508207_subject_1","sprs_508207_subject_6"))
l21 <- data.frame()
for (i in 1:500){
  l21 <- rbind(l21,l1)
}

umarks = sample(1:50, 1200, replace=T)
emarks = sample(1:100, 1800, replace=T)

res <- cbind(student_id = s1[,"student_id"], exam_id = m1, subject_id = l21)

c <- data.frame(marks_obtained = c(umarks,emarks))
v <- round(rnorm(3000,50,12.5))
v <- data.frame(marks_obtained = v)

res2 <- res %>% select(student_id,exam_id= exam,subject_id = subject) %>%
  arrange(exam_id) %>% bind_cols(v) %>%
  mutate(marks_obtained = ifelse(marks_obtained > 50 & exam_id %in% c("sprs_508207_exam_1","sprs_508207_exam_2"),sample(15:45),marks_obtained))

write.csv(res2,row.names = F,"~/Documents/git_dir/School_Dashboard/data/student_exam.csv")
