# 04-3.R
# 엑셀과 CSV 파일 읽기와 쓰기

#엑셀파일 읽기
install.packages("readxl") # 패키지를 설치, 한번만 설치하면 된다
library(readxl)            # 패키지를 로드, 처음 실행할 때마다 로드해야한다
require(readxl)            # 패키지를 로드
df_exam <- read_excel("excel_exam.xlsx")
df_exam
str(df_exam)
summary(df_exam)


data() # R의 내장 데이터 셋 목록을 출력

iris
mean(iris$Petal.Width)

df_exam <- read_excel("excel_exam_sheet.xlsx", sheet = 3) # sheet 3번만 불러오기

# 엑셀파일 저장하기
# rJava 설치하기
install.packages("rJava")
library(rJava)
Sys.setenv(JAVA_HOME="C:/Program Files/Java/jre1.8.0_211")

install.packages("xlsx")
require(xlsx)
write.xlsx(df_exam,"my_excel1.xlsx",sheetname = "Sheet3")

# CSV 파일 읽고 쓰기 - Data 공부할 때 UCI Machine Learning Repository
# Comma Separated values





