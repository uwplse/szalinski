//Golden Spiral Fan Duct v0.2 
//Edward Stradinger - Jan 2014
//Shroud 2d polygon code fixed by user PGent - Nov 2015
//Derivative of http://www.thingiverse.com/thing:139984 by ei8ghtohms
//Given fan dimensions construct a conical shroud featuring internal fins to
//guide the airflow into a vortex.  As the cross sectional area of the cone
//decreases the radial motion component also decreases, allowing a greater 
//distance over which the air can accelerate, diminishing turbulent flow
//and fostering an axial low pressure zone which, upon exiting the nozzle,
//increases the duration of vortex coherence.  

/*[General Settings:]*/
//perimeter extrusion width configured in your slicing utility
perimeter_extrusion_width=.5;
//constant exponent denominator to relate unitless phi to units of measurement
scale_factor = 10;
//golden ratio conjugate selected for reduction.  Add significant digits as desired.
phi=0.618034;
//default number of facets generated.
$fn = 24;
//Layer height in mm, smaller gives better resolution but more polygons
layer_height = .5;

/*[Mounting Bracket:]*/
//mounting bracket side in mm
mount_side = 40; 
//height of mounting bracket in mm
mount_height = 8;
//Distance between screw bore centers in mm
screw_distance = 32;
//diameter of screw bores
screw_diameter = 2.8;
//radius of mounting bracket corner rounds
corner_radius= 6;
//radius of ball joint sphere
ball_radius = 5; 
//fraction of ball radius protruding above mounting surface
ball_inset = .8; 

/*[Duct Configuration]*/
//Fan Diameter in mm
fan_diameter = 38;
//Desired height of duct in mm
duct_height = 30;
//thickness of outer walls in mm
wall_thickness = 1.5;
//number of desired fins
fins=5;
//direction of fin rotation.  1=clockwise, -1=counterclockwise
direction = -1;


/*[Additional Relations]*/

//for readability
fan_radius=fan_diameter/2;
//number of layers through which to iterate
layer_count = duct_height/layer_height;
//diameter of nozzle at desired height
nozzle_diameter = fan_diameter * pow(phi, duct_height/scale_factor);
//fin thickness at tip on layer 1
fin_minimum = perimeter_extrusion_width/pow(phi,duct_height/scale_factor);
//fin thickness at inner wall on layer 1
fin_thickness=fin_minimum*(1+phi);//max thickness of fins in mm

difference(){
	union(){  
		translate([0,0,mount_height/2]) //mounting bracket with corner rounds
			minkowski(){
				cube([	mount_side+2*wall_thickness - 2*corner_radius,
						mount_side+2*wall_thickness - 2*corner_radius,
						mount_height-1],
						center=true);
				cylinder(	r=corner_radius,
							h=1,
							$fn=32,
							center=true);				
		}
//		rotate_extrude(convexity=4, $fn=48) //outer wall - 2d polygon, rotate vertical, spin
//			union(){
//				for(i=[0:layer_height:duct_height-layer_height]){
//					rotate([90,0,0])
//					polygon(points=[	[0,i],
//									[0,i+layer_height],
//									[(fan_radius)*pow(phi,(i+layer_height)/scale_factor)+wall_thickness,
//										i+layer_height],
//									[(fan_radius)*pow(phi,(i/scale_factor))+wall_thickness,
//										i]]);
//				}
//			}
        /****list comprehension syntax thanks to user PGent!****/
        rotate_extrude(convexity=4, $fn=48) // outer wall - 2d polygon, rotate extrude 
            {
            poly_points_outer = [ 
            for(i = [0: layer_height: duct_height - layer_height] )
                    [ (fan_radius) * pow(phi, (i/scale_factor) ) + wall_thickness, i ] ] ;

            // add start and end points at 0
            polygon(points = concat( [ [0, 0] ], poly_points_outer, [ [0, duct_height - layer_height] ] ) );
            }
		translate([		mount_side/2 + //add ball joint
						wall_thickness - 
						ball_radius*cos(asin(ball_inset)), 
						0,
						mount_height + ball_radius * ball_inset])
			sphere(		r=ball_radius,
						center=true,
						$fn=24);
	}
	union(){//construct negative space within
		difference(){
//			rotate_extrude(convexity=4) //inner wall
//				union(){
//					for(i=[0:layer_height:duct_height-layer_height]){
//						rotate([90,0,0])
//							polygon(points=[	[0,i],
//									[0,i+layer_height],
//									[(fan_radius)*pow(phi,(i+layer_height)/scale_factor),
//										i+layer_height],
//									[(fan_radius)*pow(phi,(i/scale_factor)),
//										i]]);
//				}
//			}
             /****Thanks again user PGent!****/
             rotate_extrude(convexity=4, $fn=48) // inner wall - 2d polygon, rotate extrude, 
                {
                poly_points_inner = [ 
                    for(i = [0: layer_height: duct_height - layer_height] )
                        [ (fan_radius) * pow(phi, (i/scale_factor) ), i ] ] ;

                    // add start and end points at 0
                    polygon(points = concat( [ [0, 0] ], poly_points_inner, [ [0, duct_height - layer_height] ] ) );
                   }
				union(){
					for(i= [0:fins-1]){//iterate through fins
						
						rotate([	0,0,(360/fins * i)])
							linear_extrude(	height=duct_height,
 		  							twist=direction * 360 * pow(phi,duct_height/scale_factor),
									scale=pow(phi,duct_height/scale_factor),
									slices=layer_count)
					
							translate([fan_radius*((2-phi)/2),0,0])
								polygon(points=//vertices of fin slice.  
									[[-fan_radius * phi/2,-fin_minimum/2],
									[-fan_radius * phi/2,fin_minimum/2],
									[fan_radius * phi/2,fin_thickness/2],
									[fan_radius * phi/2 + fin_thickness/2, 0],
									[fan_radius * phi/2, -fin_thickness/2]]);
					}
				}
			
		}	  
	}
  	for(i = [0:3]){//diff screw bores 
		rotate([0,0,90*i])
		translate([screw_distance/2,screw_distance/2,mount_height/2])	  
			cylinder(	r=screw_diameter/2,
				 		h=mount_height,
				 		center=true);
 	}
}	
  