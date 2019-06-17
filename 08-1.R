# 08-2.R
# R 시각화
# 데이터 그래프 만들기

# 산점도 : Scatter plot : 두 변수간의 상관관계
# x축과 y축에 점으로 표현한 그래프

library(ggplot2)

# 1단계 : 배경 화면 출력 aes = aesthetic mapping
ggplot(data = mpg , aes(x = displ, y = hwy))

# 2단계 : 산점도 추가
ggplot(data = mpg , aes(x = displ, y = hwy)) + geom_point()
ggplot(data = mpg , aes(x = displ, y = cty)) + geom_point()

# 3단계 : x,y 축의 범위 지정
ggplot(data = mpg , aes(x = displ, y = hwy)) + 
      geom_point(colour ="red") +
  xlim(3,6) +
  ylim(10,30)

#plot(iris$Sepal.Length,iris$Sepal.width)

qplot(manufacturer, data = mpg, geom="bar",
      fill=manufacturer)

      
ggplot(data = mpg , aes(x = cty, y = hwy)) +
       geom_point(colour = "blue")      


ggplot(data = midwest , aes(x = poptotal , y = popasian)) +
  geom_point(colour = "red")+ xlim(0, 500000) + ylim(0, 10000)

View(midwest)

# 1e + 05 = 1 x 10^5     # 단위가 너무 큰 경우 로그값을 취해서 표현한다
# 5e - 05 = 5 x 10^-5


# 막대그래프 : Bar chart , 여러 집단 간의 차이

library(dplyr)

df_mpg <- mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy))

df_mpg

ggplot(data = df_mpg, aes(x = drv , y = mean_hwy)) + geom_col()
ggplot(data = df_mpg, aes(x = reorder(drv, mean_hwy) , y = mean_hwy)) + geom_col() #오름차순으로 정리
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy) , y = mean_hwy)) + geom_col() #내림차순으로 정리

# 빈도 막대 그래프
ggplot(data = mpg , aes(x=drv)) + geom_bar() # 4륜 구동, 전륜 구동, 후륜 구동의 단순 개수
ggplot(data = mpg , aes(x = manufacturer)) + geom_bar()

# 평균 막대 그래프 : 데이터를 요약한 평균표를 먼저 만든 후 평균표를 이용해 그래프
# 빈도 막대 그래프 : 별도로 표를 만들지 않고 원자료를 이용해 바로 그래프 생성

#Q1

df_Q1 <- mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "suv") %>%
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)

ggplot(data = df_Q1, aes(x = reorder(manufacturer, -mean_cty) , y = mean_cty)) + geom_col()  

#Q2

ggplot(data = mpg , aes(x = class)) + geom_bar()

# 선 그래프 : Line Chart : 시계열(Time Series data) 그래프 만들기

economics
ggplot(data = economics, aes(x= date, y= unemploy)) + geom_line()

# Q1

ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

# 상자 그림 : Box Plot :  Do it R 데이터 분석 175p 참고
# 데이터의 분포를 직사각형 상자 모양으로 표현한 그래프(사분위수)

ggplot(data = mpg , aes(x = drv, y = hwy)) +
  geom_boxplot()     
# 첫 박스 : 대부분의 데이터가 18에서 22구간에 몰려있다

# Q1
df_Q1 <- mpg %>%
  filter(class %in% c("compact", "subcompact", "suv"))
ggplot(data = df_Q1 , aes ( x = class , y = cty)) +
  geom_boxplot()

