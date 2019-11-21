echo(version=version());

// Propellor Diameter (mm) - This drives the internal diameter of the duct, so add a little.
prop_diameter = 60;
// Propellor Height (mm) - This drives the height of the duct diameter of the duct.
prop_height=5.2;
// Motor Height (mm) - This is the height from the motor mount to the bottom of the duct, so subtract a little.
motor_height=12.5;
// Motor Diameter (mm) - This defines the size of the motor mount.
motor_diameter=14;

// Duct Thickness (mm) - This is the wall thickness of the duct.
duct_thickness=1.6;
// Arm Thickness (mm) - This is the thickness of the arms (in height and width).
arm_thickness=4;
// Duct Offset (mm) - defines the spacing between ducts, tweak this to ensure the ducts don't overlap.
duct_offset=48;

// Plate Thickness (mm) - This is the thickness of the middle connecting plate.
plate_thickness=2;

// Flight Controller Screw Spacing (mm) - Distance between the FC screws.
fc_screw_spacing=20;
// Flight Controller Screw Hole (mm) - FC screw hole size.
fc_screw_hole=2.5;
// Flight Controller Screw Hole Surround (mm) - FC screw hole surround size.
fc_screw_hole_surround=6;

// Motor Screw Spacing (mm) - Distance between the motor screws.
motor_screw_hole_spacing=9;
// Motor Screw Hole (mm) - Motor screw hole size.
motor_screw_hole=2.5;
// Motor Axle Hole (mm) - Motor axle hole size.
motor_axle_hole=5;

// Resolution - This is how smooth the curved surfaces will be... this number is the number of faces on a 360 degree surface.
resolution=128;

duct_bottom=motor_height;
duct_height=prop_height*2;

union()
    {   
    //centre
    translate([0,0,duct_bottom+plate_thickness])
    linear_extrude(plate_thickness)
    union()
        {
        difference()
            {
            square(size=[duct_offset*1.41421356237,duct_offset*1.41421356237],center=true);
            for(degrees2 = [45 : 90 : 315])
                {
                rotate([0,0,degrees2])
                translate([duct_offset,0,0])
                circle(prop_diameter/2+0.5*duct_thickness, $fn=resolution);
                }
            circle(fc_screw_spacing/2+fc_screw_hole/2,$fn=resolution);
                
            }
        for(degrees = [45 : 90 : 315])
            {
            rotate([0,0,degrees])
            translate([fc_screw_spacing/2,0,0])
            difference()
                {
                circle(fc_screw_hole_surround/2,$fn=resolution);
                circle(fc_screw_hole/2,$fn=resolution);
                }
            
            }
        }
    for(degrees = [45 : 90 : 315])
        {
        rotate([0,0,degrees])
        translate([duct_offset,0,0])
        union()
            {

            //arms
            union()
                {
                linear_extrude(arm_thickness)
                difference()
                    {
                    circle(motor_diameter/2, $fn=resolution);
                    for(degrees = [0 : 90 : 270])
                        {
                        rotate([0,0,degrees])
                        translate([motor_screw_hole_spacing/2,0,0])
                        circle(motor_screw_hole/2,$fn=resolution);
                        }
                        circle(motor_axle_hole/2, $fn=resolution);
                    }
                    
                difference(){
                rotate_extrude(angle = 360, convexity = 10, $fn=resolution)
                union()
                    {
                        difference()
                        {
                            translate([(prop_diameter/2)-arm_thickness+duct_thickness,duct_bottom,0])
                            circle(arm_thickness);
                            translate([(prop_diameter/2)-(arm_thickness*2)+duct_thickness,duct_bottom,0])
                            square(size=[arm_thickness*2,arm_thickness]);
                        }
                        difference()
                        {
                            translate([motor_diameter+arm_thickness,duct_bottom-arm_thickness,0])
                            circle(arm_thickness);
                            translate([motor_diameter,duct_bottom-2*arm_thickness,0])
                            square(size=[arm_thickness*2,arm_thickness]);
                        }
                        translate([motor_diameter+arm_thickness,duct_bottom-arm_thickness,0])
                        square(size=[(prop_diameter/2)-2*arm_thickness+duct_thickness-motor_diameter,arm_thickness]);
                        difference()
                        {
                            translate([motor_diameter,arm_thickness,0])
                            circle(arm_thickness);
                            translate([motor_diameter-arm_thickness,arm_thickness,0])
                            square(size=[arm_thickness*2,arm_thickness]);
                        }
                        translate([motor_diameter,arm_thickness,0])
                        square(size=[arm_thickness,duct_bottom-2*arm_thickness]);
                        translate([motor_diameter/2,0,0])
                        square(size=[motor_diameter/2,arm_thickness]);
                    }
                    
                // cutouts
                translate([0,0,-0.5*duct_bottom])
                linear_extrude(duct_bottom*2)
                    difference(){
                        circle((prop_diameter/2)+duct_thickness*2);
                        for(degrees2 = [60 : 120 : 300])
                            {
                            rotate([0,0,degrees2])translate([0,-0.5*arm_thickness,0])square(size=[(prop_diameter)+duct_thickness*2,arm_thickness]);
                            }
                    }
                }
            }
            // duct
            translate([0,0,duct_bottom])
            rotate_extrude(angle = 360, convexity = 10, $fn=resolution)
            translate([-duct_thickness-(prop_diameter/2),0])
            union() 
                { 
                // straight part
                square([duct_thickness,duct_height]);
                
                // curved lip
                difference()
                    {
                    difference() 
                        { 
                        translate([duct_thickness-duct_height,duct_height]) circle(duct_height); 
                        translate([-duct_height*2,duct_height]) circle(2*duct_height);
                        };
                    translate([-duct_height,0]) 
                    square([duct_height*2,duct_height]);
                    }
                       
                } 
            }
        }
    }


    



//color("white")
//  translate([0,-0,duct_bottom])
//    hollowCylinder(d=60+duct_thickness,h=duct_height,wallWidth=duct_thickness);
