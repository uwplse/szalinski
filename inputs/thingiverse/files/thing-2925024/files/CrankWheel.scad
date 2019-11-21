
// Crank Diameter (in)
od  = 4;

// Crank Thickness (in)
height = .6;

// Hex Nut Diameter (in)
// Measured from flat part of nut.
hnd = .795;

or = od/2;

include <MCAD/units.scad>;

scale([inch, inch, inch]) {

    difference(){
    union(){
        difference() {
            cylinder(height,or,or, $fn=90);
            translate([0,0,-.1]){
                cylinder(1,r=or*.8, $fn=90);
            }
        }
        for(i=[0:5]) {
            rotate(i*72){
               translate([0,-.25,0]) 
                  cube([or*.9, .5, height*.5]);
            }
        }
        
        // inner cylinder
        cylinder(height*.5,r=or*.58, $fn=90);
        // 
        cylinder(height,r=.9, $fn=90);
        translate([0,0,height]) {
            cylinder(.4,.9,1.6/2, $fn=90);
       }
        translate([or-.25,0,0]) cylinder(height,r=.5, $fn=90);
    }
    union(){
        // handle countersink
        translate([or-.25,0,height-.1]) cylinder(.9,.35,.35, $fn=90);
        // handle hole
        translate([or-.25,0,-.1]) cylinder(50,.13,.13, $fn=90);      
        // screw hole
        translate([0,0,-.1]) {cylinder(50,.2/2,.2/2, $fn=90);}
        // key bolt
        translate([0,0,height+.4-.56]) {
            cylinder(.57, r=hnd/2, $fn=6);
        }
    }
}
}