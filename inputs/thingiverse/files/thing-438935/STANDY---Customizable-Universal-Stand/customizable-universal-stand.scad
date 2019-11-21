//CUSTOMIZER VARIABLES

// Your stand consists from too parts. Which one would you like to see?
part = "both"; // [left,right,both]

// Your stand consists from too parts. This is the width of one part.
stand_width = 70;

// Your stand consists from too parts. This is the height of one part.
stand_height = 60;

// Thickness of the object you want to fix.
object_thickness = 16; 

// The slope of the object. 
angle_deviation = 10;//[5:45]

// Thickness of the wall depends on the object you want to fix. Usually, 2 mm is enough for the most objects.  
wall_thickness = 1.5;

// The frame supports your object from the front side.
frame_size = 6;

// From the back side the object is supported by spheres. This value should be less then half width and half height of the stand. If your object is light, this radius could be decreased.
sphere_radius = 25;

//HIDDEN VARIABLES

quality = +40;

stand_thickness = object_thickness + 2*wall_thickness; 

//USED MODULES

// this holder covers the object
module holder() 
{
	translate([0,0,sin(angle_deviation)*stand_thickness])
	rotate([-angle_deviation,0,0])

	intersection()
	{
		// special cylinder to round up sharp corners
		rotate([-90,0,0])
		resize(newsize=[2*stand_width,2*stand_height,stand_thickness])
		cylinder(h=10,r=10, $fn=quality);
	
		difference()
		{	
			// external cube
			cube(size=[stand_width, stand_thickness, stand_height]);
		
			// internal cube
			translate([wall_thickness, wall_thickness, wall_thickness])
			cube(size=[stand_width, object_thickness, stand_height]);
		
			// cut off the frame for the object
			translate([wall_thickness+frame_size, wall_thickness-wall_thickness, wall_thickness+frame_size])
			cube(size=[stand_width, object_thickness, stand_height]);
		};
	}
}

// creates necessary back support for the holder
module fixer()
{
	internal_circle_size = stand_width*0.8;
	coef_height=1.5;
	
	difference()
	{
		union()
		{
			translate([0,stand_thickness,0])
			difference()
			{
				hull()
				{	
					translate([stand_width-sphere_radius,0,0])
					sphere(r=sphere_radius, $fn=quality);
					translate([sphere_radius,0,])
					sphere(r=sphere_radius, $fn=quality);
				};

				hull()
				{	
					translate([stand_width-sphere_radius,0,0])
					sphere(r=sphere_radius-wall_thickness, $fn=quality);
					translate([sphere_radius,0,])
					sphere(r=sphere_radius-wall_thickness, $fn=quality);
				};
		
				translate([0,-stand_width/2,-sphere_radius])
				cube([stand_width,stand_width,sphere_radius]);
				
				translate([0,-stand_width - stand_thickness*sin(angle_deviation),0])
				cube([stand_width,stand_width,sphere_radius]);
			}
	
			cube(size=[stand_width, stand_thickness, stand_thickness*sin(angle_deviation)]);
		}

		translate([0,0,sin(angle_deviation)*stand_thickness])
		rotate([-angle_deviation,0,0])
		cube(size=[stand_width, stand_thickness, stand_height]);
		
		rotate([-angle_deviation,0,0])
		translate([0,-sphere_radius,stand_thickness*sin(angle_deviation)])
		cube([stand_width,sphere_radius,2*sphere_radius]);
	}	
}

module stand()
{	
	union()
	{
		holder();
		fixer();
	}
}

module left_part()
{
	stand();
}

module right_part()
{
	translate([2*stand_width+5,0,0])
	mirror([1,0,0]) 
	stand();
}

// MAIN BODY

if (part == "left") 
{
	left_part();
} 
else if (part == "right") 
{
	right_part();
} 
else if (part == "both") 
{
	left_part();
	right_part();
} 
else {
	left_part();
	right_part();
}




