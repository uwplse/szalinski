//Depth of camera
camera_depth = 20.2;
//Height of the supporting back
back_height = 30;
//C/C Distance between front holes
front_cc = 30;
//C/C Distance between rear holes
rear_cc = 36;
//C/C Distance between front and rear holes
front_rear_cc = 49.5;
//angle of camera
angle = 30; //[10:45]
//Thickness of the base
base_thickness = 3;
//Hole diameter (may need adjustment depending on printer)
hole_size = 3.2;
//Determines the amount of "meat" around the holes
edge_margin = 3;
//Diameter of screw head (to allow enough clerance)
screw_head_size = 6;
//Wedge offset from front
front_offset = 0;
//Add lip to fron of wedge
use_lip = "No"; //[Yes,No]
//Velcro strap width
velcro_width = 18;
//Velcro strap thickness
velcro_thickness = 3;
//Added height under the camera e.g. for prop clearence
added_height = 0;


//Calculated variables wont be visible to Thingiverse customizer
hole_clearence = edge_margin+hole_size/2;
screw_head_clerance = screw_head_size / 2;
hole_radius = hole_size / 2;
lip_thickness = use_lip == "Yes" ? 2*1 : 0*1;
lip_height =  use_lip == "Yes" ? 2*1 : 0*1;

//internal global varaibles
_xFrontOffset = front_cc/2;
_xRearOffset = rear_cc/2;
_xTotFrontOffset = front_cc/2+hole_clearence;
_xTotRearOffset = rear_cc/2+hole_clearence;
_yOffset = front_rear_cc/2;
_yTotOffset = front_rear_cc/2+hole_clearence;
_cameraHolderDepth = (lip_thickness+camera_depth)*cos(angle)+back_height*sin(angle)+lip_thickness;
_cameraHolderHeight = back_height*cos(angle) + base_thickness + velcro_thickness + added_height;
_wedgeStartYoffset = _yTotOffset - front_offset;
_wedgeEndYoffset = _yTotOffset - front_offset - _cameraHolderDepth;
_rearSpaceLeft = _yTotOffset * 2 - front_offset - _cameraHolderDepth;
_totWidth = front_cc > rear_cc ? front_cc + hole_clearence*2 : rear_cc + hole_clearence*2;
_velcroXpos = (velcro_width + edge_margin) < (front_cc+2*edge_margin+hole_size) / 2 ? 0 :  ((front_cc+2*edge_margin+hole_size) / 1 )-(velcro_width + edge_margin);

module createBase()
{   
           
    difference()
    {
        linear_extrude( height = _cameraHolderHeight)
        {
            union()
            {
                if( front_offset > 0 )
                {
                    polygon(
                                points = [  [-_xTotFrontOffset, _yOffset],
                                            [-_xFrontOffset+hole_clearence, _yOffset],
                                            [-_xFrontOffset+hole_clearence, _wedgeStartYoffset],
                                            [_xFrontOffset-hole_clearence, _wedgeStartYoffset],
                                            [_xFrontOffset-hole_clearence, _yOffset],
                                            [_xTotFrontOffset, _yOffset], 
                                            [_xTotRearOffset, -_yOffset], 
                                            [_xRearOffset-hole_clearence, -_yOffset], 
                                            [_xRearOffset-hole_clearence, _wedgeEndYoffset], 
                                            [-_xRearOffset+hole_clearence, _wedgeEndYoffset], 
                                            [-_xRearOffset+hole_clearence, -_yOffset], 
                                            [-_xTotRearOffset, -_yOffset] ], 
                                convexity = 10);
                } else {
                    polygon(
                                points = [  [-_xFrontOffset, _yOffset+hole_clearence],                                        [_xFrontOffset, _yOffset+hole_clearence], 
                                            [_xTotFrontOffset, _yOffset], 
                                            [_xTotRearOffset, -_yOffset], 
                                            [_xRearOffset-hole_clearence, -_yOffset], 
                                            [_xRearOffset-hole_clearence, _wedgeEndYoffset], 
                                            [-_xRearOffset+hole_clearence, _wedgeEndYoffset], 
                                            [-_xRearOffset+hole_clearence, -_yOffset], 
                                            [-_xTotRearOffset, -_yOffset],
                                            [-_xTotFrontOffset, _yOffset]],
                                convexity = 10);
                }
                translate([-_xFrontOffset, _yOffset, 0])
                circle(r=hole_clearence, center = false); 
                translate([_xFrontOffset, _yOffset, 0])
                circle(r=hole_clearence, center = false); 
                translate([_xRearOffset, -_yOffset, 0])
                circle(r=hole_clearence, center = false); 
                translate([-_xRearOffset, -_yOffset, 0])
                circle(r=hole_clearence, center = false); 
                if(front_offset > hole_clearence*2)
                {
                    difference()
                    {
                        union()
                        {
                            translate([_xFrontOffset-hole_clearence*2, _wedgeStartYoffset, 0])
                            square([hole_clearence,hole_clearence]);
                            translate([-_xFrontOffset+hole_clearence, _wedgeStartYoffset, 0])
                            square([hole_clearence,hole_clearence]);
                        }
                        union()
                        {
                            translate([_xFrontOffset-hole_clearence*2, _wedgeStartYoffset+hole_clearence, 0])
                            circle(r=hole_clearence, center = false); 
                            translate([-_xFrontOffset+hole_clearence*2, _wedgeStartYoffset+hole_clearence, 0])                circle(r=hole_clearence, center = false);   
                        }
                    }
                }
                if((_yTotOffset + _wedgeEndYoffset) > hole_clearence*2)
                {
                    difference()
                    {
                        union()
                        {
                            translate([_xRearOffset-hole_clearence*2, _wedgeEndYoffset-hole_clearence, 0])
                            square([hole_clearence,hole_clearence]);
                            translate([-_xRearOffset+hole_clearence, _wedgeEndYoffset-hole_clearence, 0])
                            square([hole_clearence,hole_clearence]);
                            
                        }
                        union()
                        {
                            translate([_xRearOffset-hole_clearence*2, _wedgeEndYoffset-hole_clearence, 0])
                            circle(r=hole_clearence, center = false); 
                            translate([-_xRearOffset+hole_clearence*2, _wedgeEndYoffset-hole_clearence, 0])
                            circle(r=hole_clearence, center = false); 
                        }
                    }
                }
            }
        }
        union()
        {
            translate([-_totWidth/2, _wedgeStartYoffset, base_thickness])
            cube([_totWidth,front_rear_cc,_cameraHolderHeight], center = false);
            rearSpace = _yTotOffset + _wedgeEndYoffset;
            translate([-_totWidth/2, _wedgeEndYoffset-rearSpace, base_thickness])
            cube([_totWidth,rearSpace,_cameraHolderHeight], center = false);
        }
    }    
}

module addWedge()
{
    totWidth = front_cc > rear_cc ? front_cc + edge_margin*2+hole_size: rear_cc + edge_margin*2+hole_size;
                xOffset = totWidth/2;  
    difference()
    {
        difference()
        {
            children();
            union()
            {
                          
                yOffset = (front_rear_cc/2+edge_margin+hole_size/2)-(lip_thickness+camera_depth)*cos(angle) -front_offset;
                translate([-xOffset, yOffset, base_thickness+velcro_thickness+added_height])
                rotate([angle,0,0])
                cube([totWidth, camera_depth, back_height+5], center = false);
                
            }
        }
       
        union()
       {
           yOffset = (front_rear_cc/2+edge_margin+hole_size/2)-lip_thickness*cos(angle) -front_offset; 
                zOffset = base_thickness+velcro_thickness + camera_depth*sin(angle) + added_height;
                translate([-xOffset, yOffset, zOffset])
                rotate([angle,0,0])
                translate([0, -1, lip_height])
                cube([totWidth, front_rear_cc, back_height+5], center = false);
                translate([-xOffset, yOffset, zOffset])
                rotate([angle,0,0])
                translate([0, lip_thickness, 0])
                cube([totWidth, front_rear_cc, back_height+5], center = false);
       }
    }
}

module addStrapHole()
{
    difference()
    {
        children();
        union()
        {
            yOffset = (front_rear_cc/2+edge_margin+hole_size/2)-lip_thickness*cos(angle) -front_offset; 
            zOffset = base_thickness+velcro_thickness + camera_depth*sin(angle);
            translate([0, yOffset, zOffset+added_height])
            rotate([angle,0,0])
            translate([_velcroXpos, 0, -zOffset+base_thickness])
            cube([velcro_width, lip_thickness+1, zOffset*2], center = true);
            ySize = camera_depth + base_thickness + velcro_thickness;
            translate([0, yOffset, zOffset])
            rotate([angle,0,0])            
            translate([_velcroXpos, -ySize, -base_thickness-velcro_thickness])
            cube([velcro_width, ySize+1, velcro_thickness], center = true);
            translate([0, yOffset, zOffset])
            rotate([angle,0,0])            
            translate([_velcroXpos, -ySize, -base_thickness-velcro_thickness])            
            cube([velcro_width, velcro_thickness, back_height*1.5], center = true);
            
        }
    }
}

module clearForScrews()
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
            translate([xOffsetRear, -yOffset, 50+base_thickness])
            cylinder(h=100, r=screw_head_clerance, center = true);        translate([-xOffsetRear, -yOffset, 50+base_thickness])
            cylinder(h=100, r=screw_head_clerance, center = true);
            translate([-xOffsetFront, yOffset, 50+base_thickness])
            cylinder(h=100, r=screw_head_clerance, center = true);
            translate([xOffsetFront, yOffset, 50+base_thickness])
            cylinder(h=100, r=screw_head_clerance, center = true);             
        }
    }
}


$fn = 48;
clearForScrews()
{
    addStrapHole()
    {
        addWedge()
        {
            createBase();
        }
    }
}
