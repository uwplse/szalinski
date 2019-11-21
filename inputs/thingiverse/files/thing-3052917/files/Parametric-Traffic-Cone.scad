// V2: Parametric Traffic Cone by bikecyclist: https://www.thingiverse.com/thing:3052917
// V1: Traffic Cone by felixstdp: https://www.thingiverse.com/thing:1260767

//Height of the Traffic Cone
cone_height = 70;

//Diameter at the Base
cone_base_diameter = 60;

//Diameter at the Top
cone_tip_diameter = 20;     

//Wall Thickness
cone_wall = 0.5;            

//Height of the Square Base
base_height = 1; 

//Edge Length of the Square Base
base_edge = 76;

//Corner Radius of the Square Base
base_corner_radius = 10;

//Number of Facets. Try 4 for a diamond cone! :-D
$fn=120;

//Parameter to ensure proper meshing, normally no need to change it
epsilon = 0.01;

difference()
{
    union()
    {
        linear_extrude (base_height)
            hull ()
                for (i = [-1, 1])
                   for (j = [-1, 1])
                        translate([i * (base_edge/2 - base_corner_radius), j * (base_edge/2 - base_corner_radius),0])
                            circle(r = base_corner_radius);
                   
        cylinder (d1 = cone_base_diameter, d2 = cone_tip_diameter, h = cone_height);
    }
    
    translate([0,0,-epsilon])
        cylinder(d1 = cone_base_diameter - 2 * cone_wall, d2 = cone_tip_diameter - 2 * cone_wall, h = cone_height + 2 * epsilon);
}