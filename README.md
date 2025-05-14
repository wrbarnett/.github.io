# Coding Examples Repository

This repository contains a collection of examples demonstrating various statistical modeling techniques using R and Python. Currently, it includes implementations of Cox Regression, Logistic Regression, and Naive Bayes Classifier.

## Table of Contents

- [Overview](#overview)
- [Technologies Used](#technologies-used)
- [Examples](#examples)
  - [Cox Regression](#cox-regression)
  - [Logistic Regression](#logistic-regression)
  - [Naive Bayes Classifier](#naive-bayes-classifier)
  - [tidyverse and ggplot2](#tidyverse-ggplot2)
  - [SQL](#sql)
  - [Data Cleaning in Python](#data-cleaning-in-python)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Overview

This repository serves as a practical resource for understanding and implementing key statistical models in R. Each example includes explanations of the underlying theory, data preprocessing steps, and model evaluation metrics.

## Technologies Used

- R
- tidyverse
- survival (for Cox Regression)
- rms (for Cox and Logistics Regressions)
- caret (for Logistic Regression and Naive Bayes)
- klaR (for Naive Bayes)
- qwraps2 (for confusion matrices)
- ggplot2 (for visualization)

- SQL

- Python
- Pandas (for data manipulation and analysis)
- Numpy (for numerical computing)
- SimpleImputer (for handling missing data)

## Examples

### Cox Regression

This example demonstrates the implementation of the Cox Proportional Hazards model for survival analysis. It includes data preprocessing, model fitting, and evaluation.

- **File**: `cox_reg.R`
- **Description**: Analyze survival data and visualize the results.

### Logistic Regression

This example covers the Logistic Regression model for binary classification tasks. The example includes data preparation, model training, and performance metrics.

- **File**: `log_reg.R`
- **Description**: Predict binary outcomes and evaluate model accuracy.

### Naive Bayes Classifier

This example illustrates the Naive Bayes classifier, particularly suited for text classification. The example showcases data handling and classification metrics.

- **File**: `nb_class.R`
- **Description**: Classify text data and assess the model’s performance.

### tidyverse and ggplot2

This example demonstrates the use of the 'pipe' operator and the creation of a bar chart.

- **File**: `pipe_chart.R`
- **Description**: This script processes the data to visualize of data. It utilizes dplyr for data manipulation and ggplot2 for plotting.
  
---
### SQL

This example demonstrates how to create a table and import data from a CSV file into a PostgreSQL database.

- **File**: `create.sql`
- **Description**: This script creates a table with demographic and clinical variables, then populates it using data from a CSV file.
---

### Data cleaning in Python

This example demonstrates basic data cleaning techniques using Python.

- **File**: `data_cleaning.py`
- **Description**: This script performs data cleaning tasks such as handling missing values and formatting data for analysis.

### 
## Installation

To get started, clone this repository and install the required R packages:

```r
# Clone the repository
git clone https://github.com/wrbarnett/.github.io.git
setwd("coding-examples")

# Install required packages
install.packages(c("tidyverse", "survival", "caret", "rms", "klaR", "qwraps", "ggplot2"))

#Install libraries
pip install pandas numpy scikit-learn
```

## Usage

Each example can be run individually. For instance, to run the logistic regression example:

```r
source("log_reg.R")
```

Make sure to check the comments in each script for detailed explanations and guidance.

## Contributing

Contributions are welcome! If you have improvements or additional examples to add, feel free to fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
