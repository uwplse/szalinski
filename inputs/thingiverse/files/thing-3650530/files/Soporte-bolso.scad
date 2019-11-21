//////////////////////////  Soporte para Carrito / Maleta  //////////////////////////


////////////// Creado por Luis Rodríguez para la Fundación ONCE - 2019 /////////////



//Este software se distribuye bajo licencia Creative Commons - Attribution - NonCommercial - ShareAlike license.
//https://creativecommons.org/licenses/by-nc-sa/4.0/
//Este software no tiene ningún tipo de garantía y el usuario será el único responsable de su uso



//////// Este Soporte está pensado para poder sujetar un bolso pequeño tanto por delante como por detrás de las piernas de la persona dependiendo de la orientación con la que se fijen los soportes ////////


/////////////// Todos los parámetros están medidos en milímetros ///////////////


/////////////////////////////////////////////////////////////////////////////////////

/*[Parámetros]*/


//Diámetro del tubo de la silla de ruedas a donde se va a fijar el soporte
Diametro = 25;      //[20:1:35]

//Anchura del soporte
Ancho = 20;         //[15:1:40]

//Grosor de las paredes del soporte
Grosor = 6;         //[5:0.5:10]

//Diámetro del tornillo que se va a utilizar
Tornillo = 5;       //[4:1:6]

//Diámetro de la cabeza del tornillo
Cabeza = 8;         //[6:1:12]

//Diámetro de la tuerca hexagonal que se va a utilizar (en su parte más ancha)
Tuerca = 9;         //[5:1:12]

//Hueco necesario para que quede recogida la correa del bolso
Hueco_Bolso = 15;   //[10:1:30]

//Separación entre la mordaza y el enganche del bolso
Separacion = 0;    //[0:5:25]




/*[Hidden]*/

Tubo = Diametro/2;
Bolso = Hueco_Bolso/2;



/////////////////////////////////// Módulos ///////////////////////////////////


module Mordaza() {
hull() {
    cylinder(Hueco_Bolso,Tubo+Grosor,Tubo+Grosor,$fn=100,center=true);
        translate([Diametro-Grosor/2,0,0])
        rotate([0,90,90])
            cylinder(Diametro+Grosor*2,Tuerca+1,Tuerca+1,$fn=100,center=true);
        }
                 }


module Bol() {
translate([-Tubo-Hueco_Bolso/2-Grosor-Separacion,0,0])
    rotate([90,0,0])
    cylinder(Ancho,Bolso+Grosor,Bolso+Grosor,$fn=100,center=true);
                  }


module Base() {
hull() {
    Mordaza();
    Bol();
        }
               }


difference() {
Base();
    
    rotate([90,0,0])
    translate([-Tubo-Hueco_Bolso/2-Grosor-Separacion,0,0])
        cylinder(Ancho+20,Bolso,Bolso,$fn=100,center=true);


    translate([-Tubo-Hueco_Bolso/2-Separacion-Grosor/4,0,Bolso+6])
    rotate([0,20,0])
        cube([Bolso/1.5,Diametro*2,Ancho+1],center=true);


    cylinder(Ancho+45,Tubo,Tubo,$fn=100,center=true);

    translate([Diametro-Grosor/2,0,0])
    rotate([0,90,90])
        cylinder(Diametro+Grosor*4+1,Tornillo/2+0.2,Tornillo/2+0.2,$fn=100,center=true);

    rotate([90,0,0])
    translate([Diametro-Grosor/2,0,-Tubo-Grosor])
        cylinder(10,Cabeza/2,Cabeza/2,$fn=100,center=true);

    translate([Diametro,0,0])
        cube([Diametro+Grosor*2,Grosor*2,Ancho+25],center=true);

    rotate([90,90,0])
    translate([0,Diametro-Grosor/2,+Tubo+Grosor])
        cylinder(10,Tuerca/2,Tuerca/2,$fn=6,center=true);

             }



