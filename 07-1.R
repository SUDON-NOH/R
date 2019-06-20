# 07-1
# 데이터 정제
 
# 결측치 정제하기(Missing Value) : 누락된 값, 비어있는 값
# NA (NUMBER) <NA> (WORD)

# 예시 데이터
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df

# 결측치 확인
is.na(df) # 결측치의 존재 여부를 검색

table(is.na(df)) # 결측치의 개수(TRUE = 결측치)
table(is.na(df$sex))
table(is.na(df$score))

mean(df$score) # 결측치가 포함된 데이터를 함수에 적용하면 정상적으로 연산되지 않고 NA가 출력
sum(df$score)  # 결측치가 포함된 데이터를 함수에 적용하면 정상적으로 연산되지 않고 NA가 출력

# 결측치 제거하기

df %>% filter(is.na(score))
df %>% filter(!is.na(score)) %>%  # not을 의미하는 !를 붙여서 score에 있는 결측치 NA를 제거한다
  filter(!is.na(sex))             # 해당 조건의 컬럼의 결측치만 제거

df_no <- df %>% filter(!is.na(score) & !is.na(sex))

# na.omit() : 모든 컬럼의 결측치를 모두 제거
df_nomiss <- na.omit(df)
df_nomiss

# 함수의 결측치 제외기능
mean(df$score, na.rm = T) # 결측치를 제외하고 평균 산출 
sum(df$score, na.rm = T)  # 결측치를 제외하고 합계 산출

exam <- read.csv("csv_exam.csv")
exam[c(3, 8, 15), c("math")] <- NA # math 열의 3, 8, 15 행에 NA를 할당
exam
is.na(exam)
table(is.na(exam))

exam %>% summarise(mean_math = mean(math))
exam %>% summarise(mean_math = mean(math, na.rm = T))


exam %>% summarise(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   median_math = median(math, na.rm = T))

# 결측치를 평균값으로 대체하기

mean(exam$math, na.rm = T)
# [1] 55.23529
exam$math <- ifelse(is.na(exam$math), 55, exam$math) # math가 NA면 평균인 55로 대체, NA가 아니면 원래 값으로 부여
table(is.na(exam$math))
# FALSE 
# 20 
exam
#    id class math english science
# 1   1     1   50      98      50
# 2   2     1   60      97      60
# 3   3     1   55      86      78
# 4   4     1   30      98      58
# 5   5     2   25      80      65
# 6   6     2   50      89      98
# 7   7     2   80      90      45
# 8   8     2   55      78      25
# 9   9     3   20      98      15
# 10 10     3   50      98      45
# 11 11     3   65      65      65
# 12 12     3   45      85      32
# 13 13     4   46      98      65
# 14 14     4   48      87      12
# 15 15     4   55      56      78
# 16 16     4   58      98      65
# 17 17     5   65      68      98
# 18 18     5   80      78      90
# 19 19     5   89      68      87
# 20 20     5   78      83      58

mean(exam$math)

# Q1
mpg <- as.data.frame(ggplot2::mpg)
mpg[c(65,124, 131,153, 212), "hwy"] <- NA
is.na(mpg$drv)
is.na(mpg$hwy)
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

# Q2
mean(mpg$hwy)
Q2 <- mpg %>%
  filter(!is.na(hwy)) %>%
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))
Q2

# summarise(mean_hwy = mean(hwy, na.rm = T)) : hwy 평균 구하기기