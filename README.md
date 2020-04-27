In run_analysis.R, the code does following things:

1. define a function call genDf:

   In genDf, we have two parameters: pth and dtType, first one is for the input path, second if for type of data(train,test)

   Fisrt, we read feature data, subject list, activity, x data, and y data.
   
   We generate a activity list by lapply y data with corresponding labels.
   
   Then, we add y as a column into x.
  
2. We generate dataframe for test and train dataset using genDf.

3. We combine two dataframes into tb3

4. we select only mean() and std() data from subjects and generate new dataframe -> tb4

5. we remove the numbers from column names in tb4

6. we generate a new summary table, which is the mean of all culumns of tb4 group by activities

7. Finally, save the generated summary data.
