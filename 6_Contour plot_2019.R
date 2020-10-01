library(plotly)
library(ggplot2)
library(readxl)
library(tidyverse)

####################### Contour plots of GHG reduction, datacenter profits and net abatement cost ######################

## Read the data

reduction2019 <- read_excel("~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/Contour_2019.xlsx",
                            sheet = "reduction")
absorp2019 <- read_excel("~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/Contour_2019.xlsx",
                         sheet = "absorption")
abatement2019 <- read_excel("~/Box/Suh's lab/GSRs/Jiajia/Curtailment of VRE/Model inputs/Contour_2019.xlsx",
                            sheet = "abatement")

##################### Panel A - GHG reduction by max server utilization and Additional data center capacity ##################

UR <- seq(0.65, 0.90, by = 0.01)

percent <- function(x, digits = 0, format = "f", ...) {
  paste0(formatC(100 * x, format = format, digits = digits, ...), "%")}

UR <- percent(UR)

MW <- seq(0, 1000, by = 50)

matrix_reduction2019 <- as.matrix(reduction2019[,-1])

reduction_2019 <- plot_ly(
  x = UR, y = MW, z = matrix_reduction2019,
  # x = UR, y = MW[1:21], z = matrix_reduction2019[1:21,], #MW = seq(0, 2500, by = 50)
  type = "contour",
  # autocontour = TRUE,
  contours = list(coloring = 'heatmap', showlabels = TRUE, 
                  labelfont = list(family = "Avenir", size = 20, color = "white"),
                  start = 100, end = 250, size = 20), #smooth contour coloring
  # colorscale ="viridis",
  # reversescale = T,
  line = list(smoothing = 0.85, color = "white")
) %>%
  layout(xaxis = list(ticksuffix="%", title = 'Maximum server utilization rate', 
                      range = c(65, 90),
                      titlefont = list(family = "Avenir", size = 23, color = "black"), 
                      tickfont = list(family = "Avenir", size = 21, color = "black"),
                      showline = TRUE, mirror = TRUE),
         yaxis = list(title = 'Additional data center capacity (MW)', 
                      range = c(min(MW), max(MW)), 
                      titlefont = list(family = "Avenir", size = 23, color = "black"), 
                      tickfont = list(family = "Avenir", size = 21, color = "black"),
                      tickformat = ",d",
                      showline = TRUE, mirror = TRUE,
                      automargin = T, tickprefix = "   ")) %>%
  colorbar(title = "Net GHG\nemissions\nreduction\n(KtCO<sub>2</sub>e)\n",
           limits = c(min(reduction2019[,-1]), max(reduction2019[,-1])),
           # dtick = 40, 
           exponentformat = "none", len = 0.85,
           titlefont = list(family = "Avenir", size = 21, color = "black"), 
           tickfont = list(family = "Avenir", size = 19, color = "black"),
           tickformat = ",d",
           x = 1.015, y = 0.93) 

# reduction_2019 

# Add lines of different absorption rates

absorp2019$absorption <- percent(absorp2019$absorption)

colnames(absorp2019) <- c("absorption", percent(c(0.65,0.70,0.72,0.75,0.79,0.80,0.85,0.88,0.90)))

absorp2019_long <- gather(absorp2019, utilization, capacity, -absorption)

reduction2019_absorp <- reduction_2019 %>% 
  add_trace(data = absorp2019_long, 
            x = ~utilization, y = ~capacity, color = ~absorption,
            colors = '#363333', type = "scatter", mode = "lines", 
            line = list(color = '#363333', width = 1),
            showlegend = FALSE)

# Add annotation of the absorption rate lines

text <- c("40%","50%","60%","70%","80%","90%")
ur_position <- c(68.5,72.5,76,80,83.4,88.6)
mw_position <- c(78,134,213,329,553,969)

contour2019_reduction <- reduction2019_absorp %>% 
  layout(legend = list(orientation = 'h')) %>%
  add_annotations(x = ur_position, y = mw_position, showarrow = FALSE,
                  text = text, xref = "x", yref = "y", 
                  # ax = 500, ay = 500, 
                  font = list(color = '#363333', family = "Avenir", size = 20))


############################# Panel B - net abatement cost ((total cost-total revenue)/GHG reduction) ##############################

matrix_abatement2019 <- as.matrix(abatement2019[,-1])

abatement_2019 <- plot_ly(
  x = UR, y = MW, z = matrix_abatement2019,
  type = "contour",
  # autocontour = TRUE,
  contours = list(coloring = 'heatmap', showlabels = TRUE, 
                  labelfont = list(family = "Avenir", size = 20, color = "white"),
                  start = -800, end = 1900, size = 400), #smooth contour coloring
  colorscale ="Cividis",
  reversescale = T,
  line = list(smoothing = 0.85, color = "white")
) %>%
  
  layout(xaxis = list(ticksuffix="%", title = 'Maximum server utilization rate', 
                      range = c(65, 90),
                      titlefont = list(family = "Avenir", size = 23, color = "black"), 
                      tickfont = list(family = "Avenir", size = 21, color = "black"),
                      showline = TRUE, mirror = TRUE), 
         yaxis = list(title = 'Additional data center capacity (MW)', 
                      range = c(min(MW), max(MW)), 
                      titlefont = list(family = "Avenir", size = 23, color = "black"), 
                      tickfont = list(family = "Avenir", size = 21, color = "black"),
                      tickformat = ",d",
                      showline = TRUE, mirror = TRUE,
                      automargin = T, tickprefix = "   ")) %>%
  colorbar(title = "Net\nabatement\ncost\n($/tCO<sub>2</sub>e)\n",
           limits = c(min(abatement2019[,-1]), max(abatement2019[,-1])), 
           # dtick = 400, 
           exponentformat = "none", len = 0.85,
           titlefont = list(family = "Avenir", size = 21, color = "black"), 
           tickfont = list(family = "Avenir", size = 19, color = "black"),
           tickformat = ",d",
           x = 1.015, y = 0.93) 

abatement2019_absorp <- abatement_2019 %>% 
  add_trace(data = absorp2019_long, 
            x = ~utilization, y = ~capacity, color = ~absorption,
            colors = '#363333', type = "scatter", mode = "lines", 
            line = list(color = '#363333', width = 1),
            showlegend = FALSE)

contour2019_abatement <- abatement2019_absorp %>% 
  add_annotations(x = ur_position, y = mw_position, showarrow = FALSE,
                  text = text, xref = "x", yref = "y", 
                  # ax = 800, ay = 800, 
                  font = list(color = '#363333', family = "Avenir", size = 20))

# 750*600
contour2019_reduction
contour2019_abatement 

