# 이상치(outlier)제거하기
# 존재할 수 없는 값

outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier
table(outlier$sex)
# 1 2 3  1이 3개, 2가 2개, 3이 1개
# 3 2 1 
table(outlier$score)
# 2 3 4 5 6 
# 1 1 2 1 1

outlier$sex <- ifelse(outlier$sex >= 3, NA, outlier$sex)
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

# 결측치 처리, 제거
outlier %>%
  filter(!is.na(sex) & !is.na(score)) %>%
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

# 결측 처리하기
library(ggplot2)
boxplot(mpg$hwy)$stats
quantile(mpg$hwy, na.rm = T)

# mpg 데이터의 극단치로 제거
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))
mpg %>% 
  group_by(drv) %>% 
  summarise(mean_hwy = mean(hwy, na.rm = T))

