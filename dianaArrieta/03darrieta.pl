#!perl

#Arrieta Jimenez Diana Laura
=pod

=head1 NAME

	CursoPerl::Tarea3::03darrieta.pl -Arrieta Jimenez Diana Laura

=head1 VERSION
	
	Version 1.0

=head1 DESCRIPTION
	
	Este programa genera un archivo 03prueba.html con el contenido del archivo
	/etc/passwd, la forma de abrirlo es mediante un navegador web.
	Colocar una copia de /etc/passwd con el nombre datos.txt en el directorio actual

=cut

use strict;
use warnings;
use HTML::Template;


open FP,">03prueba.html" or die "Error";
print FP &pass_info();
close FP;

sub pass_info
{
	my $fip="datos.txt";

	open FILE,"<",$fip;
	my @file=(<FILE>);
	my $output;
	my $template = HTML::Template->new(filename => './03template.tmpl');
	my @loop_data=();
	for(@file)
	{
		my %hash;
		if(/(.*):(.*):(.*):(.*):(.*):(.*):(.*)/)
		{
			$hash{user} = $1;
			$hash{pass} = $2;
			$hash{uid} = $3;
			$hash{gid} = $4;
			$hash{desc} = $5;
			$hash{home} = $6;
			$hash{shell} = $7;
		}

		push(@loop_data,\%hash);

	}
	
	close FILE;
	$template->param(passwd => \@loop_data);
	$output.=$template->output();
	return $output;
}