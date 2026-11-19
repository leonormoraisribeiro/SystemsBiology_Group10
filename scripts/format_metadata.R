library(tidyverse)

metadata_GSE173955 <- read.csv(
  "data/metadata/GSE173955_metadata_raw.csv",
  row.names = 1,
  check.names = FALSE
)

metadata_GSE67333 <- read.csv(
  "data/metadata/GSE67333_metadata_raw.csv",
  row.names = 1,
  check.names = FALSE
)

metadata_clean_GSE173955 <- metadata_GSE173955 %>%
  mutate(
    sample_id = geo_accession,
    condition = ifelse(
      grepl("^Alzheimer's Disease", title),
      "AD",
      "Control"
    ),
    age = as.numeric(`age:ch1`),
    sex = `gender:ch1`,
    tissue = source_name_ch1
  ) %>%
  select(
    sample_id,
    condition,
    age,
    sex,
    tissue
  )


metadata_clean_GSE67333 <- metadata_GSE67333 %>%
  mutate(sample_id = geo_accession,
         condition = ifelse(
           grepl("LOAD", title),
           "AD",
           "Control"
         ),
         age_raw = `age (yrs):ch1`,
         age = readr::parse_number(`age (yrs):ch1`),
         sex = `gender:ch1`,
         tissue = `tissue:ch1`,
         braak_stage = `braak stage:ch1`,
         apoe_genotype = `apoe genotype:ch1`
         ) %>%
         select(
           sample_id,
           condition,
           age_raw,
           age,
           sex,
           tissue,
           braak_stage,
           apoe_genotype
         )
  
write.csv(
  metadata_clean_GSE173955,
  "data/metadata/GSE173955_metadata_clean.csv",
  row.names = FALSE
)
  
write.csv(
  metadata_clean_GSE67333,
  "data/metadata/GSE67333_metadata_clean.csv",
  row.names = FALSE
)

metadata_clean_GSE173955 <- metadata_clean_GSE173955[
  match(
    colnames(isoform_counts_GSE173955),
    metadata_clean_GSE173955$sample_id
  ),
]

metadata_clean_GSE67333 <- metadata_clean_GSE67333[
  match(
    colnames(isoform_counts_GSE67333),
    metadata_clean_GSE67333$sample_id
  ),
]