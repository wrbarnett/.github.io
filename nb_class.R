library(survival)
library(rms)
library(caret)
library(qwraps2)
library(klaR)  

train_data <- read.csv("vae_186_train.csv")
test_data <- read.csv("vae_186_test.csv")

train_data$status <- as.factor(train_data$status)
test_data$status <- as.factor(test_data$status)

# Train Naive Bayes model
nb_model <- NaiveBayes(status ~ ltac + dm + chf + cad + lung + opsite + timecat2, data=train_data)

# Make predictions on the test set
predictions <- predict(nb_model, test_data)

# Create a data frame for truth and predictions
results_df <- data.frame(
  truth = test_data$status,  
  pred = predictions$class    
)

# Create confusion matrix
confusion_mat <- confusionMatrix(as.factor(results_df$pred), as.factor(results_df$truth))

# Display confusion matrix results
print(confusion_mat)
