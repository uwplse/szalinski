// Diameter of the hanger
diameter = 10.0;
// Distance of the two circle centers
distance = 13.0;
// Depth of the hole 
depth=10;
// Wall thickness of the hanger
wall=1.5;
// Diameter of the shaft of the screw
screwshaft=4;
// Diameter of the head of the screw
screwhead=6;
// Depth of the groves at the sides (0=max, 1=no groves)
shiftout = 0.2; //[0:0.05:1]

hanger(diameter=diameter, depth=depth, wall=wall, screwshaft=screwshaft, screwhead=screwhead, shiftout=shiftout, distance=distance);

module hanger(  diameter = 20.2,
                   depth=10,
                   wall=4,
                   screwshaft=4,
                   screwhead=9,
                   shiftout = 0.2,
                   distance = 13.0
                   ) {

    difference() {
            
        difference() {
            // Exterior shell
            difference() {

                hull() {
                    cylinder(r=diameter/2, h=depth);
                    translate([distance,0,0]) cylinder(r=diameter/2, h=depth);
                }
                
                hull() {
                    cylinder(r=(diameter/2)-wall, h=depth-wall);
                    translate([distance,0,0]) cylinder(r=(diameter/2)-wall, h=depth-wall);
                }
            }

            // Slot
            translate([0.5*distance,0,0]) {
                keyhole(width=screwshaft, length=0.6*distance, height=depth*3, width2=screwhead);
            }
            
        }

        //slots(depth=wall/2, radius=diameter/2, height=depth, shiftout=shiftout);

    }

}

module keyhole(width, length, height, width2) {
    shift=((width2-width)/2);
    union() {
        roundrect(width, length, height);
        translate([(length/2)-shift,0,0])
            cylinder(r=width2/2, h=height);
    }
}

module roundrect(width, length, height) {
  hull() {
      translate([-length/2,0,0])
        cylinder(r=width/2, h=height);
      translate([length/2,0,0])
        cylinder(r=width/2, h=height);
  }  
}

module slots(depth, radius, height, shiftout) {
    union() {
    for(z=[height-2*depth:-depth:0-depth]) {
        echo(z);
        translate([0,0,z])
        rotate_extrude(convexity=10)
          translate([radius+shiftout*depth,0,0])
          rotate(45)
          square(0.5*sqrt(2*depth*depth));
        
    }
}
}