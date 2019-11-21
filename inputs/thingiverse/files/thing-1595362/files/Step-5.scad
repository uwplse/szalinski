// Customizable Fractal Tree
// 
// By steveweber314
// 
// 5/12/2015
//
// Utilizes thing:16193 "Write" by HarlanDMii
//
// This builds a tree using a recursive algorithm. For more information, please visit the Instructable, at http://www.instructables.com/id/Procedurally-Generated-Trees/
//
//
// BEGIN CUSTOMIZER

/* [Tree Parameters] */

//Random Seed 
random_seed = 46;

//text
text1 = "Your Text Here";

//depth of recursion (warning: each iteration will take exponentially more time to process)
number_of_iterations = 5; // [1:10]

//starting height of the first branch
height = 45; //[1:100]

//maximum size of a leaf relative to the branch
leaf_scale = 2.0; //[0.10:10.0]

/* [Advanced Parameters] */

//font
text_font = "orbitron.dxf";//[Letters.dxf,orbitron.dxf,knewave.dxf,braille.dxf,Blackrose.dxf]

// text height
text_height=10; // [4:25]

//control the amount of taper on each branch segment
width_ratio_bottom = 0.25; 
width_ratio_top = 0.20;

//size of the "knuckles" between segments
knuckle_size = 0.24; 

//minimum size ratio of a new branch to its parent
min_rate_of_growth = 0.85; //[0.05:1.0]

//maximum size ratio of a new branch to its parent
max_rate_of_growth = 1.20; //[1.0:5.0]

//number of faces on the cylinders
level_of_smoothness = 16; // [4:100]

//number of faces on the spheres
leaf_smoothness = 16; // [4:100]

//number of faces on the base/stand
base_smoothness = 60; //[20:200]



use <write/Write.scad>

module trunk(size, depth, seed)
{
    //create an array of random numbers
    operation = rands(1,4,1, seed+5);

    //automatically stop if the size gets too small so we dont waste computation time on tiny little twigs
    if (size > 5)
    {
        //choose a module based on that array
        if (operation[0] < 1)
        {
            branch_one(size*.9, depth, seed+1);          
        }
        if (operation[0] < 2)
        {
            branch_two(size*.9, depth, seed+2);          
        }
        else if (operation[0] < 3)
        {
            branch_three(size*.9, depth, seed+3);          
        }
        else if (operation[0] < 4)
        {
            branch_four(size*.9, depth, seed+4);          
        }
    }
    
}

module branch_one(size, depth, seed)
{
    sizemod = rands(min_rate_of_growth,max_rate_of_growth,10, seed+1);
	entropy = rands(0.01,leaf_scale,1, seed+2);
	rotations = rands(-20,20,10, seed+3);

	color([1,1,0]) 
	{
		//create the branch by tapering a cylinder from one radius to another
		cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);
	}

	//move to the tip of the branch
	translate([0,0,size])
	{
		//check for stop condition
		if (depth > 0) 
		{
            union() 
            {
                //create a "knuckle"
                sphere(size*knuckle_size);
                rotate([0+rotations[0],0+rotations[1],0+rotations[2]])
                {
                    //build another trunk
                    trunk(size*.9*sizemod[0], depth-1, seed+1);
                }
            }   
		}
		else
		{
            //create the leaves
			color([0.5,0.5,0]) {
				sphere(size*entropy[0], $fn=leaf_smoothness);
			}
		}
	}
}

module branch_two(size, depth, seed)
{
    sizemod = rands(min_rate_of_growth,max_rate_of_growth,10, seed+1);
	entropy = rands(0.01,leaf_scale,1, seed+2);
	rotations = rands(-20,20,10, seed+3);

	color([1,1,0]) {
		cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);
	}

	translate([0,0,size])
	{
		
		if (depth > 0) 
		{
            union() 
            {
                sphere(size*knuckle_size);
                rotate([0+rotations[0],30+rotations[1],0+rotations[2]])
                {
                    trunk(size*.9*sizemod[0], depth-1, seed+2);
                }
                rotate([0+rotations[3],30+rotations[4],180+rotations[5]])
                {
                    trunk(size*.9*sizemod[1], depth-1, seed+3);
                }
            }   
		}
		else
		{
			color([0.5,1,0]) {
				sphere(size*entropy[0], $fn=leaf_smoothness);
			}
		}
	}
}


module branch_three(size, depth, seed)
{   
    sizemod = rands(min_rate_of_growth,max_rate_of_growth,10, seed+1);
	entropy = rands(0.01,leaf_scale,1, seed+2);
	rotations = rands(-20,20,10, seed+3);

	color([1,1,0]) {
		cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);
	}

	translate([0,0,size])
	{
		
		if (depth > 0) 
		{
            union() 
            {
                sphere(size*knuckle_size);
                rotate([0+rotations[0],30+rotations[1],0+rotations[2]])
                {
                    trunk(size*.9*sizemod[0], depth-1, seed+4);
                }
                rotate([0+rotations[3],30+rotations[4],120+rotations[5]])
                {
                    trunk(size*.9*sizemod[1], depth-1, seed+5);
                }
                rotate([0+rotations[6],30+rotations[7],240+rotations[8]])
                {
                    trunk(size*.9*sizemod[2], depth-1, seed+6);
                }
            }   
		}
		else
		{
            color([0.2,0.6,0]) {
				sphere(size*entropy[0], $fn=leaf_smoothness);
			}
		}
	}
}

module branch_four(size, depth, seed)
{
    sizemod = rands(min_rate_of_growth,max_rate_of_growth,10, seed+1);
	entropy = rands(0.01,leaf_scale,1, seed+2);
	rotations = rands(-20,20,12, seed+3);

	color([1,1,0]) {
		cylinder(h = size, r1 = size*width_ratio_bottom, r2 = size*width_ratio_top);
	}


	translate([0,0,size])
	{
	
		if (depth > 0)
		{
            union()
            {
                sphere(size*knuckle_size);
                rotate([0+rotations[0],30+rotations[1],0+rotations[2]])
                {
                    trunk(size*.9*sizemod[0], depth-1, seed+7);
                }
                rotate([0+rotations[3],30+rotations[4],90+rotations[5]])
                {
                    trunk(size*.9*sizemod[1], depth-1, seed+8);
                }
                rotate([0+rotations[6],30+rotations[7],180+rotations[8]])
                {
                    trunk(size*.9*sizemod[2], depth-1, seed+9);
                }
                rotate([0+rotations[9],30+rotations[10],270+rotations[11]])
                {
                    trunk(size*.9*sizemod[2], depth-1, seed+10);
                }                
            }
		}
		else
		{
            color([0.2,0.6,0]) {
				sphere(size*entropy[0], $fn=leaf_smoothness);
			}
		}
	}

}





union()
{
        translate([0,0,text_height*-2-5])
        {
            color([0.2,0.6,0]) {              
                difference()
                {
                    //create the base
                    union()
                    {
                        //sphere(40, $fn=base_smoothness);
                        translate([0,0,text_height+5])
                        {
                            cylinder(h=text_height, r1 = 42, r2 = height*.20, $fn=base_smoothness);
                        }
                        cylinder(h = text_height+5, r1 = 42, r2 = 42, $fn=base_smoothness);
                    }
                    
                    //write the text on the base
                    writecylinder(text1,[0,0,0],radius=44,height=text_height+5,t=6,up=0,h=text_height,font=text_font);

                }
            }
        }	
    //build the tree
    trunk(height, number_of_iterations, $fn=level_of_smoothness, random_seed);
}



