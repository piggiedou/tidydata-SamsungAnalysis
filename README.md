# tidydata-SamsungAnalysis
1. download zip file from source; extract to folders; create new folders containing files to be interested
2. set correct working directory; read six data files and one feature files to R console
3. check dimension of each file, merge them appropriately using cbind and rbind command
4. create a rawmerge dataset
5. renames the measurement columns by using the values from feature file
6. replace () to paren in column names to avoid future confusion 
7. extract columns with columnnames containing "meanparen" and "stdparen" (actually mean() and std())
8. merge to get a new tidydata set with interested mean and std measurements as well as subject and activity columns
9. rename activity column with more descriptive names
10. rename measurement variables with more descriptive names
11. upload dplyr package
12. grouping by subject and activity; summarize each measurement under grouping result; create final data set
13. check dimension to see result
13. write finaldata to local JH-finaldata as txt file; remove row name
