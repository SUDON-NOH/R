# 가로 = 수평 = 열 (column)
# 세로 = 수직 = 행 (row)

# 데이터 합치기(join, merge, bind)

# (1) 가로 = 수평 = 열(column)로 합치기
# left_join()

test1 <- data_frame(id = c(1,2,3,4,5),
                    midterm = c(60,80,70,90,85))
test2 <- data_frame(id = c(1,2,3,4,5),
                    final = c(70,83,65,95,80))

total <- left_join(test1, test2, by = 'id') # by 는 기준이 되는 열

test1 <- data_frame(id = c(1,2,0,4,5),
                    midterm = c(60,80,70,90,85))
test2 <- data_frame(id = c(1,2,3,4,5),
                    final = c(70,83,65,95,80))

total <- left_join(test1, test2, by = 'id')
total
# 처음 나오는 식이 기준이 된다. 따라서 ID 가 매치가 안되는 값은 N/A로 처리되고, ID가 존재하지 않는 부분은 값이 나타나지 않는다

name <- data.frame(class = c(1:5),
                   teacher = c("kim", "park", "lee", "choi", "jung"))
name

exam <- read.csv("csv_exam.csv")
exam_new <- left_join(exam, name, by = "class")
exam_new

# (2) 세로 = 수직 = 행(row)로 합치기
# bind_rows()
# ex) 100명의 데이터가 존재, 100명을 추가적으로 입력해야 하는 경우

group_A <- data.frame(id = c(1:5),
                      test = c(60, 80, 70, 90, 85))
group_B <- data.frame(id = c(6:10),
                      test = c(60, 83, 72, 99, 81))
group_All <- bind_rows(group_A, group_B)
group_All

View(mpg)

# Q1

df_fuel <- data.frame(fl = c("c","d","e","p","r"),
                      kind = c("CNG", "diesel","ethanol E85","premium","regular"),
                      perg = c(2.35, 2.38, 2.11, 2.76, 2.22),
                      stringsAsFactors = F)
Q1 <- left_join(mpg, df_fuel, by = "fl")
Q1

# Q2

Q1 %>% 
  select(model, fl, perg) %>% 
  head(5)


# P.160 문제

View(midwest)

# Q1

Q1 <- midwest %>% mutate(percent = (poptotal-popadults)/poptotal * 100)
Q1

# Q2

Q2 <- Q1 %>% 
  arrange(desc(percent)) %>% 
  select(county, percent) %>% 
  head(5)
Q2

# Q3

Q3 <- Q1 %>% 
  mutate(div = ifelse(percent >= 40, "large",
                                 ifelse(percent >= 30, "middle", "small")))
table(Q3$div)

ggplot(data = Q3, aes(x = div)) + geom_bar()


# Q4

Q4 <- Q3 %>%
  mutate(ratio_asian = popasian / poptotal * 100) %>% 
  arrange(desc(ratio_asian)) %>% 
  tail(10) %>% 
  select(state, county, ratio_asian)

Q4 <- Q3 %>% 
  mutate(ratio_asian = popasian / poptotal * 100) %>% 
  arrange(ratio_asian) %>%
  select(state, county, ratio_asian) %>% 
  head(10)


