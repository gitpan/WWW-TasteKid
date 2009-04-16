#!perl -T
# /* vim:et: set ts=4 sw=4 sts=4 tw=78: */
#$Id: 04-multiquery-info-resource.t,v 1.2 2009/04/16 08:08:48 dinosau2 Exp $

use strict;
use warnings;

use Test::More tests => 26;

use WWW::TasteKid;

my $tskd = WWW::TasteKid->new;

## start for dev, test locally
#use LWP::Simple;
#use File::Basename qw/dirname/;
#use Cwd 'abs_path';
#$tskd->set_xml_result(
#    get('file:///'.dirname(abs_path(__FILE__)).'/data/bach_beethoven_mozart.xml')
#);
# end for dev, test locally

{
  $tskd->query({ name => 'bach' });
  $tskd->query({ name => 'beethoven' });
  $tskd->query({ name => 'mozart' });
  $tskd->ask;
  
  my $res = $tskd->info_resource;
  
  is $res->[0]->name, 'Johann Sebastian Bach';
  is $res->[1]->name, 'Ludwig Van Beethoven';
  is $res->[2]->name, 'Wolfgang Amadeus Mozart';
  
  # we didn't specify a type, so the obvious one is returned
  is $res->[0]->type, 'music';
  is $res->[1]->type, 'music';
  is $res->[2]->type, 'music';
}

{
  $tskd->query({ type => 'music', name => 'bach' });
  $tskd->query({ type => 'music', name => 'beethoven' });
  $tskd->query({ type => 'music', name => 'mozart' });
  $tskd->ask;
  my $res = $tskd->info_resource;
 
  # retured in order recieved
  my @expected = ('Johann Sebastian Bach',
                  'Ludwig Van Beethoven',
                  'Wolfgang Amadeus Mozart');
  
  my @result = ();
  foreach my $r (@{$res}){
      push @result, $r->name;
  }
  
  is scalar @expected, scalar @result;
  is_deeply \@expected, \@result;
}


$tskd->query({ type => 'music', name => 'bach' });
$tskd->query({ type => 'music', name => 'beethoven' });
$tskd->query({ type => 'music', name => 'mozart' });
$tskd->ask({ verbose => 1 });

## start for dev, test locally
#use LWP::Simple;
#use File::Basename qw/dirname/;
#use Cwd 'abs_path';
#$tskd->set_xml_result(
#    get('file:///'.dirname(abs_path(__FILE__)).'/data/bach_beethoven_mozart_verbose.xml')
#);
## end for dev, test locally

my $res = $tskd->info_resource;

# return hash ref, specify by element
is $res->[0]->name, 'Johann Sebastian Bach';
is $res->[0]->type, 'music';

is substr($res->[0]->wteaser, 0, 40), 
'<b>Johann Sebastian Bach</b> (31 March 1';

is $res->[0]->wurl, 'http://en.wikipedia.org/wiki/J.S.Bach';

is $res->[0]->ytitle, 
      q{'Air' from Suite No.3 in D major - Johann Sebastian Bach};

is $res->[0]->yurl, 
 q{http://www.youtube.com/v/CyLo9-Voy5s&f=videos&c=TasteKid&app=youtube_gdata};

# add for 
is $res->[1]->name, 'Ludwig Van Beethoven';
is $res->[1]->type, 'music';
# geez, no wiki love for Ludwig,... -see, if you update wikipedia, you will
# break this test,... ;)
is substr($res->[1]->wteaser, 0, 27 ), 
'<b>Ludwig van Beethoven</b>';

is $res->[1]->wurl, q{http://en.wikipedia.org/wiki/Ludwig_van_Beethoven};
is $res->[1]->ytitle, q{Ludwig van Beethoven};
is $res->[1]->yurl, q{http://www.youtube.com/v/9NJ5BzyJq7E&f=videos&c=TasteKid&app=youtube_gdata};

is $res->[2]->name, 'Wolfgang Amadeus Mozart';
is $res->[2]->type, 'music';

is substr($res->[2]->wteaser, 0, 30 ), 
'<b>Wolfgang Amadeus Mozart</b>';

is $res->[2]->wurl, 'http://en.wikipedia.org/wiki/Wolfgang_Amadeus_Mozart';

is $res->[2]->ytitle, 
      q{Wolfgang Amadeus Mozart - Piano Concerto No. 21 - Andante};

is $res->[2]->yurl, 
 q{http://www.youtube.com/v/df-eLzao63I&f=videos&c=TasteKid&app=youtube_gdata};

