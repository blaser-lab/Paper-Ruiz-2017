#!/usr/bin/env Rscript

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @ Thomas W. Battaglia
# @ tb1280@nyu.edu
# Convert a mapping file with alpha diversity metrics into a format
# compatible with PRISM for graphing alpha diversity measures over
# time in different groups.

# @parameters
# QIIME mapping file
# name of column variable corresponding to group
# name of column variable corresponding to time
# output table (.txt)

# @example
# Rscript scripts/alpha_for_prism.R \
# -i data/mapping_walpha.txt \
# -o analysis/alphadiv/pd_tree_summarized.txt \
# --group Treatment \
# --time Day_of_life \
# --alpha PD_whole_tree_alpha
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Load libraries that are required
if(!require(optparse)){
  message("Error! optparse could not be found. Downloading now...")
  install.packages("optparse", repos = 'http://cran.cnr.berkeley.edu/')
  suppressPackageStartupMessages(library(optparse))
}

if(!require(dplyr)){
  message("Error! dplyr could not be found. Downloading now...")
  install.packages("dplyr", repos = 'http://cran.cnr.berkeley.edu/')
  suppressPackageStartupMessages(library(dplyr))
}

if(!require(lazyeval)){
  message("Error! lazyeval could not be found. Downloading now...")
  install.packages("lazyeval", repos = 'http://cran.cnr.berkeley.edu/')
  suppressPackageStartupMessages(library(lazyeval))
}


# Make options
option_list = list(
  make_option(c ("-i", "--input"),
              type="character",
              default=NULL,
              help="QIIME mapping file with alpha diversity metrics",
              metavar="character"),
  make_option(c ("-o", "--output"),
              type="character",
              default="results.txt",
              help="output file name [default= %default]",
              metavar="character"),
  make_option(c ("-g", "--group"),
              type="character",
              default=NULL,
              help="Group variable name [default= %default]",
              metavar="character"),
  make_option(c ("-t", "--time"),
              type="character",
              default=NULL,
              help="Time variable name [default= %default]",
              metavar="character"),
  make_option(c ("-a", "--alpha"),
              type="character",
              default=NULL,
              help="Alpha diversity column name [default= %default]",
              metavar="character")
)

# Get arguments
opt_parser = OptionParser(option_list=option_list)
opt = parse_args(opt_parser)

# Error if null
if (is.null(opt$input)){
  print_help(opt_parser)
  stop("At least one argument must be supplied (input file) \n", call.= FALSE)
}

# Import input file
metadata <- read.delim(opt$input)

# Stop if NA values
if(is.numeric(metadata[ ,opt$alpha]) == FALSE){
  stop("There cannot be any NA values in the alpha diversity values. Please remove these vaules or choose a lower rarifying depth to include them. \n", call.= FALSE)
}

# Use dplyr to collpase
prism_ready <- metadata %>%
  group_by_(opt$group, opt$time) %>%
  summarise_(mean = interp(~ mean(var), var = as.name(opt$alpha)),
             sem = interp(~ sd(var)/sqrt(length(var)), var = as.name(opt$alpha)),
             N = interp(~ n(), var = as.name(opt$alpha)))

write.table(prism_ready, opt$output, row.names = F, sep = "\t", quote = F)
message(paste0("Sucessfully created the table: ", opt$output), appendLF = T)




