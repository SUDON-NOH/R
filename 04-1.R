# 04-1.R
# 데이터프레임 실습

English <- c(90, 80, 60, 70)
Math <- c(50, 60, 100, 20)
Name <- c("김지훈", "이유진", "박동현", "김민지")
Class <- c(1, 2, 1, 1)
AvgofEnglisih <- mean(df_midterm$English) # 영어점수의 평균
AvgofMath <- mean(df_midterm$Math)        # 수학점수의 평균

df_midterm <- data.frame(Name, Class, English, AvgofEnglisih, Math, AvgofMath)
df_midterm

sum(df_midterm$English)
sum(df_midterm$Math)

# Class - 사람
# Object - 홍길동, 김철수

# [5] 배열 array : n차원 행렬이다

a <- matrix(1:12, ncol=4)
a

# 2차원의 행렬은 matrix와 array는 같은 값을 갖는다
a <- array(1:12, dim = c(3,4))   # dim (dimension 차원) 
a

# 3차원의 array
# dim = c(행, 열, 면), 면의 갯수는 matrix의 갯수(즉, 아래의 예는 2x2 행렬 3개를 갖고 있다는 의미)
b <- array(1:12, dim = c(2,2,3)) # 행, 열, 면을 다 곱하면 12가 되어야 한다
b
# , , 1

#       [,1] [,2]
# [1,]    1    3    # 1면 1행 1열 = 1   1면 1행 2열 = 3
# [2,]    2    4    # 1면 2행 1열 = 2

# , , 2

#       [,1] [,2]
# [1,]    5    7
# [2,]    6    8

# , , 3

#       [,1] [,2]
# [1,]    9   11
# [2,]   10   12

b[1,1,1]   # [1] 1    의미: 1행 1열 1면
b[1,2,3]   # [1] 11   의미: 1행 2열 3면
b[,,]
b[,-1,2:3] # 1열을 제외하고 면은 2에서 3까지 행은 전부 사용 !! 정육면체를 그려서 이해하기
#     [,1] [,2]
#[1,]    7   11
#[2,]    8   12

# [6] 리스트 List
# list(key=value,key=value,...)
# key는 value를 찾기 위한 값
x <- list(name="류현진",height=170,age=32,weight=99,score=c(10,20,30))
x
score <- c(10,20,30)
names(score) <- c("국어", "영어", "수학")
x <- list(name="류현진",height=170,age=32,weight=99,score)
x
x$name
x$age
x[1]    #list가 나옴
x[[1]]  #list에서 value 값만 뽑는다.

x[4]
x[5]

# 제어문 : IF, FOR, WHILE문

# [1] IF 문 : 조건을 가지고 제어한다
# if (조건) { 문장1 }   # 조건이 TRUE면 문장1을 수행, 조건이 FALSE면 문장2를 수행
# else {  문장2 }

cond <- TRUE
if(cond) {
  print('TRUE')
  print('You Win')
} else {
  print('FALSE')
  print('You Lose!!')
}

cond <- FALSE
if(cond) {
  print('TRUE')
  print('You Win')
} else {
  print('FALSE')
  print('You Lose!!')
}

cond2 <- -10
if(cond2 > 0) {
  print('TRUE')
  print('You Win')
} else {
  print('FALSE')
  print('You Lose!!')
}

cond3 <- 10
if(cond3 > 0) {
  print('TRUE')
  print('You Win')
} else {
  print('FALSE')
  print('You Lose!!')
}

# [2] FOR 문 : 반복문
for (i in 1:10) {
  print(i)
}    # i 값은 1:10 안에(in) 있는 변수다.

for (i in 1:12) {
  print(i)
}

# 1부터 100까지 합을 for 문을 사용하여 구하라, 변수 사용은 자유
a <- c(1:100)
sum(a)
mean(a)


result <- 0
mean <- 0
for (m in 1:100) {
  result <- result + m
}
print(result) #5050
mean <- result/100
print(mean)

# [3] WHILE 문 : 조건을 사용한  무한 반복
# while(TRUE) { } : 무한루프
cond <- TRUE
i <- 0
while(i<101) {         # i 1 ,,, 100
  print(i)
  i <- i + 1
}
print(i) #101

# 함수
a <- 10
b <- 20
c <- a + b
c
a <- 50
b <- 60
c <- a + b
c
# 반복적인 코드는 비효율적 : 재사용이 목적이다
# 함수명(add) <- function(인자1, 인자2, ...)
# {   문장   
#     return(반환값)      
# }
add <- function(a,b)
{
  c = a + b
  return(c)
}  
d <- add(10,20)
e <- add(150,234)

# 예제 : 1 + 10, 2 + 20, 3 + 30, ... 100 + 1000
result <- 0
for (i in 1:100) {
  result <- add(i,i*10)
  print(result)
}

sum_func <- function(a){
  print(a)
  len <- length(a)
  b <- 0
  for (i in 1:len) {
    b <- b + a[i]
  }
  return(b)
}
sum_func(c(1,2,3,4,5))

