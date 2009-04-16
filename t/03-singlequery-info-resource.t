#!perl -T
# /* vim:et: set ts=4 sw=4 sts=4 tw=78: */
#$Id: 03-singlequery-info-resource.t,v 1.2 2009/04/16 08:08:48 dinosau2 Exp $

use strict;
use warnings;

use Test::More tests => 8;

use WWW::TasteKid;

my $tskd = WWW::TasteKid->new;
{
 $tskd->query({ type => 'music', name => 'bach' });
 $tskd->ask;
 my $res = $tskd->info_resource;
 is $res->[0]->name, 'Johann Sebastian Bach';
 is $res->[0]->type, 'music';
}

$tskd->query({ type => 'music', name => 'bach' });
#$tskd->query_inspection; # inspect what in the query
$tskd->ask({ verbose => 1 });

## start for dev, test locally
#use LWP::Simple;
#$tskd->set_xml_result(
#    get('file:///'.dirname(abs_path(__FILE__)).'/data/bach_verbose.xml')
#);
## end for dev, test locally

my $res = $tskd->info_resource;

# return hash ref, specify by element
is $res->[0]->name, 'Johann Sebastian Bach';
is $res->[0]->type, 'music';

# test could easily be false positive and not mean anything!, leave it for now

is substr($res->[0]->wteaser, 0, 40), 
'<b>Johann Sebastian Bach</b> (31 March 1';

is $res->[0]->wurl, 'http://en.wikipedia.org/wiki/J.S.Bach';

is $res->[0]->ytitle, 
      q{'Air' from Suite No.3 in D major - Johann Sebastian Bach};

is $res->[0]->yurl, 
 q{http://www.youtube.com/v/CyLo9-Voy5s&f=videos&c=TasteKid&app=youtube_gdata};

