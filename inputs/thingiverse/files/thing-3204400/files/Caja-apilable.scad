///// Cajon Extraible y Parametrizable con Compartimentado /////


///// Creado por Luis Rodriguez - 2018 /////


/////Este software se distribuye bajo licencia Creative Commons Attribution-NonCommercial-ShareAlike license/////
/////https://creativecommons.org/licenses/by-nc-sa/4.0//////




/* [Dimensiones. Measurements] */

// Anchura de la caja (Exterior). Wide
Ancho = 75;

// Profundidad de la caja (Exterior). Deep
Profundidad = 200;

// Altura de la caja (Total). Heigh
Alto = 40;

// Numero de particiones del cajon a lo largo. Lenght divisions
N_Largo = 6;

// Numero de particiones del cajon a lo ancho. Wide divisions 
N_Ancho = 2;

// Grosor de las paredes externas. External walls thickness
Grue = 1.5;

// Grosor de las paredes internas. Internal walls thickness
GrueC = 1;




/* [Elementos mostrados. Shown components] */

// Muestra las guias del lado izquierdo. Left guides
GuiIz = "SI";     //[SI,NO]

// Muestra las guias del lado derecho. Right guides
GuiDe = "SI";     //[SI,NO]

// Muestra las guias superiores. Upper guides
GuiSu = "SI";     //[SI,NO]

// Muestra las guias inferiores. Lower guides
GuiIn = "SI";     //[SI,NO]

// Muestra la caja de alojamiento. Box
Caja = "SI";      //[SI,NO]

// Muestra el cajon. Drawer
CajonS = "SI";    //[SI,NO]

// Muestra el tirador para el cajon. Drawer handle
Tirador = "SI";   //[SI,NO]


/*[Colores (a efectos de previsualizacion). Colors]*/

//Color de las guias "hembra"
color1 = "yellow";  //[yellow, blue, red, orange, green, brown, pink, grey, violet]

//Color de las guias "macho"
color2 = "blue";    //[yellow, blue, red, orange, green, brown, pink, grey, violet]

//Color de la caja
color3 = "red";     //[yellow, blue, red, orange, green, brown, pink, grey, violet]

//Color del cajon
color4 = "orange";  //[yellow, blue, red, orange, green, brown, pink, grey, violet]



////////////////////////////////////////////// Caja //////////////////////////////////////////
module Caja() {
    translate([0,0,Profundidad/2])
        union() {
            difference() {
                cube([Ancho,Alto,Profundidad],center = true);
                translate([0,0,Grue])
                cube([Ancho-Grue*2,Alto-Grue*2,Profundidad],center = true);
            }
            translate([0,Alto/2-Grue*1.5,Profundidad/2-Grue-2.5])
            cube([Ancho-Grue*5,1.5,2],center = true);
        }
}


/////////////////////////////////////// Guias inferiores /////////////////////////////////////
module GuiIn() {
    translate([0,0,Profundidad/2])
        union() {
            translate([-Ancho/2+3,-Alto/2-1.19,0])
                cylinder(Profundidad,1.2,1.2,center = true,$fn = 50);
            translate([Ancho/2-3,-Alto/2-1.19,0])
                cylinder(Profundidad,1.2,1.2,center = true,$fn = 50);
        }
}


/////////////////////////////////////// Guias derechas //////////////////////////////////////
module GuiDe() {
    translate([0,0,Profundidad/2])
        union() {
            translate([Ancho/2+1.19,-Alto/2+3,0])
                cylinder(Profundidad,1.2,1.2,center = true,$fn = 50);
            translate([Ancho/2+1.19,Alto/2-3,0])
                cylinder(Profundidad,1.2,1.2,center = true,$fn = 50);
        }
}


////////////////////////////////////// Guias izquierdas /////////////////////////////////////
module GuiIz() {
    translate([0,0,Profundidad/2])
        union() {
            translate([-Ancho/2-1.7,Alto/2-3,0])
                union() {    
                    difference() {
                        difference() {
                            cylinder(Profundidad,2.5,2.5,center = true,$fn = 50);
                            cylinder(Profundidad+2,1.55,1.55,center = true,$fn = 50);
                        }
                        translate([-4.2,0,0])
                            cube([6,6,Profundidad+2],center = true);
                    }
                }

    translate([-Ancho/2-1.7,-Alto/2+3,0])
        union() {    
            difference() {
                difference() {
                    cylinder(Profundidad,2.5,2.5,center = true,$fn = 50);
                    cylinder(Profundidad+2,1.55,1.55,center = true,$fn = 50);
                }
                    translate([-4.2,0,0])
                        cube([6,6,Profundidad+2],center = true);
            }
        }
        }
}

////////////////////////////////////// Guias superiores /////////////////////////////////////
module GuiSu() {
    translate([0,0,Profundidad/2])
        union() {
            translate([-Ancho/2+3,Alto/2+1.7,0])
                union() {    
                    difference() {
                        difference() {
                            cylinder(Profundidad,2.5,2.5,center = true,$fn = 50);
                            cylinder(Profundidad+2,1.55,1.55,center = true,$fn = 50);
                        }
                        translate([0,4.2,0])
                            cube([6,6,Profundidad+2],center = true);
                    }
                }

    translate([Ancho/2-3,Alto/2+1.7,0])
        union() {    
            difference() {
                difference() {
                    cylinder(Profundidad,2.5,2.5,center = true,$fn = 50);
                    cylinder(Profundidad+2,1.55,1.55,center = true,$fn = 50);
                }
                translate([0,4.2,0])
                    cube([6,6,Profundidad+2],center = true);
            }
        }
        }
}



////////////////////////////////////////////// Cajon //////////////////////////////////////////
module Cajon() {
    difference() {
        cube([Profundidad-Grue-1,Ancho-Grue*2-1,Alto-Grue*2-1],center = true);
        translate([0,0,Grue])
            cube([Profundidad-Grue*3-1,Ancho-Grue*4-1,Alto-Grue*2-1],center = true);
    }   

}


module CajonS() {
    translate([0,0,(Alto-Grue*2-1)/2])
        union() {
            difference() {
                Cajon();
                translate([-Profundidad/2+Grue*2-Grue/2,0,(Alto-Grue*2-1)/2-0.9])
                    cube([Grue+2,Ancho-Grue*5,2],center = true);
            }

            for(x=[-(Profundidad-Grue*2-1)/2-GrueC/2:(Profundidad-Grue*2-1)/N_Largo:(Profundidad-Grue*2-1)/2-GrueC/2])
            translate([x+GrueC/2, 0, -0.4])
                cube([GrueC, Ancho-Grue*4-1, Alto-Grue*2-5], center=true);
            translate([-(Profundidad-Grue-1)/2+Grue/2, 0, 0])
                cube([Grue, Ancho-Grue*4-1, Alto-Grue*2-1], center=true);

            for(y=[-(Ancho-Grue*2-0.5)/2+GrueC/2:(Ancho-Grue*2-2.5)/N_Ancho:(Ancho-Grue*2-0.5)/2-GrueC/2])
            translate([0, y+GrueC/2, -0.4])
                cube([Profundidad-Grue*2, GrueC, Alto-Grue*2-5], center=true);

        }
}




module Tirador() {
    translate([Profundidad/2-4.5,-9.5,2.5])
        linear_extrude(height = 5,center = true)
            text("D",20);
}


if(GuiIz=="SI")
        color(color1){
            translate([0,Alto/2+Ancho/2,0])
                GuiIz();
        }


if(GuiDe=="SI")
        color(color2){
            translate([0,Alto/2+Ancho/2,0])
                GuiDe();
        }
        

if(GuiSu=="SI")
        color(color1){
            translate([0,Alto/2+Ancho/2,0])
                GuiSu();
        }



if(GuiIn=="SI")
        color(color2){
            translate([0,Alto/2+Ancho/2,0])
                GuiIn();
        }


if(Caja=="SI")
        color(color3){ 
            translate([0,Alto/2+Ancho/2,0])
                Caja();
        }



if(CajonS=="SI")
        color(color4){
           translate([0,-Alto/2-Ancho/2,0]) 
                CajonS();
        }


if(Tirador=="SI")
        color(color4){
           translate([0,-Alto/2-Ancho/2,0]) 
                Tirador();
        }




