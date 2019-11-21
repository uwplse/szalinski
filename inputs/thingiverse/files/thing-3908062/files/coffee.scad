/* now with hints for Thingiverse Customiser */

// cup loop top diameter
d1 = 82.5;  

// cup loop bottom diameter
d2 = 71.5;

// handlebar diameter, also height between top and bottom diameters
hd = 25;

// thickness of cup loop
th = 5;

// clamp length 
xo = 45;

// clamp offset 
yo = 10;

// clamp screw hole diameter
sd = 3;

/* [Hidden] */

xr = th/2;
$fn=100;

rotate([0,180,0]) {
  difference() {
    union() {
        
        // cup loop
        rotate_extrude() hull() {
            translate([d1/2+xr,+hd/2,0]) circle(r=xr);
            translate([d2/2+xr,-hd/2,0]) circle(r=xr);
        };

        // clamp
        difference() {
            union() {
                translate([0,d1/4+d2/4+yo+xr,0]) rotate([0,90,0]) cylinder(h=xo,d=hd+xr*2,center=true);        
                translate([0,d1/4+d2/4+5,0]) cube([xo,yo*2,hd+xr*2],center=true);
                translate([-xo/4,d1/4+d2/4+yo,-hd/2-xr-1]) rotate([90,90,0]) cylinder(h=xo/2,d=sd*4,center=true);
                translate([+xo/4,d1/4+d2/4+yo,-hd/2-xr-1]) rotate([90,90,0]) cylinder(h=xo/2,d=sd*4,center=true);
            }
    
            // cup clearance        
            cylinder(d1=d2-(d1-d2)/2+xr*2,d2=d1+(d1-d2)/2+xr*2,h=2*hd,center=true);
            
            // clamp slot
            translate([0,d1/4+d2/4+yo+xr,-20]) cube([xo+2,2,xo+2],center=true);
            
            // 
            translate([-xo/4,d1/4+d2/4+yo+1,-hd/2-xr-1]) rotate([90,90,0]) cylinder(h=xo/2,d=sd,center=true);
            translate([xo/4,d1/4+d2/4+yo+1,-hd/2-xr-1]) rotate([90,90,0]) cylinder(h=xo/2,d=sd,center=true);
    
        }
    }
    
    // bar clearance
    translate([0,d1/2+yo,0]) rotate([0,90,0]) cylinder(d=hd,h=100,center=true);
  }
}
