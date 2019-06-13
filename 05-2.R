# 05-2
# 데이터 수정하기 - 변수명 바꾸기
# dplyr pakages 설치 & 로드
install.packages("dplyr")
library(dplyr)   # rename() 함수를 지원

df_raw <- data.frame(var1 = c(1,2,1),
                     var2 = c(2,3,2))
df_new <- df_raw # 그래프 복사(변경없음)
df_new

# rename: 변수명(컬럼이름)을 변경 가능
df_new <- rename(df_raw,  model = var1 , fuel =var2)
df_new
rm(list=ls())

# 변수를 추가하기: 파생변수
df <- data.frame(var1 = c(1,2,1),
                 var2 = c(2,3,2))
df$var_sum <- df$var1 + df$var2
df$var_sum
df
#  var1 var2 var_sum
#1    1    2       3
#2    2    3       5
#3    1    2       3

df$var_mean <- (df$var1 + df$var2)/2
df

df <- data.frame(var1 = c(1,2,1),
                 var2 = c(2,3,2),
                 var3 = c(5,6,7))
df$var_sum <- df$var1 + df$var2 + df$var3
df
df$var_mean <- (df$var1 + df$var2 + df$var3)/3
df
df <- rename(df, top1 = var1, top2 = var2, top3 = var3)  # 이름변경
df

mpg <- as.data.frame(ggplot2::mpg)
mpg$sum <- mpg$cty + mpg$hwy
mpg
mpg$mean <- (mpg$cty + mpg$hwy)/2
mpg
summary(mpg$sum)
summary(mpg$mean)
mean(mpg$mean)
hist(mpg$mean)

mpg$myvar <- c(1:234) # 자체 데이터를 데이터 프레임에 추가 하는 법
mpg
mpg$cnty <- "대한민국"
mpg$cnty <- NULL # 컬럼 삭제
mpg$myvar <- NULL
View(mpg)

# 조건에 따른 변수의 값을 할당
mpg$test <- ifelse(mpg$mean >= 20, "pass", "fail")
View(mpg)
str(mpg$manufacturer)
# 중첩된 조건에 따른 변수 할당
summary(mpg$mean)   # A >= 30, B >= 20, 나머지 C
mpg$grade <- ifelse(mpg$mean >= 30, "A",
                    ifelse(mpg$mean >= 20, "B", "C"))
View(mpg)
table(mpg$test) # 빈도표를 출력
table(mpg$grade)
qplot(mpg$test) # 막대 그래프
qplot(mpg$manufacturer)

mpg$cnty <- ifelse(mpg$manufacturer == "audi", "독일",
                   ifelse(mpg$manufacturer == "chevrolet", "미국",
                          ifelse(mpg$manufacturer == "dodge", "미국",
                                 ifelse(mpg$manufacturer == "ford", "미국","미정"))))  
# 코딩 언어에서는 "="은 입력 명령어로 사용되기 때문에 "=="을 입력해야 "같은"이라는 뜻을 갖는다

mpg$grade <- ifelse(mpg$mean >= 30, "A",
                    ifelse(mpg$mean >= 25, "B", 
                           ifelse(mpg$mean >=20, "C", "D")))
qplot(mpg$grade)
table(mpg$grade)

distinct(mpg, manufacturer)  # 중복값 없이 원하는 값을 추출 (2개 이상도 가능)
mpgaudi <- as.data.frame(mpg %>% filter(manufacturer == "audi"))


midwest <- as.data.frame(ggplot2::midwest)
View(midwest)
summary(midwest)
str(midwest)
midwest <- rename(midwest, total = poptotal, asian = popasian)
midwest$per <- midwest$asian/midwest$total*100
hist(midwest$per)
qplot(midwest$per)
mean(midwest$per)
midwest$mean <- ifelse(midwest$per >= 0.487, "large", "small")
qplot(midwest$mean)
table(midwest$mean)

