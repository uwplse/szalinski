// what is inner diameter of the rings?
outer_diameter = 18.5;

// how big is the hole ion the center?
inner_diameter = 12;

// distance between the top and botton of the rings on the outside
height = 43 ;

// diameter of the lip that will overhang the ring
lip_diameter = 25;

// how thick the overhanging lip should be
lip_thickness = 2;

// radius of the retaining spheres that keep the tube in place
sphere_radius = 0.5;

// total height of the tube including the lip
total_height = lip_thickness + height;

// how round do you want it?
facets = 100;

//Let's built it!
Insert(inner_diameter);

// I just learned how to do this so lets create a function 
module Insert(Size)
{
    // subtract the hole from the body
    difference()
    {
        //create the body
        
        union()
        {
            //main cylinder
            translate([0,0,lip_thickness]) cylinder(h=height,d=outer_diameter,$fn=facets);
            
            //lip
            cylinder(h=lip_thickness,d=lip_diameter,$fn=facets);
            
            //retaining spheres
            translate([outer_diameter/2,0,total_height]) sphere(sphere_radius, $fn=facets);
            translate([-outer_diameter/2,0,total_height]) sphere(sphere_radius, $fn=facets);
            translate([0,outer_diameter/2,total_height]) sphere(sphere_radius, $fn=facets);
            translate([0,-outer_diameter/2,total_height]) sphere(sphere_radius, $fn=facets);
        }
        
        //cut the hole
        cylinder(h=total_height, d=Size,$fn=facets);
    }
}
