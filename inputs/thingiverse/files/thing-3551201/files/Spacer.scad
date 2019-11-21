// 'Customizable Spacer and standoff' Version 1.0 by sn4k3 
// is licensed under the Attribution - Share Alike license. 
// (c) April 2019

outer_diameter=14;
inner_diameter=5.5;
height=38;

outer_number_of_sides=100; //[3,4,5,6,7,8,9,10,12,15,100:round]
inner_number_of_sides=100; //[3,4,5,6,7,8,9,10,12,15,100:round]

/* [ Top Extra Feature ] */
top_feature_enable = 0; // [0:No,1:Yes]
top_feature_diameter = 8;
// Use positive value for standoff and negative for hole
top_feature_height = -5.10;
top_feature_number_of_sides=6; //[3,4,5,6,7,8,9,10,12,15,100:round]

/* [ Bottom Extra Feature ] */
bottom_feature_enable = 0; // [0:No,1:Yes]
bottom_feature_diameter = 8;
// Use positive value for standoff and negative for hole
bottom_feature_height = -5.10;
bottom_feature_number_of_sides=6; //[3,4,5,6,7,8,9,10,12,15,100:round]

/* [Hidden] */
build_spacer();

module build_spacer()
{	
	difference()
	{
		linear_extrude(height,convexity=10)
		difference()
		{
			circle((outer_diameter)/2,$fn=outer_number_of_sides);
			circle(inner_diameter/2,$fn=inner_number_of_sides);
            
		}
        
        if(bottom_feature_enable && bottom_feature_height < 0)
        {
            linear_extrude(-bottom_feature_height,convexity=10)
            difference()
            {
                circle((bottom_feature_diameter)/2,$fn=bottom_feature_number_of_sides);
            }
        }
        
        if(top_feature_enable && top_feature_height < 0)
        {
            translate([0,0,height+top_feature_height])
            linear_extrude(-top_feature_height,convexity=10)
            difference()
            {
                circle((top_feature_diameter)/2,$fn=top_feature_number_of_sides);
            }
        }
	}	
    
    if(bottom_feature_enable && bottom_feature_height > 0)
    {
        linear_extrude(1.2,convexity=10)    // Seal bottom just in case
            circle((outer_diameter)/2,$fn=100); // Seal bottom just in case
        
        // Standoff
        translate([0,0,-bottom_feature_height])
            linear_extrude(bottom_feature_height,convexity=10)
                circle((bottom_feature_diameter)/2,$fn=bottom_feature_number_of_sides);
    }
    
    if(top_feature_enable && top_feature_height > 0)
    {
        translate([0,0,height-1.2])         // Seal top just in case
            linear_extrude(1.2,convexity=10)    // Seal top just in case
                circle((outer_diameter)/2,$fn=100); // Seal top just in case
        
        // Standoff
        translate([0,0,height])
            linear_extrude(top_feature_height,convexity=10)
                circle((top_feature_diameter)/2,$fn=top_feature_number_of_sides);
    }
   
}

