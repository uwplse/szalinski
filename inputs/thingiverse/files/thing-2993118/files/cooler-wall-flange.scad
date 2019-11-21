// Jim Dodgen 2018
// round cooler "wall flange"

thickness=14.5;    // thickness of flange
width=40;       // narrow part width of flange  

radius =390/2;  // radius of cooler
hole_size=23.3;  // shank hole size
indent=1.5;      // recess depth

// end of custom 
// these should not need to be changed
height=thickness+indent;

$fs=0.2; // def 1, 0.2 is high res
$fa=3;//def 12, 3 is very nice

translate([0,0,height]) {
    rotate([0,180,0]){
        intersection() {
            difference() { 
                translate([0,0,0]) {
                    top_radius=(hole_size/2)+1.5;
                    cylinder(h=height*2, r2=top_radius, 
                        r1=width-top_radius, center=true);
                }  
                translate([0,0,-radius]) { // cut base curve
                    rotate([0,90,0]) {
                        cylinder(h=width*2,r=radius, center=true); 
                    }       
                }
                cylinder(h=height*2,r=hole_size/2, 
                    center=true); // drill hole               
            }           
        }
    }
}