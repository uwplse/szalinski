//Sphere Torture Customizable
//preview[view:west,tilt:top diagonal]

/* [Sphere] */
//Outer sphere diameter in mm
outer_sphere_diameter=40; //[5:200]
//Wall thickness of sphere in mm
wall=5;  //[0.100]
//Smoothness
smoothness=100; //[5:100]
/* [Squish] */
//Amount erased from top
top_squish=4; //[0:200]
//Amount erased from bottom
bottom_squish=6; //[0:200]

/* [Base] */
//Diameter of bottom 
bottom_diameter=28; //[1:200]
//Thickness of bottom
bottom=2; //[0:5]

/* [Axle] */
//Axle diameter of top
top_axle_diameter=20; //[0:200]
//Axle diameter of bottom
bottom_axle_diameter=0; //[0:200]


r=outer_sphere_diameter/2;  //outer radius
down=-(r-bottom_squish);
top=r-top_squish;
base_radius=bottom_diameter/2;    //cylinder radius bottom
cylinder_top=top_axle_diameter/2;    //cylinder radius top
cylinder_bottom=bottom_axle_diameter/2;    //cylinder radius bottom

$fn=smoothness;

///////////////////////program///////////

//move it all up to sit on the platform
translate([0,0,outer_sphere_diameter/2-bottom_squish+bottom]) 
{
union(){  //build the bowl, then add the base
difference(){ //make a sphere, then cut things away
sphere (r);
sphere (r-wall);  //inner hollow
translate([0,0,top+100]) cube(200,center=true); //cut off the top
translate([0,0,down-100]) cube(200,center=true); //cut off the bottom
cylinder (h=r,r1=cylinder_top,r2=cylinder_top,center=false);
translate([0,0,-r])cylinder (h=r,r1=cylinder_bottom,r2=cylinder_bottom,center=false);
}
translate([0,0,down-bottom]) 
cylinder(h=bottom, r1=base_radius, r2=base_radius); //add a base
}
}

