disease_cold_CGG <- read.csv("실제진료정보_감기_시군구.csv")
disease_eye_CGG <- read.csv("실제진료정보_눈병_시군구.csv")
disease_asthma_CGG <- read.csv("실제진료정보_천식_시군구.csv")
disease_skin_CGG <- read.csv("실제진료정보_피부염_시군구.csv")

list_CGG <- read.csv("시군구 지역코드.csv")

head(list_CGG)

disease_cold_CGG <- left_join(disease_cold_CGG, list_CGG, by = "시군구지역코드")

disease_cold_CGG <- disease_cold_CGG %>% 
  filter(disease_cold_CGG$상위.시도지역코드 == 30)

disease_cold_CGG$날짜 <- substr(disease_cold_CGG$날짜, 1, 7)

disease_cold_CGG <- disease_cold_CGG %>% 
  group_by(날짜, 시군구명) %>% 
  mutate(mean_발생건수 = mean(발생건수.건.))



ggplot(data = disease_cold_CGG, aes(x = 날짜, y = mean_발생건수, fill = 시군구명)) +
  geom_col()
