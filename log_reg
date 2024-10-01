library(rms)

dat1=read.csv("vae_186.csv")

# Create logistic regression model
GLM.1 <- glm(status ~ ltac + chf + cad + lung + ed + ward + tpn + timecat, family=binomial(logit), data = dat1)
summary(GLM.1)
exp(GLM.1$coefficients)
exp(confint(GLM.1))

#Validation of the model
library(caret)
library(qwraps2)

train_data <- read.csv("vae_186_train.csv")
test_data <- read.csv("vae_186_test.csv")

# Create logistic regression model
logistic_model <- glm(status ~ ltac + dm + chf + cad + lung + opsite + timecat2,
                       family = binomial(link = "logit"), data = train_data)

# Make predictions on the test dataset
predicted_probs <- predict(logistic_model, test_data, type = "response")
predicted_classes <- ifelse(predicted_probs > 0.5, 1, 0)

# Create confusion matrix dataframe using true labels from test data
predictions_df <- data.frame(
  truth = test_data$status,  
  pred = predicted_classes
)

# Generate confusion matrix
confusion_matrix <- confusionMatrix(as.factor(predictions_df$pred), 
                                    as.factor(predictions_df$truth), 
                                    positive = "1")

# Print the confusion matrix
print(confusion_matrix)
