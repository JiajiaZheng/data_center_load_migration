library(ggplot2)
library(tidyverse)
library(viridis) # colour blind friendly palette
library(lubridate) 
# library(ggExtra) 
library(readxl)
library(cowplot)


######################################## Daily curtailment bar chart 2015-2019 ##############################################

curtail_caiso_daily <- read_excel("~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/CAISO_Curtailment_2015-2019.xlsx", sheet = "2015-2019daily")

curtail_caiso_daily$Day <- as.Date(curtail_caiso_daily$Day)

curtail_caiso_daily_long <- gather(curtail_caiso_daily[, 1:3], type, curtailment, 2:3)

bar_daily_curtail <- ggplot(curtail_caiso_daily_long, aes(x = Day, y = curtailment/1000, fill = type)) +
  geom_bar(stat = "identity", position = "stack", width = 1.0) +
  theme_bw(base_family = "Avenir") +
  theme(legend.title = element_blank(), legend.key.size = unit(0.75, "cm"), 
        legend.text = element_text(size = 13), legend.box.margin = margin(r = 8.8)) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_text(size = 14, margin = margin(t = 0, r = 7, b = 0, l = 0)),
        axis.text = element_text(size = 12),
        panel.grid.minor = element_blank(), panel.spacing = unit(0, "lines")) +
  scale_fill_manual(labels = c( "Solar", "Wind"), values = c( "orange", "skyblue")) +
  scale_y_continuous(expand = c(0, 0), limits=c(0, 40), labels = function(x) format(x, big.mark = ",", scientific = FALSE)) +
  labs(y = "CAISO curtailment (GWh)") +
  scale_x_date(date_labels = "%b-%y", expand = c(0,0), limits = c(as.Date("2015-01-01"), as.Date("2020-01-01")),
               breaks = c(from = as.Date("2015-01-01"), seq(as.Date("2015-01-01"), to = as.Date("2020-01-01"), by = "6 month"))) +

  geom_vline(aes(xintercept = as.numeric(as.Date("2016-01-01"))), linetype = "dashed", colour = "gray21") + # remove this if exluding 2015
  geom_vline(aes(xintercept = as.numeric(as.Date("2017-01-01"))), linetype = "dashed", colour = "gray21") +
  geom_vline(aes(xintercept = as.numeric(as.Date("2018-01-01"))), linetype = "dashed", colour = "gray21") +
  geom_vline(aes(xintercept = as.numeric(as.Date("2019-01-01"))), linetype = "dashed", colour = "gray21")

# bar_daily_curtail


######################################### Hourly curtailment heat map 2016-2019 ##################################################


curtail_caiso <- read_excel("~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/CAISO_Curtailment_2015-2019.xlsx",
                            sheet = "2015-2019hourly")

curtail_caiso_16to19 <- curtail_caiso %>%  ##  Change to curtail_caiso[-c(1:8760), ] if only wanna exclude 2015 data
  mutate(Date = date(Time), Hour = hour(Time)) %>% 
  select(-Time)

curtail_caiso_16to19_long <- gather(curtail_caiso_16to19[, c(1:5)], "Type", "Curtailment", 1:3)

curtail_heatmap <- ggplot(transform(curtail_caiso_16to19_long, 
                                    Type = factor(Type, levels = c("Solar curtailment", "Wind curtailment","Total curtailment"))),
                          aes(Date, Hour, fill = Curtailment)) +
  geom_tile() +  ## can add: color="White", size=0.01
  scale_fill_viridis(name = "MWh", option = "plasma", direction = -1, na.value = "grey70", 
                     limits = c(0, max(curtail_caiso_16to19_long[,4])), breaks = seq(0, 4500, 1000),
                     labels = function(x) format(x, big.mark = ",", scientific = FALSE)) + 
  facet_wrap(~Type, scales = "free_y", nrow = 3) +
  scale_y_continuous(trans = "reverse", breaks = c(0,5,11,17,23), labels = c(1,6,12,18,24), expand = c(0,0)) +
  scale_x_date(date_labels = "%b-%y", expand = c(0,0), limits = c(as.Date("2015-01-01"), as.Date("2020-01-01")),
               breaks = c(from = as.Date("2015-01-01"), seq(as.Date("2015-01-01"), to = as.Date("2020-01-01"), by = "6 month"))) +
  theme_bw(base_family = "Avenir") +  
  labs(x = "Day", y = "Hour")  +
  
  theme(legend.position = "bottom") +
  theme(axis.ticks.length = unit(1.5,"pt")) +
  theme(strip.background = element_blank(), 
        strip.text = element_text(size = 14, hjust = 0.5, margin = margin(b = 2), color = "black")) +
  theme(panel.spacing = unit(0.5, "lines"), panel.border = element_rect(colour = "black"),
        plot.margin = unit(c(t=0.3, r=0.5, b=0.1, l=0.3), "cm")) +
  theme(legend.title = element_text(size = 13), legend.text = element_text(size = 12), 
        legend.position = "right") +
  theme(legend.key.size = unit(0.8, "cm"), legend.key.width = unit(0.7, "cm"), 
        legend.title.align = 0, legend.text = element_text(size = 13),
        legend.box.margin = margin(l = 0)) +
  theme(axis.title.x = element_text(size = 14, margin = margin(t = 8)),
        axis.title.y = element_text(size = 14, margin = margin(r = 6)),
        axis.text = element_text(size = 12)) +
  # removeGrid() +
  geom_vline(aes(xintercept = as.numeric(as.Date("2016-01-01"))), linetype = "dashed", colour = "gray21") + # remove this if exluding 2015
  geom_vline(aes(xintercept = as.numeric(as.Date("2017-01-01"))), linetype = "dashed", colour = "gray21") +
  geom_vline(aes(xintercept = as.numeric(as.Date("2018-01-01"))), linetype = "dashed", colour = "gray21") +
  geom_vline(aes(xintercept = as.numeric(as.Date("2019-01-01"))), linetype = "dashed", colour = "gray21")

curtail_heatmap ## Export resolution 1000*700


### Combine daily and hourly curtailment plots

fig1 <- plot_grid(bar_daily_curtail, curtail_heatmap, nrow = 2, labels = "AUTO", label_fontface = "bold",
          rel_heights = c(1,2.2), rel_widths = c(1, 1)) #export 1200*1000

ggsave(filename = "Fig 1.jpeg", plot=fig1, device = "jpeg", 
       dpi = 300, width = 12, height = 10,
       path="~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Visualization")

# tiff is too big (40 MB)
ggsave(filename = "Fig 1.tiff", plot=fig1, device = "tiff", 
       dpi = 300, width = 12, height = 10,
       path="~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Visualization") 

