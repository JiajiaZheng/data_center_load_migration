library(tidyverse)
library(readxl)
library(ggExtra) 
library(cowplot)


#################### Read the datacenter energy consumption data under 65% and 80% scenarios ############

apr_profile <- read_excel("~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/Datacenter_Profile_Change.xlsx", sheet = "apr")

## Energy profile of data center under 80% max utilization rate assumption 

## April profile 65%

apr_ur65 <- cbind(hour = 0:167, apr_profile[, c(10:15)])
apr_ur80 <- cbind(hour = 0:167, apr_profile[, c(10:12,16:18)])

apr_ur65_before <- gather(apr_ur65[c(1:3)], type, mwh, -hour)
apr_ur80_before <- gather(apr_ur80[c(1:3)], type, mwh, -hour)

# dc_ur65_absorp <- gather(dc_ur65[c(1,2,4,5,7)], type, mwh, -hour)

apr_ur65_before$type <- factor(apr_ur65_before$type, levels = c( "Nonserver_before", "Server_before"))
apr_ur80_before$type <- factor(apr_ur80_before$type, levels = c( "Nonserver_before", "Server_before"))

# ## Energy profile of data center under 65% max utilization rate assumption 
 
plot_apr_ur65 <- ggplot() +
  
  geom_area(data = apr_ur65_before, aes(x = hour, y = mwh, fill = type)) +
  
  geom_ribbon(data = apr_ur65, aes(x = hour, ymin = Total_before, ymax = Total_after_65, fill = "lightsalmon4"),
              stat = "identity") +
  
  geom_ribbon(data = apr_ur65, aes(x = hour, ymin = Server_before, ymax = Server_after_65, fill = "steelblue4"),
              stat = "identity") +
  
  geom_line(data = apr_ur65, aes(x = hour, y = Server_before), size = 0.5) +
  geom_line(data = apr_ur65, aes(x = hour, y = Total_before), size = 0.5) +
  
  scale_fill_manual(values = c("#FCC7C7",  "#FE8D8D",  "#2C7BCA", "#7DB5EC"),
                    labels = c("Non-server additional absorption", "Non-server energy use before migration",
                               "Server energy use before migration", "Server additional absorption" )) +
  
  labs(x = "Hour", y = "Energy consumption (MWh)") +
  scale_x_continuous(breaks = seq(0, 168, 24), expand = c(0.02, 0.02)) +
  scale_y_continuous(breaks = seq(0, 15, 5), limits = c(0, 15), expand = c(0.02, 0.02)) +
  theme_bw(base_family = "Avenir") +
  theme(axis.title.x = element_text(size = 14, margin = margin(t = 2)), 
        axis.title.y = element_text(size = 14, margin = margin(r = 5)),
        axis.text = element_text(size = 12), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(legend.title = element_blank(), legend.position = c(0.78, 0.87), legend.text = element_text(size = 12),
        legend.key.size = unit(0.52, "cm"), legend.spacing = unit(-0.1, "cm")) 

plot_apr_ur65 # export 900*500 (JPEG), 9*5 inch (PDF)


## April profile 80%

plot_apr_ur80 <- ggplot() +
  
  geom_area(data = apr_ur80_before, aes(x = hour, y = mwh, fill = type)) +
  
  geom_ribbon(data = apr_ur80, aes(x = hour, ymin = Total_before, ymax = Total_after_80, fill = "lightsalmon4"),
              stat = "identity") +  
  
  geom_ribbon(data = apr_ur80, aes(x = hour, ymin = Server_before, ymax = Server_after_80, fill = "steelblue4"),
              stat = "identity") +
  
  geom_line(data = apr_ur80, aes(x = hour, y = Server_before), size = 0.5) +
  geom_line(data = apr_ur80, aes(x = hour, y = Total_before), size = 0.5) +
  
  scale_fill_manual(values = c("#FCC7C7",  "#FE8D8D",  "#2C7BCA", "#7DB5EC"),
                    labels = c("Non-server additional absorption", "Non-server energy use before migration", 
                               "Server energy use before migration", "Server additional absorption" )) +
  
  labs(x = "Hour", y = "Energy consumption (MWh)") +  
  scale_x_continuous(breaks = seq(0, 168, 24), expand = c(0.02, 0.02)) +
  scale_y_continuous(breaks = seq(0, 15, 5), limits = c(0, 15), expand = c(0.025, 0.02)) +
  theme_bw(base_family = "Avenir") +
  theme(axis.title.x = element_text(size = 14, margin = margin(t = 2)), 
        axis.title.y = element_text(size = 14, margin = margin(r = 5)),
        axis.text = element_text(size = 12), 
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  theme(legend.title = element_blank(), legend.position = c(0.78, 0.87), legend.text = element_text(size = 12),
        legend.key.size = unit(0.52, "cm"), legend.spacing = unit(-0.1, "cm")) 

plot_apr_ur80 # export 900*500 (JPEG), 9*5 inch (PDF)

## Export the plots

ggsave(filename = "Fig 3 - DC profile - 65pct.jpeg", plot = plot_apr_ur65, device = "jpeg", 
       dpi = 300, width = 9, height = 5,
       path="~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Visualization")

ggsave(filename = "Fig 3 - DC profile - 65pct.tiff", plot = plot_apr_ur65, device = "tiff", 
       dpi = 300, width = 9, height = 5,
       path="~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Visualization") 
