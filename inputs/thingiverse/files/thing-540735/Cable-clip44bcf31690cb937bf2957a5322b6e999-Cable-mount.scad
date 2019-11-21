//The radius of the cable thickness
cable_thickness_r = 4;

//The strength/thickness of the wall
wall_thickness = 2;

//The height of the clip
height = 20;

/* [Hidden] */
outer_size = cable_thickness_r + wall_thickness;

difference()
{
    //Outside shell
    union()
    {
        hull()
        {
            cylinder(r=outer_size,h=height,$fn=72, center=true);

            translate([0,0,-height/2])
            cube([outer_size,outer_size,height]);
        }
        
        difference()
        {
            translate([outer_size,outer_size/2,0])
            rotate([90,0,0])
            cylinder(r=height/2,h=outer_size,$fn=72,center=true);
            
            translate([-outer_size - height,-1,-height/2])
            cube([outer_size + height,outer_size + 2,height]);
        }
    }
    
    //Remove thightner opening
    translate([0,wall_thickness,-height/2])
    cube([height + outer_size,outer_size - wall_thickness*2,height]);

    //make center cable hole
    cylinder(r=cable_thickness_r,h=height+1,center=true,$fn=24);
    
    //make mounting hole
    translate([outer_size + height/4,0,0])
    rotate([90,0,0])
    cylinder(r=1.6,h=(outer_size*2)+1,center=true,$fn=18);
}