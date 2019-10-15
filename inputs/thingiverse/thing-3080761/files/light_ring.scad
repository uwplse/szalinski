/* Mount for a light-ring around webcamera or similar.

   This work is licenses under Create Common Attribution License 4.0.
   For the full license text see:
   
       https://creativecommons.org/licenses/by/4.0/legalcode
       
   For an abridged, human readable, license text see:
   
       https://creativecommons.org/licenses/by/4.0/
       
   Have fun!
   
   Mathias Broxvall, 2018-09-02
*/

inner_r = 30/2;             //< Radius of hole for camera
outer_r = inner_r + 10;     //< Outer radius of center part
thick = 3;
pin_r = 1;                  //< Thickness of LED legs. Increase if holes are too small
pin_x = inner_r+5;
pin_y1 = +1.5;
pin_y2 = -1.5;
pins = 9;                   //< Number of LEDs 
edge = 2;
inner_h = 5;

translate([0,0,-30])
diffuser();
front();

translate([0,0,30])
rotate(180,[1,0,0])
back();

module diffuser() {
    ring(inner_r, outer_r+1, 0.75);
    ring(outer_r+0.25, outer_r+2.0, 15);
}

module ring(inner, outer, thick) {
    difference() {
        cylinder(r=outer, h=thick, $fa=1);
        translate([0,0,-1])
        cylinder(r=inner, h=thick+2, $fa=1);
    }
}

module front() {
    difference() {
        ring(inner_r, outer_r, thick);
        for (rot = [0:360/pins:360]) {
            rotate(rot, [0,0,1]) {
                translate([pin_x,pin_y1,-1])
                cylinder(r = pin_r, h=thick+2, $fn=10);
                translate([pin_x,pin_y2,-1])
                cylinder(r = pin_r, h=thick+2, $fn=10);
            }
        }
    }
    ring(inner_r, inner_r+edge, thick+inner_h);
    difference() {        
        ring(outer_r-edge, outer_r, thick+inner_h);
        translate([outer_r-2*edge, -5, thick])
        cube([12,12,20]);
        translate([-outer_r+2*edge-10, -5, thick])
        cube([12,12,20]);
        translate([0,0,thick+inner_h-1.0])
        cylinder(r=outer_r-edge+0.4, h=0.6);
    }
}


module back() {
    ring(inner_r, outer_r, thick);
    ring(inner_r+edge+0.5, outer_r-edge-0.5, thick+1);
    intersection() {
        translate([0,0,thick+0.49])
        ring(inner_r+edge+0.5, outer_r-edge+0.3, 0.5);
        cube([2*outer_r+10, 9, 20], center=true);
    }

}