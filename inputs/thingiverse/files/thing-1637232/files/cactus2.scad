// Customizable Cactii
// 
// By steveweber314
// 
// 6/20/2016
//
 
// BEGIN CUSTOMIZER

/* [Cactii Parameters] */

random_seed = 786;

//width of segment
segment_width = 10;

//segment length relative to width
length_multiplier = 4;

//number of iterations
number_of_iterations = 10;

level_of_smoothness = 25;


module trunk(width, depth, seed)
{
    //create an array of random numbers
    operation = rands(1,100,1, seed+5);

        echo(operation);
    
        //choose a module based on that array
        if (operation[0] < 60)
        {
            straight_trunk(width*.9, depth, seed+23546);          
        }
        else if (operation[0] < 70)
        {
            branch_crook(width*.9, depth, seed+28543);          
        }        
        else if (operation[0] < 98)
        {
            branch_left(width*.9, depth, seed+28543);          
        }
        else 
        {
           sphere(width);
        }
   
}

module straight_trunk(width, depth, seed)
{
	rotations = rands(-10,10,10, seed+987654);

	color([0,1,0]) 
	{
	
		cylinder(h = width*length_multiplier, r1 = width, r2 = width);
	

        //move to the tip of the branch
        translate([0,0,width*length_multiplier])
        {
        
            union() 
            {
               
                sphere(width);
                rotate([0+rotations[0],0+rotations[1],0+36*rotations[2]])
                {
                    //check for stop condition
                    if (depth > 0) 
                    {
                        //build another trunk
                        trunk(width, depth-1, seed+8532);
                    }
                }   
            }
            
        }
    }
}

module branch_left(width, depth, seed)
{
    rotations = rands(-10,10,10, seed+45678);


	color([0,1,0]) 
	{
		//create the branch by tapering a cylinder from one radius to another
		cylinder(h = width*length_multiplier, r1 = width, r2 = width);
	

        //move to the tip of the branch
        translate([0,0,width*length_multiplier])
        {
            
            union() 
            {
               
                sphere(width);
                
                //trunk
                rotate([0+rotations[0],0+rotations[1],0+36*rotations[2]])
                {
                    //check for stop condition
                    if (depth > 0) 
                    {
                        //build another trunk
                        trunk(width, depth-1, seed+24571);
                    }
                }   
                //branch
                rotate([0+rotations[0],0+rotations[1],0+36*rotations[2]])
                {
                    //check for stop condition
                    if (depth > 0) 
                    {
                        rotate([0,90,36*rotations[3]])
                        {
                            cylinder(h = width*length_multiplier*0.75, r1 = width, r2 = width);
                            translate([0,0,width*length_multiplier*0.75])
                            {
                                            sphere(width);
                                rotate([0,-90,0])
                                {   
                                    //build another trunk
                                    trunk(width*.75, depth-1, seed+1);
                                }
                            }
                        }
                    }
                }   
            }
        }
	}
}


module branch_crook(width, depth, seed)
{
    rotations = rands(-10,10,10, seed+75326);


	color([0,1,0]) 
	{
		//create the branch by tapering a cylinder from one radius to another
		cylinder(h = width*length_multiplier, r1 = width, r2 = width);
	

        //move to the tip of the branch
        translate([0,0,width*length_multiplier])
        {
            
            union() 
            {
               
                sphere(width);
                 
                //branch
                rotate([0+rotations[0],0+rotations[1],0+36*rotations[2]])
                {
                    //check for stop condition
                    if (depth > 0) 
                    {
                        rotate([0,-90,36*rotations[3]])
                        {
                            cylinder(h = width*length_multiplier*0.75, r1 = width, r2 = width);
                            translate([0,0,width*length_multiplier*0.75])
                            {
                                sphere(width);
                                rotate([0,90,0])
                                {   
                                    //build another trunk
                                    trunk(width*.75, depth-1, seed+1);
                                }
                            }
                        }
                    }
                }   
            }
        }
	}
}


union()
{
    	
    //build the tree
    trunk(segment_width, number_of_iterations, $fn=level_of_smoothness, random_seed);
}



