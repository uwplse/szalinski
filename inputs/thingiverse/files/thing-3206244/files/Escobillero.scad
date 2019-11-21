///// Escobillero /////


///// Creado por Luis Rodriguez - 2018 /////


/////Este software se distribuye bajo licencia Creative Commons Attribution-NonCommercial-ShareAlike license/////
/////https://creativecommons.org/licenses/by-nc-sa/4.0//////




// Diametro inferior (el mas fino). Bottom diameter
Diametro_Inferior = 76;

// Diametro superior (el mas grueso). Upper diameter
Diametro_Superior = 92;

// Altura (total). Total height
Altura = 198;

// Grosor de las paredes. Thickness
Grosor = 2;



/*[Hidden]*/

DI = Diametro_Inferior/2;
DS = Diametro_Superior/2;
altura = Altura-DI;

difference() {
    cylinder(altura,DS,DI,$fn=100);
    translate([0,0,-1])
    cylinder(altura+2,DS-Grosor,DI-Grosor,$fn=100);
}


difference() {
difference() {
translate([0,0,altura])
sphere(DI,$fn=100);
translate([0,0,altura])
sphere(DI-Grosor,$fn=100);
}

translate([0,0,altura-DI])
cube(DI*2,center=true);
}

