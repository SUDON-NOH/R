#install.packages("dygraphs")
library(dygraphs)
library(xlsx)
library(dplyr)
library(ggplot2)
library(xts)



disease_cold_CGG <- read.csv("./kpublic_20190430/실제진료정보_감기_시군구.csv",stringsAsFactors=FALSE)
str(disease_cold_CGG)
disease_eye_CGG <- read.csv("./kpublic_20190430/실제진료정보_눈병_시군구.csv")
disease_asthma_CGG <- read.csv("./kpublic_20190430/실제진료정보_천식_시군구.csv")
disease_skin_CGG <- read.csv("./kpublic_20190430/실제진료정보_피부염_시군구.csv")

# 대전시 관련 코드 생성
# (1)방법
disease_cold_CGG <- disease_cold_CGG %>% 
  filter(시군구지역코드 %in% c(30110, 30140, 30170, 30200, 30230))

# (2)방법
list_CGG <- read.csv("./kpublic_20190430/시군구 지역코드.csv")

head(list_CGG)

disease_cold_CGG <- left_join(disease_cold_CGG, list_CGG, by = "시군구지역코드")

disease_cold_CGG <- disease_cold_CGG %>% 
  filter(disease_cold_CGG$상위.시도지역코드 == 30)

disease_eye_CGG <- left_join(disease_eye_CGG, list_CGG, by = "시군구지역코드")

disease_eye_CGG <- disease_eye_CGG %>% 
  filter(disease_eye_CGG$상위.시도지역코드 == 30)

disease_asthma_CGG <- left_join(disease_asthma_CGG, list_CGG, by = "시군구지역코드")
disease_asthma_CGG <- disease_asthma_CGG %>% 
  filter(disease_asthma_CGG$상위.시도지역코드 == 30)



disease_cold_CGG$날짜 <- as.Date(disease_cold_CGG$날짜)

tibble_disease_cold_CGG <- as_tibble(disease_cold_CGG,stringsAsFactors=FALSE) # xts 타입을 위해 티블 변환  jam 20190619
View(tibble_disease_cold_CGG)
str(tibble_disease_cold_CGG)
ggplot(data = disease_cold_CGG, aes(x = 날짜, y = 발생건수.건., col = 시군구명)) +
  geom_line() + xlim("2014-01-01","2014-02-01")



#----------------------------jam
eco <- xts(tibble_disease_cold_CGG$발생건수.건., order.by = tibble_disease_cold_CGG$날짜)
eco
dygraph(eco)
tibble_disease_cold_CGG2<- tibble_disease_cold_CGG
str(tibble_disease_cold_CGG)

tibble_disease_cold_CGG2$날짜 <- substr(tibble_disease_cold_CGG2$날짜,1,7)
View(tibble_disease_cold_CGG2)
str(tibble_disease_cold_CGG2)


#df2<- tibble_disease_cold_CGG2 %>% 
#    group_by(날짜, 시군구지역코드) %>% 
#    mutate(n=n()) %>% 
#filter(tibble_disease_cold_CGG2$날짜=="2014-01"& tibble_disease_cold_CGG2$시군구지역코드==30140) %>% 
#mutate(n=n()) %>% 
#    mutate(tot_발생건수=sum(발생건수.건.)) %>% 
#    mutate(mean= tot_발생건수/n)

#View(df2)
#str(df2)

df3<- tibble_disease_cold_CGG2 %>% 
  group_by(날짜, 시군구지역코드) %>% 
  summarise(n=n(),
            tot_발생건수=sum(발생건수.건.),
            mean= tot_발생건수/n)


df3<- as_tibble(df3) #date 형식을 위해 tibble로 변환 
#View(df3)

#df3 <- group_by(날짜, 시군구지역코드 ) %>% 
#    summarise()
#str(df3)
#install.packages("lubridate")
library(lubridate) #date 형식 인식ㄷ을 위한 라이브러리

# 각 구별 데이터 프레임 나누기
dff0 <- df3%>% 
  filter(시군구지역코드==30110)
#View(dff0)
dff1 <- df3 %>% 
  filter(시군구지역코드==30140)
dff2 <- df3 %>% 
  filter(시군구지역코드==30170)
dff3 <- df3 %>% 
  filter(시군구지역코드==30200)
dff4 <- df3 %>% 
  filter(시군구지역코드==30230)


#날짜 부분을 date형식 인식
dff0$날짜 <- as.POSIXlt(paste(dff0$날짜, days(Sys.Date()), sep="-"))
dff1$날짜 <- as.POSIXlt(paste(dff1$날짜, days(Sys.Date()), sep="-"))
dff2$날짜 <- as.POSIXlt(paste(dff2$날짜, days(Sys.Date()), sep="-"))
dff3$날짜 <- as.POSIXlt(paste(dff3$날짜, days(Sys.Date()), sep="-"))
dff4$날짜 <- as.POSIXlt(paste(dff4$날짜, days(Sys.Date()), sep="-"))

#df3$날짜 <- as.Date(df3$날짜)
#df3$날짜 <- strptime(df3$날짜, "%Y-%m")
View(df3)
str(df3)


#출력을 위한 정리
eco_0 <- xts(dff0$mean, order.by = dff1$날짜)
eco_1 <-xts(dff1$mean, order.by = dff1$날짜)
eco_2 <-xts(dff2$mean, order.by = dff1$날짜)
eco_3 <-xts(dff3$mean, order.by = dff1$날짜)
eco_4 <-xts(dff4$mean, order.by = dff1$날짜)


eco_a <- cbind(eco_0,eco_1,eco_2,eco_3,eco_4)

colnames(eco_a) <- c("동구","중구","서구","유성구","대덕구") # 변수명 변경
head(eco_a)

#eco <- xts(df3$mean, order.by = df3$날짜)
#eco
dygraph(eco_a) %>%  dyRangeSelector() #출력력