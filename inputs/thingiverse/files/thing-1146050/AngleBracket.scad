//Horizontal angle
angle_1 = 90;

//Vertical angle
angle_2 = 25;

//Height of the bracket
height = 20;

//Width of the bracket
width = 12;

//Thickness
thickness = 2;

//The diameter of the mounting hole
mount_d = 4;

module plane()
{
    rotate([-angle_2,0,0])
    rotate([0,0,angle_1/2])
    translate([-thickness/2,0,0])
    difference()
    {
        cube([thickness,width,height]);
        
        rotate([angle_2/3,0,0])
        translate([-thickness*2,width - mount_d, height/2])
        rotate([0,90,0])
        cylinder(r=mount_d/2,h=4*thickness, $fn=30);

        rotate([angle_2/3,0,0])
        translate([thickness-0.5,width - mount_d, height/2])
        rotate([0,90,0])
        cylinder(r=mount_d,h=thickness, $fn=30);
    }
}

module holder(height)
{
    union()
    {
        plane();

        mirror([1,0,0])
        plane();
        
        rotate([-angle_2,0,0])
        cylinder(r=thickness/2,h=height, $fn=30);
    }
}

difference()
{
    union()
    {
        holder(height);
        difference()
        {
            hull()
            {
                holder(height);
            }
            translate([-width,0,thickness])
            cube([width*2,width*2,height]);
        }
    }
    
    translate([-width,0,-height])
    cube([width*2,width*2,height]);
}

