# 06-1.R
# 데이터 가공하기
# 데이터 전처리


# filter()     행추출
# select()     열(변수) 추출
# arrange()    정렬
# mutate()     변수 추가
# summarise()  통계치 산출
# group_by()   집단별로 나누기
# left_join()  데이터 합치기(열)
# bind_rows()  데이터 합치기(행)

# <      작다
# <=     작거나 같다
# >      크다
# >=     크거나 같다
# ==     같다
# !=     같지 않다 ( ! = not )
# |      또는
# &      그리고
# %in%   매칭확인

# +      더하기
# -      뺴기
# *      곱하기
# /      나누기
# ^ , ** 제곱
# %/%    나눗셈의 몫
# %%     나눗셈의 나머지



# %>% <- control + shift + M 으로 기호 입력 가능
library(ggplot2)
library(dplyr)
exam <- read.csv("csv_exam.csv")
exam

# filter <- 행을 추출해내는 기능
exam %>% filter(class==1)
out_data <- exam %>% filter(class==1) # class가 1인 데이터 추출
out_data2 <- exam %>% filter(class==2)

out_data3 <- exam %>% filter(class != 1) # class가 1이 아닌 경우만 추출  [ != : 같지 않다]

out_data4 <- exam %>% filter(math > 50)
out_data4
out_data5 <- exam %>% filter(english <= 80)
out_data5

# 다중 조건을 필터링
out_data6 <- exam %>% filter(math > 50 & class == 1)     # and 조건
out_data7 <- exam %>% filter(math > 60 | english > 60)   # or 조건

out_data8 <- exam %>% filter(class %in% c(1,3,5)) # exam %>% filter(class = 1 | class = 3 | class = 5) 와 같은 식

mpg
View(mpg)
rm(list=ls())
mpg <- as.data.frame(mpg)

# Q1
out_data4 <- mpg %>% filter(displ <= 4)
out_data5 <- mpg %>% filter(displ >= 5)
mean(out_data4$hwy) # 배기량이 4 이하인ㅁ 자동차들의 연비가 더 높음
mean(out_data5$hwy)

# Q2
out_audi <- mpg %>% filter(manufacturer == "audi")
out_toyota <- mpg %>% filter(manufacturer == "toyota")
str(out_audi)
dim(out_audi)
mean(out_audi$cty)
mean(out_toyota$cty) # 도요타의 연비가 더 좋음

# Q3
out_hwy <- mpg %>% filter(manufacturer %in% c("chevrolet", "ford", "honda"))
mean(out_hwy$hwy)

# select 는 필요한 열 즉, 변수를 추출가능
exam <- read.csv("csv_exam.csv")
df_math <- exam %>% select(math)
str(df_math) # data fram으로 나타남
str(exam$math) # Vector 로 출력됨

df_math_english <- exam %>% select(math,english)
str(df_math_english)
head(df_math_english)

df_exam <- exam %>% select(math, english, class)
df_exam2 <- exam %>% select(class, math, english)

df_nomath <- exam %>% select(-math)  # 필요 없는 열을 제외할 떄에는 "-"기호를 사용한다

# filter와 select를 같이 사용

df_new <- exam %>%  filter(class == 1) %>% select(class, english)
df_new2 <- exam %>%  
  filter(class == 1) %>% 
  select(class, english) %>% 
  head(2)

df_new2


# Q1
mpg_Q1 <- mpg %>% select(class, cty)

# Q2
mpg_Q2_1 <- mpg_Q1 %>% filter(class == "suv")
mpg_Q2_2 <- mpg_Q1 %>% filter(class == "compact")
mean(mpg_Q2_1$cty)
mean(mpg_Q2_2$cty)

# 합쳐서
mpg_Q2_1 <-
  mpg %>%
  filter(class == "suv") %>% 
  select(class, cty)

# arrange() : 순서로 정렬

df <- exam %>% arrange(math) # 오름차순
df
df <- exam %>% arrange(desc(math)) # 내림차순
df

df <- exam %>% arrange(class, math)
df

# Q1
out_audi_q1 <- mpg %>%  filter(manufacturer == "audi") %>% select(manufacturer, hwy) %>% arrange(desc(hwy)) %>% head(5)
out_audi_q1


# mutate

df <- exam %>%
      mutate(total = math + english + science)

df <- exam %>% 
      mutate(total = math + english + science, 
             Avg = total/3
             )
df <- exam %>% mutate(test = ifelse(science >= 60, "PASS", "FAIL"))
df <- exam %>% mutate(Avg = (math + english + science)/3)
df <- exam %>%
      mutate(total = math + english + science, Avg = (math + english + science)/3) %>%
      mutate(test = ifelse(science >= 70, "PASS",
                       ifelse(math >= 70, "PASS",
                              ifelse(english >= 70, "PASS", "FAIL"))),
             Avg_Grade = ifelse(Avg >= 85, "A",
                          ifelse(Avg >= 70, "B",
                            ifelse(Avg >= 60, "C", "D")))) %>%
      arrange(desc(Avg))
df

# Q1
mpg_new <- mpg
mpg_new1 <- mpg %>% mutate(total = cty + hwy)

# Q2
mpg_new2 <- mpg_new1 %>%  mutate(Avg = total/2)

# Q3
mpg_new3 <- mpg_new2 %>% arrange(desc(Avg)) %>%  head(3)
mpg_new3

# Q4
mpg_last <- mpg %>% mutate(total = cty + hwy) %>% 
                    mutate(Avg = total/2) %>% 
                    arrange(desc(Avg)) %>% 
  head(3)


# Summarise
# mean()   평균
# sd()     표준편차
# sum()    합계
# median() 중앙값
# min()    최솟값
# max()    최댓값
# n()      빈도

# summarise : 통계 함수를 사용한 변수를 할당
result <- exam %>% summarise(mean_math = mean(math),
                             mean_english = mean(english))
str(result)

# group_by() : 항목별로 데이터를 분리
df <- exam %>%
      group_by(class) %>% 
      summarise(mean_math = mean(math))  # 각 반의 수업 평균을 요약해서 보여준 것

df <- exam %>%
      group_by(class) %>% 
      summarise(mean_math = mean(math),
                sum_math = sum(math),
                mean_english = mean(english),
                sum_english = sum(english),
                n_Class = n())
df                

df <- mpg %>% 
  group_by(manufacturer, drv) %>%
  summarise(mean_cty = mean(cty))
df


df <- mpg %>%
  group_by(manufacturer) %>%           # 제조업체별로 분류
  filter(class == "suv") %>%           # suv를 구분
  mutate(tot = (cty + hwy)/2) %>%
  summarise(mean_Avg = mean(tot)) %>% 
  arrange(desc(mean_Avg)) %>% 
  head(5)
df  

# Q1
Q1 <- mpg %>% 
  group_by(class) %>% 
  summarise(mean_cty = mean(cty))
Q1

# Q2
Q2 <- Q1 %>% 
      arrange(desc(mean_cty))
Q2

# Q3
mpg <- as.data.frame(ggplot2::mpg)
Q3 <- mpg %>% 
      group_by(manufacturer) %>%
      summarise(mean_hwy = mean(hwy)) %>% 
      arrange(desc(mean_hwy)) %>% 
      head(3)
Q3

# Q4
Q4 <- mpg %>% 
      group_by(manufacturer) %>% 
      filter(class == "compact") %>% 
      summarise(sum_n = n()) %>% 
      arrange(desc(sum_n))
Q4



