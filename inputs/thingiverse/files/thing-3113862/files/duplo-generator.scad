//
// LEGO DUPLO BRICK GENERATOR
//
// Author: Emanuele Iannone (emanuele@fondani.it)
//
// Url: https://www.thingiverse.com/thing:3113862

/* [Main] */

// Size along X axis (in studs)
X_size = 3;

// Size along Y axis (in studs)
Y_size = 2;

// (1 = standard brick height)
Height_factor = 1;

// Enable or disable studs
Studs = 1; // [0:No studs, 1:With studs]

// Add extended triangular support ridges
Extended_Ridges = 0; // [0:No extended ridges, 1:Add extended ridges]

/* [Advanced] */
// Size of a single stud (in mm)
base_unit = 15.75;
// Standard height of a block
std_height = 19.25;
// Vertical walls thickness
wall_thickness = 1.29;
// Top surface thickness
roof_thickness = 1.4;
// Stud outer radius
stud_radius = 4.7;
// Internal cylinder outer radius
cyl_radius = 6.6;
// Internal cylinder thickness
cyl_thickness = 1;
// Ridge thickness
ridge_thickness = 1;
// Ridge extension (control grip)
ridge_width = 3.1;



brick(X_size, Y_size, Height_factor, Studs);

module brick(nx, ny, heightfact, studs=true){
    height = heightfact * std_height;
    dx = nx * base_unit;
    dy = ny * base_unit;
    union() {
        // Shell
        difference() {
            cube([dx, dy, height]);
            translate(v=[wall_thickness, wall_thickness, -1]) {
                cube([dx - (wall_thickness * 2), dy - (wall_thickness * 2), height - roof_thickness + 1]);
            }
        }
        
        // Studs
        if (studs) for (r=[0:nx-1])for (c=[0:ny-1]){
            stud((base_unit/2) + r * base_unit, base_unit/2 + c * base_unit, height, stud_radius);
        }
       
        // Internal cylinders
        if (nx > 1 && ny > 1) for(r=[1:nx-1]) for(c=[1:ny-1]) {
            internal_cyl(base_unit * r, base_unit * c, height - roof_thickness + 0.1);
        }
        
        // Ridges
        ridgeset(0, 0, 0, nx, height);
        ridgeset(dx, dy, 180, nx, height);
        ridgeset(0, dy, -90, ny, height);
        ridgeset(dx, 0, 90, ny, height);
    }
}

module stud(x, y, z, r){
  translate(v=[x, y, 1.875 + z]){
    difference(){
       cylinder(h=3.75, r=r, center=true, $fn=100);
       cylinder(h=4, r=r-1.5, center=true, $fn=100);
    }
  }
}

module internal_cyl(x, y, h) {
    translate(v=[x, y, 0]) difference() {
        union() {
            cylinder(h=h, r=cyl_radius, $fn=100);
            translate([0,0,h]) {
                rotate([-90,0,45]) linear_extrude(height = ridge_thickness, center=true)
                    polygon([[-base_unit*0.7,0],[base_unit*0.7,0],[0,14]]);
                rotate([-90,0,-45]) linear_extrude(height = ridge_thickness, center=true)
                    polygon([[-base_unit*0.7,0],[base_unit*0.7,0],[0,14]]);
            }
        }
        cylinder(h=h*3, r=cyl_radius-cyl_thickness, center=true, $fn=100);           
        cube(size=[cyl_radius*2, 1, 10], center=true); 
        cube(size=[1, cyl_radius*2, 10], center=true); 
    }
}

module ridgeset(x, y, angle, n, height){
    translate([x, y, 0]) rotate([0, 0, angle]) {
        for (i=[1:2*n-1]){
            // Ridge
            translate([(i*base_unit - ridge_thickness)/2,0,0]) rotate([90,0,90]) {
                if (Extended_Ridges) {
                    linear_extrude(height = ridge_thickness, center=true) 
                        polygon([[0,height - std_height],[0,height],[10,height]]);
                }
                if (i % 2) cube([ridge_width, height, ridge_thickness]);
            }  
        }
    }
}