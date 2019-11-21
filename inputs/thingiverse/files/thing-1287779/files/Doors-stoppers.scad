

//height
height = 25  ;
//length
length = 120 ;
//width
width= 60 ;


module toto() {
}

$fn = 24;

half_width  = width / 2;

ep_bor = 10;
bottom_cube_length = length - 4 * ep_bor;
bottom_cube_width = width - 2 * ep_bor;
bottom_cube_height = 6; // 3mm in / 3mm outsite
bottom_z = 0;
top_cube_length = length - 4 * ep_bor;
top_cube_width  = width - 2 * ep_bor;
top_cube_height = height;
top_z = height/2 + 7.5;
tip_cut_pos = length/2 - 0.5;
top_tip_pos = height + 0.5;




bloque_porte();

module bloque_porte()
{
 
 
    difference() {
	translate ([-length/2.0, 0, 0])
    	    polyhedron (	
	    		points = [[0, -half_width, height], [0, half_width, height], [0, half_width, 0], [0, -half_width, 0], [length, -half_width, 0], [length, half_width, 0]],
			faces = [[0,3,2], [0,2,1], [3,0,4], [1,2,5], [0,5,4], [0,1,5],  [5,2,4], [4,2,3], ]);

	translate ([-1 * ep_bor, 0, top_z]) 
	     cube ([top_cube_length,
		     top_cube_width,
		     top_cube_height],
		    center=true) ;
	
	translate ([- length/2 + 10, 0, top_tip_pos]) 
	     cube ([length / 2,
		     width+2,
		     height / 2],
		    center=true) ;
	
	translate ([tip_cut_pos, 0, 0]) 
	     cube ([20,
		   width + 1,
		   height],
		  center=true) ;
	
    }	    
}