
segments = 8;
distance = 10;
radius = 10;
thickness = 2;

rotate([-90,0,0])
    drawCableManagementStrip(segments,distance,radius,thickness);

module drawCableManagementStrip(segments=8,distance=10,radius=10,thickness=2) {
    difference() {
        union() {
        translate([-radius - 5 + thickness/2 ,-2,-3])
            cube([10,2,segments*distance + 6]);
            for(i=[0:1:segments]) {
                translate([0,0,i*distance])
                    drawArm(radius,thickness);
            }
        }
         for(i=[0:1:segments]) {
            translate([-radius+thickness/2,0,distance/2 + distance*i])
                    rotate([90,0,0])
                        cylinder(r=1.7,h=50,center=true,$fn=30);    
         }
    }



    translate([radius-thickness,-1,-3])
        cube([thickness,1,segments *distance + 6]);

    translate([-radius,-1,-3])
        cube([2*radius,1,2]);

    translate([-radius,-1,segments*distance+1])
        cube([2*radius,1,2]);
}

module drawArm(radius=10,thickness=2) {
 
    nf=90;
    difference() {
        union() {
            difference() {        
                cylinder(r=radius,h=3,$fn=nf,center=true);
                translate([0.0,0,0])
                    cylinder(r=radius-thickness,h=3.1,$fn=nf,center=true);
                
            }
            difference() {        
                cylinder(r=radius,h=3,$fn=nf,center=true);
                translate([1.0,0,0])
                    cylinder(r=radius-thickness,h=3.1,$fn=nf,center=true);
                
            }
        }
        translate([-radius,0,-2])
                cube([2*radius,radius,4]);
    }
}