/**
 * Maceta tubería de Mario
 * Copyright 2016 - Fábrica Digital (fabricadigital.org)
 *
 * Publicado bajo licencia CC-BY-SA 4.0
 * Creative Commons: Reconocimiento - Compartir Igual 4.0 Internacional
 * http://creativecommons.org/licenses/by-sa/4.0/deed.es_ES
 *
 * Modificado el 10 de juni de 2016
 * por Eloísa Romero para Fábrica Digital
 */

// Diámetros
boca_d = 64;
tubo_d = 56;
agujero_d = 50;

// Alturas
boca_al = 25;
tubo_al = 60 ;
agujero_al = 75;

difference(){
  union(){
      // Boca
      color([0,1,0])
      cylinder(r = boca_d/2, h = boca_al, $fn=200);
      // Tubo
      color([0,1,0])
      cylinder(r = tubo_d/2, h = tubo_al, $fn=200);
  }
  // Agujero
  translate([0,0,-agujero_al/3])
  cylinder(r = agujero_d/2, h = agujero_al, $fn=200);
}

