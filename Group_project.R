disease_cold_CGG <- read.csv("실제진료정보_감기_시군구.csv")
disease_eye_CGG <- read.csv("실제진료정보_눈병_시군구.csv")
disease_asthma_CGG <- read.csv("실제진료정보_천식_시군구.csv")
disease_skin_CGG <- read.csv("실제진료정보_피부염_시군구.csv")

# 대전시 관련 코드 생성
# (1)방법
disease_cold_CGG <- disease_cold_CGG %>% 
  filter(시군구지역코드 %in% c(30110, 30140, 30170, 30200, 30230))

# (2)방법
list_CGG <- read.csv("시군구 지역코드.csv")

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

install.packages("dygraphs")
library(dygraphs)

disease_cold_CGG$날짜<-as.Date(disease_cold_CGG$날짜)



ggplot(data = disease_cold_CGG, aes(x = 날짜, y = 발생건수.건., col = 시군구명)) +
  geom_line() +
  xlim("2014-01-01", "2014-01-31")


