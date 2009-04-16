#!perl -T
# /* vim:et: set ts=4 sw=4 sts=4 tw=78: */
#$Id: 02-xml_result.t,v 1.2 2009/04/16 08:08:48 dinosau2 Exp $

use strict;
use warnings;

use Test::More tests => 1;

use WWW::TasteKid;
use File::Slurp qw/slurp/;
use File::Basename qw/dirname/;

my $bach_file_content = slurp(dirname(__FILE__).'/data/bach.xml');

#XXX: this is a weak test and can easily be false positive
## i.e maybe the results for 'bach' won't change but they probably will

my $tc = WWW::TasteKid->new;
$tc->query({ type => 'music', name => 'bach' });
$tc->ask;

# file content is same
diag( 'if fails but comparsions are close test is false positive, you can proceed' )
  if not
    is_deeply $tc->get_xml_result, $bach_file_content;

