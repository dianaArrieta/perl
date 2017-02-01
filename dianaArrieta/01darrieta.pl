#!perl
#Arrieta Jimenez Diana Laura
=pod

=head1 NAME

	CursoPerl::Tareas::01darrieta.pl - Arrieta Jimenez Diana Laura

=head1 VERSION

	Version 1.0	

=head1 DESCRIPTION

	Programa que imprime los 10 primeros numeros de la serie de Fibonacci.

=cut

use warnings;
use strict;
=pod

	El programa parte de los numeros 0 y 1, con estos comienza  el calculo de la serie

=cut
my @s=(0,1);

for(1..8)
{
	$s[$#s+1] =$s[$#s] + $s[$#s-1];
}

print join  " , ", @s , "\n";

print "\nLos pragmas son modulos que influyen en el proceso de compilacion, especifican como este debe procesar una entrada  \n";
