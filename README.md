# Do-Retail-Investors-need-Analysts-Recommendations

This repository provides the Python and STATA codes for our analysis for the Capstone project: Do Retail Investors Need Analysts’ Recommendations?

We have added our initial code to the following GitHub repository. There are currently three files in the repository:

Data Cleaning and Organization.ipynb: This file pulls in our initial dataset from I/B/E/S for the analyst recommendations and CRSP for the daily level security trading prices. This is our initial
cleaning and exploration file. We restructure the data weekly and monthly for the latest recommendation for each firm issued within the prior three months. This code file allows us to
restructure the data with respect to our unique trading strategy. We also include the Fama-French industry classifications.

Monthly Return Analysis.ipynb: This code calculates and attaches the monthly return for each firm from the CRSP database. It also merges the factors from the monthly Fama-French database
(FF3 & FF5), Cahart 4-factors, Hou-Xue-Zhang q-factor and Hou-Mo-Xue-Zhang augmented factor. This code also outputs another dataset for the Fama-McBeth Robustness test which includes firm fundamentals. 

Broker-Level Data : This code is used for the investment bank/ broker level cross section to select observations at each sell-side firm.

Period Do File: This is a STATA command file for all analysis and tables included in our results using the datafiles. We have included the links for the datafiles below. 



It is important to note that to implement this, we use the Unity Computing Cluster, a collaborative, multi-institutional high-performance computing cluster located at the Massachusetts Green High
Performance. Our daily-level CRSP dataset requires about 100GB of RAM to load and perform the necessary restructuring. We can provide the necessary data (about 25GB) to run both these
files. However, a computing cluster or web service like Amazon Web Services would be needed to deploy to execute it.

However, we have attached links below to the cleaned datasets on which the STATA DO file runs. The imported datasets for the Python script from I/B/E/S and CRSP are very large and are available upon request.

CRSP Original Data - https://liveumb-my.sharepoint.com/:u:/g/personal/uchenna_onuoha001_umb_edu/EfQpUHbnYstCtWJn6BRQlRMBK9Tjd57uWL0UAYoyHpe5gw?e=gReiqz

I/B/E/S Original Data - https://liveumb-my.sharepoint.com/:u:/g/personal/uchenna_onuoha001_umb_edu/ETd00Rir2ORIjgnajzMQ6pkBDCE2iuXnJ9WTYwLyqpVFqQ?e=qGm2jr

Monthly Portfolio Sort Data - https://liveumb-my.sharepoint.com/:u:/g/personal/uchenna_onuoha001_umb_edu/Eff36sP3UUlPq1fRQcQKgl8BpFD4XuR85Uxrc949VDtKEg?e=iHVuav

Broker-Level Data - https://liveumb-my.sharepoint.com/:u:/g/personal/uchenna_onuoha001_umb_edu/ES4NHNLyPCZHqoSSxtpDd_kBEH-Xu_w2fg8sB3z4VOLmHg?e=KsX3ck

Fama-McBeth Robustness Test Data - https://liveumb-my.sharepoint.com/:u:/g/personal/uchenna_onuoha001_umb_edu/EYZCo3kbDLpNh6tV8lEgtVMBPtHb_6aRCiChvrflJSIASw?e=PnjAk8

