library(GEOquery)
library(Biobase)
library(tidyverse)

datasets <- c("GSE173955", "GSE67333")

for (dataset in datasets) {
  
  geo_object <- getGEO(
    dataset,
    GSEMatrix = TRUE,
    getGPL = FALSE
  )
  
  if (is.list(geo_object)) {
    geo_object <- geo_object[[1]]
  }
  
  metadata <- pData(geo_object)
  
  write.csv(
    metadata,
    file = paste0(
      "data/metadata/",
      dataset,
      "_metadata_raw.csv"
    ),
    row.names = TRUE
  )
}