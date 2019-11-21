//pet collar
//by william collins

use <write/Write.scad> //customizer's location
//resolution faces
$fn = 50; 

//CUSTOMIZER VARIABLES
//Text to write on collar (can be pretty long)
p_collar_id = "My Pet , My Address , My Phone#";

//Approx. radius of pet's neck (add slack!) 
p_collar_r = 50;

//width of collar
p_collar_w = 10;

//collar thickness
p_collar_thick = 2.5;

//split thickness for break
p_collar_break = 1;

//angle subtended by catch
p_box_ang = 10;

//width of catch
p_box_r = 4;


//CUSTOMIZER VARIABLES END
inff = 1000 * 1;
ri = p_collar_r - p_collar_thick;
//r_round = .5;
difference()
{
	union()
	{
		writecylinder( p_collar_id , [0,0,0] , p_collar_r , p_collar_w ,rotate = 0 );
		ring(p_collar_r , ri ,  p_collar_w); 
			
			difference()
			{
				ring_seg(p_collar_r + p_box_r, p_collar_r , p_collar_w , 10); 
				translate([0 , 0 , .3333 * p_collar_w])
				ring(p_collar_r + .6666 * p_box_r , p_collar_r , .333 * p_collar_w);
			}
		
	}
		translate([-.5 * p_collar_break, ri - p_collar_thick , - p_collar_w])
		cube([p_collar_break , inff , 3 * p_collar_w]);
}

translate([0 , -p_collar_r , 0])
ring_seg(p_collar_r + .6666 * p_box_r , p_collar_r , .35 * p_collar_w ,   p_box_ang * 1.2 );




module ring_seg(ro , ri , h , angle )
{
	thick = ro - ri;
	wide = 2 * ro * sin(angle);
	intersection()
	{
		ring(ro , ri , h);
		translate([ - .5 * wide ,ri - thick, -h])
		cube([wide , 3 * thick , 3 * h]);
	}


}

module ring(ro , ri , hi)
{
	difference()
	{
			cylinder( r = ro  , h = hi );
			cylinder( r = ri  , h = hi );
	}

}


























