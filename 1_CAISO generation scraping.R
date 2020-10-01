library(tidyverse)
library(readxl)

## Scrape hourly electricity generation data from CAISO website

#################################################### 2018 ##########################################################

days_2018 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/CAISO/Days for scraping.xlsx", sheet = "2018")

CAISO_REgen_2018 <- data.frame()

for (i in 1:365){
  
  url_i <- paste0("http://content.caiso.com/green/renewrpt/", days_2018[i,1], "_DailyRenewablesWatch.txt")
  gen_day_i <- read.table(url_i, skip = 2, nrows = 24)
  CAISO_REgen_2018 <- rbind(CAISO_REgen_2018, gen_day_i)
  rm(url_i)
  rm(gen_day_i)
  
}

CAISO_Allgen_2018 <- data.frame()

for (j in 1:365){
  
  url_j <- paste0("http://content.caiso.com/green/renewrpt/", days_2018[j,1], "_DailyRenewablesWatch.txt")
  gen_day_j <- read.table(url_j, skip = 30, nrows = 24)
  CAISO_Allgen_2018 <- rbind(CAISO_Allgen_2018, gen_day_j)
  rm(url_j)
  rm(gen_day_j)
  
}

colnames(CAISO_REgen_2018) <- c("Hour","Geothermal","Biomass","Biogas","Small_hydro", "Wind", "Solar_PV","Solar_thermal")

colnames(CAISO_Allgen_2018) <- c("Hour", "Renewables","Nuclear","Thermal","Imports","Large_hydro")

CAISO_gen_2018 <- cbind(CAISO_REgen_2018, CAISO_Allgen_2018[, -c(1,2)])

# CAISO_gen_2018 <- CAISO_gen_2018 %>% mutate(Solar = Solar_PV + Solar_thermal) %>% select(-c(Solar_PV, Solar_thermal)) %>% select(Hour, Solar, Wind, everything())

openxlsx::write.xlsx(CAISO_gen_2018, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/CAISO_hrly_gen_2018.xlsx", sheetName = "2018")




#################################################### 2017 ##########################################################

days_2017 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/CAISO/Days for scraping.xlsx", sheet = "2017")

## 03/12/2017 daylight savings day. Data on CAISO webpage (http://content.caiso.com/green/renewrpt/20170312_DailyRenewablesWatch.txt) is weired. So skip this day.

CAISO_REgen_2017 <- data.frame()

for (i in 1:364){
  
  url_i <- paste0("http://content.caiso.com/green/renewrpt/", days_2017[i,1], "_DailyRenewablesWatch.txt")
  gen_day_i <- read.table(url_i, skip = 2, nrows = 24)
  CAISO_REgen_2017 <- rbind(CAISO_REgen_2017, gen_day_i)
  rm(url_i)
  rm(gen_day_i)
  
}

CAISO_Allgen_2017 <- data.frame()


for (j in 1:364){
  
  url_j <- paste0("http://content.caiso.com/green/renewrpt/", days_2017[j,1], "_DailyRenewablesWatch.txt")
  gen_day_j <- read.table(url_j, skip = 30, nrows = 24)
  CAISO_Allgen_2017 <- rbind(CAISO_Allgen_2017, gen_day_j)
  rm(url_j)
  rm(gen_day_j)
  
}

colnames(CAISO_REgen_2017) <- c("Hour","Geothermal","Biomass","Biogas","Small_hydro", "Wind", "Solar_PV","Solar_thermal")

colnames(CAISO_Allgen_2017) <- c("Hour", "Renewables","Nuclear","Thermal","Imports","Large_hydro")

CAISO_gen_2017 <- cbind(CAISO_REgen_2017, CAISO_Allgen_2017[, -c(1,2)])

openxlsx::write.xlsx(CAISO_gen_2017, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/CAISO_hrly_gen_2017.xlsx", sheetName = "2017")



#################################################### 2016 ##########################################################

days_2016 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/CAISO/Days for scraping.xlsx", sheet = "2016")

## 02/29/2016 exists because 2016 is a leap year. But skipped this day to make sure it's comparable between different years.
## 03/13/2016 daylight savings day. Data on CAISO webpage (http://content.caiso.com/green/renewrpt/20160313_DailyRenewablesWatch.txt) is weired. So skipped this day.

CAISO_REgen_2016 <- data.frame()

for (i in 1:364){
  
  url_i <- paste0("http://content.caiso.com/green/renewrpt/", days_2016[i,1], "_DailyRenewablesWatch.txt")
  gen_day_i <- read.table(url_i, skip = 2, nrows = 24)
  CAISO_REgen_2016 <- rbind(CAISO_REgen_2016, gen_day_i)
  rm(url_i)
  rm(gen_day_i)
  
}

CAISO_Allgen_2016 <- data.frame()


for (j in 1:364){
  
  url_j <- paste0("http://content.caiso.com/green/renewrpt/", days_2016[j,1], "_DailyRenewablesWatch.txt")
  gen_day_j <- read.table(url_j, skip = 30, nrows = 24)
  CAISO_Allgen_2016 <- rbind(CAISO_Allgen_2016, gen_day_j)
  rm(url_j)
  rm(gen_day_j)
  
}

colnames(CAISO_REgen_2016) <- c("Hour","Geothermal","Biomass","Biogas","Small_hydro", "Wind", "Solar_PV","Solar_thermal")

colnames(CAISO_Allgen_2016) <- c("Hour", "Renewables","Nuclear","Thermal","Imports","Large_hydro")

CAISO_gen_2016 <- cbind(CAISO_REgen_2016, CAISO_Allgen_2016[, -c(1,2)])

openxlsx::write.xlsx(CAISO_gen_2016, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/CAISO_hrly_gen_2016.xlsx", sheetName = "2016")



#################################################### 2015 ##########################################################

days_2015 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/CAISO/Days for scraping.xlsx", sheet = "2015")

## 03/08/2015 daylight savings day. Data on CAISO webpage (http://content.caiso.com/green/renewrpt/20150308_DailyRenewablesWatch.txt) is weired. So skipped this day.

CAISO_REgen_2015 <- data.frame()

for (i in 1:364){
  
  url_i <- paste0("http://content.caiso.com/green/renewrpt/", days_2015[i,1], "_DailyRenewablesWatch.txt")
  gen_day_i <- read.table(url_i, skip = 2, nrows = 24)
  CAISO_REgen_2015 <- rbind(CAISO_REgen_2015, gen_day_i)
  rm(url_i)
  rm(gen_day_i)
  
}

CAISO_Allgen_2015 <- data.frame()


for (j in 1:364){
  
  url_j <- paste0("http://content.caiso.com/green/renewrpt/", days_2015[j,1], "_DailyRenewablesWatch.txt")
  gen_day_j <- read.table(url_j, skip = 30, nrows = 24)
  CAISO_Allgen_2015 <- rbind(CAISO_Allgen_2015, gen_day_j)
  rm(url_j)
  rm(gen_day_j)
  
}

colnames(CAISO_REgen_2015) <- c("Hour","Geothermal","Biomass","Biogas","Small_hydro", "Wind", "Solar_PV","Solar_thermal")

colnames(CAISO_Allgen_2015) <- c("Hour", "Renewables","Nuclear","Thermal","Imports","Large_hydro")

CAISO_gen_2015 <- cbind(CAISO_REgen_2015, CAISO_Allgen_2015[, -c(1,2)])

openxlsx::write.xlsx(CAISO_gen_2015, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/CAISO_hrly_gen_2015.xlsx", sheetName = "2015")


#################################################### 2019 01/01-09/22 ##########################################################

days_2019 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/CAISO/Days for scraping.xlsx", sheet = "2019")

CAISO_REgen_2019 <- data.frame()

for (i in 1:265){
  
  url_i <- paste0("http://content.caiso.com/green/renewrpt/", days_2019[i,1], "_DailyRenewablesWatch.txt")
  gen_day_i <- read.table(url_i, skip = 2, nrows = 24)
  CAISO_REgen_2019 <- rbind(CAISO_REgen_2019, gen_day_i)
  rm(url_i)
  rm(gen_day_i)
  
}

CAISO_Allgen_2019 <- data.frame()


for (j in 1:265){
  
  url_j <- paste0("http://content.caiso.com/green/renewrpt/", days_2019[j,1], "_DailyRenewablesWatch.txt")
  gen_day_j <- read.table(url_j, skip = 30, nrows = 24)
  CAISO_Allgen_2019 <- rbind(CAISO_Allgen_2019, gen_day_j)
  rm(url_j)
  rm(gen_day_j)
  
}

colnames(CAISO_REgen_2019) <- c("Hour","Geothermal","Biomass","Biogas","Small_hydro", "Wind", "Solar_PV","Solar_thermal")

colnames(CAISO_Allgen_2019) <- c("Hour", "Renewables","Nuclear","Thermal","Imports","Large_hydro")

CAISO_gen_2019 <- cbind(CAISO_REgen_2019, CAISO_Allgen_2019[, -c(1,2)])

openxlsx::write.xlsx(CAISO_gen_2019, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/CAISO_hrly_gen_2019_Jan-Sep.xlsx", sheetName = "2019")

#################################################### 2019 12/12-12/31 ##########################################################

days_Dec2019 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/CAISO/Days for scraping.xlsx", sheet = "2019Dec")

CAISO_REgen_Dec2019 <- data.frame()

for (i in 1:20){
  
  url_i <- paste0("http://content.caiso.com/green/renewrpt/", days_Dec2019[i,1], "_DailyRenewablesWatch.txt")
  gen_day_i <- read.table(url_i, skip = 2, nrows = 24)
  CAISO_REgen_Dec2019 <- rbind(CAISO_REgen_Dec2019, gen_day_i)
  rm(url_i)
  rm(gen_day_i)
  
}

CAISO_Allgen_Dec2019 <- data.frame()


for (j in 1:20){
  
  url_j <- paste0("http://content.caiso.com/green/renewrpt/", days_Dec2019[j,1], "_DailyRenewablesWatch.txt")
  gen_day_j <- read.table(url_j, skip = 30, nrows = 24)
  CAISO_Allgen_Dec2019 <- rbind(CAISO_Allgen_Dec2019, gen_day_j)
  rm(url_j)
  rm(gen_day_j)
  
}

colnames(CAISO_REgen_Dec2019) <- c("Hour","Geothermal","Biomass","Biogas","Small_hydro", "Wind", "Solar_PV","Solar_thermal")

colnames(CAISO_Allgen_Dec2019) <- c("Hour", "Renewables","Nuclear","Thermal","Imports","Large_hydro")

CAISO_gen_Dec2019 <- cbind(CAISO_REgen_Dec2019, CAISO_Allgen_Dec2019[, -c(1,2)])

openxlsx::write.xlsx(CAISO_gen_Dec2019, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/CAISO_hrly_gen_2019_Dec.xlsx", sheetName = "2019Dec")

