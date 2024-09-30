# Do-Retail-Investors-need-Analysts-Recommendations

This repository provides the Python and STATA codes for our analysis for the Capstone project: Do Retail Investors Need Analysts’ Recommendations?

We have added our initial code to the following GitHub repository as requested. There are currently three files in the repository:
Data Cleaning and Organization.ipynb: This file pulls in our initial dataset from I/B/E/S for the analyst recommendations and CRSP for the daily level security trading prices. This is our initial
cleaning and exploration file. We restructure the data weekly and monthly for the latest recommendation for each firm issued within the prior three months. This code file allows us to
restructure the data with respect to our unique trading strategy. We also include the Fama-French industry classifications.

Monthly Return Analysis.ipynb: This code calculates and attaches the monthly return for each firm from the CRSP database. It also merges the factors from the monthly Fama-French database
(FF3 & FF5), Cahart 4-factors, Hou-Xue-Zhang q-factor and Hou-Mo-Xue-Zhang augmented factor. 

Broker-Level Analysis : This code is used for the investment bank/ broker level cross section to select observations at each level.


It is important to note that to implement this, we use the Unity Computing Cluster, a collaborative, multi-institutional high-performance computing cluster located at the Massachusetts Green High
Performance. Our daily-level CRSP dataset requires about 100GB of RAM to load and perform the necessary restructuring. We can provide the necessary data (about 25GB) to run both these
files. However, a computing cluster or web service like Amazon Web Services would be needed to deploy to execute it.

However, we have attached links below to the cleaned datasets on which the STATA DO file runs. The imported datasets for the Python script from I/B/E/S and CRSP are very large and are available upon request.

Monthly Portfolio Sort Data - https://liveumb-my.sharepoint.com/:u:/g/personal/uchenna_onuoha001_umb_edu/EbcQ8PuCJB5CqA_T-lSDjeABQq5URl3RqnI21EDRsnNMiQ?e=FkQaWv

Broker-Level Data - https://liveumb-my.sharepoint.com/:u:/g/personal/uchenna_onuoha001_umb_edu/EdGIittWWrNAi-D_OzJaHyEBCI02I5LoDMOkM9fEtKeFdg?e=QY9xdt

