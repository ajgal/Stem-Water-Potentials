# Plot Stem Water Potential (SWP) readings comparing Deep Root Irrigation (DRI) to Conventional Drip Irrigation Treatments

setwd("/Users/ajgal/Documents/WES_SWP_Data") # set the working directory

#install.packages("ggplot2")   # install packages (only need to run this the first time you use this code; remove the "#" to run it)
#install.packages("readxl")

library(ggplot2)  # load libraries
library(readxl)

swp <- read_xlsx("SWP_04192024.xlsx") # read excel file with data; change file name to choose sampling date.
swp <- as.data.frame(swp) # convert excel file to a data frame

baseline_DRI <- -6.3 # change these values based on the air temp and relative humidity conditions at the time of sampling
baseline_drip <- -6.1

swp_plot <- ggplot(swp, aes(x = block, y = reading_bar, color = block)) +
              geom_jitter(show.legend = FALSE, width = 0.1, size = 3) + #jitterplot in ggplot2
              ggtitle("Stem Water Potential, Block #4 Westley, 4/19/2024") + # title
              theme_classic() + # theme
              theme(plot.title = element_text(size = 14, # center title
                                              hjust = 0.5,
                                              face = "bold"),
                    axis.text = element_text(size = 12), # axis numbers and "DRI" and "Drip" text size 
                    axis.title.y = element_text(size = 12)) + # y-axis title size
              labs(x = " ",  y = "Stem Water Potential (bar)") + # rename axis titles
              scale_color_manual(values = c("#377eb8", "#ff7f00"), # select colors for data
                                labels = c("DRI", "Drip"),
                                name = "Treatment") +
              scale_y_continuous(limits = c(-15, 0), breaks = seq(0, -15, by = -1)) + # set the y axis limits
              scale_x_discrete(position = "top") + # reverse y axis order
              geom_segment(aes(x = 0.6, xend = 1.4, y = baseline_DRI, yend = baseline_DRI), 
                           linetype = "dashed", linewidth = 1.25, color = "black") + # DRI baseline SWP horizontal bar
              geom_segment(aes(x = 1.6, xend = 2.4, y = baseline_drip, yend = baseline_drip), 
                           linetype = "dashed", linewidth = 1.25, color = "black") # drip baseline SWP horizontal bar

swp_plot # plot figure

ggsave("SWP_04192024.png", plot = swp_plot, width = 6, height = 8, units = "in") # save figure to working directory, change file name to match collection date



