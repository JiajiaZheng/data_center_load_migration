library(readxl)
library(tidyverse)
library(openxlsx)
library(readr)


## PJM hourly generation data cleaning

PJM_gen_2018 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/ISOs/PJM/PJM_gen_by_fuel_2018.xlsx", sheet = "Clean")

PJM_gen_2018 <- PJM_gen_2018 %>% spread(key = Type, value = Generation)

openxlsx::write.xlsx(PJM_gen_2018, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/PJM_hrly_gen_2018.xlsx", sheetName = "Clean")


## PJM hourly load data cleaning

PJM_load_2018 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/ISOs/PJM/PJM_load_metered_2018.xlsx", 
                            sheet = "Clean")

PJM_load_2018 <- PJM_load_2018 %>% group_by(hour) %>% summarise(load = sum(mw))

openxlsx::write.xlsx(PJM_load_2018, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/PJM_hrly_load_2018.xlsx", sheetName = "Clean")

# Then fill in the missing data of 2 a.m. load on 3/11 using average value of neighbor hours


### PJM interchange data cleaning

PJM_interchange_2018 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/ISOs/PJM/PJM_interchange_2018_Clean.xlsx", sheet = "Clean")

PJM_interchange_2018 <- PJM_interchange_2018 %>% group_by(hour) %>% summarise(flow = sum(actual_flow))

openxlsx::write.xlsx(PJM_interchange_2018, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/PJM_hrly_flow_2018.xlsx", sheetName = "Clean")



########################################## PJM generation data cleaning 2016-2019 ################################################################

## 2016

PJM_gen_2016 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/PJM/PJM_gen_by_fuel_2016.xlsx", sheet = "Clean")

PJM_gen_2016 <- PJM_gen_2016 %>% spread(key = Type, value = Generation)

openxlsx::write.xlsx(PJM_gen_2016, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/PJM_hrly_gen_2016.xlsx", sheetName = "Clean")

## 2017

PJM_gen_2017 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/PJM/PJM_gen_by_fuel_2017.xlsx", sheet = "Clean")

PJM_gen_2017 <- PJM_gen_2017 %>% spread(key = Type, value = Generation)

openxlsx::write.xlsx(PJM_gen_2017, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/PJM_hrly_gen_2017.xlsx", sheetName = "Clean")

## 2019

PJM_gen_2019 <- read_excel("C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/PJM/PJM_gen_by_fuel_2019.xlsx", sheet = "Clean")

PJM_gen_2019 <- PJM_gen_2019 %>% spread(key = Type, value = Generation)

openxlsx::write.xlsx(PJM_gen_2019, file = "C:/Users/jzheng/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model outputs/PJM_hrly_gen_2019.xlsx", sheetName = "Clean")