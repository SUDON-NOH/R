# 05-1.R
# 데이터 분석 기초

# 데이터 파악하기

exam <- read.csv("csv_exam.csv")
exam

head(exam)     # 기본 데이터 앞의 6행을 보여준다
head(exam, 10) # 데이터 앞의 10행을 보여준다

tail(exam)     # 기본 데이터 뒤의 6행을 보여준다
tail(exam, 10) # 데이터 뒤의 10행을 보여준다

View(exam)     # Viewer 창에 데이터 프레임을 보여준다다
View(iris3)

dim(exam)      # 차원을 보여준다 행과 열
dim(iris3)     # 행 열 면

str(exam)      # 데이터의 속성
summary(exam)  # 요약

quantile(exam$math)

# mpg 데이터 파악하기
# miles per gallon , 자동차의 제원과 연비데이터
install.packages("ggplot2") # gg : Grammar of Graphic 시각화 도구 패키지
library(ggplot2)
mpg                         # tibble = data frame : 234 x 11

View(mpg)
str(mpg)
summary(mpg)

mean(mpg$cty)
mean(mpg$hwy)

hist(mpg$hwy)    # 막대그래프
qplot(mpg$cty)   # 막대그래프
