package Formatter::HTML::Preformatted;

use 5.006;
use strict;
use warnings;
use URI::Find::Simple qw( list_uris change_uris );


our $VERSION = '0.1';

=head1 NAME

Formatter::HTML::Preformatted - Absolute minimal HTML formatting of pure text

=head1 SYNOPSIS

  use Formatter::HTML::Preformatted;
  my $formatter = Formatter::HTML::Preformatted->new;
  $formatter->format($data);

=head1 DESCRIPTION

This module will simply take any text-string and put it in a HTML C<pre> element. It will escape tags and entities. It will also look through it to see if there are any URIs, and they will be turned into hyperlinks.

=head1 METHODS

This module conforms with the Formatter API:

=over

=item C<new>

The constructor, nothing special.

=cut

sub new {
  my $that  = shift;
  my $class = ref($that) || $that;
  my $self = {
	      _text => undef,
	     };
  bless($self, $class);
  return $self;
}

=item C<format($string)>

The format function that you call to get the formatted HTML. It takes the plain text as a string argument and returns a string with HTML.

=cut

sub format {
  my $self = shift;
  $self = $self->new unless ref($self);
  $self->{_text} = shift || "";
  my $raw = $self->{_text};
  # Escaping the 
  $raw =~ s/&/&amp;/g;
  $raw =~ s/\>/&gt;/g;
  $raw =~ s/\</&lt;/g;
  
  return "<pre>\n" . change_uris($raw, sub { "<a href=\"$_[0]\">$_[0]</a>" }) . "\n</pre>";
}

=item C<links($string)>

Will return all links found the input plain text string as a list.

=cut

sub links {
  my $self = shift;
  $self = $self->new unless ref($self);
  $self->{_text} = shift || "";
  return list_uris($self->{_text});
}

=item C<title>

This method shall return the title of the document or C<undef> if none can be found. Since it doesn't make sense in this context, it will always return C<undef>. 

=cut


sub title {
  return undef;
}





1;
__END__

=back


=head1 SEE ALSO

L<Formatter::HTML::Textile>, L<URI::Find::Simple>

=head1 AUTHOR

Kjetil Kjernsmo, E<lt>kjetilk@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2004 by Kjetil Kjernsmo

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.4 or,
at your option, any later version of Perl 5 you may have available.


=cut
