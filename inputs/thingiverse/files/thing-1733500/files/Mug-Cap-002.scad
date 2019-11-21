//Mug outer diameter
mug_diameter=86;

//Mug thickness
mug_thickness=4;

//Cap wall thickness
wall_thick=2.4;

//Aperture numbers
An="one";//[one,two]

//Aperture width
A_angle=10;//[5:1:20]

//Apertures positions
Ap_angle=110;//[65:5:295]

tolerance=0.15;//[0:0.05:0.5]
definition=60;//[60:Low,90:Medium,120:High]

///////

$fn=definition;

module section() {
    difference() {
        union() {
            translate([mug_diameter/2 - mug_thickness/2,wall_thick + tolerance,0]) circle(d=mug_thickness + wall_thick*2 + tolerance*2);
            square([mug_diameter/2 + wall_thick + tolerance,wall_thick]);
        }

        translate([mug_diameter/2 - mug_thickness/2,wall_thick + tolerance,0]) {
            circle(d=mug_thickness+2*tolerance);
            translate([-tolerance - mug_thickness/2,-2*mug_thickness,0]) square([mug_thickness + tolerance*2,2*mug_thickness]);
            }
            translate([mug_diameter/2 - mug_thickness/2 - 2*mug_thickness,-2*mug_thickness,0]) square([4*mug_thickness,2*mug_thickness]);
        
    }
}

module ouverture(a) {
    difference() {
        hull() {for(i=[-1,1]) rotate([0,0,i*a]) translate([mug_diameter/2 - wall_thick,0,0]) cylinder(r=2.5*wall_thick + mug_thickness/2,h=4*mug_thickness,center=true);}
        cylinder(r=mug_diameter/2 - wall_thick - (2.5*wall_thick + mug_thickness/2),h=5*mug_thickness,center=true);
    }
}


difference() {
    rotate_extrude() section();
    ouverture(A_angle);
    translate([-mug_diameter/5,0,0]) cylinder(d=3,h=3*wall_thick,center=true);
    if (An=="two") {
        rotate([0,0,Ap_angle]) ouverture(A_angle);
    }
    else {}
}