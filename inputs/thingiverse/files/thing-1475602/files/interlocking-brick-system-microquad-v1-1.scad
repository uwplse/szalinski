/* [Output settings] */
//Which parts should be generated
output_type = "All"; //[Motormount, Midsection, Cameramount, All]
//Motor outer diameter (mm)
motor_diameter = 8.5;
//Length of the arm on the motor mount. Measured in studs
mount_arm_length = 2; //[1:10]
//Number of motor mounts to be generated
number_of_motor_mounts = 4;
//Size of the midsection side plates
midsection_side_plates_size = 1; //[0:4]
//Size of the midsection front plate
midsection_front_plate_size = 2; //[0:6]
//Size of the midsection rear plate
midsection_rear_plate_size = 2; //[0:6]

/* [Camera mount settings] */
//Angle
camera_mount_angle = 10;
//Add supporting back to mount
add_back_support = "Yes"; //[Yes,No]
//Height of back support (mm)
back_support_height = 10;

/* [Printer corrections] */
//Adjust +/- to get a snug fit (mm)
stud_adjustment = -0.1; 
//Adjust +/- to get a snug fit (mm)
hole_adjustment = 0.1; 
//Adjust +/- if your prints tend to be larger or smaller than they should be (mm). Note: Does not affect the size of the hole for the motor, the studs or the holes!
margin = 0.0; 

//constants
modulesize = 8 * 1.0;
moduleheight = 3.2 * 1.0;
edgeremoval = 0.15 * 1.0;
stud_height = 1.6 * 1.0;
hole_depth = 2.0 * 1.0;
motor_mount_thickness = 2 * 1.0;
motor_mount_height = 10 * 1.0;

//calculated values
stud_diameter = 4.8 + stud_adjustment; 
hole_diameter = 4.8 + hole_adjustment;

module cameramount()
{
    difference()
    {
        translate([-modulesize+edgeremoval/2+margin,-modulesize+edgeremoval/2+margin,0])
        {  
            cube([2*modulesize-edgeremoval-margin*2, 2*modulesize-edgeremoval-margin*2, moduleheight]);  
            translate([2*modulesize-edgeremoval-margin*2,0,moduleheight])
            {
                
                rotate([0,-90,0])
                {
                        front_height = (2*modulesize-edgeremoval-margin*2)*tan(camera_mount_angle);
                        linear_extrude(height=2*modulesize-edgeremoval-margin*2)
                    {    
                        polygon(points = [[0,0], [0,2*modulesize-edgeremoval-margin*2], [front_height,2*modulesize-edgeremoval-margin*2]]);
                    }
                    if(add_back_support == "Yes")
                    {
                        x1 = back_support_height * sin(camera_mount_angle);
                        h1 = x1 / cos(camera_mount_angle);
                        y2 = h1 * tan(camera_mount_angle);
                        back_height = (y2+back_support_height)*cos(camera_mount_angle);
                        back_depth = 1 + (y2+back_support_height)*sin(camera_mount_angle);
                        linear_extrude(height=2*modulesize-edgeremoval-margin*2)
                    {    
                        polygon(points = [[0,0], [0,back_depth], [back_height,1],[back_height,0]]);
                    }
                    }
                }
                 
            }
        }
        union()
        {
            translate([-modulesize/2, modulesize/2, -1])
            cylinder(r = hole_diameter/2, h = hole_depth + 1, $fn=100);
            translate([modulesize/2, modulesize/2, -1])
            cylinder(r = hole_diameter/2, h = hole_depth + 1, $fn=100);
            translate([-modulesize/2, -modulesize/2, -1])
            cylinder(r = hole_diameter/2, h = hole_depth + 1, $fn=100);
            translate([modulesize/2, -modulesize/2, -1])
            cylinder(r = hole_diameter/2, h = hole_depth + 1, $fn=100);
        }
    }
}

module motormount()
{
    xoffset = (modulesize/2-margin-edgeremoval/2);
    yoffset = ((motor_diameter/2)+motor_mount_thickness+modulesize*mount_arm_length-margin);
    
    difference()
    {
        union()
        {
            cylinder( r = (motor_diameter/2) + motor_mount_thickness, h = motor_mount_height, $fn = 100 );
            translate([-xoffset, -yoffset, 0])
            cube([xoffset*2, yoffset, moduleheight]);
            translate([-xoffset, -((motor_diameter/2)+motor_mount_thickness), moduleheight])
            cube([xoffset*2, (motor_diameter/2)+motor_mount_thickness, moduleheight]);
            translate([0,-yoffset-edgeremoval/2-margin+modulesize/2,moduleheight])
            {
                    for( i = [1:mount_arm_length])
                    {
                        translate([0,modulesize*(i-1),0])             
                        cylinder( r = stud_diameter/2, h = stud_height, $fn = 100);
                    }
                    
            }        
        }
        
        union()
        {
            translate([0,0,-1])
            cylinder( r = (motor_diameter/2), h = motor_mount_height+2, $fn = 100 );
            translate([0,(motor_diameter/2) + motor_mount_thickness/2,motor_mount_height/2])
            cube([2,motor_mount_thickness+2,motor_mount_height+2], center = true);
            translate([0,-yoffset-edgeremoval/2-margin+modulesize/2,-1])
            {
                    for( i = [1:mount_arm_length])
                    {
                        translate([0,modulesize*(i-1),0])             
                        cylinder( r = hole_diameter/2, h = hole_depth+1, $fn = 100);
                    }
                    
            }
        }
    }
}

module midsection()
{
    difference()
    {
        union()
        {
            
            //base
            difference()
            {
                union()
                {
                    difference()
                    {
                        union()
                        {
                            translate([0,0,moduleheight])
                            cube([modulesize*4-edgeremoval-margin*2, modulesize*4-edgeremoval-margin*2, moduleheight*2], center = true);
                            
                        }
                        union()
                        {
                            for( a = [45:90:315])
                            {
                                rotate([0,0,a])
                                translate([-(modulesize/2+margin),modulesize*2.5-edgeremoval/2-margin,-1])
                                cube([modulesize+margin*2, modulesize, moduleheight*2+2]);
                            }                    
                        }
                    } 
                    rotate([0,0,45])
                    translate([0,0,moduleheight/2])
                    cube([modulesize*5-edgeremoval-margin*2, modulesize-edgeremoval-margin*2, moduleheight], center = true);
                    rotate([0,0,-45])
                    translate([0,0,moduleheight/2])
                    cube([modulesize*5-edgeremoval-margin*2, modulesize-edgeremoval-margin*2, moduleheight], center = true);
                }
                union()
                {
                    //midstuds
                    rotate([0,0,45])
                    translate([-modulesize*2,0,-1])
                    for( i = [0:4] )
                    {
                        translate([modulesize*i, 0, 0])
                        cylinder( r = hole_diameter/2, h = hole_depth+1, $fn = 100);
                    }    
                    rotate([0,0,-45])
                    translate([-modulesize*2,0,-1])
                    for( i = [0:4] )
                    {
                        translate([modulesize*i, 0, 0])
                        cylinder( r = hole_diameter/2, h = hole_depth+1, $fn = 100);
                    }
                }
            }
 
            
            //front
            translate([-modulesize+edgeremoval/2+margin,2*modulesize-edgeremoval/2-margin, 0])
            cube([2*modulesize-edgeremoval-margin*2, midsection_front_plate_size*modulesize, moduleheight]);
            translate([-modulesize,((2+midsection_front_plate_size)*modulesize),moduleheight])
            {
                    for(i = [0:1])
                    {
                        translate([modulesize/2+modulesize*i, 0, 0])               
                        for(j = [0:midsection_front_plate_size])
                        {
                            translate([0, -(modulesize/2+j*modulesize), 0])
                            cylinder( r = stud_diameter/2, h = stud_height, $fn = 100);
                        }                    
                    }
            }
            
            
            //rear
            translate([-modulesize+edgeremoval/2+margin,-((2+midsection_rear_plate_size)*modulesize-edgeremoval/2-margin), 0])
            cube([2*modulesize, midsection_rear_plate_size*modulesize, moduleheight]);
            translate([-modulesize,-((2+midsection_rear_plate_size)*modulesize),moduleheight])
            {
                    for(i = [0:1])
                    {
                        translate([modulesize/2+modulesize*i, 0, 0])               
                        for(j = [0:midsection_rear_plate_size])
                        {
                            translate([0, (modulesize/2+j*modulesize), 0])
                            cylinder( r = stud_diameter/2, h = stud_height, $fn = 100);
                        }                    
                    }
            }
            
            
            
            
            if(midsection_side_plates_size > 0)
            {
                //left
                union()
                {
                    translate([-(2+midsection_side_plates_size)*modulesize+edgeremoval/2+margin,-modulesize+edgeremoval/2+margin,0])        
                    cube([midsection_side_plates_size*modulesize, 2*modulesize-edgeremoval-margin*2, moduleheight]);
                    translate([-(2+midsection_side_plates_size)*modulesize,-modulesize,0])
                    {
                            for(i = [0:1])
                            {
                                translate([0, modulesize/2+i*modulesize, moduleheight])               
                                for(j = [0:midsection_side_plates_size])
                                {
                                    translate([modulesize/2+j*modulesize, 0, 0])
                                    cylinder( r = stud_diameter/2, h = stud_height, $fn = 100);
                                }                    
                            }
                    }
                }
                    
                
                //right
                union()
                {
                    translate([2*modulesize-edgeremoval/2-margin,-modulesize+edgeremoval/2+margin,0])
                    cube([midsection_side_plates_size*modulesize, 2*modulesize-edgeremoval-margin*2, moduleheight]);
                    translate([(2+midsection_side_plates_size)*modulesize,-modulesize,0])
                    {
                            for(i = [0:1])
                            {
                                translate([0, modulesize/2+i*modulesize, moduleheight])               
                                for(j = [0:midsection_side_plates_size])
                                {
                                    translate([-(modulesize/2+j*modulesize), 0, 0])
                                    cylinder( r = stud_diameter/2, h = stud_height, $fn = 100);
                                }                    
                            }
                    }    
                }
                    
            }
        }
        union()
        {
            if(midsection_side_plates_size > 0)
            {
                //left
                union()
                {
                    translate([-(2+midsection_side_plates_size)*modulesize,-modulesize,-1])
                    {
                            for(i = [0:1])
                            {
                                translate([0, modulesize/2+i*modulesize, 0])               
                                for(j = [0:midsection_side_plates_size-1])
                                {
                                    translate([modulesize/2+j*modulesize, 0, 0])
                                    cylinder( r = hole_diameter/2, h = hole_depth+1, $fn = 100);
                                }                    
                            }
                    }
                }
                
                //right
                union()
                {
                    translate([(2+midsection_side_plates_size)*modulesize,-modulesize,-1])
                    {
                            for(i = [0:1])
                            {
                                translate([0, modulesize/2+i*modulesize, 0])               
                                for(j = [0:midsection_side_plates_size-1])
                                {
                                    translate([-(modulesize/2+j*modulesize), 0, 0])
                                    cylinder( r = hole_diameter/2, h = hole_depth+1, $fn = 100);
                                }                    
                            }
                    }    
                }
            }
            
            //front
            translate([-modulesize,((2+midsection_front_plate_size)*modulesize),-1])
            {
                    for(i = [0:1])
                    {
                        translate([modulesize/2+modulesize*i, 0, 0])               
                        for(j = [0:midsection_front_plate_size-1])
                        {
                            translate([0, -(modulesize/2+j*modulesize), 0])
                            cylinder( r = hole_diameter/2, h = hole_depth+1, $fn = 100);
                        }                    
                    }
            }
            //rear
            translate([-modulesize,-((2+midsection_rear_plate_size)*modulesize),-1])
            {
                    for(i = [0:1])
                    {
                        translate([modulesize/2+modulesize*i, 0, 0])               
                        for(j = [0:midsection_rear_plate_size-1])
                        {
                            translate([0, (modulesize/2+j*modulesize), 0])
                            cylinder( r = hole_diameter/2, h = hole_depth+1, $fn = 100);
                        }                    
                    }
            }
            translate([0,0,moduleheight*1.5+1])
            rotate([0,0,45])
            cube([modulesize+margin*2, 100, moduleheight+2], center = true);
            translate([0,0,moduleheight*1.5+1])
            rotate([0,0,-45])
            cube([modulesize+margin*2, 100, moduleheight+2], center = true);
        }
        
        
    }
    //midstuds
    rotate([0,0,45])
    translate([-modulesize*2,0,moduleheight])
    for( i = [0:4] )
    {
        translate([modulesize*i, 0, 0])
        cylinder( r = stud_diameter/2, h = stud_height, $fn = 100);
    }    
    rotate([0,0,-45])
    translate([-modulesize*2,0,moduleheight])
    for( i = [0:4] )
    {
        translate([modulesize*i, 0, 0])
        cylinder( r = stud_diameter/2, h = stud_height, $fn = 100);
    }
}

if( (output_type == "All" || output_type == "Motormount" || output_type == "Both") && number_of_motor_mounts > 0) //"Both" for legacy support
{
    numRows = number_of_motor_mounts > 1 ? 2 : 1;
    echo(numRows);
    numColumns = ceil(number_of_motor_mounts / 2);
    echo(numRows);
    totspace = numRows * (motor_diameter+motor_mount_thickness*2+modulesize*mount_arm_length) + (numRows-1)*10;
    translate([-motor_diameter/2-motor_mount_thickness-10, totspace/2-(motor_diameter/2+motor_mount_thickness), 0])    
    for( c = [1:numColumns])
    {
        translate([-((c-1)*(motor_diameter+motor_mount_thickness*2+10)), 0, 0])
        for( i = [0:1] )
        {
            if( (((c-1)*2)+(i+1)) <= number_of_motor_mounts )
            {
                if( number_of_motor_mounts > 1 )
                {
                    translate([0, (i-1)*(motor_diameter+motor_mount_thickness*2+modulesize*mount_arm_length+10), 0])
                    motormount();                
                } else {
                    motormount();  
                }
            }            
        }
    }
}

if( output_type == "All" || output_type == "Midsection" || output_type == "Both") //"Both" for legacy support
{
    translate([10+(midsection_side_plates_size+2)*modulesize, 0, 0])
    midsection();
}

if( (output_type == "All" || output_type == "Cameramount" ) && camera_mount_angle > 0)
{
    translate([10+(midsection_side_plates_size+2)*modulesize, 10 + (midsection_front_plate_size+4)*modulesize, 0])
    cameramount();
}
