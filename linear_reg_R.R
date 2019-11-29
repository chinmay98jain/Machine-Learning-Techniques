#Required packages

install.packages('readr')
install.packages('ggplot2')
install.packages('mlbench')
install.packages('corrplot')
install.packages('Amelia')
install.packages('caret')
install.packages('plotly')
install.packages('caTools')
install.packages('reshape2')
install.packages('dplyr')

library(readr)
library(ggplot2)
library(corrplot)
library(mlbench)
library(Amelia)
library(plotly)
library(reshape2)
library(caret)
library(caTools)
library(dplyr)

#mlbench package
data(BostonHousing)
housing <- BostonHousing

# str(housing)
??cex

#Amelia package
missmap(housing,col=c('yellow','black'),y.at=1,y.labels='')

#caTools
split <- sample.split(housing,SplitRatio =0.70)
train <- subset(housing,split==TRUE)
test <- subset(housing,split==FALSE)

#training model
model <- lm(medv ~ lstat, data = train)
summary(model)
plot(model)


#testing
test$predicted.medv <- predict(model,test)

plot(test$medv,test$predicted.medv)

pl1 <-test %>% 
  ggplot(aes(medv,predicted.medv)) +
  geom_point(alpha=0.5) +stat_smooth(aes(colour='black'))+ 
  xlab('Actual value of medv') +
  ylab('Predicted value of medv')

ggplotly(pl1)


#part c all attributes excluding age

model <- lm(medv ~.-age, data = train)
summary(model)
plot(model)

#testing
test$predicted.medv <- predict(model,test)

pl2 <-test %>% 
  ggplot(aes(medv,predicted.medv)) +
  geom_point(alpha=0.5) + 
  stat_smooth(aes(colour='black')) +
  xlab('Actual value of medv') +
  ylab('Predicted value of medv')

ggplotly(pl2)


#part a

gradientDesc <- function(x, y, learn_rate, conv_threshold, n, max_iter) {
  plot(x, y, col = "blue", pch = 20)
  m <- runif(1, 0, 1)
  c <- runif(1, 0, 1)
  yhat <- m * x + c
  MSE <- sum((y - yhat) ^ 2) / n
  converged = F
  iterations = 0
  while(converged == F) {
    ## Implement the gradient descent algorithm
    m_new <- m - learn_rate * ((1 / n) * (sum((yhat - y) * x)))
    c_new <- c - learn_rate * ((1 / n) * (sum(yhat - y)))
    m <- m_new
    c <- c_new
    yhat <- m * x + c 
    MSE_new <- sum((y - yhat) ^ 2) / n
    if(MSE - MSE_new <= conv_threshold) {
      abline(c, m) 
      converged = T
      return(paste("Optimal intercept:", c, "Optimal slope:", m))
    }
    iterations = iterations + 1
    if(iterations > max_iter) { 
      abline(c, m) 
      converged = T
      return(paste("Optimal intercept:", c, "Optimal slope:", m))
    }
  }
}


# Run the function 
gradientDesc(test$lstat, test$medv, 0.0000293, 0.001, 32, 2500000)