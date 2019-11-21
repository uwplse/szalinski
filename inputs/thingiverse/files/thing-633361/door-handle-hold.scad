// diameter of door handle in mm
handle_diameter = 20;
logo_image_file = "wi1logo.dat"; // [image_surface:44x26]
radius = handle_diameter / 2;




rotate([0,-90,0]) union() {
translate([0,-2.25,radius+1]) cube(size = [20,2,20]);

translate([1,-2.2,radius+3]) rotate([90,0,0]) 
    
    scale([0.4, 0.4, 1]) surface(file = logo_image_file, invert = false);


translate([0,0.25,radius+1]) cube(size = [20,2,20]);

rotate([0,90,0]) {
    
    difference() {
        cylinder(h=20, r=radius+2, $fn=80);
        union() {
            translate([0,0,-3]) cylinder(h=40, r=radius, $fn=80);
            translate([0,-5,-10]) cube([50,10,100]);
        }
    }
}

}