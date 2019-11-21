// Total Height of in the middle
total_height = 5;

// what angle to cut the rocker
rocker_angle = 5;

//concavity (the bigger, the longer the "waist")
factor = 7.5;

// magnet depth
magnet_depth = 4;

// magnet diameter
magnet_diameter = 12;

// how round do you want the clip in the x-Y plane?
xy_facets = 100;

// how round do you want the clip in the Z dimension
z_facets = 50;

// how round do you want the magnet holes
magnet_facets = 50;

radius = total_height/2;
difference()
{
    union()
    {
        //create positve lobe
        translate ([0,0,radius])hull()
        {
            translate([17.5,0,0])
            rotate_extrude(convexity = 10,$fn=xy_facets)
            translate([10.5, 0, 0])
            circle(r = radius,$fn=z_facets);
            
            translate([-17.5,0,0])
            hull()
            {
                translate([0, radius,0])sphere(r=radius, $fn=z_facets);
                translate([0, -radius,0])sphere(r=radius, $fn=z_facets);
            }
        }
        //create negative lobe
        translate ([0,0,radius])hull()
        {
            translate([-17.5,0,0])
            rotate_extrude(convexity = 10,$fn=xy_facets)
            translate([10.5, 0, 0])
            circle(r = radius,$fn=z_facets);
            
            translate([17.5,0,0])
            hull()
            {
                translate([0, radius,0])sphere(r=radius, $fn=z_facets);
                translate([0, -radius,0])sphere(r=radius, $fn=z_facets);
            }
        }
     
        //fill in the middle to give the appearence of a smooth curve
        translate ([0,0,radius])hull()
        {
            translate([-17.5,0,0])
            hull()
            {
                translate([0, factor,0])sphere(r=radius, $fn=z_facets);
                translate([0, -factor,0])sphere(r=radius, $fn=z_facets);
            }
            
            translate([17.5,0,0])
            hull()
            {
                translate([0,factor, 0])sphere(r=radius, $fn=z_facets);
                translate([0, -factor,0])sphere(r=radius, $fn=z_facets);
            }
        }   
   
    }
    
    // slice the model at an angle to make the rocker
    rotate([0,rocker_angle,0])translate([-1,-15,total_height])cube([40,30,total_height]);
    rotate([0,-rocker_angle,0])translate([-39,-15,total_height])cube([40,30,total_height]);
    
    //Cut out the angled magnet holes
    translate ([-17.5,0,-1]) rotate([0,-rocker_angle,0]) cylinder(h=magnet_depth,d=magnet_diameter,$fn=magnet_facets); 
    translate ([17.5,0,-1]) rotate([0,rocker_angle,0]) cylinder(h=magnet_depth,d=magnet_diameter,$fn=magnet_facets);
}

