This contains accession lists from NCBI and sequences from GISAID for
different taxonomic groupings. They are inside in/
I have stored locally information about curating these lists.

The '_trimmed' files simply remove two sequences (RaTG13, as an NCBI
accession; and GD/P1L (Guandong pangolin sequence) from GISIAD). These
are extremely similar to SARS-CoV-2 and not having them lets us make a
relaxed SARS-CoV-2 design that is not as constrained in specificity.

The script make_fastas.sh groups these to create different FASTA files
for different taxonomic groupings, placed in fastas-for-design/

Note that all fastas with GISAID data are ignored from this repository
so we do not distribute them (per GISAID policy). The directory
fastas-for-design/ is also ignored.
