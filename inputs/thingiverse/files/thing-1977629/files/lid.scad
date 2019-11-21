$fa = 0.5; // default minimum facet angle is now 0.5
$fs = 0.5; // default minimum facet size is now 0.5 
$fn = 50;

bay = [60,45];
lip = 2;
wall = 1;
box_wall = 1;

cap = [13, 4, 1];

module wedge(d = [1,1,1], center = false) {
    mov = center ? [-d[0]/2,-d[1]/2,0] : [0,0,d[2]]/2;
    
    translate(mov)
    linear_extrude(height = d[2], center=true)
    polygon([[0,0],[d[0],0],[0,d[1]]]);
}

module rounded_cube(d=[1,1,1], center = false, r = 1) {
    mov = center ? [-d[0]/2,-d[1]/2,0] : [0,0,d[2]]/2;
    
    translate(mov)
    hull() {
        translate([r,r,0]) cylinder(d[2], r = r, center = true);
        translate([d[0]-r,r,0]) cylinder(d[2], r = r, center = true);
        translate([r,d[1]-r,0]) cylinder(d[2], r = r, center = true);
        translate([d[0]-r,d[1]-r]) cylinder(d[2], r = r, center = true);
    }
}

d = [17,4,wall+6];
space = 1;

module box(solid=false) {
    rotate([0,180,0])
    difference() {
        union() {
            translate([0,0,d[2]/2]) cube(d, center = true);
            translate([-(d[0]-2*space-2*box_wall)/2,d[1]/2,cap[2]+2])
                rotate([90,0,90])
                    wedge([box_wall,d[2]-box_wall-cap[2]-2,d[0]-2*space-2*box_wall]);
            if (solid) {
                translate([0,-d[1]/2+space/2+box_wall,(d[2]-box_wall)/2-1]) 
                    cube([d[0]-2*box_wall,space,d[2]-box_wall+1], center = true);

                translate([d[0]/2-space/2-box_wall,
                          -space/2+d[1]/2-box_wall+lip,
                          (d[2]-box_wall)/2-1])
                    cube([space,d[1]+lip,d[2]-box_wall+1], center = true);
                translate([-d[0]/2+space/2+box_wall,
                          -space/2+d[1]/2-box_wall+lip,
                          (d[2]-box_wall)/2-1]) 
                    cube([space,d[1]+lip,d[2]-box_wall+1], center = true);
            }

        }
        if (!solid) {
            translate([0,-d[1]/2+space/2+box_wall,(d[2]-box_wall)/2]) 
                cube([d[0]-2*box_wall,space,d[2]-box_wall], center = true);
            translate([d[0]/2-space/2-box_wall,-space/2+d[1]/2-box_wall,(d[2]-box_wall)/2]) 
                cube([space,d[1]-box_wall,d[2]-box_wall], center = true);
            translate([-d[0]/2+space/2+box_wall,-space/2+d[1]/2-box_wall,(d[2]-box_wall)/2]) 
                cube([space,d[1]-box_wall,d[2]-box_wall], center = true);
        }
    }
}

module module_cover() render() {
    union() {
        difference() {
            union() {
                rounded_cube([bay[0]+2*lip, 
                              bay[1]+2*lip, 
                              wall], center=true);
                translate([0,bay[1]/2+lip-space,wall/2-cap[2]/2]) 
                    rounded_cube(cap, center = true);
                translate([0,-bay[1]/2-lip+space,wall/2-cap[2]/2]) 
                    rounded_cube(cap, center = true);
            }
            translate([0, bay[1]/2-d[1]/2, wall/2]) box(solid=true);
            mirror([0,1,0]) translate([0, bay[1]/2-d[1]/2, wall/2]) box(solid=true);
        }
    
        translate([0, bay[1]/2-d[1]/2,wall/2]) box();
        mirror([0,1,0]) translate([0, bay[1]/2-d[1]/2,wall/2]) box();
    }
}

module_cover();