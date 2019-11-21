$fn = 100; //Quality
//All dimensions are in mm

//Scale
SCL = 1; //Scales the UFO

//Geometry Dimensions
G_RO_W = 5; // Width of Outer Portion of the Ring
G_RO_R = 90; // Radius of Outer Portion of the Ring
G_RI_W = 60; // Width of Inner Portion of the Ring
G_RI_R = 30; // Radius of Inner Portion of the Ring
G_S_R  = 50; // Radius of the main fuselage(sphere)
G_A    = 30; // Pitch of UFO

// Geometry Dimensions of windows
G_W_R  = 10; // Radius of the windows(spheres around ring)
G_W_RL = 70; // Distance of windows from main fuselage
G_W_D  = 10; // Depth of windows in ring

//Dimensions for the mounting bolt clearence
B_B=25; //Bolt head diamter with clearance for tool
B_h=16; // Bolt head height
B_l= G_S_R*SCL; // Bolt overall length
B_d=11; // Diamter


module UF()
{
union()
{   
    hull()
    {
    cylinder(h = G_RO_W*SCL, r = G_RO_R*SCL ,center = true); //Ring_Outer Dimensions
    cylinder(h = G_RI_W*SCL, r = G_RI_R*SCL ,center = true); // Ring_Inner Dimensions
    }
    sphere(r = G_S_R*SCL);
}
}
 
module O()
{
for ( i = [0 : 5] )
    {
        rotate( i * 32, [0, 0, 1])
        translate([G_W_RL*SCL, 10, G_W_D*SCL])
        sphere(r = G_W_R*SCL);
    }
}


module bolt(){
union(){
		translate([0,0,B_l-0.1])cylinder(h = B_h, r = B_B/2); //space for head
		cylinder(h = B_l, r = B_d/2); // bolt shaft
		}
					}

module UFO()
{
    difference()
    {
        UF();
        O();
    }
}

difference(){
rotate([G_A,0,0]) UFO();
translate([0,0,-G_RO_R*SCL]) cube([2*G_RO_R*SCL, 2*G_RO_R*SCL, 2*G_RO_R*SCL],center = true);
   translate ([0,0,-15]) bolt();
}