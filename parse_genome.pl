#!/usr/bin/perl -w
use strict;
use File::Basename;
use Getopt::Std;
my $PROGRAM = basename $0;
my $USAGE=
"Usage: $PROGRAM
";

my %OPT;
getopts('', \%OPT);

my $FILE;
my $CONTENTS;
while (<>) {
    if (/chromosome (\S+)/) {
        write_file();
        $FILE = "chr$1";
        $CONTENTS = $_;
    } elsif (/mitochondrion/) {
        write_file();
        $FILE = "chrMT";
        $CONTENTS = $_;
    } else {
        tr/atgc/ATGC/;
        $CONTENTS .= $_;
    }
}
write_file();

################################################################################
### Function ###################################################################
################################################################################

sub write_file {
    if ($FILE and $CONTENTS) {
        open(FILE, ">$FILE") || die "$!";
        print FILE $CONTENTS;
        close(FILE);    
    }
}
