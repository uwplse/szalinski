//////////////////////////  Soporte para Carrito / Maleta  //////////////////////////


////////////// Creado por Luis Rodríguez para la Fundación ONCE - 2019 /////////////



//Este software se distribuye bajo licencia Creative Commons - Attribution - NonCommercial - ShareAlike license.
//https://creativecommons.org/licenses/by-nc-sa/4.0/
//Este software no tiene ningún tipo de garantía y el usuario será el único responsable de su uso



//////////Este Soporte está pensado para poder arrastrar detrás de la silla de ruedas un carrito o una maleta de forma autónoma. Para ello, el usurio tiene que poder anclar el carrito o la maleta de forma autónoma, por lo que en principio debe ser un usuario de silla de ruedas activo//////////


///////////////Todos los parámetros están medidos en milímetros///////////////


/////////////////////////////////////////////////////////////////////////////////////

/*[Parámetros]*/


//Diámetro del tubo de la silla de ruedas a donde se va a fijar el soporte
Diametro = 25;      //[20:1:35]

//Anchura del soporte
Ancho = 20;         //[15:1:30]

//Grosor de las paredes del soporte
Grosor = 8;         //[6:0.5:10]

//Diámetro del tornillo que se va a utilizar
Tornillo = 5;       //[4:1:6]

//Diámetro de la cabeza del tornillo
Cabeza = 8;         //[6:1:12]

//Diámetro de la tuerca hexagonal que se va a utilizar (en su parte más ancha)
Tuerca = 9;         //[5:1:12]

//Diámetro del asa del carro o maleta a transportar
Dia_Carro = 32;     //[15:1:45]

//Separación entre la mordaza y el enganche del carro
Separacion = 10;    //[0:5:25]




/*[Hidden]*/

Tubo = Diametro/2;
Carro = Dia_Carro/2;



///////////////////////////////////Módulos///////////////////////////////////


module Mordaza() {
hull() {
    cylinder(Ancho,Tubo+Grosor,Tubo+Grosor,$fn=50,center=true);
        translate([Diametro-Grosor/2,0,0])
        rotate([0,90,90])
            cylinder(Diametro+Grosor*2,Ancho/2,Ancho/2,$fn=50,center=true);
        }
                 }


module Carrito() {
translate([-Tubo-Dia_Carro/2-Grosor*2-Separacion,0,0])
    cylinder(Ancho,Carro+Grosor,Carro+Grosor,$fn=50,center=true);
                  }


module Base() {
hull() {
    Mordaza();
    Carrito();
        }
               }


difference() {
Base();
    
    translate([-Tubo-Dia_Carro/2-Grosor*2-Separacion,0,0])
        cylinder(Ancho+1,Carro,Carro,$fn=50,center=true);


    translate([-Tubo-Dia_Carro/2-Separacion/2-3,Carro,0])
    rotate([0,0,45])
        cube([Carro*3,Carro,Ancho+1],center=true);


    cylinder(Ancho+1,Tubo,Tubo,$fn=50,center=true);

    translate([Diametro-Grosor/2,0,0])
    rotate([0,90,90])
        cylinder(Diametro+Grosor*4+1,Tornillo/2+0.2,Tornillo/2+0.2,$fn=50,center=true);

    rotate([90,90,0])
    translate([0,Diametro-Grosor/2,+Tubo+Grosor])
        cylinder(10,Cabeza/2,Cabeza/2,$fn=50,center=true);

    translate([Diametro,0,0])
        cube([Diametro+Grosor*2,Grosor*2,Ancho+1],center=true);

    rotate([90,0,0])
    translate([Diametro-Grosor/2,0,-Tubo-Grosor])
        cylinder(10,Tuerca/2,Tuerca/2,$fn=6,center=true);

             }










