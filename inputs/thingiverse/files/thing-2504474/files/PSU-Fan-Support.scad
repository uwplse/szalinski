fan=79.8; // Fan diameter
thickness=25; // Fan thickness

placca(fan, thickness);

module placca (fan,thickness){
    translate([0,0,-2])difference(){
        cube([fan,fan,2]);
        translate([fan/2,fan/2,-.5]) cylinder(r=(fan-9)/2,h=3);
        translate([4.4,4.4,-.5]) cylinder(r=5.1/2,h=3);
        translate([fan-4.4,4.4,-.5]) cylinder(r=5.1/2,h=3);
        translate([fan-4.4,fan-4.4,-.5]) cylinder(r=5.1/2,h=3);
        translate([4.4,fan-4.4,-.5]) cylinder(r=5.1/2,h=3);
    }
    
    difference(){
        union(){
            translate([fan,0,-2]) cube([2,10,2+22+thickness]);
            translate([fan,5,thickness+22]) rotate([0,90,0]) cylinder(r=10/2,h=2);
        }
        translate([fan+1,10/2,thickness+22])rotate([0,90,0])cylinder(r=4.5/2,h=3,center=true);
        translate([fan+1,10/2,thickness+22])rotate([0,90,0])cylinder(r=6/2,h=2);
    }
    
    difference(){
        union(){
            hull(){
                translate([fan-20,fan,-2]) cube([20,110.5-fan,2]);
                translate([fan-20,110.5,-2]) cube([20+9,2,2]);
            }
            hull(){
                translate([fan-20,110.5,-2]) cube([20+9,2,2]);
                translate([fan+5,110.5,thickness+25]) rotate([-90,0,0]) cylinder(r=8/2,h=2);
            }
        }
        translate([fan+5,110,thickness+25]) rotate([-90,0,0]) cylinder(r=3.5/2,h=3);
    }
}

$fn=200;