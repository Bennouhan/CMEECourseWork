
### Clear workspace, set working directory
rm(list = ls())
setwd('~/cmeecoursework/project/data/') #for local
unlink("../results/window_lengths*")


### Import packages
library(data.table,warn.conflicts=F) #needs installing
library(parallel)
library(ggplot2) #need to install - tidyverse
library(RColorBrewer)
library(forcats)
library(tidyr)
library(dplyr,warn.conflicts=F)
library(grid)
library(gridExtra,warn.conflicts=F)
library(cowplot) #needed installing
library(qwraps2) #needed installing





### Reads the 2 query sample lists used in RFMix2 run, and the original ind_3pop file for the missing Pop and Subpop data from query files
query_list  <- read.table('RFMix2/query_vcfs/query_list_renamed.txt')#pelID.1
PEL_sub_99  <- read.table('RFMix2/query_vcfs/PEL_sub_99_renamed.txt')#pelID.2
all_samples <- read.table('sample_maps/ind_3pop_popgroup.txt')
whole_query_list <- rbind(query_list, PEL_sub_99) # merges query files

### Matches query files' samples to the original sample file, to add the Pop and Subpop data; makes list of subpops
temp <- all_samples[match(substr(whole_query_list[,1], 1, 7), all_samples$V1),] 
temp[2:3] <- temp[c(3,2)] #swaps column values but not names
whole_query_df <- cbind(whole_query_list, temp[,2:3])
colnames(whole_query_df) <- c("ID", "Pop", "Subpop")
subpops <- c("PEL", "PEL_sub_99", "MXL", "CLM", "PUR", "ASW", "ACB")

### Creates new ADM subpop, "PEL_sub_99" for samples from PEL_sub_99_renamed.txt
for (row in 1:nrow(whole_query_df)){
  ID <- whole_query_df[row,1]
  if(substr(ID, nchar(ID)-1, nchar(ID)) == ".2"){
    whole_query_df[row,3] <- "PEL_sub_99" }
}



### Reads and merges MSP files
msp <- fread(paste0('RFMix2/output/RFMix2_output_chr',1,'.msp.tsv'),nThread=6)
for (chr in 2:22){ 
  msp <- rbind(msp,
      fread(paste0('RFMix2/output/RFMix2_output_chr',chr,'.msp.tsv'),nThread=6))
}

### Creates a table of values for each ancestry for each subpopulation
for (subpop in 1:length(subpops)){
  ### Creates matrix of the first 6 columns and the columns specific to each subpopulation
  samples <- which(whole_query_df[,3] == subpops[subpop])
  samp_cols <- 1:6
  for (sample in samples){
    samp_cols <- c(samp_cols, 6+(sample*2-1):(sample*2))}
  subpop_df <- as.matrix(msp)[,samp_cols]
  ### runs rle on all columns for that subpop
  rle_on_cols <- lapply(7:ncol(subpop_df), function(x) rle(subpop_df[,x]))
  ### make a list of 3 vectors you can append grangments to; afr=0, eur=1, nat=2, so value +1 is the list fragment length is appended to
  frag_ls <- list(vector(), vector(), vector())
  for (col_num in 1:length(rle_on_cols)){
    col_output <- data.frame(unclass(rle_on_cols[[col_num]]))
    col_output$lengths <- cumsum(col_output$lengths)
    col_output <- rbind(c(0,0), col_output) 
    ### Find length between each fragment, appends to relevent row
    for (frag in 2:nrow(col_output)){
      ls_num <- col_output$values[frag]+1
      frag_ls[[ls_num]] <- c(frag_ls[[ls_num]],
      as.integer(subpop_df[ col_output$lengths[frag],3] - 
                subpop_df[(col_output$lengths[frag-1]+1),2]))
    } 
  }
  ### Finds longest column, matches it with one of repeated subpop labels
  max <- max(c(length(frag_ls[[1]]),length(frag_ls[[2]]),length(frag_ls[[3]])))
  label <- rep(subpops[subpop], max)
  ### Creates dataframe with all fragments of each ancestry and subpop in long format for plotting, same format and colnames as in rfmix.Q_analysis.R
   if (subpop == 1){
    frag_df <- qpcR:::cbind.na(label, frag_ls[[1]], frag_ls[[2]], frag_ls[[3]])
    colnames(frag_df) <- c("Subpop", "African", "European", "Native")
  }else{
    temp    <- qpcR:::cbind.na(label, frag_ls[[1]], frag_ls[[2]], frag_ls[[3]])
    colnames(temp) <- c("Subpop", "African", "European", "Native")
    frag_df <- rbind.data.frame(frag_df, temp)
  }
}

### Replace negatives (which are the gaps between chromosomes) with NA
frag_df[frag_df < 1] <- NA





#################### Creating comparative boxplots #############################

anc_boxplot <- function(pop_num){
### Function to plot jittered comparative boxplot by subpop for argued pop number (corresponding to pops vecotr below)
  ### Removes NAs and takes log10 of data
  adm <- adm[!is.na(adm[,1+pop_num]),]
  adm[,1+pop_num] <- log10(adm[,1+pop_num])
  q <- ggplot(adm, aes_string(x="fct_inorder(Subpop)", y=pops[pop_num])) +
        labs(y=paste(pops[pop_num], "Fragment Lengths (bp)")) +
        geom_boxplot(outlier.shape=NA, na.rm=TRUE) + ylim(c(4.95, NA)) +
        geom_jitter(position=position_jitter(width=.3, height=0),
                    colour=anc_palette[pop_num], size=.01, na.rm=TRUE) +
        stat_boxplot(geom ='errorbar', na.rm=TRUE) + theme_bw() + 
        # top whisker goes to last value within 1.5x the interquartile range &vv
        theme(axis.title.x = element_blank(),
              axis.title.y = element_blank())
  for (i in 1:length(subpops)) {
  q <- q + geom_text(x=i, y=4.9, size=2.7, fontface="plain", 
  label = table[i,pop_num+1])}
  return(q)
}

MeanSD3 <- function(vector, fun=round, num=3){
### Converts vector into its mean ± SD to 3 decimal places each
  vector = as.numeric(vector[!is.na(vector)])
  mean <- fun(mean(vector), num)/1000000
  sd   <- fun(  sd(vector), num)/1000000
  return(paste0(mean, "±", sd, "Mbp"))
}


### Names the 3 pops for use in function above, and the 6 subpops in new order
pops    <- c("African", "European", "Native")
subpops <- c("ACB", "ASW","PUR", "CLM", "MXL", "PEL_sub_99", "PEL")
anc_palette <- brewer.pal(3,"Set1")

### Subsets and reorders data so subpops are plotted by African/Native ancestry
adm <- data.frame()
for (subpop in subpops){
  adm <- rbind(adm, subset(frag_df, Subpop==subpop))
}
adm$African <- as.numeric(adm$African)
adm$European <- as.numeric(adm$European)
adm$Native <- as.numeric(adm$Native)

### Table in same layout as boxplots, giving mean+-SD for each box
table <- adm %>% 
         group_by(Subpop) %>%
         summarize(.groups="keep", 
                   Native   = MeanSD3(Native,   fun=signif),
                   African  = MeanSD3(African,  fun=signif), 
                   European = MeanSD3(European, fun=signif)) %>% as.data.frame()
table <- table[match(subpops, table$Subpop),] #reorders rows
table <- table[,c(1, 3:4, 2)] #reorders cols

### Randomly remove a given percent of values from each column to make plot less dense - 90 is good
percent <- 90
adm$African[ sample(nrow(adm), round(nrow(adm)*percent/100))] <- NA
adm$European[sample(nrow(adm), round(nrow(adm)*percent/100))] <- NA
adm$Native[  sample(nrow(adm), round(nrow(adm)*percent/100))] <- NA

### Lays out multiplot
plot <- cowplot::plot_grid(
  anc_boxplot(1) + theme(axis.text.x=element_blank(),
                        axis.ticks.x=element_blank()),
  anc_boxplot(2) + theme(axis.text.x=element_blank(),
                        axis.ticks.x=element_blank()), 
  anc_boxplot(3),
  ncol=1,
  labels = "AUTO",
  label_size = 13,
  axis=c("b"),
  align = "hv",
  label_x = .03, 
  label_y = 0.985)

### Create Legend from scratch
legend <- data.frame(matrix(c(1:16), ncol=4))
colnames(legend) <- c("ID", pops)
legend$ID <- as.factor(legend$ID)
L <- legend %>% pivot_longer(2:4, names_to="Ancestry", values_to="Prop") %>%
    ggplot(aes(fill=Ancestry, y=Prop, x=fct_inorder(ID))) +
      geom_bar(position="fill", stat="identity", width=1) +
      scale_fill_manual(values = anc_palette, name="Ancestry:")
### Get and format legend from plot "L" for use in main figure
legend <- get_legend(L + guides(color = guide_legend(nrow = 1)) +
    theme(legend.position = "top",
          legend.key.size = unit(0.5, "cm"),
          legend.title=element_text(size=11, face="bold.italic"), 
          plot.margin = margin(0, 0, 10, 0),
          legend.text=element_text(size=10, face="italic")))
          
### Set common y and x labels
xGrob <- textGrob("Admixed Population", 
                   gp=gpar(col="black", fontsize=15))
yGrob <- textGrob(expression(paste("Length of Fragment   log"["10"],"(bp)")),
                   gp=gpar(col="black", fontsize=15), rot=90)

### Arrange plot, legend and axis titles, saves to png
ggsave(file="../results/window_lengths_boxplot.png",
grid.arrange(arrangeGrob(plot,left=yGrob,bottom=xGrob), legend,heights=c(2,.1)),
dpi=1000, width=6, height=15, units="in")






###################### Creating window size histogram ##########################


subpop_hist <- function(subpop, x, y){
### Creates histogram from a named subpopulation and x&y tick numbers
  histo <- frag_df %>% 
                  pivot_longer(!Subpop, names_to = "Ancestry") %>% 
                  filter(Subpop == subpop & is.na(value) == FALSE) %>% 
                  transmute(Ancestry, value=log10(as.numeric(value))) %>% 
                  ggplot(aes(x = value, fill = Ancestry)) + ggtitle(subpop) +
                    geom_histogram(position="identity", alpha=0.5, bins=100) +
                    scale_fill_manual(values=anc_palette) + theme_bw() + 
                    theme(axis.title.x = element_blank(),
                          axis.title.y = element_blank(),
                          plot.title = element_text(hjust=0.5,    vjust=-80,
                                                    face="plain", size=16),) + 
                    scale_x_continuous(expand = c(0, 0), limits = c(NA, NA),
                    breaks=scales::pretty_breaks(n = x)) + 
                    scale_y_continuous(expand = c(0, 0), limits = c(0, 100*y),
                    breaks=scales::pretty_breaks(n = y)) +
                    theme(legend.position = "none")
  return(histo)
}


### Lays out multiplot
plot <- cowplot::plot_grid(
  subpop_hist("PEL", 24, 7), 
  subpop_hist("MXL", 24, 7), 
  subpop_hist("CLM", 24, 9), 
  subpop_hist("PUR", 22, 9), 
  subpop_hist("ASW", 24, 8), 
  subpop_hist("ACB", 24, 9), 
  ncol=3,
  labels = "AUTO",
  label_size = 20,
  axis=c("b"),
  align = "hv",
  label_x = .08, 
  label_y = 0.92)

### Create Legend from scratch
legend <- get_legend(subpop_hist("PEL", 24, 7)
 + guides(color = guide_legend(nrow = 1)) +
    theme(legend.position = "top",
          legend.key.size = unit(0.5, "cm"),
          legend.title=element_text(size=11, face="bold.italic"), 
          plot.margin = margin(0, 0, 10, 0),
          legend.text=element_text(size=10, face="italic")))
          
### Set common y and x labels
xGrob <- textGrob(expression(paste("Length of Fragment  (log"["10"]," bp)")), 
                   gp=gpar(col="black", fontsize=20))
yGrob <- textGrob("Fragment Count",
                   gp=gpar(col="black", fontsize=20), rot=90)

### Arrange plot, legend and axis titles, saves to png
ggsave(file="../results/window_lengths_histogram.png",
grid.arrange(arrangeGrob(plot,left=yGrob,bottom=xGrob), legend,heights=c(2,.1)),
width=13, height=10, units="in")
