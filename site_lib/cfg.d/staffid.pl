# which field contains staff id?
# will be used as creator/editor/contributor_id
# by cgi/users/lookup/staffid
$c->{staffid_field} = "staffid";

push @{ $c->{fields}->{user} },
{
	name => "staffid",
	type => "id"
}
;
