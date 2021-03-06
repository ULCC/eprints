=head1 NAME

EPrints::Apache::MapToStorage::View - update and show view pages

=head1 DESCRIPTION

=over 4

=cut

package EPrints::Apache::MapToStorage::View;

use EPrints::Const qw( :http );
use base qw( EPrints::Apache::MapToStorage );

use strict;

sub handler
{
	my( $r ) = @_;

	my $repo = EPrints->new->current_repository;

	my $localpath = $r->pnotes( "localpath" );
	my $langid = $r->pnotes( "langid" );
	my $localuri = $r->pnotes( "localuri" );

	my $filename = EPrints::Update::Views::update_view_file( $repo, $langid, $localpath, $localuri );
	$filename =~ s/\.html$// if defined $filename;

	if( defined $filename && -r "$filename.page" )
	{
		my $ua = $r->headers_in->{'User-Agent'};
		if( $ua && $ua =~ /MSIE ([0-9]{1,}[\.0-9]{0,})/ && $1 >= 8.0 )
		{
			$r->headers_out->{'X-UA-Compatible'} = "IE=9";
		}

		$r->filename( "$filename.html" );
		$r->handler('perl-script');
		$r->set_handlers(PerlResponseHandler => [ 'EPrints::Apache::Template' ] );

		return OK;
	}

	return DECLINED;
}

1;

=head1 COPYRIGHT

=for COPYRIGHT BEGIN

Copyright 2000-2012 University of Southampton.

=for COPYRIGHT END

=for LICENSE BEGIN

This file is part of EPrints L<http://www.eprints.org/>.

EPrints is free software: you can redistribute it and/or modify it
under the terms of the GNU Lesser General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

EPrints is distributed in the hope that it will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
License for more details.

You should have received a copy of the GNU Lesser General Public
License along with EPrints.  If not, see L<http://www.gnu.org/licenses/>.

=for LICENSE END

