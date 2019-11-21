
phone_width = 87.5;
phone_height = 125;  // actually taller but we don't care, we're not enclosing the top
phone_depth = 16.5;
power_opening = 20;
wall_width = 3.5;

difference()
{
    cube([phone_width + wall_width, phone_height + wall_width, phone_depth + wall_width], center=true);

    translate([0, 20, wall_width])
        difference() {
            cube([phone_width, phone_height, phone_depth], center=true);
            translate([phone_width /2, -phone_height/1.25, 0])
                rotate([0, 0, -35]) 
                    cube([phone_width, phone_height, phone_depth], center=true);
            translate([-phone_width /2, -phone_height/1.25, 0])
                rotate([0, 0, 35]) 
                    cube([phone_width, phone_height, phone_depth], center=true);
        }

    translate([0, -wall_width, wall_width])
        cube([power_opening, phone_height, phone_depth + wall_width], center=true);

    translate([0, wall_width, 0])
        cube([phone_width, phone_height + wall_width, phone_depth], center=true);
    
    translate([phone_width / 4, 40, -phone_depth/2 -wall_width/4]) 
        #cylinder(h=wall_width/2, r1=2, r2=4, $fn=36, center=true);
    
    translate([-phone_width / 4, 40, -phone_depth/2 -wall_width/4]) 
        cylinder(h=wall_width/2, r1=2, r2=4, $fn=36, center=true);

    translate([0, -phone_height/4, -phone_depth/2 -wall_width/4]) 
        cylinder(h=wall_width/2, r1=2, r2=4, $fn=36, center=true);

}