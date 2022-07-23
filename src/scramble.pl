#!/usr/bin/perl -w
use strict;
$|++;

#
# scramble.pl
#
# pour utilisation avec AntiSpamMailTo.js
# idee: gagnjea
# code: saintamh
#

sub scramble {
    my ($email) = @_;
    my $len = length($email);
    my @new_email = ();
    my $jump = 3;
    while( $len % ($jump % $len) == 0 ) { $jump++; }
    my $start = int rand $len;
    
    for( my $i = 0; $i < $len; $i++ ) {
        $new_email[$start] = substr( $email, $i, 1 );
        $start = ($start + $jump) % $len;
    }
    
    my $new_email = join( '', @new_email );
    
    return "<script>AntiSpamMailTo(\"$new_email\", $start, $jump);</script>" .
           "<noscript>Javascript doit &ecirc;tre activ&eacute; pour avoir ce e-mail (pour des raisons d'anti-spam =;-) )</noscript>";
}

if( @ARGV ) {
    print &scramble( $ARGV[0] ), "\n";
} else {
    print STDERR "usage: scamble.pl <email>\n";
}
