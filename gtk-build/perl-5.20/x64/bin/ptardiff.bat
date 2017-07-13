@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!perl
#line 15
    eval 'exec c:\mozilla-build\perl-5.20\x64\bin\perl.exe -S $0 ${1+"$@"}'
	if $running_under_some_shell;
#!/usr/bin/perl

use strict;
use Archive::Tar;
use Getopt::Std;

my $opts = {};
getopts('h:', $opts) or die usage();

die usages() if $opts->{h};

### need Text::Diff -- give a polite error (not a standard prereq)
unless ( eval { require Text::Diff; Text::Diff->import; 1 } ) {
    die "\n\t This tool requires the 'Text::Diff' module to be installed\n";
}

my $arch = shift                        or die usage();
my $tar  = Archive::Tar->new( $arch )   or die "Couldn't read '$arch': $!";


foreach my $file ( $tar->get_files ) {
    next unless $file->is_file;
    my $name = $file->name;

    diff(   \($file->get_content), $name,
            {   FILENAME_A  => $name,
                MTIME_A     => $file->mtime,
                OUTPUT      => \*STDOUT
            }
    );
}




sub usage {
    return q[

Usage:  ptardiff ARCHIVE_FILE
        ptardiff -h

    ptardiff is a small program that diffs an extracted archive
    against an unextracted one, using the perl module Archive::Tar.

    This effectively lets you view changes made to an archives contents.

    Provide the progam with an ARCHIVE_FILE and it will look up all
    the files with in the archive, scan the current working directory
    for a file with the name and diff it against the contents of the
    archive.


Options:
    h   Prints this help message


Sample Usage:

    $ tar -xzf Acme-Buffy-1.3.tar.gz
    $ vi Acme-Buffy-1.3/README

    [...]

    $ ptardiff Acme-Buffy-1.3.tar.gz > README.patch


See Also:
    tar(1)
    ptar
    Archive::Tar

    ] . $/;
}



=head1 NAME

ptardiff - program that diffs an extracted archive against an unextracted one

=head1 DESCRIPTION

    ptardiff is a small program that diffs an extracted archive
    against an unextracted one, using the perl module Archive::Tar.

    This effectively lets you view changes made to an archives contents.

    Provide the progam with an ARCHIVE_FILE and it will look up all
    the files with in the archive, scan the current working directory
    for a file with the name and diff it against the contents of the
    archive.

=head1 SYNOPSIS

    ptardiff ARCHIVE_FILE
    ptardiff -h

    $ tar -xzf Acme-Buffy-1.3.tar.gz
    $ vi Acme-Buffy-1.3/README
    [...]
    $ ptardiff Acme-Buffy-1.3.tar.gz > README.patch


=head1 OPTIONS

    h   Prints this help message

=head1 SEE ALSO

tar(1), L<Archive::Tar>.

=cut

__END__
:endofperl
