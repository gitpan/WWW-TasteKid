#!perl -T
# /* vim:et: set ts=4 sw=4 sts=4 tw=78: */
#$Id: 05-results-resource.t,v 1.2 2009/04/16 08:08:48 dinosau2 Exp $

use strict;
use warnings;

#use Test::More qw/no_plan/;
use Test::More tests => 20;
use Data::Dumper qw/Dumper/;
use Encode qw/decode encode/;
use WWW::TasteKid;

my $tskd = WWW::TasteKid->new;
$tskd->query({ type => 'music', name => 'bach' });
# show in example
#my $debug_query = $tskd->query_inspection; # inspect what in the query
#warn $debug_query;
$tskd->ask({ verbose => 1 });
my $res = $tskd->results_resource;

# order may change but these 4 should remain 'suggested' from bach,... (I hope)
#use utf8;
my @expected_in_res = (
   'George Frideric Handel',
   'Joseph Haydn',
   'Johannes Brahms',
   "Anton\x{ed}n Leopold Dvo\x{159}\x{e1}k"
   #'Antonín Leopold Dvořák'
);

my @first_3 = ();
my $seen = 0;
foreach my $r (@{$res}){
    #warn $r->name;
    if ( scalar grep { $r->name eq encode('utf8',$_) } @expected_in_res ) {
        push @first_3, $r;
        $seen++;
    }
}
pop @first_3; # it's 3 now ;)
is $seen, scalar @expected_in_res;
is scalar @first_3, 3;


# now check verbose data, NOTE: lots of possibility of false/positive
my $tskdr0 = WWW::TasteKidResult->new;
$tskdr0->name('George Frideric Handel');
$tskdr0->type('music');
$tskdr0->wteaser(q{<b>George Frideric Handel</b> (23 F});
$tskdr0->wurl('http://en.wikipedia.org/wiki/George_Frideric_Handel');
$tskdr0->ytitle(q{George Frideric Handel - Messiah "Hallelujah!"});
$tskdr0->yurl(q{http://www.youtube.com/v/3uOabPZScQs&f=videos&c=TasteKid&app=youtube_gdata});
 

my $tskdr1 = WWW::TasteKidResult->new;
$tskdr1->name('Joseph Haydn');
$tskdr1->type('music');
$tskdr1->wteaser(q{<b>(Franz) Joseph Haydn</b> (March });
$tskdr1->wurl('http://en.wikipedia.org/wiki/Joseph_Haydn');
$tskdr1->ytitle(q{Joseph Haydn - Piano Sonata in Eb});
$tskdr1->yurl(q{http://www.youtube.com/v/Vkse1g9ibnM&f=videos&c=TasteKid&app=youtube_gdata});
 

my $tskdr2 = WWW::TasteKidResult->new;
$tskdr2->name('Johannes Brahms');
$tskdr2->type('music');
$tskdr2->wteaser(q{<b>Johannes Brahms</b> (pronounced });
$tskdr2->wurl('http://en.wikipedia.org/wiki/Johannes_Brahms');
$tskdr2->ytitle(q{Johannes Brahms- Waltz});
$tskdr2->yurl(q{http://www.youtube.com/v/TJcoaIeH3GI&f=videos&c=TasteKid&app=youtube_gdata});

my @r_obj = ($tskdr0,$tskdr1,$tskdr2);  

for my $i (0..2){
    is $first_3[$i]->name,   $r_obj[$i]->name;
    is $first_3[$i]->type,   $r_obj[$i]->type;
    is substr($first_3[$i]->wteaser, 0, 35), $r_obj[$i]->wteaser;
    is $first_3[$i]->wurl,   $r_obj[$i]->wurl;
    is $first_3[$i]->ytitle, $r_obj[$i]->ytitle;
    is $first_3[$i]->yurl,   $r_obj[$i]->yurl;
}


## start for dev, test locally
#use LWP::Simple;
#$tskd->set_xml_result(
#    get('file:///'.dirname(abs_path(__FILE__)).'/data/bach_verbose.xml')
#);
## end for dev, test locally
