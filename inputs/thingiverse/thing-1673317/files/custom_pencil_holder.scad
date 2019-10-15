// customizable magnetic pencil holder
// created by james wickware - 7/14/16

// preview[view:north east, tilt:top diagonal]

/* [Size] */
// The overall width of the pencil holder in millimeters.
width = 150; // [0:0.5:400]

// The overall depth of the pencil holder in millimeters.
depth = 38; // [0:0.5:200]

// The overall height of the pencil holder in millimeters.
height = 108; // [0:0.5:200]

/* [Walls] */
// The thickness of the outer walls in millimeters.  
outer_wall_thickness = 2; // [0.5:0.5:20]

// The thickness of the inner walls in millimeters.
inner_wall_thickness = 1; // [0.5:0.5:20]

/* [Sections] */
// The number of sections the holder will be divided into.
sections = 5; // [1:30]

// Controls the size of each section is calculated. "Constant" will make each section the same size. "Increasing" will make each section double in size from the previous from left to right. "Decreasing" will make each section half the size of the previous from left to right.
division_mode = 2; // [0:Constant ,1: Increasing ,2:Decreasing]

// Sets the minimum size a section can be in millimeters for the "Increasing" and "Decreasing" division modes. *A large value here may cause less sections to be generated depending on the width of the holder and the number of sections selected.
minimum_section_width = 15; // [0:100]

/* [Bevel] */
// Controls how the opening of the holder is beveled.  
bevel_type = 0; // [0:Flat ,1:Round, 2:Scoop]

// Controls the angle of the bevel in degrees for Flat bevel and the radius for Round and Scoop bevels.
bevel= 43;	//	[0:0.5:80]
/* [Other] */
// Choose whether to generate the pencil holder standing upright or laying on its back.
upright =0; //[0:Yes, 1:No]
 
 
// generate holder upright or lying down
translate([0,height * upright,0]) // [0:Yes, 1:No]
rotate([upright * 90, 0,0])   
union()
{
    difference()
    {
        difference()
        {
            cube([width, depth, height],false);
            translate([-10,outer_wall_thickness,height])
            rotate([-bevel,0,0])
            
            // bevel outer walls
            if(bevel_type == 0)
            {                
                cube([width*2, depth*2, height*2],false);
            }

            if(bevel_type == 1)
            {
                translate([-outer_wall_thickness,depth+outer_wall_thickness,height]) 
                rotate([90,0,90])
                difference()
                {
                    translate( [-outer_wall_thickness, 0  ,0]) 
                    cylinder(h=width+(outer_wall_thickness*4), r=(depth/45)*bevel ) ;
                    translate([-((depth/45)*bevel) -outer_wall_thickness,-((depth/45)*bevel)   ,0]) 
                    cylinder(h=width+(outer_wall_thickness*8) , r=(depth/45)*bevel );    
                }
            }
            
            if(bevel_type == 2)
            {
                translate([-outer_wall_thickness,depth+outer_wall_thickness,height]) 
                rotate([90,0,90])
                cylinder(h=width+(outer_wall_thickness*2), r=(depth/45)*bevel);
            }  
        }
        
        translate([outer_wall_thickness,outer_wall_thickness,outer_wall_thickness])
        cube ([width - (outer_wall_thickness*2), depth- (outer_wall_thickness*2), height], false);
    };

    for(i = [1:sections-1  ])
    {    
        if(division_mode == 0)
        { 
            difference()
            {
                translate([((width/sections) * i - (inner_wall_thickness/2)),0 ,0])      
                cube([inner_wall_thickness, (depth), height],false);
                translate([-outer_wall_thickness,outer_wall_thickness,height])
                rotate([-bevel,0,0]) 
                
                // bevel inner walls 
                if(bevel_type == 0)
                {
                    cube([width*2, depth*2, height*2],false);
                }
              
                if(bevel_type == 1)
                {
                    translate([-outer_wall_thickness,depth+outer_wall_thickness,height]) 
                    rotate([90,0,90])
                    difference()
                    {
                        translate( [-outer_wall_thickness, 0  ,0]) 
                        cylinder(h=width+(outer_wall_thickness*4), r=(depth/45)*bevel ) ;
                        translate([-((depth/45)*bevel) -outer_wall_thickness,-((depth/45)*bevel)   ,0]) 
                        cylinder(h=width+(outer_wall_thickness*8) , r=(depth/45)*bevel );    
                    }
                }

                if(bevel_type == 2)
                {
                    translate([-outer_wall_thickness,depth+outer_wall_thickness,height]) 
                    rotate([90,0,90])
                    cylinder(h=width+(outer_wall_thickness*2), r=(depth/45)*bevel);
                }
            } 
        }
        
        // Increasing section size      
        if (division_mode == 1)
        {
            difference()
            {          
                translate([width - (min(max((((width/sections) * i)/(sections/i)),(minimum_section_width*i)), width )) +(inner_wall_thickness/2) ,0 ,0])    
                cube([inner_wall_thickness, (depth), height],false);
                translate([-outer_wall_thickness,outer_wall_thickness,height])
                rotate([-bevel,0,0]) 
                
                // bevel inner walls 
                if(bevel_type == 0)
                {
                    cube([width*2, depth*2, height*2],false);
                }
                
                if(bevel_type == 1)
                {
                    translate([-outer_wall_thickness,depth+outer_wall_thickness,height]) 
                    rotate([90,0,90])
                    difference()
                    {
                        translate( [-outer_wall_thickness, 0  ,0]) 
                        cylinder(h=width+(outer_wall_thickness*4), r=(depth/45)*bevel ) ;
                        translate([-((depth/45)*bevel) -outer_wall_thickness,-((depth/45)*bevel)   ,0]) 
                        cylinder(h=width+(outer_wall_thickness*8) , r=(depth/45)*bevel );    
                    }
                }
                    
                 if(bevel_type == 2)
                {
                    translate([-outer_wall_thickness,depth+outer_wall_thickness,height]) 
                    rotate([90,0,90])
                    cylinder(h=width+(outer_wall_thickness*2), r=(depth/45)*bevel);
                }
            } 
        }
        
        if (division_mode == 2)
        {
            difference()
            {          
                translate([min(max((((width/sections) * i)/(sections/i)),(minimum_section_width*i)), width ) -(inner_wall_thickness/2) ,0 ,0])    
                cube([inner_wall_thickness, (depth), height],false);
                translate([-outer_wall_thickness,outer_wall_thickness,height])
                rotate([-bevel,0,0]) 
                
                // bevel inner walls 
                if(bevel_type == 0)
                {
                    cube([width*2, depth*2, height*2],false);
                }
 
                if(bevel_type == 1)
                {
                    translate([-outer_wall_thickness,depth+outer_wall_thickness,height]) 
                    rotate([90,0,90])
                    difference()
                    {
                        translate( [-outer_wall_thickness, 0  ,0]) 
                        cylinder(h=width+(outer_wall_thickness*4), r=(depth/45)*bevel ) ;
                        translate([-((depth/45)*bevel) -outer_wall_thickness,-((depth/45)*bevel)   ,0]) 
                        cylinder(h=width+(outer_wall_thickness*8) , r=(depth/45)*bevel );    
                    }
                }
                
                if(bevel_type == 2)
                {
                    translate([-outer_wall_thickness,depth+outer_wall_thickness,height]) 
                    rotate([90,0,90])
                    cylinder(h=width+(outer_wall_thickness*2), r=(depth/45)*bevel);
                }
            } 
        }
    }
}
