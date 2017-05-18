# @ Thomas W. Battaglia
# Function to generate mean inter-group distances between 2 groups across
# multiple timepoints
#
# Input = Phyloseq object
# Class = Grouping variable
# Timepoint = Vraible to split on
intergroup_div <- function(pseq, class, timepoint, metric = "unifrac", divergence = "inter", ntimes = 99){
  
  # Get samples metadata into dataframe
  metadata <- as(phyloseq::sample_data(pseq), "data.frame")
  
  # Split table according to timepoint variable
  sptables <- split(metadata, metadata[[timepoint]], drop = T)
  
  # Iterate over each time point and apply significance function
  final <- do.call(rbind, lapply(sptables, function(data) {
    
    # Drop unused levels from metadata
    data[[class]] <- droplevels(data[[class]])
    
    # Get levels for comparisons
    comparing_groups <- levels(data[[class]])
    
    # Check number of levels
    if(length(comparing_groups) <= 1){
      message("Not enough factors, skipping this timepoint", appendLF = T)
      return(NULL)
    }
    
    # Find each 2 group comparison
    #comparison_list <- combn(comparing_groups, 2, simplify = F)
    comparison_df = expand.grid(comparing_groups, comparing_groups, KEEP.OUT.ATTRS = T, stringsAsFactors = F) %>% as.matrix()
    
    # Convert to list
    comparison_list = split(comparison_df, rep(1:nrow(comparison_df), each = ncol(comparison_df)))

    # Iterate over 2 group comparisons for one time point
    do.call(rbind, lapply(comparison_list, function(combination){
      
      # Subset metadata and apply to phyloseq object
      metatable_sub <- subset(data, data[[class]] %in% combination, droplevels = T)
      phylo0 = pseq
      phyloseq::sample_data(phylo0) <- metatable_sub
      
      # Run Unifrac
      bdiv <- phyloseq::distance(phylo0, method = metric)
      
      # Print message
      message(paste("Comparing:",
                    combination[1], "vs", combination[2] ,
                    "at",
                    as.character(timepoint), unique(metatable_sub[[timepoint]]), sep = " "),
              appendLF = T)
      
      # Function for randomization
      F1 <- function(input_matrix, ntimes){
        
        # Get basic vars
        full = as.matrix(input_matrix)
        drawing = nrow(full)
        
        # Generate data.frame to store results
        storing = data.frame(Comparison = character(), 
                             timepoint = character(),
                             Mean = numeric(),
                             SEM = numeric(),
                             SampleN = numeric(),
                             Iteration = character(),
                             divergence = character())
        
        # Iterate over N times
        for(x in 1:ntimes){

          # Draw a tuple (w/o replacement)
          to_keep <- sample(1:drawing, size = drawing, replace = F)
          
          # Create a dataframe from values of pairwise comparisons
          df = data.frame(sample1 = character(0), sample2 = character(0), value = numeric())
          
          # Iterate over each tuple and grab the comparison value
          for(k in 1:drawing){

            # Err if last element
            if(k == drawing){next("Too many iterations")}
            
            # Gather the 
            i = to_keep[k]
            j = to_keep[k + 1]
            
            # Create new row
            row = data.frame(sample1 = colnames(full)[i], 
                             sample2 = row.names(full)[j],
                             value = full[i, j])
            
            # Bind to existing DF
            df = rbind(df, row)
          }
          
          # Make sure i,j are unique
          if(any(duplicated(df$sample1))){
            message("Error! Sample1 have duplicates!")
          }
          if(any(duplicated(df$sample2))){
            message("Error! Sample2 have duplicates!")
          }
          
          # Check to make sure i != j
          ## TODO
          
          # Add metadata to table
          df$Group1_metadata <- metadata[match(df$sample1, metadata$X.SampleID), class]
          df$Group2_metadata <- metadata[match(df$sample2, metadata$X.SampleID), class]
          
          # Make an inter-group data-table
          df_inter = subset(df, Group1_metadata == combination[1] & Group2_metadata == combination[2] | 
                                Group1_metadata == combination[2] & Group2_metadata == combination[1])
            
          # Set up for rbinding!
          inter_df <- data.frame(Comparison = paste0(combination[1], "vs", combination[2]), 
                                 timepoint = as.character(unique(metatable_sub[[timepoint]])),
                                 Mean = mean(df_inter$value),
                                 SEM = sd(df_inter$value)/sqrt(length(df_inter$value)),
                                 SampleN = nrow(unique(df_inter)),
                                 Iteration = as.character(x), 
                                 divergence = "inter")
          
          # Append line to table
          storing = rbind(storing, inter_df)
          
          # Message and return
          #message(paste0("Completed with ", ntimes, " iterations."))
        }
        return(storing)
      }
      
     # Run function to generate data.frame
     results = F1(input_matrix = bdiv, ntimes = ntimes)
     
    }))
  }))
  
}


