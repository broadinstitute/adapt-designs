# Experimentally-tested designs

These are designs that were experimentally tested in the paper describing ADAPT (for citation, see the [ADAPT repository](https://github.com/broadinstitute/adapt) on GitHub).

## Summary of contents

* `guides.tsv`: Guides tested for each experiment. Columns provide the design method (ADAPT or a baseline method), a summary of the experiment, the rank of the design, the protospacer sequence, and the crRNA sequence, among other information.
* `targets.tsv`: Synthetic targets against which guides were tested. The targets were evaluated at different concentrations in a dilution series. Columns include corresponding information to `guides.tsv`.
* `experimental-data/`: Experimental measurements (by microfluidic CARMEN) for each experiment.

## ADAPT's full design output

The full designs, including primers, output by ADAPT for each experiment are also found in this repository at the links below:
* [SARS-CoV-2](../designs/coronaviridae/sars/out/sars-cov-2.0.tsv)
* [SARS-CoV-2-related](../designs/coronaviridae/sars/out/sars-cov-2-related.0.tsv)
* [SARS-related CoV](../designs/coronaviridae/sars/out/severe_acute_respiratory_syndrome-related_coronavirus.0.tsv)
* [Enterovirus B](../designs/picornaviridae/enterovirus-species-entero/out/enterovirus_b.0.tsv)

