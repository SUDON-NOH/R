# 09-1.R
# 한국 복지 패널 데이터 분석

install.packages("foreign") # foreign 패키기 설치
library(dplyr)              # 전처리
library(ggplot2)            # 시각화
library(foreign)            # SPSS 파일 불러오기
library(readxl)             # 엑셀 파일 불러오기

# 통계 파일 불러 오기
raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)
# 데이터 프레임 사본 생성
welfare <-  raw_welfare

head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marrige = h10_g10,
                  religion = h10_g11,
                  code_job = h10_eco9,
                  income = p1002_8aq1,
                  code_region = h10_reg7)
str(welfare)

# 성별에 따른 월급 차이
table(welfare$sex)
# 1    2 
# 7578 9086 

welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

class(welfare$income)
summary(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

welfare$income <- ifelse(welfare$income == 0, NA,
                         ifelse(welfare$income == 9999, NA, welfare$income))
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
table(is.na(welfare$income))

sex_income <- welfare %>% 
  filter(!is.na(welfare$income)) %>% 
  group_by(sex) %>% 
  summarise(mean_income = mean(income))
sex_income
ggplot(data = sex_income, aes(x = sex, y =mean_income)) + geom_col()

ggplot(data = welfare , aes(x = sex, y = income)) + geom_boxplot()
# 나이에 따른 월급차이

class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)
table(welfare$birth)
table(is.na(welfare$birth))
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$birth)

age_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income))
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

# 연령대에 따른 월급 차이
welfare <- welfare %>%
  mutate(ageg = ifelse(age >= 60, "노년",
                       ifelse(age >= 30, "중년", "초년")))
table(welfare$ageg)
qplot(welfare$ageg)

ageg_income <- welfare %>% 
  group_by(ageg) %>% 
  filter(!is.na(income)) %>% 
  summarise(mean_income = mean(income))
ggplot(data = ageg_income, aes(x = reorder(ageg, -mean_income), y = mean_income)) +
  geom_col() # 내림차순으로 정렬된 그래프

ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("초년", "중년", "노년")) # 만들고 싶은 순서대로

# 연령대 및 성별 월급 차이
sex_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))
sex_income


ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) + 
  geom_col() + 
  scale_x_discrete(limits = c("초년", "중년", "노년"))
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("초년", "중년", "노년"))

# 나이 및 성별 월급 차이
sex_income <- welfare %>%
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>%
  summarise(mean_income = mean(income))
sex_income

ggplot(data = sex_income, aes(x = age, y = mean_income, col = sex)) +
  geom_line()

# 직업별 월급 차이
table(welfare$code_job)

library(readxl) # 엑셀 읽기기
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)
# col_names : 
head(list_job)
dim(list_job)

welfare <- left_join(welfare, list_job, id = "code_job")
str(welfare)
welfare %>% 
  filter(!is.na(code_job)) %>% 
  select(code_job, job) %>% 
  head(10)

job_income <- welfare %>% 
  filter(!is.na(job) & !is.na(income)) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income))
head(job_income)

top10 <- job_income %>% 
  arrange(desc(mean_income)) %>% 
  head(10)
top10

# coord_flip : 막대를 90 도 회전
ggplot(data = top10, aes(x = reorder(job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()

bottom10 <- job_income %>% 
  arrange(mean_income) %>% 
  head(10)
bottom10

ggplot(data = bottom10, aes(x = reorder(job, -mean_income), y = mean_income)) +
  geom_col() +
  coord_flip() +
  ylim(0, 800)

# 성별 직업 빈도
job_male <- welfare %>%
  filter(!is.na(job), sex == "male") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_male

job_female <- welfare %>% 
  filter(!is.na(job), sex == "female") %>% 
  group_by(job) %>% 
  summarise(n = n()) %>% 
  arrange(desc(n)) %>% 
  head(10)
job_female

ggplot(data = job_male, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

ggplot(data = job_female, aes(x = reorder(job, n), y = n)) +
  geom_col() +
  coord_flip()

# 연습
class(welfare$religion)
table(welfare$religion)
welfare$religion <- ifelse(welfare$religion == 1, "Yes", "No")
table(welfare$religion)

table(welfare$marrige)
welfare$group_marrige <- ifelse(welfare$marrige == 1, "marrige",
                          ifelse(welfare$marrige == 3, "divorce", NA))
table(welfare$marrige)

religion_marrige <- welfare %>% 
  filter(!is.na(welfare$group_marrige)) %>% 
  group_by(religion, group_marrige)  %>% 
  summarise(n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group * 100, 1))

religion_marrige

divorce <-religion_marrige %>% 
  filter(group_marrige == "divorce") %>% 
  select(religion, pct)
divorce

ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()

ageg_religion_marrige <- welfare %>% 
  filter(!is.na(group_marrige)) %>% 
  group_by(ageg, religion, group_marrige) %>% 
  summarise( n = n()) %>% 
  mutate(tot_group = sum(n)) %>% 
  mutate(pct = round(n/tot_group * 100, 1))
ageg_religion_marrige

df_divorce <- ageg_religion_marrige %>% 
  filter(group_marrige == "divorce") %>% 
  select(ageg, religion, pct)

ggplot(df_divorce, aes(x = ageg, y = pct, fill = religion)) +
  geom_col(position = "dodge")

