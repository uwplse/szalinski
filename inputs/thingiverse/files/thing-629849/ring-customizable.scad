
// RING 

//Adjust the radius.
r_cyl 		= 5; // [1:30]
//Adjust the height.
h_cyl 		= 25; // [1:50]

//Adjust the radius.
r_ring 		= 25; // [1:100]
//Number of cylinders.
v_nbr_cyl 	= 5; // [1:50]
//Adjust the thickness.
e_cube		= 2; // [1:50]


$fn=100;

for (nb = [0: v_nbr_cyl]) 
{
    rotate(360*nb/v_nbr_cyl,[0,0,1])
    translate([r_ring, 0, 0])
    {		
    	cylinder(r= r_cyl, h= h_cyl);
		rotate(90+180/v_nbr_cyl,[0,0,1])
		translate(v=[0,-e_cube/2,0])
    	cube([2*cos((180/v_nbr_cyl)-90)*r_ring,e_cube,h_cyl]);   
    }
}


