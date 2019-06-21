# 프로젝트
rm(list = ls())
library(dplyr)
library(ggplot2)
library(readxl)


weather <- read.csv("merge2.csv", stringsAsFactors = F)
medi <- read.csv("medi_F_2014_2015_2016.csv", stringsAsFactors = F)

# 날짜 맞추기

weather <- weather %>% 
  mutate(year = weather$일시)

weather$year <- substr(weather$year, 1, 4)
weather$year <- ifelse(weather$year == "2014", "2014",
                  ifelse(weather$year == "2015", "2015",
                         ifelse(weather$year == "2016", "2016", NA)))

# 결측치 제거

weather_modi <- weather %>% 
  filter(!is.na(year))

str(weather_modi)         

weather_modi$평균.상대습도...
weather_modi <- rename(weather_modi,
                       평균습도 = 평균.상대습도...)

weather_modi2 <- weather_modi %>% 
  select(일시, 평균습도)

str(medi)

medi_modi <- medi %>%
  filter(!is.na(요양개시일자)) %>% 
  group_by(요양개시일자) %>%
  summarise(n = n())

medi_modi2 <- rename(medi_modi,
                     num = n)

medi_modi3 <- as_tibble(medi_modi2)
weather_modi2 <- as_tibble(weather_modi2)

medi_modi3$요양개시일자 <- as.character(medi_modi3$요양개시일자)
weather_modi2$일시 <- as.Date(weather_modi2$일시)
medi_modi3$요양개시일자 <- as.Date(medi_modi3$요양개시일자, format = "%Y%m%d", origin = "1900-01-01")

medi_modi3 <- rename(medi_modi3,
                     일시 = 요양개시일자)

weather_medi <- left_join(medi_modi3, weather_modi2, by = "일시")

install.packages("dygraphs")
library(dygraphs)
library(xts)

weather_medi2 <- xts(weather_medi$num, order.by = weather_medi$일시)
weather_medi3 <- xts(weather_medi$평균습도, order.by = weather_medi$일시)

eco <- cbind(weather_medi2, weather_medi3)
colnames(eco) <- c("num", "평균습도")
dygraph(eco) %>% dyRangeSelector()


# 날짜 자르기
medi$요양개시일자 <- as.Date(medi$요양개시일자, format = "%Y%md",origin = "1900-01-01")