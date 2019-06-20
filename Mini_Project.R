raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)

welfare <-  raw_welfare
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marrige = h10_g10,
                  religion = h10_g11,
                  code_job = h10_eco9,
                  income = p1002_8aq1,
                  code_region = h10_reg7,
                  start = np1006_4,
                  end = np1006_5,
                  economic_activity = h10_eco4,
                  reason_inactivity = h10_eco11,
)

# 연령대, 성별에 따른 비경제활동 사유

table(welfare$economic_activity)

# 비경제활동인구  filter(economic_activity == 9)

# 성별
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
# 연령대별
welfare$age <- 2015 - welfare$birth + 1
welfare$ageg <- ifelse(welfare$age >= 60, "60대",
                       ifelse(welfare$age >= 50, "50대",
                              ifelse(welfare$age >= 40, "40대",
                                     ifelse(welfare$age >= 30, "30대",
                                            ifelse(welfare$age >= 20, "20대", NA)))))

# 엑셀파일 코드 불러오기
list_job2 <- data.frame(reason_inactivity = c(1,2,3,4,5,6,7,8,9,10,11),
                        reason = c("근로무능력","군복무","정규교육기관 학업","진학준비", "취업준비", "가사", "양육", "간병", "구직활동포기", "근로의사 없음", "기타"))
head(list_job2)
str(list_job2)
welfare <- left_join(welfare, list_job2, id = reason_inactivity)
table(welfare$reason)

welfare <- welfare %>%
  filter(!is.na(ageg), !is.na(reason)) %>% 
  group_by(ageg, sex, reason) %>% 
  filter(economic_activity == 9) %>%
  summarise( n = n()) %>% 
  mutate(tot_group = sum(n))
welfare$tot_group  
welfare

ageg_20 <- welfare %>% 
  filter(ageg == "20대")
ggplot(data = ageg_20, aes(x = reorder(reason, n), y = n, fill = sex)) +
  geom_col(position = "dodge") +
  coord_flip()

ageg_30 <- welfare %>% 
  filter(ageg == "30대")
ggplot(data = ageg_30, aes(x = reorder(reason, n), y = n, fill = sex)) +
  geom_col(position = "dodge") +
  coord_flip()

ageg_40 <- welfare %>% 
  filter(ageg == "40대")
ggplot(data = ageg_40, aes(x = reorder(reason, n), y = n, fill = sex)) +
  geom_col(position = "dodge") +
  coord_flip()

ageg_50 <- welfare %>% 
  filter(ageg == "50대")
ggplot(data = ageg_50, aes(x = reorder(reason, n), y = n, fill = sex)) +
  geom_col(position = "dodge") +
  coord_flip()

ageg_60 <- welfare %>% 
  filter(ageg == "60대")
ggplot(data = ageg_60, aes(x = reorder(reason, n), y = n, fill = sex)) +
  geom_col(position = "dodge") +
  coord_flip()


# 형제가 없는 사람들은 외로움을 더 느끼나?

raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)

welfare <-  raw_welfare

welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marrige = h10_g10,
                  religion = h10_g11,
                  code_job = h10_eco9,
                  income = p1002_8aq1,
                  code_region = h10_reg7,
                  start = np1006_4,
                  end = np1006_5,
                  economic_activity = h10_eco4,
                  reason_inactivity = h10_eco11,
)


welfare <- rename(welfare,
                  siblings = p1005_aq4,
                  lonliness = p1005_14)
welfare$siblings <- ifelse(welfare$siblings != 0, "Yes", "No")
is.na(welfare$siblings)
table(welfare$siblings)

siblings_lonliness <- welfare %>%
  filter(!is.na(siblings)) %>% 
  group_by(siblings) %>%
  summarise(mean_lonliness = mean(lonliness))

ggplot(data = siblings_lonliness, aes(x = siblings, y = mean_lonliness)) +
  geom_col()
# 외로움
# 1. 극히 드물다(일주일에 1일 미만)       2. 가끔 있었다(일주일에 1-2일간)      
# 3. 종종 있었다(일주일에 3-4일간)        4. 대부분 그랬다(일주일에 5일 이상)
# 높을수록 외로움을 많이 탐

