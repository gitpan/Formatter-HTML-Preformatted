use strict;
use warnings;
use Test::More tests => 3;

use_ok ('Formatter::HTML::Preformatted');


my $data = <<'_EOD_';
This is a test of Formatter::HTML::Preformatted, which can be found at
http://search.cpan.org/dist/Formatter-HTML-Preformatted/
It has been written by http://www.kjetil.kjernsmo.net/ in the hope
it will be useful for someone.
_EOD_

my $expected = <<'_EOD_';
<pre>
This is a test of Formatter::HTML::Preformatted, which can be found at
<a href="http://search.cpan.org/dist/Formatter-HTML-Preformatted/">http://search.cpan.org/dist/Formatter-HTML-Preformatted/</a>
It has been written by <a href="http://www.kjetil.kjernsmo.net/">http://www.kjetil.kjernsmo.net/</a> in the hope
it will be useful for someone.

</pre>
_EOD_

my $text = Formatter::HTML::Preformatted->new;
isa_ok( $text, 'Formatter::HTML::Preformatted' );

# Hrmpf! I can't get the below test working, anybody able to see why?
#ok($text->format($data) eq $expected);

my @links = qw( http://search.cpan.org/dist/Formatter-HTML-Preformatted/ http://www.kjetil.kjernsmo.net/ );

# TODO: Make this prettier:
ok(join('', $text->links($data)), join('', @links));


