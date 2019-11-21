//C/C Distance between front holes
front_cc = 30;
//C/C Distance between rear holes
rear_cc = 36;
//C/C Distance between front and rear holes
front_rear_cc = 49.5;
//angle of camera
angle = 20; //[10:45]
//Should a solid wedge be used?
solid_wedge = "Yes"; //[Yes,No]
//Thickness of the base
base_thickness = 2;
//Hole diameter (may need adjustment depending on printer)
hole_size = 3.2;
//Determines the amount of "meat" around the holes
edge_margin = 3;
//Diameter of screw head (to allow enough clerance)
screw_head_size = 6;
//Width of velcro strap hole (only valid for solid wedge)
velcro_width = 20;
//Height of velcro strap hole (only valid for solid wedge)
velcro_height = 3;

//Calculated variables wont be visible to Thingiverse customizer
hole_clearence = edge_margin+hole_size/2;
screw_head_clerance = screw_head_size / 2;
hole_radius = hole_size / 2;

module createBase()
{   
    xFrontOffset = front_cc/2;
    xRearOffset = rear_cc/2;
    yOffset = front_rear_cc/2;
    zOffset = base_thickness/2;
    hole_radius = front_cc < rear_cc ? front_cc / 2-3 : rear_cc / 2-3;
    
    
        hull() {
            linear_extrude( height = base_thickness)
            {
                polygon(
                    points = [  [-xFrontOffset, yOffset], 
                                [xFrontOffset, yOffset], 
                                [xRearOffset, -yOffset], 
                                [-xRearOffset, -yOffset] ], 
                    convexity = 10);
            }
            union(){
                translate([-xFrontOffset, yOffset, zOffset])
                cylinder(h=base_thickness, r=hole_clearence, center = true); 
                translate([xFrontOffset, yOffset, zOffset])
                cylinder(h=base_thickness, r=hole_clearence, center = true); 
                translate([xRearOffset, -yOffset, zOffset])
                cylinder(h=base_thickness, r=hole_clearence, center = true); 
                translate([-xRearOffset, -yOffset, zOffset])
                cylinder(h=base_thickness, r=hole_clearence, center = true); 
            }
        }
        
}

module createWedge()
{
    yDepth = cos(angle)*65 < front_rear_cc+hole_clearence*2 ? cos(angle)*65 : front_rear_cc+hole_clearence*2;
    width = front_cc < rear_cc ? (front_cc - screw_head_clerance*2) : (rear_cc -screw_head_clerance*2);
    height = tan(angle)*yDepth;    
    height2 = tan(angle)*(yDepth-10);
    height3 = tan(angle)*15;    
        
    
    if( solid_wedge == "Yes" )
    {
        difference()
        {
            translate([width/2, front_rear_cc/2 + hole_clearence, base_thickness])
            rotate([0, -90, 0])
            linear_extrude(height = width)
            {
                    polygon( 
                        points = [  [0, 0], 
                                    [height, 0],
                                    [0, -yDepth]], 
                        convexity = 10 );            
            }
            translate([0, (front_rear_cc/2+hole_clearence)-yDepth/2,   tan(angle)*yDepth/2 + base_thickness])
            rotate([angle, 0, 0])  
            cube(size = [width+2, velcro_width, velcro_height*2], center = true);
        }   
    } else {
        translate([width/2, front_rear_cc/2 + hole_clearence, base_thickness])
        rotate([0, -90, 0])
        difference()
        {
            linear_extrude(height = width)
            {
                polygon( 
                    points = [  [0, 0], 
                                [height, 0],
                                [height2, -10],
                                [0, -10]], 
                    convexity = 10 );
                polygon( 
                    points = [  [0, -yDepth+15], 
                                [height3, -yDepth+15],
                                [0, -yDepth]], 
                    convexity = 10 );
            }
            translate([0,0,5])
            linear_extrude(height = width-10)
            {
                polygon( 
                    points = [  [0, 0], 
                                [height, 0],
                                [height2, -10],
                                [0, -10]], 
                    convexity = 10 );
            }
        }
    }
}

module createMount()
{
    length = 75;
    
    yDepth = cos(angle)*65 < front_rear_cc+hole_clearence*2 ? cos(angle)*65 : front_rear_cc+hole_clearence*2;
        
    difference()
    {
        translate([0, (front_rear_cc/2+hole_clearence)-yDepth/2,   tan(angle)*yDepth/2 + base_thickness-0.1])
        rotate([angle, 0, 0])
        union()
        {
            intersection()
            {
                difference()
                {
                    translate([0, 0, 5])
                    cube( size = [39, length, 13 ], center = true );       //start with a box
                    
                    rotate([-90, 0, 0])
                    translate([0,-5,0])
                    union()     //Remove the inside remove
                    {
                        translate([-14.5,0,0])
                        cylinder(r=3, h=length+2, center = true);
                        translate([14.5,0,0])
                        cylinder(r=3, h=length+2, center = true);
                        translate([0,-5,0])
                        cube(size = [35, 10, length+2], center = true);
                        cube(size = [29, 6, length+2], center = true);
                    }
                }
                rotate([-90, 0, 0])
                translate([0,-5,0])
                union() //Remove the outside
                {       
                    translate([-14.5,0,0])
                    cylinder(r=5, h=length+2, center = true);
                    translate([14.5,0,0])
                    cylinder(r=5, h=length+2, center = true);
                    translate([0,-5,0])
                    cube(size = [39, 10, length+2], center = true);
                    cube(size = [29, 10, length+2], center = true);            
                }
            }
            union()
            {
                translate([-17.1, 0, 11])
                cube(size = [0.8, 55, 0.8], center = true);
                translate([17.1, 0, 11])
                cube(size = [0.8, 55, 0.8], center = true);
            }
            
        }
        //remove stuff that might stick down under the base
        translate([0,0,-5])
        cube(size = [100, 100, 14], center = true);
    }
}


module clearForScrewsAndStuff()
{
    xOffsetFront = front_cc/2;
    xOffsetRear = rear_cc/2;
    yOffset = front_rear_cc/2;
    
    difference()
    {
        children();
        union()
        {
            //Screw holes
            translate([-xOffsetFront, yOffset, (base_thickness+1)/2])
            cylinder(h=base_thickness+1, r=hole_radius, center = true); 
            translate([xOffsetFront, yOffset, (base_thickness+1)/2])
            cylinder(h=base_thickness+1, r=hole_radius, center = true); 
            translate([xOffsetRear, -yOffset, (base_thickness+1)/2])
            cylinder(h=base_thickness+1, r=hole_radius, center = true); 
            translate([-xOffsetRear, -yOffset, (base_thickness+1)/2])
            cylinder(h=base_thickness+1, r=hole_radius, center = true); 
                       
            //Clearing for rear screw heads
            //(Left)
            translate([xOffsetRear, -yOffset, 50+base_thickness])
            cylinder(h=100, r=screw_head_clerance, center = true); 
            translate([-rear_cc, -yOffset-20, base_thickness])
            cube(size=[xOffsetRear+screw_head_clerance, 20, 100]);
            translate([-rear_cc, -yOffset, base_thickness])
            cube(size=[xOffsetRear, screw_head_clerance, 100]);   
            //(Right)
            translate([-xOffsetRear, -yOffset, 50+base_thickness])
            cylinder(h=100, r=screw_head_clerance, center = true);
            translate([xOffsetRear-screw_head_clerance, -front_rear_cc/2-20, base_thickness])
            cube(size=[xOffsetRear+screw_head_clerance, 20, 100]);
            translate([xOffsetRear, -front_rear_cc/2, base_thickness])
            cube(size=[xOffsetRear, screw_head_clerance, 100]);
                        
            //Remove overhang on mount
            //(Front)
            translate([-20, yOffset+hole_clearence, 0])
            cube(size=[40, 15, 100]);
            //(Rear)
            translate([0, -(yOffset+50+hole_clearence), 0])
            cube(size=[40, 100, 100], center = true);
            
            //Clearing for front screw heads
            if( tan(angle)*(front_rear_cc+hole_clearence*2) < 15 )
            {
                //remove all way through, beacuse of the (probably) low angle                
                translate([-xOffsetFront, yOffset, 50+base_thickness])
                cylinder(h=100, r=screw_head_clerance, center = true);
                translate([-front_cc, yOffset, base_thickness])
                cube(size=[xOffsetFront+screw_head_clerance, 5, 100]);
                translate([-front_cc, yOffset-screw_head_clerance, base_thickness])
                cube(size=[xOffsetFront, screw_head_clerance, 100]);
                translate([xOffsetFront, yOffset, 50+base_thickness])
                cylinder(h=100, r=screw_head_clerance, center = true); 
                translate([xOffsetFront-screw_head_clerance, front_rear_cc/2, base_thickness])
                cube(size=[xOffsetFront+screw_head_clerance, 5, 100]);
                translate([xOffsetFront, yOffset-screw_head_clerance, base_thickness])
                cube(size=[xOffsetFront, screw_head_clerance, 100]);
            } 
            
            //Add holes for tool to go thrpugh mount
            translate([-xOffsetFront, yOffset, 50+base_thickness])
            cylinder(h=100, r=2.5, center = true);
            translate([xOffsetFront, yOffset, 50+base_thickness])
            cylinder(h=100, r=2.5, center = true);             
        }
    }
}


clearForScrewsAndStuff()
{
    $fn = 48;
    createBase();
    createWedge();    
    createMount();    
}
