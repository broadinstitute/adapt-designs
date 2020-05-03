Design for SARS species and subspecies groupings.

This includes all Coronaviridae species in in/taxa.tsv in order to
ensure designs are specific against the full diversity in this
family.

This creates designs for the following taxa:
  - pan-SARS species (all of Severe acute respiratory syndrome-related coronavirus species)
  - SARS-CoV-2
  - SARS-like CoV
    * This consists of: ((everything in SARS species) minus SARS-CoV-1
      minus SARS-CoV-2)
    * It is mostly bat SARS coronaviruses (and some pangolin)
    * It seems some other resources call this SARSr-CoV
    * The 'SARS-like CoV' name appears to be adopted on Nextstrain
      at https://nextstrain.org/groups/blab/sars-like-cov
  - SARS-CoV-1 (usually called SARS-CoV (i.e., the 2003 outbreak causing SARS
    disease), but hopefully soon to be renamed SARS-CoV-1)
  - SARS-CoV-2-related and SARS-CoV-1-related, as defined in Fig. 1b
    of https://doi.org/10.1038/s41586-020-2169-0
  - SARS-CoV-2-relaxed, which is specific against all coronavirus
    species and a FASTA containing all sequences in the SARS-related species
    except for SARS-CoV-2 and 2 sequences very closely related to SARS-CoV-2
    (RaTG13 and a pangolin sequence)

