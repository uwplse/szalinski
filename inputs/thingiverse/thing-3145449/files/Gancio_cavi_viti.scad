$fn=72;

//0= round     1=Oval      2=rectangular
Type=0;
//Structure measures
Foot_length=15;
Structure_thickness=6;
Structure_height=10;
//Rounded structure measures
Radius=40;
//Rectangular structure measures
Side_1=20;
Side_2=75;
//Screws measures
Screw_hole_radius=1.75;
Screw_hole_recess_radius=3.2;
Screw_hole_recess_depth=3;


//--------------------------------------------------------------------------------------------------

if(Type==0)
difference()
    {
    union()
        {
        translate([Radius/1.25,0,0])
            cylinder(r=Radius+Structure_thickness,h=Structure_height);
        translate([0,-Radius-Foot_length,0])
            cube([Structure_thickness,Radius*2+Foot_length*2,Structure_height]);
        }

        translate([Radius/1.25,0,-1])
            cylinder(r=Radius,h=Structure_height+2);
        translate([-Radius*4,-Radius*2,-Structure_height/2])
            cube([Radius*4,Radius*4,Structure_height*2]);            

//Screw holes
        translate([-2,Radius+Foot_length-Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_radius,h=Structure_height*2);
        translate([-2,-Radius-Foot_length+Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_radius,h=Structure_height*2);
//Screw holes recesses
        translate([Structure_thickness-Screw_hole_recess_depth,Radius+Foot_length-Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_recess_radius,h=Structure_height);
        translate([Structure_thickness-Screw_hole_recess_depth,-Radius-Foot_length+Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_recess_radius,h=Structure_height);

    }

if(Type==1)
difference()
    {
    union()
        {
        scale([0.5,1,1])
        translate([Radius/1.25,0,0])
            cylinder(r=Radius+Structure_thickness,h=Structure_height);
        translate([0,-Radius-Foot_length,0])
            cube([Structure_thickness,Radius*2+Foot_length*2,Structure_height]);
        }

        scale([0.5,1,1])
        translate([Radius/1.25,0,-1])
            cylinder(r=Radius,h=Structure_height+2);
        translate([-Radius*4,-Radius-Foot_length*2,-Structure_height/2])
            cube([Radius*4,Radius*2+Foot_length*4,Structure_height*2]);          

//Screw holes
        translate([-2,Radius+Foot_length-Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_radius,h=Structure_height*2);
        translate([-2,-Radius-Foot_length+Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_radius,h=Structure_height*2);
//Screw holes recesses
        translate([Structure_thickness-Screw_hole_recess_depth,Radius+Foot_length-Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_recess_radius,h=Structure_height);
        translate([Structure_thickness-Screw_hole_recess_depth,-Radius-Foot_length+Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_recess_radius,h=Structure_height);
  
    }


if(Type==2)
difference()
    {
    union()
        {
        translate([0,-Side_2/2-Structure_thickness,0])
            cube([Side_1+Structure_thickness,Side_2+Structure_thickness*2,Structure_height]);
        translate([0,-Side_2/2-Structure_thickness-Foot_length,0])
            cube([Structure_thickness,Side_2+Structure_thickness*2+Foot_length*2,Structure_height]);
        }

        translate([-0.1,-Side_2/2,-1])
            cube([Side_1,Side_2,Structure_height+2]);

//Screw holes
        translate([-2,Side_2/2+Structure_thickness+Foot_length-Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_radius,h=Structure_height*2);
        translate([-2,-Side_2/2-Structure_thickness-Foot_length+Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_radius,h=Structure_height*2);
//Screw holes recesses
        translate([Structure_thickness-Screw_hole_recess_depth,Side_2/2+Structure_thickness+Foot_length-Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_recess_radius,h=Structure_height);
        translate([Structure_thickness-Screw_hole_recess_depth,-Side_2/2-Structure_thickness-Foot_length+Screw_hole_recess_radius*1.5,Structure_height/2])
            rotate([0,90,0])
            cylinder(r=Screw_hole_recess_radius,h=Structure_height);
            
    }