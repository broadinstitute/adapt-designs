#!/usr/bin/env python3
"""Compile ADAPT outputs to a single JSON file."""

import argparse
from collections import defaultdict
from datetime import datetime
import hashlib
import json
import os

__author__ = 'Hayden Metsky <hayden@mit.edu>'


class DesignTarget:
    """Store information on a design of a single target.
    """

    def __init__(self, target_start, target_end, guide_seqs,
            left_primer_seqs, right_primer_seqs, cost):
        self.target_start = target_start
        self.target_end = target_end
        self.guide_seqs = tuple(sorted(guide_seqs))
        self.left_primer_seqs = tuple(sorted(left_primer_seqs))
        self.right_primer_seqs = tuple(sorted(right_primer_seqs))
        self.cost = cost


class Design:
    """Store information on a design encompassing multiple possible targets.
    """

    def __init__(self, targets):
        self.targets = targets

    @staticmethod
    def from_file(fn, num_targets=None):
        """Read a collection of targets from a file.

        Args:
            fn: path to a TSV file giving targets
            num_targets: only construct a Design from the top num_targets
                targets, as ordered by cost (if None, use all)

        Returns:
            Design object
        """
        if not os.path.isfile(fn):
            return None

        rows = []
        with open(fn) as f:
            col_names = {}
            for i, line in enumerate(f):
                line = line.rstrip()
                ls = line.split('\t')
                if i == 0:
                    # Parse header
                    for j in range(len(ls)):
                        col_names[j] = ls[j]
                else:
                    # Read each column as a variable
                    cols = {}
                    for j in range(len(ls)):
                        cols[col_names[j]] = ls[j]
                    rows += [(cols['cost'], cols['target-start'],
                             cols['target-end'], cols)]

        # Sort rows by cost (first in the tuple); in case of ties, sort
        # by target start and target end positions (second and third in
        # the tuple)
        # Pull out the best N targets
        rows = sorted(rows)
        if num_targets != None:
            if len(rows) < num_targets:
                raise Exception(("The number of rows in a design (%d) is fewer "
                    "than the number of targets to read (%d)") %
                    (len(rows), num_targets))
            rows = rows[:num_targets]

        targets = []
        for row in rows:
            _, _, _, cols = row
            targets += [DesignTarget(
                int(cols['target-start']),
                int(cols['target-end']),
                cols['guide-target-sequences'].split(' '),
                cols['left-primer-target-sequences'].split(' '),
                cols['right-primer-target-sequences'].split(' '),
                float(cols['cost'])
            )]

        return Design(targets)


def read_design_listing(in_tsv):
    """Read TSV listing designs to compile.

    Arg:
        in_tsv: path to TSV file (see arg help for format)

    Returns:
        list [x_i] where each x_i is a dict giving information
        about the design
    """
    designs_info = []
    with open(in_tsv) as f:
        for line in f:
            ls = line.rstrip().split('\t')
            name, group, display_name, taxon_rank, designs_path, num_options, timestamp_path, description = ls

            if description.lower() == "none":
                # Use blank description
                description = ""

            info = {'name': name,
                    'group': group,
                    'display_name': display_name,
                    'taxon_rank': taxon_rank,
                    'designs_path': designs_path,
                    'num_options': int(num_options),
                    'timestamp_path': timestamp_path,
                    'description': description}
            designs_info += [info]
    return designs_info


def rc(seq):
    """Determine reverse complement."""
    rc_map = {'A': 'T', 'T': 'A', 'C': 'G', 'G': 'C'}
    # Using rc_map.get(b, b) ensures that this can process bases
    # like 'N'. It returns the base itself (e.g., 'N') if it is
    # not either 'A', 'T', 'C', or 'G'.
    rc_seq = ''.join([rc_map.get(b, b) for b in seq[::-1]])
    return rc_seq
def rewrite_guide(seq):
    """Output correct guide sequence (technically, spacer).

    This should be the reverse complement of the target sequence and
    in RNA.
    """
    rc_seq = rc(seq)
    rna_rc_seq = rc_seq.replace('T', 'U')
    return rna_rc_seq
def rewrite_primer_fwd(seq):
    """Output correct forward primer sequence.

    Since this is forward, nothing changes.
    """
    return seq
def rewrite_primer_rev(seq):
    """Output correct reverse primer sequence.

    Since this is reverse, we take the reverse complement.
    """
    return rc(seq)


def make_json_dict_for_design(design, design_info):
    """Create dict to use for JSON string for a design.

    Args:
        design: Design object
        design_info: dict of information on design

    Returns:
        dict
    """
    # The name may have '_' and '-', which may present problems for the web
    # app; calculate an ID from its hash
    hash_len = 8
    design_id = hashlib.sha224(design_info['name'].encode()).hexdigest()[-hash_len:]

    # Read timestamp
    with open(design_info['timestamp_path']) as f:
        for i, line in enumerate(f):
            # Should be just 1 line
            assert i == 0
            timestamp = int(line)
    timestampHuman = datetime.utcfromtimestamp(timestamp).strftime('%b %d, %Y')

    # Collect key design information
    design_targets = []
    for i, target in enumerate(design.targets):
        rank = i + 1
        amplicon_len = target.target_end - target.target_start
        amplicon_mid_pos = target.target_start + int(amplicon_len/2)
        guide_seqs = [rewrite_guide(s) for s in target.guide_seqs]
        primer_fwd_seqs = [rewrite_primer_fwd(s) for s in target.left_primer_seqs]
        primer_rev_seqs = [rewrite_primer_rev(s) for s in target.right_primer_seqs]
        target_dict = {
                'rank': rank,
                'ampliconMidPos': amplicon_mid_pos,
                'spacerSeqs': guide_seqs,
                'primerFwdSeqs': primer_fwd_seqs,
                'primerRevSeqs': primer_rev_seqs
        }
        design_targets += [target_dict]

    # Only report the first design_info['num_options'] targets
    design_targets = design_targets[:design_info['num_options']]

    return {'id': design_id, 'group': design_info['group'],
            'displayName': design_info['display_name'],
            'description': design_info['description'],
            'taxonRank': design_info['taxon_rank'],
            'lastUpdatedTimestamp': timestamp, 'lastUpdatedStr': timestampHuman,
            'designOptions': design_targets}


def compile_json(args):
    """Compile JSON from designs.

    Args:
        args: parsed arguments
    """
    design_listing = read_design_listing(args.in_tsv)

    designs = {}
    designs_order = []
    designs_grouped = defaultdict(list)
    for design_info in design_listing:
        # Read TSV of design options
        design = Design.from_file(design_info['designs_path'])
        if design is None or len(design.targets) < design_info['num_options']:
            print(("WARNING: Design for {} does not exist or has too few "
                "options; skipping").format(design_info['name']))
            continue

        # Create dict of JSON for this design
        json_dict = make_json_dict_for_design(design, design_info)
        designs[json_dict['id']] = json_dict

        # Use the same order as in the input TSV file
        designs_order += [json_dict['id']]

        # Add this design to its group
        designs_grouped[json_dict['group']].append(json_dict['id'])

    json_dict = {
            'designs': designs,
            'designsOrder': designs_order,
            'groupedDesigns': designs_grouped
    }

    # Dump the JSON to the given file path
    # Use indent to make it pretty; otherwise, do not
    with open(args.out_json, 'w') as fw:
        json.dump(json_dict, fw, indent=1, sort_keys=True)


def main():
    parser = argparse.ArgumentParser()

    parser.add_argument('in_tsv',
        help=("Path to TSV file giving the information to compile. "
              "Each row is a design -- i.e., corresponding to a set "
              "of design options (in their own TSV) output by ADAPT. "
              "Columns are: (1) non-spaced name to refer to the design; "
              "(2) name of group under which design falls (e.g., family); "
              "(3) display name (e.g., full species or strain name); "
              "(4) taxonomy rank (e.g., 'species'); "
              "(5) path to TSV file giving design options; (6) number of "
              "design options to report; (7) path to "
              "file giving timestamp of last update; (8) description of "
              "the design"))
    parser.add_argument('out_json',
        help=("Path to file at which to write JSON"))

    args = parser.parse_args()
    compile_json(args)


if __name__ == "__main__":
    main()
