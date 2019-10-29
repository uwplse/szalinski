

//adjusts the distance of the outer rings from the center(can't be less than 22)
ring_distance = 24;
//changes spacing of wall around the outside bearings
ring_radius = 15;
//changes spacing of wall around the inner bearing
inner_ring_radius = 20;
//adjusts the amount of curve of the outer wall(%)
outside_scale = 50;
//adjusts the amount of curve of the inner wall(%)
inside_scale = 50;
//number of bearings around the center bearing
number_holes = 4;
//adjusts the center hole's thickness to add inner holes for a cool effect(center ring must be pretty large)(set equal to or over inner_ring_radius to turn off)
center_hole_effect_thickness = 13;

sphere_scale = outside_scale/100;
inner_sphere_scale = inside_scale/100;
inner_scale_ring_height = ring_radius + (inner_sphere_scale * 20);
scale_ring_height = inner_ring_radius + (sphere_scale * 20);
center_hole_effect_distance = inner_ring_radius - 3;


difference()
{
    union()
    {
        //inner ring
        translate([0,0,3.5])scale([1,1,inner_sphere_scale])sphere(r=inner_ring_radius, $fn=50);
        
        //outside rings
        for (i=[1:number_holes])
        {
           rotate([0,0,i*360/number_holes])translate([0,ring_distance,3.5])scale([1,1,sphere_scale])sphere(r=ring_radius, $fn=50);
        }
    }
    
    union()
    {
        //inner ring
        translate([0,0,-0.01])cylinder(h=7.02, r=11, $fn=50);
        translate([0,0,7])cylinder(h=inner_scale_ring_height, r=inner_ring_radius);
        rotate([0,180,0])cylinder(h=inner_scale_ring_height, r=inner_ring_radius);
        
        //inner ring hole effect
        difference()
        {
            //subtracts
            union()
            {
                translate([0,0,-0.001])cylinder(r=center_hole_effect_distance, h=7.002, $fn=50);
            }
            
            //adds
            union()
            {
                cylinder(r=center_hole_effect_thickness, h=7.001, $fn=50);
                        //outside rings
        for (i=[1:number_holes])
        {
           rotate([0,0,i*360/number_holes])translate([0,ring_distance,3.5])scale([1,1,sphere_scale])sphere(r=ring_radius, $fn=50);
        }
            }
        }
        
        //outside rings
        for (i=[1:number_holes])
        {
            rotate([0,0,i*360/number_holes])translate([0,ring_distance,-0.01])cylinder(h=7.02, r=11, $fn=50);
            rotate([0,0,i*360/number_holes])translate([0,ring_distance,7])cylinder(h=scale_ring_height, r=ring_radius);
            rotate([0,180,i*360/number_holes])translate([0,ring_distance,0])cylinder(h=scale_ring_height, r=ring_radius);
        }
    }
}