Design for relevant Picornaviridae species.

This only designs for:
  - Rhinovirus A, B, C
but designs are specific against all other species in
the Enterovirus genus.

Note that this is only includes the Enterovirus genus to
determine specificity, rather than the whole family, because
the family is exceptionally diverse and the designs take
too long to run when ensuring specificity against the full
family. According to https://talk.ictvonline.org/ictv-reports/ictv_online_report/positive-sense-rna-viruses/picornavirales/w/picornaviridae,
the Enterovirus genus seems to form a distinct clade so
it should be ok to only enforce specificity within this
(large) genus.

Also, note that when I ran this, the run included
Enterovirus {A,B,C,D} (the only-design.tsv file listed
these too); I killed the run after it completed the
Rhinovirus designs, and instead am designing for those
inside ../enterovirus-species-entero/.
