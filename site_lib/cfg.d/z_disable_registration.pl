# disable registration
$c->{allow_web_signup} = 0;
$c->{plugins}->{"Screen::Register"}->{actions}->{register}->{appears}->{key_tools} = undef;
