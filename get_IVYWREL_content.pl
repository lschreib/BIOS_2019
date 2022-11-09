#!/usr/bin/env perl

# This script calculates the content of the amino acids I, V, Y, W, R, E and L, which have
# been proposed to affect the optimal growth temperature of a genome
#(Bowman 2017, DOI:10.1007/978-3-319-57057-0_15)
# The input file is assumed to contain all translated gene sequences of a genome
# The script relies on the BioPerl package Bio:SeqIO which needs to be installed prior to
# usage

# Script usage: perl get_IVYWREL_content.pl genome_file.faa 

use strict;
use warnings;
use Bio::SeqIO;

my ($infile) = @ARGV;
my $in = Bio::SeqIO->new(-file => $infile, -format => 'fasta');
my $overallCount = 0;
my $overallLength = 0;
while (my $seqobj = $in->next_seq) {
    my $id = $seqobj->id;
    my $seq = $seqobj->seq;
    my $length = $seqobj->length;
    $overallLength = $overallLength + $length;
    for (my $i = 0; $i < $length; $i++) {
	my $sub = substr($seq,$i,1);
	if ($sub =~ /I|V|Y|W|R|E|L/i) {
	    $overallCount++;
	}
    }
}
my $psyContent = ($overallCount / $overallLength) * 100;
print "$infile\t$overallLength\t$psyContent\n";