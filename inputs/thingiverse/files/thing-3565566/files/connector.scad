// Inner diameter of the connector, in mm
inner_diameter = 23;
// Length of each cylinder, in mm
height = 40;
// Wall thickness, in mm
wall_thickness = 3;
// Connection angle, in degrees
angle = 120; // [1:180]

module connector(diameter, height, wall, angle) {
    module outer_cylinder(){ cylinder(r=diameter/2+wall, h=height); }
    module inner_cylinder(){ cylinder(r=diameter/2, h=height+wall); }
    
    difference() {
        union() { //outer cylinder
            sphere(diameter/2+wall);
            rotate([0, 90, 0]) outer_cylinder();
            rotate([90, 0, 0]) outer_cylinder();
            rotate([90-angle, 0, 0]) outer_cylinder();
        }
        
        union() { //inner cylinder
            sphere(diameter/2);
            rotate([0, 90, 0]) inner_cylinder();
            rotate([90, 0, 0]) inner_cylinder(); 
            rotate([90-angle, 0, 0]) inner_cylinder(); 
        }
    }

}



connector(diameter=inner_diameter,height=height,wall=wall_thickness,angle=angle);