//////////////////////////  Soporte para Tubo Horizontal  //////////////////////////


////////////// Creado por Luis Rodríguez para la Fundación ONCE - 2019 /////////////



//Este software se distribuye bajo licencia Creative Commons - Attribution - NonCommercial - ShareAlike license.
//https://creativecommons.org/licenses/by-nc-sa/4.0/
//Este software no tiene ningún tipo de garantía y el usuario será el único responsable de su uso



//////// Este Soporte está pensado para poder colocar un tubo horizontal en el respaldo de una silla de ruedas ////////


/////////////// Todos los parámetros están medidos en milímetros ///////////////


/////////////////////////////////////////////////////////////////////////////////////



/*[Parámetros]*/

//Diámetro del tubo vertical del respaldo de la silla
Tubo_silla = 25;        

//Anchura total del conjunto de la mordaza
Anchura = 60;           

//Altura de la mordaza que se fija al tubo vertical de la silla
Altura = 80;            

//Grosor que deseamos que tengan las paredes de la pieza
Grosor_pieza = 3;       

//Diámetro del tubo de aluminio que se va a utilizar
Tubo_trasero = 25;      

//Diámetro del tornillo que se va a utilizar
Tornillo = 5;           

//Diámetro de la cabeza del tornillo
Cabeza = 8;           

//Diámetro de la tuerca hexagonal que se va a utilizar(en su parte más ancha)
Tuerca = 9;             


/*[¿Qué piezas desea generar para su impresión?]*/

Grapa_Izqda = "SI";     //[SI:Sí,NO:No]
Grapa_Dcha = "SI";      //[SI:Sí,NO:No]
Barra_Izqda = "SI";     //[SI:Sí,NO:No]
Barra_Dcha = "SI";      //[SI:Sí,NO:No]


/*[Hidden]*/

Tubo = Tubo_trasero/2;
Silla = Tubo_silla/2;
Pared = Grosor_pieza;



///////////////////////////////// Módulos //////////////////////////////

module Cierre(){
difference() {
    cylinder(Altura,Silla+Pared,Silla+Pared,$fn=100,center=true);

        cylinder(Altura+1,Silla,Silla,$fn=100,center=true);
        translate([0,Silla,0])
            cube([Anchura+1,Tubo_silla,Altura+1],center=true);
             }

difference() {
    cube([Anchura,Pared*4,Altura],center=true);

        cylinder(Altura+1,Silla,Silla,$fn=100,center=true);
        translate([0,Silla,0])
            cube([Anchura+1,Tubo_silla,Altura+1],center=true);
        rotate([90,90,0])
        translate([-Altura/2+Tuerca,Anchura/2-Tuerca,Pared*1.5+0.1])
            cylinder(Pared,Cabeza/2,Cabeza/2,$fn=50,center=true);
        rotate([90,90,0])
        translate([Altura/2-Tuerca,Anchura/2-Tuerca,Pared*1.5+0.1])
            cylinder(Pared,Cabeza/2,Cabeza/2,$fn=50,center=true);
        rotate([90,90,0])
        translate([Altura/2-Tuerca,-Anchura/2+Tuerca,Pared*1.5+0.1])
            cylinder(Pared,Cabeza/2,Cabeza/2,$fn=50,center=true);
        rotate([90,90,0])
        translate([-Altura/2+Tuerca,-Anchura/2+Tuerca,Pared*1.5+0.1])
            cylinder(Pared,Cabeza/2,Cabeza/2,$fn=50,center=true);
        rotate([90,90,0])
        translate([+Altura/2-Tuerca,-Anchura/2+Tuerca,Pared*1.5-0.1])
            cylinder(Pared*4,Tornillo/2+0.25,Tornillo/2+0.25,$fn=50,center=true);
        rotate([90,90,0])
        translate([-Altura/2+Tuerca,-Anchura/2+Tuerca,Pared*1.5-0.1])
            cylinder(Pared*4,Tornillo/2+0.25,Tornillo/2+0.25,$fn=50,center=true);
        rotate([90,90,0])
        translate([-Altura/2+Tuerca,Anchura/2-Tuerca,Pared*1.5-0.1])
            cylinder(Pared*4,Tornillo/2+0.25,Tornillo/2+0.25,$fn=50,center=true);
        rotate([90,90,0])
        translate([+Altura/2-Tuerca,Anchura/2-Tuerca,Pared*1.5-0.1])
            cylinder(Pared*4,Tornillo/2+0.25,Tornillo/2+0.25,$fn=50,center=true);
             }
               }



module Grapa() {
difference() {
    cylinder(Altura,Silla+Pared,Silla+Pared,$fn=100,center=true);

        cylinder(Altura+1,Silla,Silla,$fn=100,center=true);
        translate([0,-Silla,0])
            cube([Anchura+1,Tubo_silla,Altura+1],center=true);
             }

difference() {
    cube([Anchura,Pared*4,Altura],center=true);

        cylinder(Altura+1,Silla,Silla,$fn=100,center=true);
        translate([0,-Silla,0])
            cube([Anchura+1,Tubo_silla,Altura+1],center=true);
        rotate([90,90,0])
        translate([-Altura/2+Tuerca,Anchura/2-Tuerca,-Pared*1.5-0.1])
            cylinder(Pared,Tuerca/2,Tuerca/2,$fn=6,center=true);
        rotate([90,90,0])
        translate([+Altura/2-Tuerca,Anchura/2-Tuerca,-Pared*1.5-0.1])
            cylinder(Pared,Tuerca/2,Tuerca/2,$fn=6,center=true);
        rotate([90,90,0])
        translate([-Altura/2+Tuerca,-Anchura/2+Tuerca,-Pared*1.5-0.1])
            cylinder(Pared,Tuerca/2,Tuerca/2,$fn=6,center=true);
        rotate([90,90,0])
        translate([+Altura/2-Tuerca,-Anchura/2+Tuerca,-Pared*1.5-0.1])
            cylinder(Pared,Tuerca/2,Tuerca/2,$fn=6,center=true);
        rotate([90,90,0])
        translate([+Altura/2-Tuerca,-Anchura/2+Tuerca,-Pared*1.5-0.1])
            cylinder(Pared*4,Tornillo/2+0.25,Tornillo/2+0.25,$fn=50,center=true);
        rotate([90,90,0])
        translate([-Altura/2+Tuerca,-Anchura/2+Tuerca,-Pared*1.5-0.1])
            cylinder(Pared*4,Tornillo/2+0.25,Tornillo/2+0.25,$fn=50,center=true);
        rotate([90,90,0])
        translate([-Altura/2+Tuerca,Anchura/2-Tuerca,-Pared*1.5-0.1])
            cylinder(Pared*4,Tornillo/2+0.25,Tornillo/2+0.25,$fn=50,center=true);
        rotate([90,90,0])
        translate([+Altura/2-Tuerca,Anchura/2-Tuerca,-Pared*1.5-0.1])
            cylinder(Pared*4,Tornillo/2+0.25,Tornillo/2+0.25,$fn=50,center=true);
             }
               }



module Barra_primaria(){
    rotate([0,90,0]) {
    
        difference() {
        cylinder(Anchura,Tubo+Pared,Tubo+Pared,$fn=100,center=true);
            cylinder(Anchura+1,Tubo,Tubo,$fn=100,center=true);
                     }
                       
                     }
                       }


module Barra() {
difference() {
    translate([0,-Tubo-Pared*2-Silla,Tubo/2])
        Barra_primaria();
    
        translate([0,-Silla-Tubo-Pared*2,Tubo*1.5+Pared*2+2])
            cube([Anchura+1,Tubo*2+Pared*2,Tubo*2+Pared*2],center=true);
             }

               }


module Junta() {
difference() {
translate([-Anchura/2,-Silla-Pared*2-Tubo,-Tubo/2-Pared])
    cube([Anchura,Silla+Pared*2+Tubo,Tubo+Pared*2+2]);

    rotate([0,90,0]) 
    translate([-Tubo/2,-Tubo-Pared*2-Silla,0]) 
        cylinder(Anchura+1,Tubo,Tubo,$fn=100,center=true);
    cylinder(Altura+1,Silla,Silla,$fn=100,center=true);
              }
               }
              
module Tope_Izqdo() {
difference() {
    rotate([0,90,0]) 
    translate([-Tubo/2,-Tubo-Pared*2-Silla,-Anchura/2+Pared/2]) 
        cylinder(Pared,Tubo,Tubo,$fn=100,center=true);
    translate([-Anchura/2+Pared/2,-Silla-Tubo-Pared*2,Tubo])
        cube([Pared+1,Tubo*2+Pared*2,Tubo],center=true);
              }           
               }
               
module Tope_Dcho() {
difference() {
    rotate([0,90,0]) 
    translate([-Tubo/2,-Tubo-Pared*2-Silla,Anchura/2-Pared/2]) 
        cylinder(Pared,Tubo,Tubo,$fn=100,center=true);
    translate([Anchura/2-Pared/2,-Silla-Tubo-Pared*2,Tubo])
        cube([Pared+1,Tubo*2+Pared*2,Tubo],center=true);
              }
                    }


if(Grapa_Izqda=="SI")
        translate([-Anchura,1,0]) 
        Grapa();
        
if(Grapa_Dcha=="SI")
        translate([Anchura,1,0]) 
        Grapa();

if(Barra_Izqda=="SI")
        translate([-Anchura,-1,0]){ 
        Cierre();
        Barra();
        Junta();
        Tope_Izqdo();
        }

if(Barra_Dcha=="SI")
        translate([Anchura,-1,0]){ 
        Cierre();
        Barra();
        Junta();
        Tope_Dcho();
        }



