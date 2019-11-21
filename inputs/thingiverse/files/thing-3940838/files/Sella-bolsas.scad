// Bags Sealer 
//Designed by Federico Bitonte https://federico.bitonte.com 

//Sellabolsas
//Diseñado por Federico Bitonte https://federico.bitonte.com


//What part to print? - Que pieza imprimir?
print = "both"; //[ring,lid,both]

//Total diameter - Diámetro total
total_diameter = 40;
//Lid height - Altura de la tapa
lid_height = 20;
//lid wall thickness - Grosor de la pared de la tapa
lid_wall_thickness = 3;
//Roof lid thickness - Grosor del techo de la tapa
lid_top_thickness = 2;
//Ring wall thickness - Grosor de la pared del anillo
ring_wall_thickness = 2;
//Gap between parts - Espacio intermedio entre las piezas
space_btw = 0.5;
//Ring brinm height to pull to open - Borde inferior del anillo para tirar para abrir
pullBrim = 10;
//Steps
$fn = 100;

//Text - Leyenda
brandName = "René";
//Font zise - Tamaño de la tipografía
brandFontSize = 6;
//Font spacing - Espacio entre caracteres
brandFontSpacing = 1.1;
//Font family - Tipografía
brandFont = "la chata:style=Bold"; //["la chata:style=Bold", "Arial:style=Bold", "Calibri", "Calibri:style=Bold"]
//Brand mark depth - Profundidad del texto
brandProf = 0.5;
//Brand horizontal offset - Ajuste de posición horizontal para el texto
leyendaH = 30;
//Brand vertical offset - Ajuste de posición vertical para el texto
leyendaV =3;


//Calculations - Calculos
//Ring diameter - Diametro del anillo
ringD = total_diameter-(lid_wall_thickness*2)-(space_btw*2);
//Ring Height - Alto del anillo
ringH = lid_height-lid_top_thickness+pullBrim;


module ring(){
    
    difference(){
        cylinder(r=ringD/2, h=ringH);
        
        translate ([0,0,-5])
        cylinder(r=ringD/2-ring_wall_thickness, h=ringH+10);
    }
}

module ring_border(){
    
    difference(){
        cylinder(r=ringD/2+lid_wall_thickness+space_btw, h=pullBrim);
        translate([0,0,-5])
        cylinder(r=ringD/2, h=pullBrim+10);
        
    }
}

module lid(){
    
    difference(){
        cylinder(r=total_diameter/2, h=lid_height);
        
        translate([0,0,lid_top_thickness])
        cylinder(r=total_diameter/2-lid_wall_thickness, h=lid_height);
    }
    
}

// Branding
module leyenda() {

//rotate([180,0,0])
rotate([180,180,0])
//translate([brandDistantX,brandDistantY,thickness-brandProf])

    //color ([1,0,0])
    linear_extrude(1)
    text(brandName, size=brandFontSize, direction="ltr", spacing=brandFontSpacing, font=brandFont);
}





module print(){
    
    difference(){
    union(){
        if (print == "ring") {
            ring();
            ring_border();
        }
        
        if (print == "lid") {
            difference(){
                lid();
                translate ([leyendaH,leyendaV,brandProf])
                    leyenda();
            }
        }
        
        if (print == "both") {
            ring();
            ring_border();
            
            difference(){
                translate ([total_diameter+10,0,0])
                    lid();
                translate ([ringD+leyendaH,leyendaV,lid_top_thickness-brandProf])
                   leyenda();
            }
        }
    }
    }
}


print();




