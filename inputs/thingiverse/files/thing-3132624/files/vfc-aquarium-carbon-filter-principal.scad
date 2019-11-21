//parametros
lMin = 58;
lMax = 64.88; //63
comp = 117;
altura = 2;
bordaL = 15;

//makePrincipal();
makeTopo();
//makeTela();
//makeTelaFechada();


// --------------------------------------------
module makePrincipal(addEncaixe = true) {
    difference() {
    union() {
        orelha();
        
        body();
        if (addEncaixe == true) addEncaixe();

        color("blue")
        translate([6,5,1])
        honeycomb(comp-bordaL, lMax-bordaL, altura, 2, 0.8); 
    }

    bodyCorte();
    }
}

module makeTopo() {
    //color("black")
    //translate([0,0,2])
    bodyTopo();
}

module makeTela() {
    makePrincipal(false);
}

module makeTelaFechada() {
    bodyExterno();
}


module orelha() {
translate([comp-5,(lMin/2),0])
difference() {
    cylinder(h=altura, r=20/2, $fn=60);
    
    translate([-30,-15,-1])
    cube([30,30,5]);
}
}

module addEncaixe() {
iMax = lMax - bordaL - (4+2);
icomp = comp - bordaL - 5;

union() {
    difference() {

    color("red")
    translate([bordaL-(9-2),bordaL-(10-2),0])
    cube([icomp,iMax,15]);

    color("blue")
    translate([bordaL-(9-4),bordaL-(10-4),-2])
    cube([icomp - 4,iMax - 4,19]);

    }
    
//traves
translate([bordaL+25,bordaL-(10-2),0])
cube([0.8,iMax,15]);

translate([bordaL+60,bordaL-(10-2),0])
cube([0.8,iMax,15]);

translate([bordaL-7,(lMin/2),0])
cube([icomp,0.8,15]);
}
    
}


module bodyTopo() {
iMax = lMax - bordaL - (4+2) + 2.4;
icomp = comp - bordaL - 5 + 2.4;

difference() {

color("red")
translate([bordaL-13,bordaL-14,0])
cube([icomp+10,iMax+10,3]);

color("blue")
translate([bordaL-7.2,bordaL-8.2,-2])
cube([icomp-2,iMax-2,6]);

}
    
}

module bodyCorte() {
    brd = 5;
    dDif = 2;
    eDif = 11.9;
    
    translate([0,0,-1])
    rotate([0,-1,0]) {
        translate([-2,-dDif,2])
        cube([lMax+2,brd+dDif,altura*2]);

        translate([-2,lMax-eDif,2])
        cube([lMax+2,brd+dDif,altura*2]);
    }
}

module body() {
    difference() {
        bodyExterno();
        bodyInterno();
    }
}

module bodyExterno() {
    linear_extrude(height=altura, center=false, convexity=10)
    polygon_body();
}

module bodyInterno() {
    iMax = lMax - bordaL - (4+2);
    icomp = comp - bordaL - 5;

    translate([bordaL-(9-2),bordaL-(10-2),-1])
    cube([icomp,iMax,altura*2]);
}

module cruzado() {
    color("red")
    cube([5,comp,altura]);
}

module polygon_body(diferenca = 0) {
    diferenca = diferenca * 2;
    lMin = (lMin - diferenca);
    lMax = (lMax - diferenca);
    comp = 117 - (diferenca * 1.2);
    lDif = (lMax - lMin) / 2;

    polygon([[0,0],[comp,-lDif],[comp,lMin+lDif],[0,lMin]]);
}






module hc_column(length, cell_size, wall_thickness) {
        no_of_cells = floor(length / (cell_size + wall_thickness)) ;

        for (i = [0 : no_of_cells]) {
                translate([0,(i * (cell_size + wall_thickness)),0])
                         circle($fn = 6, r = cell_size * (sqrt(3)/3));
        }
}

module honeycomb (length, width, height, cell_size, wall_thickness) {
        no_of_rows = floor(1.2 * length / (cell_size +
wall_thickness)) ;

        tr_mod = cell_size + wall_thickness;
        tr_x = sqrt(3)/2 * tr_mod;
        tr_y = tr_mod / 2;
        off_x = -1 * wall_thickness / 2;
        off_y = wall_thickness / 2;
        linear_extrude(height = height, center = true, convexity = 10,
twist = 0, slices = 1)
                difference(){
                        square([length, width]);
                        for (i = [0 : no_of_rows]) {
                                translate([i * tr_x + off_x, (i % 2) *
tr_y + off_y,0])
                                        hc_column(width, cell_size,
wall_thickness);
                        }
                }
}

