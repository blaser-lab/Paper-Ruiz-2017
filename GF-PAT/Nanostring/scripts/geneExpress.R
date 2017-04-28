# Helper functions for Nanostring statistical analysis.

# GeneExpress
## Input:
## A) Normalized count data or output from normalized_rcc function. Data must be log transformed to get proper log fold change.
## B) Mapping file
## Output: Expression Table with p-values, FDR correct pvalues and log2 fold change for each comparison.
gene_express <- function(expressionObject, 
                         fileName = "Output", 
                         logTransform = FALSE, 
                         writeFiles = F, 
                         psort = "anova_padj", 
                         pcutoff = 0.05){
  
  # Change when not lazy
  expression_set = expressionObject
  
  # Create contrast maxtrix. Take the names of the columns. (TODO)
  
  # I. Analysis
  # A) Apply signficance test function to each gene in table.
  message("Performing Significance Tests...")
  pval_table <- t(esApply(expression_set, 1, function(x) eset_anova(gene = x, group = expression_set$Group)))
  pval_names <- eset_anova_names(gene = exprs(expression_set)[1,], group = expression_set$Group)
  colnames(pval_table) <- pval_names
  
  # B) Apply FDR correcting values to each group comparisons.
  fdr_table <- apply(pval_table, 2, function(x) p.adjust(x, method = "BH"))
  
  # C) Find Log2 Fold Change values to each group comparisons.
  lfc_table <- t(esApply(expression_set, 1, function(x) log2foldchange(gene = x, group = expression_set$Group)))
  lfc_names <- log2foldchange_names(gene = exprs(expression_set)[1,], group = expression_set$Group)
  colnames(lfc_table) <- lfc_names
  
  
  # II. Tidy data
  ## Change column names to reflect raw-pvalues and p-adjusted values.
  colnames(pval_table) <- sapply(colnames(pval_table), function(x) paste(x, "_pval", sep = ""))
  colnames(fdr_table) <- sapply(colnames(fdr_table), function(x) paste(x, "_padj", sep = ""))
  colnames(lfc_table) <- sapply(colnames(lfc_table), function(x) paste(x, "_lfc", sep = ""))
  
  # Bind all tables together
  values_table <- cbind(pval_table, fdr_table)
  values_table <- cbind(values_table, lfc_table)
  
  ## Change '-' to '_' in contrast names.
  colnames(values_table) <- gsub(pattern = "-", replacement = "_", x = colnames(values_table), fixed = T)
  values_table <- as.data.frame(values_table)
  
  # Subset table by significance
  sig_table <- subset(values_table, values_table[ ,psort] < pcutoff)
  input_genedata_sig <- expressionObject[row.names(sig_table), ]
  
  # III. Printing/Writing of files
  if(writeFiles){
    
    # Make new directory
    dir.create(fileName)
    message("Writing Data...")
    
    # Raw results table
    write.csv(values_table, paste(fileName, "genes.csv", sep = "/"))
    
    # Anova_padj sorted results table
    write.csv(sig_table, paste(fileName, "significant_genes.csv", sep = "/"))
    
    # Log transformed normalized values table
    write.exprs(input_genedata_sig, paste(fileName, "significant_genes_raw.csv", sep = "/"))
  }
  
  # Return Significant Table
  return(list(results = values_table,
              sig_results = sig_table,
              sig_expression = input_genedata_sig))
}



# Secondary Analysis Functions
################################################################################

# Multiple Comparisons
eset_anova <- function(gene, group){
  
  # Fit an analysis of variance model
  aov.fit <- aov(gene ~ group)
  anova <- summary(aov.fit)[[1]]$"Pr(>F)"[1]
  
  # TukeyHSD model for each comparison
  tukey_hsd <- TukeyHSD(aov.fit)[[1]]
  
  # Find pvalues for each comparison. Change column names to reflect pvalues.
  pvalues <- as.matrix(tukey_hsd[ ,"p adj"])
  colnames(pvalues) <- names(gene)[1]
  
  # Bind together the anovaP and contrast pvalues.
  datatable <- rbind(anova, pvalues)
  
  # Return tranposed table
  datatable_t <- t(datatable)
  
  # Return transposed table
  return(datatable_t)
}

# Multiple Comparisons names (Quick Fix)
eset_anova_names <- function(gene, group){
  
  # Fit an analysis of variance model
  aov.fit <- aov(gene ~ group)
  anova <- summary(aov.fit)[[1]]$"Pr(>F)"[1]
  
  # TukeyHSD model for each comparison
  tukey_hsd <- TukeyHSD(aov.fit)[[1]]
  
  # Find pvalues for each comparison. Change column names to reflect pvalues.
  pvalues <- as.matrix(tukey_hsd[ ,"p adj"])
  colnames(pvalues) <- names(gene)[1]
  
  # Bind together the anovaP and contrast pvalues.
  datatable <- rbind(anova, pvalues)
  
  # Return tranposed table
  datatable_t <- t(datatable)
  
  # Return transposed table
  return(colnames(datatable_t))
}


# Calculate Log Fold Change
log2foldchange <- function(gene, group){
  
  # Fit an analysis of variance model
  aov.fit <- aov(gene ~ group)
  
  # TukeyHSD model for each comparison
  tukey_hsd <- TukeyHSD(aov.fit)[[1]]
  
  # Find pvalues for each comparison. Change column names to reflect pvalues.
  foldchange <- as.matrix(tukey_hsd[ ,"diff"])
  colnames(foldchange) <- names(gene)[1]
  
  # Return tranposed table
  foldchange_t <- t(foldchange)
  
  # Return transposed table
  return(foldchange_t)
}

# Calculate Log Fold Change Names (Quick fix)
log2foldchange_names <- function(gene, group){
  
  # Fit an analysis of variance model
  aov.fit <- aov(gene ~ group)
  
  # TukeyHSD model for each comparison
  tukey_hsd <- TukeyHSD(aov.fit)[[1]]
  
  # Find pvalues for each comparison. Change column names to reflect pvalues.
  foldchange <- as.matrix(tukey_hsd[ ,"diff"])
  colnames(foldchange) <- names(gene)[1]
  
  # Return tranposed table
  foldchange_t <- t(foldchange)
  
  # Return transposed table
  return(colnames(foldchange_t))
}