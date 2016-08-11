#   Copyright 2010 Arnout Engelen
#
#     This file is part of realtimeconfigquickscan.
#
#    realtimeconfigquickscan is free software: you can redistribute it and/or 
#    modify it under the terms of the GNU General Public License as published 
#    by the Free Software Foundation, either version 2 of the License, or
#    (at your option) any later version.
#
#    realtimeconfigquickscan is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with realtimeconfigquickscan.  
#    If not, see <http://www.gnu.org/licenses/>.
package HpetCheck;

use Check;
use base qw(Check);

sub new
{
	my($class) = shift;
        my($self) = Check->new($class);
	$self->{LABEL} = "Checking access to the high precision event timer";
	return (bless($self, $class));
}

sub execute
{
	my $self = shift;

	if ( -e "/dev/hpet" )
	{
			$self->{COMMENT} = undef;
		if ( -r "/dev/hpet" )
		{
			$self->{RESULTKIND} = "good";
			$self->{RESULT} = "readable";
		}
		else
		{	
			$self->{RESULTKIND} = "not good";
			$self->{RESULT} = "not readable";
			$self->{COMMENT} = "/dev/hpet found, but not readable.\n".
				"make /dev/hpet readable by the 'audio' group\n".
				"For more information, see http://wiki.linuxaudio.org/wiki/system_configuration#hardware_timers";
		}
	}
	else
	{
		$self->{RESULTKIND} = "not good";
		$self->{RESULT} = "not found";
		$self->{COMMENT} = "/dev/hpet not found.";
	}
}

1;
