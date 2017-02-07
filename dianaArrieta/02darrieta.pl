#!perl
#Arrieta Jimenez Diana Laura
=pod

=head1 NAME

	CursoPerl::Tarea2::02darrieta.pl -Arrieta Jimenez Diana Laura

=head1 VERSION
	
	Version 1.0

=head1 DESCRIPTION
	
	Este programa recibe como parametro la ruta y nombre de un archivo 
	de texto, y hace un conteo de:
		1. Correos electronicos.
		2. Dominios de internet
		3. Urls
		4. Direcciones IP
	Devolviendo un archivo de salida llamado "salida.txt" (En el 
	directorio en el que se ejecuta el programa) con las repeticiones 
	de cada coincidencia.
	En la terminal devuelve el numero de total correos, dominios,urls 
	y direcciones con repeticiones y el total de correos, dominios, urls 
	y direcciones diferentes.
	
	Ejemplo de ejecucion:
	
		perl 02darrieta.pl datos.txt

	Si el archivo de entrada no existe se genera un error y termina el 
	programa.

=cut


use warnings;
use strict;
use 5.014;

my $n_archivo = $ARGV[0];
my $s_archivo = "./salida.txt";
my %dom=();
my %mail=();
my %ip=();
my %url=();
my $numurl = 0;
my $numurlT = 0;
my $correos = 0;
my $correoT = 0;
my $dominios = 0;
my $dominioT = 0;
my $numips = 0;
my $numipsT = 0;

if (not defined $n_archivo){ die "Necesita especificar el nombre de archivo"};

open(FCG,"<",$n_archivo) or die "Error al abrir el archivo \n";
open(FCD,">",$s_archivo) or die "Error al abrir el archivo \n";
open(STDERR, ">>","error.log") or die  "No se pudo abrir el archivo\n";

while(my $linea=<FCG>)
{

	my $lmail = $linea;
	while($lmail =~ /\w/)
	{
		if($lmail =~ /([\w\.]+@[\w.-]+\.((a([cartu]|sia)|b([eorg]|iz)|c([chlnru]|at?|om?)|d[eko]|e([cs]|d?us?)|f[imro]|g([rt]|al|go[vb])|h[nr]|i([lt]|n(fo|t))|j(obs|p)|kr|l(at|u)|m([aex]|il|obi|useum)|n([iolz]|ame|et|ews?)|org|p([aelty]|ro)|r[osu]|s[ev]|t([kv]|el|ravel)|u[aky]|v[ae]|w(eb|s)|xxx|za|pф)\.?)+)(.*)/)
                {
                       if($mail{$1}){++$mail{$1};}else{$mail{$1}=1;}
                       $lmail = $18;
		}
		else{last;}
	}
	my $ldom = $linea;
	$ldom =~ s/www\./:\/\//g;
	while($ldom =~ /\w/)
	{
		if($ldom =~ m/(@|\/\/|m\.)([\w.-]+(\.(a([cartu]|sia)|b([eorg]|iz)|c([chlnru]|at?|om?)|d[eko]|e([cs]|d?us?)|f[imro]|g([rt]|al|go[vb])|h[nr]|i([lt]|n(fo|t))|j(obs|p)|kr|l(at|u)|m([aex]|il|obi|useum)|n([iolz]|ame|et|ews?)|org|p([aelty]|ro)|r[osu]|s[ev]|t([kv]|el|ravel)|u[aky]|v[ae]|w(eb|s)|xxx|za|pф))+)(.*)/i)
		{
			if($dom{$2}){++$dom{$2};}else{$dom{$2}=1;}
			$ldom = $19;
		}
		else{last;}
	}
	my $lip = $linea;
	while($lip =~ /\w/)
        {

                if($lip =~ /((([1-2]?[0-9]?[0-9])\.){3}([1-2]?[0-9]?[0-9]))(.*)/)
                {
                        if($ip{$1}){++$ip{$1};}else{$ip{$1}=1;}
                        $lip = $5;
                }
                else{last;}
        }
	my $lurl = $linea;
        while($lurl =~ /\w/)
        {
                if($lurl =~ /((https?|ftp|mailto|ldap|file|news|gopher|telnet|data):\/\/(w{3}\.|m\.)?[\w.-]+\.((a([cartu]|sia)|b([eorg]|iz)|c([chlnru]|at?|om?)|d[eko]|e([cs]|d?us?)|f[imro]|g([rt]|al|go[vb])|h[nr]|i([lt]|n(fo|t))|j(obs|p)|kr|l(at|u)|m([aex]|il|obi|useum)|n([iolz]|ame|et|ews?)|org|p([aelty]|ro)|r[osu]|s[ev]|t([kv]|el|ravel)|u[aky]|v[ae]|w(eb|s)|xxx|za|pф)\.?)+[\w\.\\\-\?!\$\%\&\/=¿¡\(\)\#]*)(.*)/)
                {
                        if($url{$1}){++$url{$1};}else{$url{$1}=1;}
                        $lurl = $20;
                }
                else{last;}
        }

}


print FCD "TOTAL\tDOMINIOS\n\n";
foreach my $key (sort {$dom{$b} <=> $dom{$a} }keys  %dom)
{say FCD $dom{$key},"\t","$key";$dominios=$dominios + $dom{$key};++$dominioT;}

print FCD "\n\nTOTAL\tCORREOS\n\n";
foreach my $key (sort {$mail{$b} <=> $mail{$a} }keys  %mail){say FCD $mail{$key}, "\t" , "$key";$correos = $correos + $mail{$key};++$correoT;}

print FCD "\n\nTOTAL\tDIRECCIONES IP\n\n";
foreach my $key (sort {$ip{$b} <=> $ip{$a} }keys  %ip){say FCD $ip{$key}, "\t" , "$key";$numips=$numips + $ip{$key};++$numipsT;}

print FCD "\n\nTOTAL\tURL \n\n";
foreach my $key (sort {$url{$b} <=> $url{$a} }keys  %url){say FCD $url{$key}, "\t" , "$key";$numurl=$numurl + $url{$key};++$numurlT;}

print "\nTotal de dominios: $dominios\nTotal de dominios diferentes : $dominioT\n\n";
print "Total de correos: $correos \nTotal de correos diferentes : $correoT\n\n";
print "Total de ips: $numips \nTotal de ips diferentes: $numipsT\n\n";
print "Total de url: $numurl \nTotal de urls diferentes: $numurlT\n\n";

print  "\n\n";


close(FCG);
close(FCD);
