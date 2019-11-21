///////////////////////////////////////////////////////////////
//Light Ball
//2019-08-31
//Ryan Stachurski
///////////////////////////////////////////////////////////////
// Unused variable to trick Customizer
unused = 3; //[1..3]

// Number of tubes to use
tube_count = 5; // [2:8]

// Tube mount angle in degrees
tube_angle = 10; // [0:60]

// Tube thickness in mm (1/2 Pex CPVC 15.875, 3/4 Pex CPVC 22.225)
tube_thick = 15.875; // [15.875, 22.225]

//Tweaks
// Wall thickness of structure
wall_thick = 5; // 

// Nub length of each tube holder
nub_length = 40; // 

barb_diameter = wall_thick / 2; //barb diameter should be related to wall thickness somehow; verify deiameter not radius...

barb_side = 2* barb_diameter * cos(30); //side of inscribed triangle
barb_max_depth = sqrt( pow(barb_side,2) - pow( barb_side / 2 ,2 ));

//barb degree increment to get good grippy
//roughly tube circumference / barb diameter
barb_inc = 360 / (2*PI*(tube_thick/2) / barb_diameter);         


//Lots of stuff to calculate arbitrary bottom of piece:
side_x = tube_thick/2 + wall_thick;
angle_B = 90 - tube_angle;
side_z = side_x / cos(angle_B);
side_xx = side_x * cos(angle_B);
side_yy = nub_length - side_xx;
lowest_z = (side_yy + side_z) / tan(angle_B);



module nub()
{        
    rotate ([90+tube_angle,0,0]) 
    cylinder(r=(tube_thick/2) + wall_thick, nub_length, $fa=1);
 
}// end nub

module nubcut()
{        

    //create the barbed rod
    difference(){
        // start with the large void cylinder
        rotate ([90+tube_angle,0,0]) 
            translate([0,0,tube_thick])
                cylinder(r=tube_thick/2+barb_max_depth, nub_length, $fa=1);

        
        // remove the barbs
        rotate ([90+tube_angle,0,0]) 
            translate([0,0,tube_thick])
                for (i=[0 : barb_inc : 359]) rotate(i) 
                    translate([-barb_diameter - tube_thick/2, 0, 0])
                        linear_extrude(height=nub_length, convexity=10) circle(r=barb_diameter, $fn=3);
        }//end difference


    
        
}// end nubcut

difference(){
    union(){
        
         //nub center support
        sphere((tube_thick/2)+wall_thick,  $fa=5, $fs=0.1);
        
        hull(){

        //nub spanning supports
        //translate ([0,0,wall_thick]) 
        scale([nub_length*0.65, nub_length*0.65, wall_thick]) sphere(1, $fa=5, $fs=0.1);
        
       
        
        //bottom support
        translate ([0,0,-lowest_z])
            rotate([0,0,-90])
            cylinder(r=side_yy, h=1, $fn=tube_count);
        
        }//end hull
        
        
        //draw all the nubs
        for (i=[0 : 360/tube_count : 359]) rotate(i) nub();
            
        
        
    }//end union
    
    //cut out each of the nubs
    for (i=[0 : 360/tube_count : 359]) rotate(i) nubcut();
    
}//end difference