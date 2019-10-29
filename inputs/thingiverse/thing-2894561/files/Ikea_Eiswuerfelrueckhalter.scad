dInnen=56;
dAussen=68;
h1=3;
h2=1.5;
$fn=50;




difference() {
    union() {
        cylinder(d=dInnen, h=h1);
        
        translate([0,0,-h2])
        cylinder(d=dAussen, h=h2);
    }
    
    //Halbmond
    difference() {
        translate ([dInnen-18, 0, -10])
        cylinder(d=dInnen/2, h=20);
        
        translate([0,0,-h2])
        cylinder(d=dInnen-5, h=h1+h2);
    }
    
    //Schlitz
    translate ([dInnen/2-10, -2, -10])
    cube([40,4,20]);

    //Luftloch
    rotate([0,0,20])
    translate ([-dInnen/2, 0, -10])
    cylinder(d=2, h=20);
 
    rotate([0,0,-20])
    translate ([-dInnen/2, 0, -10])
    cylinder(d=2, h=20);
}

