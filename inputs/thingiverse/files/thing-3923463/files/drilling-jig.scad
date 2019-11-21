base_length       = 90;
base_width        = 40;
base_height       = 10;
axis_distance     = 25;
tube_height       = 25;
tube_outer_radius = 8;
tube_inner_radius = 3.5;

fillet_radius = tube_inner_radius;

notches           = "yes"; // [yes, no]

$fn=50;

module drill_template() {
    difference() {
        union() {
            // base
            cube([base_length/2, base_width, base_height]);

            // tube
            translate([axis_distance/2, base_width/2, base_height])
            cylinder(h=tube_height, r=tube_outer_radius);
            
            // tube fillet
            translate([axis_distance/2, base_width/2, base_height])
            cylinder(h=fillet_radius, r=tube_outer_radius+fillet_radius);
        }

        // hole
        translate([axis_distance/2, base_width/2, -10])
        cylinder(h=base_height+tube_height+20, r=tube_inner_radius);
    
        // top chamfer
        translate([axis_distance/2, base_width/2, base_height+tube_height-(tube_outer_radius+tube_inner_radius)/2])
        cylinder(h=(tube_outer_radius+tube_inner_radius)/2, r1=0, r2=(tube_outer_radius+tube_inner_radius)/2);
        
        // bottom chamfer
        translate([axis_distance/2, base_width/2, 0])
        cylinder(h=(tube_outer_radius+tube_inner_radius)/2, r1=(tube_outer_radius+tube_inner_radius)/2, r2=0);
        
        // tube fillet
        translate([axis_distance/2, base_width/2, base_height+fillet_radius])
        rotate_extrude()
        translate([tube_outer_radius+fillet_radius,0,0])
        circle(r=fillet_radius);
        
        if(notches=="yes") {
            // notch, shorter side
            translate([base_length/2,base_width/2,base_height/2])
            rotate([0,0,45])
            cube(size=[3,3,base_height],center=true);
            
            // notches, longer side
            translate([axis_distance/2,0,base_height/2])
            rotate([0,0,45])
            cube(size=[3,3,base_height],center=true);
            
            translate([axis_distance/2,base_width,base_height/2])
            rotate([0,0,45])
            cube(size=[3,3,base_height],center=true);
            
        }
    }
}

drill_template();
mirror([-1,0,0]){ drill_template(); }