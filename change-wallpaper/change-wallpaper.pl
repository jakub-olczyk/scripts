#!/usr/bin/perl
# author: Jakub Olczyk
# license: GPLv3+

use strict;
use warnings;

use Getopt::Long;

my ($walldir, $help, $num_wallpaper);

my (@wallpapers, %used_wallpapers);
my $tmp_storage = '/tmp/used_wallpapers';

GetOptions(
    'wallpaper_dir=s' => \$walldir,
    'help' => \$help,
);

my %messages = ( #{{{

    help => <<HELP
change-wallpaper.pl --wallpaper_dir <DIRECTORY>

DESCRIPTION
    This program uses feh to change current wallpaper to a randomly chosen one
    taken from supplied directory.
    It memoizes the seen wallpapers, meaning that invoking again ensures that
    next wallpaper will always be the one not seen before.


AUTHOR
    2017 - Jakub Olczyk <jakub.olczyk\@openmailbox.org>
HELP
    ,
    no_dir => 
    "I need wallpaper directory!\nUse --wallpaper_dir flag to supply this information\n",

    no_feh => "You need to install feh first!\n",

);#}}}

print_exit(0, $messages{help}) if $help;

die $messages{no_dir} unless $walldir;

init();

# choose randomly one wallpaper ...
my $curr_wall = int(rand($num_wallpaper));

# dump its name to a tmp file...
open my $STORAGE, '>>', $tmp_storage;
print $STORAGE $wallpapers[$curr_wall], "\n";
close($STORAGE);

# ... set it
print_exit(1, 'Feh error!') unless system('feh', '--bg-fill', $wallpapers[$curr_wall]) == 0;


sub init { #{{{
    # check for feh
    die $messages{no_feh} unless system('which feh > /dev/null') == 0;

    #populate the variables
    @wallpapers = <"$walldir/*">;
    #check if no wallpapers where used before
    eval {populate_hash()}; #trick for not killing script when no tmp_storage is present
    
    if (scalar keys %used_wallpapers) { 
        for (my $i=0; $i < scalar @wallpapers; ++$i){
            undef $wallpapers[$i] if $used_wallpapers{$wallpapers[$i]};
        } 
        @wallpapers = grep {defined $_} @wallpapers;
    }

    $num_wallpaper = @wallpapers; 
    unless ($num_wallpaper) {
        system('rm', '-rf', $tmp_storage);
        init();
    }
    return;
}#}}}

sub populate_hash { #{{{
    open my $STORAGE, '<', $tmp_storage or die "Couldn't open $tmp_storage!";
    while(<$STORAGE>){
        chomp;
        $used_wallpapers{$_}++;
    }
    close($STORAGE);
}#}}}

sub print_exit {#{{{
    my $status = shift;
    print @_, "\n";
    exit $status;
}#}}}
