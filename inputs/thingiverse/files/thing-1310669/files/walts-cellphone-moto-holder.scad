part = "frame"; // [base:Support base,frame:Support frame]

// Cellphone Width (Moto G, 68mm)
width = 68; // [1:150]

// Cellphone Height (Moto G, 131mm)
height= 131; // [1:200]

// Cellphone Depth (Moto G, 12mm)
depth = 12; // [1:100]

// Border Thickness
border_thickness=2.5; // [2:0.5:10]

/* [Hidden] */

$fn=120;

print_part();

module print_part() {
	if (part == "base") {
		base(width);
	} else if (part == "frame") {
        box(width,height,depth,border_thickness);
	}
}

module frame(width, height, depth, border)
{   
    difference()
    {
        roundedRect([width+border,height+border,depth+border],border);

        translate([0,0,(depth/2)+border])
        cube([width,height,depth],center=true);        
    }
}

module sideStuff(width, height, depth, border)
{
            translate([(width/2)+border*0.75,0,depth+border*0.25])
            cube([border/2,height-20,border/2],center=true);

            translate([(width/2)+border/2,-(height-(20+border))/2,depth+border/2])
            cube([border,border,border],center=true);

            translate([(width/2)+border/2,(height-(20+border))/2,depth+border/2])
            cube([border,border,border],center=true);

            translate([-((width/2)+border*0.75),0,depth+border*0.25])
            cube([border/2,height-20,border/2],center=true);

            translate([-((width/2)+border/2),-(height-(20+border))/2,depth+border/2])
            cube([border,border,border],center=true);

            translate([-((width/2)+border/2),(height-(20+border))/2,depth+border/2])
            cube([border,border,border],center=true);

}

// size - [x,y,z]
// radius - radius of corners
module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
		circle(r=radius);
	}
}


module innerHoles(width, height, depth, border)
{
            translate([0,-height/4,0])
            roundedRect([width*0.7,height*0.35,depth+border],5);

            translate([0,height/4,0])
            roundedRect([width*0.7,height*0.35,depth+border],5);
}

module box(width, height, depth, border)
{
    difference()
    {
        frame(width, height, depth, border);
        union()
        {
            innerHoles(width, height, depth, border);
            sideStuff(width, height, depth, border);
        }
    }
}


module base(width)
{
    translate([0,0,-5])
    {        
        rotate([0,0,90])
        difference()
        {
        cube([30,width,10],center=true);
            union()
            {
                translate([0,0,-29])
                    rotate([90,90,0])
                        cylinder(h=width,r=30,center=true);            
                translate([0,0,3])
                cube([30,27,3], center=true);
            }
        }
    }
}