//************************************************
// Customizable Miniquad Gopro & Mobius Mount
//
// Script written by Ulf Lindeström 2015-10-14
// 
// Feel free to do any changes you want, but
// please leave this section intact
//
// Creative Commons - Attribution - Non-Commercial
// 
// Please respect the license, dont sell this item
//************************************************

//******* Customizer parameters ******************

/* [Basic] */

//which part/parts do you need
Parts_to_print = "Both"; // [Both, Base, Wedge]
//Camera angle
angle = 25; // [15:45]
//Width of velcro strap
velcro_width = 18;
//Thickness of velcr0 strap
velcro_thickness = 3;
//GoPro (or similar) housing depth
camera_depth = 20;
//GoPro (or similar) housing height
camera_height = 40;
//cc distance between front holes

/* [Dimensions] */

front_cc = 30;
//cc distance between rear holes
rear_cc = 36;
//distance between front and rear holes
front_rear_cc = 49.5;
//Hole diameter for screws
hole_size = 3.2;
//Diameter of screw head
screw_head_size = 6;
//The amount of "meat" around the holes
edge_thickness = 3;
//Thickness of the base
base_thickness = 3;
//Margin, adjust if the parts dont slide together
margin = 0.4; 

//****************************************


//Nonadjustable parameters
velcroSupportThickness = angle < 20 ? 3: 4;   //Thickness of walls around the velcro
mobiusSupportHeight = 10*1;     //Height of the side support for the mobius
mobiusLength = 65*1;         //Length of mobius   
mobiusWidth = 35*1;         //Width of mobius
mobiusRadius = 3;           //the radius of the mobius edge

//Helpvalues
frontHeight = sin(angle)*mobiusLength+base_thickness;
goProFrontHeight = sin(angle)*camera_depth+base_thickness+velcro_thickness;
maxWidth = front_cc > rear_cc ? front_cc + hole_size + edge_thickness*2 : rear_cc + hole_size + edge_thickness*2;
totDepth = front_rear_cc + hole_size + edge_thickness*2;
goproSolidBackHeight = (frontHeight-goProFrontHeight)*cos(angle);

module createBase()
{
    supportOffset = camera_depth + (goproSolidBackHeight)*tan(angle) + goproSolidBackHeight + margin/2;
        
    intersection()
    {
        difference()
        {
            translate([-maxWidth/2, -totDepth/2,0])
            cube([maxWidth,totDepth,frontHeight*2]);            
            union()
            {
                translate([-front_cc/2, front_rear_cc/2,0])
                cylinder(h=base_thickness, r=hole_size/2);
                translate([front_cc/2, front_rear_cc/2,0])
                cylinder(h=base_thickness, r=hole_size/2);
                translate([rear_cc/2, -front_rear_cc/2,0])
                cylinder(h=base_thickness, r=hole_size/2);
                translate([-rear_cc/2, -front_rear_cc/2,0])
                cylinder(h=base_thickness, r=hole_size/2);
                translate([-front_cc/2, front_rear_cc/2,base_thickness])
                cylinder(h=frontHeight*2, r=screw_head_size/2);
                translate([front_cc/2, front_rear_cc/2,base_thickness])
                cylinder(h=frontHeight*2, r=screw_head_size/2);
                translate([rear_cc/2, -front_rear_cc/2,base_thickness])
                cylinder(h=frontHeight*2, r=screw_head_size/2);
                translate([-rear_cc/2, -front_rear_cc/2,base_thickness])
                cylinder(h=frontHeight*2, r=screw_head_size/2);
                yoffset = supportOffset < (mobiusLength-10) ? supportOffset : mobiusLength;
                translate([-maxWidth/2, front_rear_cc/2+hole_size/2+edge_thickness,frontHeight])            rotate([angle, 0, 0])
                
                
                
                translate([0,-yoffset,0])
                cube([maxWidth,mobiusLength*2,frontHeight*2]);
                tempDepth = mobiusLength*cos(angle);                
                
                if( tempDepth < totDepth)
                {
                    translate([-maxWidth/2, -totDepth/2-1,base_thickness])
                    cube([maxWidth, totDepth-tempDepth+1,frontHeight*2]);
                }
                
                translate([0,totDepth/2,frontHeight])
                rotate([angle-90,0,0])
                union()
                {
                    translate([-(mobiusWidth-(mobiusRadius*2))/2,0,0])            
                    translate([0,-mobiusRadius,-mobiusLength/2])
                    cylinder(r=mobiusRadius, h=mobiusLength, center = true);                    translate([(mobiusWidth-(mobiusRadius*2))/2,0,0])                    translate([0,-mobiusRadius,-mobiusLength/2])
                    cylinder(r=mobiusRadius, h=mobiusLength, center = true);
                    translate([0,-(mobiusRadius+(mobiusSupportHeight/2)),-mobiusLength/2])                 
                    cube(size = [mobiusWidth, mobiusSupportHeight, mobiusLength], center = true);
                    translate([0,-mobiusRadius,-mobiusLength/2])
                    cube(size = [mobiusWidth-mobiusRadius*2, mobiusRadius*2, mobiusLength], center = true);
                    translate([-maxWidth/2,0,0])
                    rotate([-(angle-90)+angle, 0, 0])
                    translate([0,-mobiusLength,mobiusSupportHeight])
                    cube([maxWidth,mobiusLength,frontHeight*2]);
                }
                
                translate([-maxWidth/2, totDepth/2, goProFrontHeight])
                rotate([angle,0,0])
                translate([0, -camera_depth, 0])
                union()
                {
                    cube([maxWidth,camera_depth*3,frontHeight]);
                    translate([0, -velcroSupportThickness*2,goproSolidBackHeight-velcroSupportThickness*2])
                    union()
                    {
                        cube([maxWidth/2-velcroSupportThickness/2,velcroSupportThickness*2,velcroSupportThickness]);
                        translate([0, 0,-velcroSupportThickness/2])
                        cube([maxWidth/2-velcroSupportThickness/2,velcroSupportThickness,velcroSupportThickness*1.5]);
                    }
                    translate([maxWidth/2+velcroSupportThickness/2, -velcroSupportThickness*2, goproSolidBackHeight-velcroSupportThickness*2])
                    union()
                    {
                        cube([maxWidth/2-velcroSupportThickness/2,velcroSupportThickness,velcroSupportThickness*2]);
                        translate([0, -velcroSupportThickness/2, 0])
                        cube([maxWidth/2-velcroSupportThickness/2,velcroSupportThickness*1.5,velcroSupportThickness]);
                    }
                }
                
                
                
            }
        }
        linear_extrude(height=frontHeight*2)
        {
            hull()
            {
                polygon([   [-front_cc/2, front_rear_cc/2],
                            [front_cc/2, front_rear_cc/2],
                            [rear_cc/2, -front_rear_cc/2],
                            [-rear_cc/2, -front_rear_cc/2]]);
                
                translate([-front_cc/2, front_rear_cc/2,0])
                circle(r=edge_thickness+hole_size/2);
                translate([front_cc/2, front_rear_cc/2,0])
                circle(r=edge_thickness+hole_size/2);
                translate([rear_cc/2, -front_rear_cc/2,0])
                circle(r=edge_thickness+hole_size/2);
                translate([-rear_cc/2, -front_rear_cc/2,0])
                circle(r=edge_thickness+hole_size/2);
            }
        }
    }
    
}

module addStrapHoles()
{
    difference()
    {
        children();
        union()
        {
            translate([0,totDepth/2,goProFrontHeight])
            rotate([angle,0,0])
            union()
            {
                translate([front_cc/2-velcro_width-screw_head_size/2-1,0,0])
                union()
                {
                    translate([0,-mobiusLength,-(velcroSupportThickness+velcro_thickness)])
                    cube([velcro_width,mobiusLength+1,velcro_thickness]);
                    translate([0,-camera_depth-velcroSupportThickness*3-velcro_thickness,goproSolidBackHeight-frontHeight])
                    cube([velcro_width,velcro_thickness,frontHeight+1]);
                    
                    tempZoffset = (goProFrontHeight-((camera_depth+velcroSupportThickness*3+velcro_thickness)*sin(angle)))/cos(angle);
                    translate([0,-camera_depth-velcroSupportThickness*3-velcro_thickness,-tempZoffset-1])
                    rotate([-angle,0,0])
                    cube([velcro_width,5*velcroSupportThickness,velcro_thickness+1]);
                }
                
            }
            
            translate([-maxWidth/2,totDepth/2-camera_depth*cos(angle)-velcroSupportThickness*2-velcro_width,0])
            cube([maxWidth,velcro_width,velcro_thickness]);
        }
    }
}

module createWedge()
{
    zOffset = goProFrontHeight-camera_depth*sin(angle);
    yOffset = totDepth/2-camera_depth*cos(angle);
        
    intersection()
    {
        translate([-maxWidth/2, -camera_depth, 0])
        union()
        {   
            {
                difference()
                {
                    union()
                    {
                        translate([0,margin/2, margin/2])
                        cube([maxWidth,camera_depth-margin/2,goproSolidBackHeight-margin/2]);
                        translate([0,-velcroSupportThickness*2+margin/2, goproSolidBackHeight-velcroSupportThickness*2+margin/2])
                        cube([maxWidth/2-velcroSupportThickness/2-margin/2,velcroSupportThickness*2,velcroSupportThickness-margin]);
                        translate([0,-velcroSupportThickness*2+margin/2, goproSolidBackHeight-velcroSupportThickness*2.5+margin/2])
                        cube([maxWidth/2-velcroSupportThickness/2-margin/2,velcroSupportThickness-margin,velcroSupportThickness/2]);
                    }
                    tempAngle = atan2(velcroSupportThickness*3,camera_height-goproSolidBackHeight);
                    translate([(maxWidth-front_cc)/2+screw_head_size/2+1, 0, goproSolidBackHeight-(velcroSupportThickness*3+velcro_thickness)])
                    rotate([tempAngle,0,0])
                    cube([velcro_width,camera_depth*2,velcro_thickness]);
                }
            }
        }
        rotate([-angle,0,0])
        translate([0,-totDepth/2,-goProFrontHeight])
        
        linear_extrude(height=frontHeight)
        {
            hull()
            {
                polygon([   [-front_cc/2, front_rear_cc/2],
                            [front_cc/2, front_rear_cc/2],
                            [rear_cc/2, -front_rear_cc/2],
                            [-rear_cc/2, -front_rear_cc/2]]);
                
                translate([-front_cc/2, front_rear_cc/2,0])
                circle(r=edge_thickness+hole_size/2);
                translate([front_cc/2, front_rear_cc/2,0])
                circle(r=edge_thickness+hole_size/2);
                translate([rear_cc/2, -front_rear_cc/2,0])
                circle(r=edge_thickness+hole_size/2);
                translate([-rear_cc/2, -front_rear_cc/2,0])
                circle(r=edge_thickness+hole_size/2);
            }
        }
    }    
}

$fn=48;
if( Parts_to_print == "Both" || Parts_to_print == "Base")
{
    addStrapHoles()
    {
        createBase();
    }
}
if( Parts_to_print == "Both" )
{
    translate([maxWidth,0,goproSolidBackHeight])
    rotate([0,180,90])
    createWedge();
} 
else if( Parts_to_print == "Wedge" )
{
    translate([-camera_depth/2,0,goproSolidBackHeight])
    rotate([0,180,90])
    createWedge();
}

//Testfitting*****

/*
//Mobius
translate([0,totDepth/2,goProFrontHeight])
rotate([angle,0,0])
createWedge();
*/
/*
//GoPro
translate([0,totDepth/2,goProFrontHeight])
rotate([angle,0,0])
translate([0,-camera_depth-goproSolidBackHeight,goproSolidBackHeight+camera_depth])
rotate([90,0,180])
createWedge();
*/
//**********
