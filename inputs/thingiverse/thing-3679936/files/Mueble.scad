square = 4;

width = 500;

border = 50;

baseHeight = 200;

module construct(square, width, border, baseHeight) { 
    position1 = 0;
    position2 = -width + border;
    
    translate([-width, 0, 0])
        cube([width * 2, width, baseHeight]);
    translate([0, 0, baseHeight - border])
        for (i=[0 : square - 1]){
            translate([(i % 2 == 0 ? position1 : position2), 0, (width - border)*i])
            union(){   
                if (i != 0) {
                    //-- Parte inferior
                    cube([width, width, border]);
                }
                //-- Parte superior
                translate([0, 0, width - border ])
                    cube([width, width, border]);;
                //-- Parte izquierda
                translate([0 , 0, border])
                    cube([border, width, width - border * 2]);
                //-- Parte derecha
                translate([width - border, 0, border])
                    cube([border, width, width - border * 2]);
            }
        }
}

construct(square, width, border, baseHeight);

