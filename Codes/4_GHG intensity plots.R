library(ggplot2)
library(tidyverse)
library(viridis) # colour blind friendly palette
library(lubridate) 
# library(ggExtra) 
library(readxl)
library(cowplot)
# library(ggpubr)
# library(lemon)

#################################################### Hourly GHG intensity heat map 2016-2019 ###########################################################

intensity_16to19_hrly <- read_excel("~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/GHG_Intensity_2016-2019.xlsx", sheet = "Hourly")

intensity_16to19 <- intensity_16to19_hrly %>% 
  mutate(Date = date(Time), Hour = hour(Time)) %>% 
  select(-Time)

# intensity_16to19_curtail <- gather(intensity_16to19[, c(1,4:7)], "Area", "Intensity", 1:3) # Including intensity difference column
intensity_16to19_curtail <- gather(intensity_16to19[, c(1,4,6:7)], "Area", "Intensity", 1:2) # Excluding intensity difference column


GHG_heatmap_16to19 <- 
  # ggplot(transform(intensity_16to19_curtail, Area = factor(Area, levels = c("PJM", "CAISO", "Difference"))), 
  #                         aes(Date, Hour, fill = Intensity)) +
  ggplot(transform(intensity_16to19_curtail, Area = factor(Area, levels = c("PJM", "CAISO"))), 
         aes(Date, Hour, fill = Intensity)) +
  geom_tile() +  ## can add: color="White", size=0.01
  scale_fill_viridis(name = expression("kg"*"CO"[2]*"e/MWh"), option = "viridis", direction = -1, na.value = "grey", 
                     limits = c(0, max(intensity_16to19[,1])), breaks = seq(0, 700, 100)) + 
  # limits = c(min(intensity_16to19[,5]), max(intensity_16to19[,1])), breaks = seq(-100, 600, 100))
  # facet_wrap(~Area, scales = "free_y", nrow = 3) +
  facet_wrap(~Area, scales = "free_y", nrow = 2) +
  scale_y_continuous(trans = "reverse", breaks = c(0,5,11,17,23), labels = c(1,6,12,18,24), expand = c(0,0)) +
  scale_x_date(date_labels = "%b-%y", expand = c(0,0), limits = c(as.Date("2016-01-01"), as.Date("2020-01-01")),
               breaks = c(from = as.Date("2016-01-01"), seq(as.Date("2016-01-01"), to = as.Date("2020-01-01"), by = "6 month"))) +
  theme_bw(base_family = "Avenir") +  
  labs(x = "Day", y = "Hour") +
  theme(legend.position = "bottom") +
  theme(axis.title = element_text(size = 14)) +
  theme(axis.text.x = element_text(size = 12, margin = margin(t=3))) +
  theme(axis.text.y = element_text(size = 12, margin = margin(r=3))) +
  theme(axis.ticks.length = unit(1.5,"pt")) +
  theme(strip.background = element_blank(), 
        strip.text = element_text(size = 12, hjust = 0.5, margin = margin(b = 1), color = "black")) +
  theme(panel.border = element_rect(colour = "black"), panel.background = element_blank(), panel.spacing = unit(0.5, "lines"),
        plot.margin = unit(c(t=0.3, r=0.5, b=0.1, l=0.3), "cm")) +
  theme(legend.title = element_text(size = 12), legend.text = element_text(size = 11), legend.position = "right") +
  theme(legend.key.size = unit(0.8, "cm"), legend.key.width = unit(0.6, "cm"), 
        legend.key.height = unit(1.1, "cm"), legend.title.align = 1) +
  # removeGrid() +
  geom_vline(aes(xintercept = as.numeric(as.Date("2017-01-01"))), linetype = "dashed", colour = "white") +
  geom_vline(aes(xintercept = as.numeric(as.Date("2018-01-01"))), linetype = "dashed", colour = "white") +
  geom_vline(aes(xintercept = as.numeric(as.Date("2019-01-01"))), linetype = "dashed", colour = "white")

GHG_heatmap_16to19 # export 800*650 for three panels and 1000*500 for two panels

ggsave(filename = "Fig 2 - GHG intensity.jpeg", plot=GHG_heatmap_16to19, device = "jpeg", 
       dpi = 300, width = 10, height = 5,
       path="~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Visualization")

ggsave(filename = "Fig 2 - GHG intensity2.tiff", plot=GHG_heatmap_16to19, device = "tiff", 
       dpi = 300, width = 10, height = 5,
       path="~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Visualization") 

