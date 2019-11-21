// length of base plate (mm)
length = 20;

// thickness of base plate (mm)
thick = 3;

// width of carrier profile (mm)
width = 20;

// diameter of mounting screw (mm)
screw_dia = 5;


// diameter of LED carrier hole (mm) - e.g. a square profile of 10x10mm has 14.2mm diameter = ( 10 * sqrt(2) )
dia = 14.2;

// width of rim around hole (mm)
rim = 2.5;

// length of slot anchor (mm)
lsa = 3;

// protrusion of profile slot anchor into profile (mm)
deep = 1.5;

// width of profile slot anchor (mm)
slit = 6;

module slot() {
    points = [[0,0],[0,lsa+deep],[deep,lsa],[deep,0]];

rotate( [90,0,-90] )
linear_extrude( slit)
polygon( points, convexity = 1 );
}


module clip() {

translate([0,-1 * thick ,0] ) {

translate([( width + slit )/2,0,0])
slot();
    translate([width/2 -slit/2, 0, length] )
    rotate([0,180,0])
    slot();

difference() {
cube( [width, thick, length ] );
    translate( [width/2, thick + 1,length/ 2 ])
    rotate( [90,90,0] )
    cylinder( thick + 2,screw_dia/2, screw_dia/2, $fn = 7 );
    }
}

difference() {
hull() {
    translate([ width/2 + (dia/2) + rim , (dia/2) +1 , 0] ) 
    cylinder(4, (dia/2)+rim, (dia/2)+rim, $fn = 60);
    translate([0,-1 * thick,0])
    cube([ width, thick , 4]);
}

    translate([ width/2 + (dia/2) + rim , (dia/2) +1 , -1] ) 
    cylinder(6, (dia/2), (dia/2), $fn = 60);
}

}

clip();

mirror([0,1,0])
translate([0, 3 * ( thick + deep ),0])
clip();