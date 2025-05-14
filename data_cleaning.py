Import necessary libraries.

import pandas as pd
import numpy as np
from sklearn.impute import SimpleImputer

1.1 Remove cns, id, prolong, pain, od, and MME from the dataset.

def remove_cols(df):
    return df.drop(columns=['id', 'csn', 'prolong', 'MME', 'pain', 'od'], errors='ignore')

1.2 Impute the missing BMI values based on sex and race1.2 Impute the missing BMI values based on sex and race

def fix_missing_bmi(df):
    if 'race' in df.columns and 'gender' in df.columns and 'bmi' in df.columns:
        # Compute mean BMI per race-gender group
        bmi_means = df.groupby(['race', 'gender'])['bmi'].transform('mean')
        # Fill missing BMI values with corresponding group mean
        df['bmi'] = df['bmi'].fillna(bmi_means)
    else:
        print("Error: Missing 'race', 'gender', or 'bmi' column.")
        # Handle the case where required columns are missing (optional: fill with global mean)
        if 'bmi' in df.columns:
            df['bmi'] = df['bmi'].fillna(df['bmi'].mean())  # Global mean as fallback
        else:
            print("Error: Missing 'bmi' column.")
    return df

1.3 Impute the other missing variables.

def impute_missing_values(df):
    numerical_cols = df.select_dtypes(include=['number']).columns.tolist()
    categorical_cols = df.select_dtypes(exclude=['number']).columns.tolist()

    # Impute numerical columns with mean
    if len(numerical_cols) > 0:
        imputer_numerical = SimpleImputer(strategy='mean')
        df_numerical = imputer_numerical.fit_transform(df[numerical_cols])
        df_numerical = pd.DataFrame(df_numerical, columns=numerical_cols, index=df.index)  # Ensure column names are retained
        df[numerical_cols] = df_numerical  # Reassign to the original DataFrame
    
    # Impute categorical columns with most frequent value
    if len(categorical_cols) > 0:
        imputer_categorical = SimpleImputer(strategy='most_frequent')
        df_categorical = imputer_categorical.fit_transform(df[categorical_cols])
        df_categorical = pd.DataFrame(df_categorical, columns=categorical_cols, index=df.index)
        df[categorical_cols] = df_categorical

    return df

1.4 Pre-process the dataframe.

def preprocess_dataframe(df):
    df = remove_cols(df)  # Remove unnecessary columns
    df = fix_missing_bmi(df)  # Fix missing BMI values
    df = impute_missing_values(df)  # Impute missing values

    # **Standardize Race Categories**
    df['race'] = df['race'].str.lower().str.strip()

    race_mapping = {
        'black or african american': 'black',
        'white or caucasian': 'white',
        'asian/white': 'mixed',
        'black/white': 'mixed',
        'hispanic/black': 'hispanic',
        'hispanic/white': 'hispanic',
        'native hawaiian or other pacific islander': 'pacific_islander',
        'middle eastern': 'middle_eastern',
        'patient refused': 'unknown',
        'unknown': 'unknown',
    }
    
    df['race'] = df['race'].replace(race_mapping)

    # Ensure `phos` remains numeric and handle missing values
    if 'phos' in df.columns:
        df['phos'] = pd.to_numeric(df['phos'], errors='coerce')
        df['phos'] = df['phos'].fillna(df['phos'].mean())  # Impute missing values in 'p

    # Identify categorical columns correctly
    categorical_cols = df.select_dtypes(include=['object', 'category']).columns.tolist()

    # Ensure `race` and `gender` are treated as categorical
    for col in ['race', 'gender']:
        if col in df.columns:
            df[col] = df[col].astype('category')

    # Apply one-hot encoding to categorical variables
    df = pd.get_dummies(df, columns=categorical_cols, drop_first=True)

    # Convert boolean columns to integers
    bool_cols = df.select_dtypes(include=['bool']).columns
    df[bool_cols] = df[bool_cols].astype(int)

    return df

# Load the dataset
df = pd.read_csv("dataset_f23.csv")

# Preprocess the dataframe
df = preprocess_dataframe(df)
