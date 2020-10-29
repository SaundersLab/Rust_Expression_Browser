#!/usr/local/bin/Rscript

#Prepares four bar plots from a combined metadata file in preparation for paper
#The metadata files must contain the fields: country, date collected,
#host variety and source

#Import required libraries

library("ggplot2")
library("optparse")
library("gridExtra")
library("dplyr")
library("stringr")
library("sf")
library("rnaturalearth")
library("rnaturalearthdata")
library("rgeos")
library("extrafont")

#When using extrafont for the first time
#run font_import() and loadfonts() in an interactive R session

#Parse command line arguments

opt_list <- list(
    make_option("--metadata_all", type = "character",
    help = "tab separated file of all metadata used to
    build expression browser"),
    make_option("--metadata_field", type = "character",
    help = "tab separated file of field sample metadata used to
    build expression browser"),
    make_option("--variety_count", type = "character",
    help = "tab separated file of the number of confirmed host
    varities in each country"),
    make_option("--out", type = "character", help = "output plot in pdf format")
)

opt <- parse_args(OptionParser(option_list = opt_list))
f_all <- opt$metadata_all
f_field <- opt$metadata_field
f_variety <- opt$variety_count
o <- opt$out

#Create dataframe of metadata

metadata_all <- read.delim(f_all,
    header = TRUE, stringsAsFactors = FALSE, quote = "", sep = "\t")

metadata_field <- read.delim(f_field,
    header = TRUE, stringsAsFactors = FALSE, quote = "", sep = "\t")

variety_count <- read.delim(f_variety, header = TRUE, stringsAsFactors = FALSE,
    quote = "", sep = "\t")

#Prepare country plot

#Pull in country information

world <- ne_countries(scale = "medium", returnclass = "sf")
world_mod <- subset(world, name_long != "Antarctica")

#Prepare country data

countries <- count(metadata_field, country)
countries_merged <- merge(x = world_mod, y = countries,
    by.x = "name_long", by.y = "country", all.x = TRUE)

#Prepare map

country_plot <- ggplot(data = countries_merged) +
geom_sf(aes(fill = n), size = 0.2) +
scale_fill_viridis_c(option = "viridis", name = "Number of
Samples", direction = -1, na.value = "white") + labs(tag = "A") +
theme(panel.grid.major = element_blank(), panel.grid.minor =
element_blank(), panel.background = element_blank(),
panel.border = element_rect(colour = "black", fill = NA, size =
1), axis.text = element_blank(),
axis.ticks = element_blank(),
axis.title = element_text(family = "Arial", size = 7),
legend.text = element_text(family = "Arial", size = 7),
legend.title = element_text(family = "Arial", size = 7),
plot.tag = element_text(family = "Arial", size = 10))

#Prepare variety plot

variety_plot <- ggplot(variety_count,
    aes(x = reorder(Variety, -Count), y = Count)) +
xlab("Wheat Variety") + ylab("Frequency") +
geom_bar(stat = "identity", fill = "navy") + labs(tag = "D") +
theme(panel.grid.major = element_blank(), panel.grid.minor =
element_blank(), panel.background = element_blank(),
panel.border = element_rect(colour = "black", fill = NA, size =
1), axis.text = element_text(family = "Arial", size = 6, colour = "black"),
axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
axis.title = element_text(family = "Arial", size = 7),
plot.tag = element_text(family = "Arial", size = 10))

#Prepare dates plot

dates <- as.data.frame(metadata_field$Date.Isolated)
split_dates <- as.data.frame(str_split_fixed(
    as.character(dates$"metadata_field$Date.Isolated"), "/", 3))
split_date_counts <- count(split_dates, V1)
reduced_count <- split_date_counts %>% filter(V1 >= 2013)

dates_plot <- ggplot(reduced_count, aes(x = V1, y = n)) +
xlab("Year Collected") + ylab("Frequency") +
geom_bar(stat = "identity", fill = "navy") + labs(tag = "B") +
theme(panel.grid.major = element_blank(), panel.grid.minor =
element_blank(), panel.background = element_blank(),
panel.border = element_rect(colour = "black", fill = NA, size =
1), axis.text = element_text(family = "Arial", size = 6, colour = "black"),
axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
axis.title = element_text(family = "Arial", size = 7),
plot.tag = element_text(family = "Arial", size = 10))

#Prepare sample plot

type_of_sample <- count(metadata_all, source)

sample_plot <- ggplot(type_of_sample, aes(x = reorder(source, -n), y = n)) +
xlab("Source of Sample") + ylab("Frequency") +
geom_bar(stat = "identity", fill = "navy") + labs(tag = "C") +
theme(panel.grid.major = element_blank(), panel.grid.minor =
element_blank(), panel.background = element_blank(),
panel.border = element_rect(colour = "black", fill = NA, size =
1), axis.text = element_text(family = "Arial", size = 6, colour = "black"),
axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1),
axis.title = element_text(family = "Arial", size = 7),
plot.tag = element_text(family = "Arial", size = 10))

#Save Plots

plot_list <- list(country_plot, dates_plot, variety_plot, sample_plot)

pdf(o, onefile = FALSE)
layout <- rbind(c(1, 1, 1, 1), c(1, 1, 1, 1), c(3, 3, 4, 4), c(2, 2, 2, 2))
grid.arrange(country_plot, variety_plot, dates_plot, sample_plot,
    layout_matrix = layout)
dev.off()
