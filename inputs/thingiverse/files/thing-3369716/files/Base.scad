///////////NOTES//////////

///////////INCLUDES/////////

include<utils/build_plate.scad>

///////////PARAMETERS/////////

/*[Build Plate Specifications]*/

//Build plate X dimension in mm.
X_Dimension=220;
//Build plate Y dimension in mm.
Y_Dimension=220;

/*[Spool Measurements]*/

//Inner diameter of the spool, measured in mm.
Spool_Inner_Diameter=57.6;
//Height of the spool, measured in mm.
Spool_Height=60.5;

/*[Base Specifications]*/

//Diameter of the base, measured in mm.
Base_Diameter=100;
//Thickness of the base, measured in mm.
Base_Thickness=4;

/*[Hidden]*/

Build_Plate=3;
Spool_Radius=Spool_Inner_Diameter/2;
Spool_Sleeve=Spool_Height/2;
Bearing_Diameter=Spool_Radius*.5;

$fn=360;

/*[Additional Specifications]*/

//Extra width added to hold the spool, measured in mm.
Spool_Tray=10;
//Thickness of the tray that will hold up the spool, measured in mm.
Tray_Thickness=2;
//Height of the bearing, measured in mm.
Bearing_Height=10;
//A gap in the bearing to allow for movement, measured in mm.
Race_Gap=.25; //[.1:.05:.5]
//Gap between the bottom spool and the tray that supports the top spool, measured in mm.
Spool_Gap=3;
//Thickness of every wall except the the tray and bearing, measured in mm.
Wall_Thickness=2;

/*[Supports]*/

//Number of supports that hold the bottom tray away from the top tray.
Center_Supports=15;
//Number of supports outside the bearing that originate on the base.
Outside_Supports=20;
//Width of the supports in mm.
Support_Width=.96;
//Distance between the bottom supports and the vertical walls to allow for easy removal. Measured in mm.
Horizontal_Support_Gap=.5;
//Distance between all supports and the layers above and/or below them. Should be a multiple of your layer height. Measured in mm.
Vertical_Support_Gap=.3;

///////////MODULES///////////

module bearing_radius(diameter=Bearing_Height){ //Inner Race Radius
    translate([(Bearing_Height+Bearing_Diameter)/2,Bearing_Height/2,0])
        circle(d=diameter);
}
module inner_race(){
    union(){
        square([(Bearing_Height+Bearing_Diameter)/2,Bearing_Height]);
        bearing_radius();
    }
}
module outer_race(){
    difference(){
        square([Spool_Inner_Diameter/2,Bearing_Height]);
        union(){
            square([Race_Gap,Bearing_Height]);
            translate([Race_Gap,-Race_Gap,0])
            scale([1,Race_Gap/(Bearing_Height/2)+1,1])
                inner_race();
                bearing_radius();
        }
    }
}


module spool_gap(){
    translate([(Bearing_Height+Bearing_Diameter)/2-Wall_Thickness,-Spool_Gap,0])
        square([Wall_Thickness,Spool_Gap]);
}

module tray(){
    translate([0,-Spool_Gap-Tray_Thickness,0])
        square([Spool_Radius+Spool_Tray,Tray_Thickness]);
}

module sleeve(){
    translate([Spool_Radius-Wall_Thickness,-Spool_Gap-Spool_Sleeve-Tray_Thickness,0])
        square([Wall_Thickness,Spool_Sleeve]);
}

module base(){
    mirror([0,1,0]){
        translate([0,-Bearing_Height])
            difference(){
                square([Base_Diameter/2,Base_Thickness]);
            union(){
                square([Race_Gap,Bearing_Height]);
                translate([Race_Gap,-Race_Gap,0])
                scale([1,Race_Gap/(Bearing_Height/2)+1,1])
                    inner_race();
                    bearing_radius();
            }
        }
    }
}

module bearing_support(){
    for(s=[0:1:Bearing_Diameter/2]){
        rotate([0,0,s*360/(Bearing_Diameter/2)]){
            translate([0,0,-Spool_Gap])
                cube([(Bearing_Height+Bearing_Diameter)/2-Wall_Thickness,Support_Width,Spool_Gap]);
        }
    }
}

module center_supports(){
    for(s=[0:1:Center_Supports]){
        rotate([0,0,s*360/Center_Supports]){
            difference(){
                translate([0,0,-Spool_Gap+Vertical_Support_Gap])
                    cube([Spool_Radius,Support_Width,Spool_Gap-Vertical_Support_Gap*2]);
                translate([0,-.5,-Spool_Gap])
                    cube([(Bearing_Height+Bearing_Diameter)/2+Wall_Thickness,Support_Width+1,Spool_Gap+1]);
            }
        }
    }
}

module outside_supports(){
    for(s=[0:1:Outside_Supports]){
        rotate([0,0,s*360/Outside_Supports]){
            translate([Spool_Radius+Horizontal_Support_Gap,0,-Spool_Gap+Vertical_Support_Gap])
                cube([Spool_Tray-Horizontal_Support_Gap,Support_Width,Bearing_Height-Vertical_Support_Gap*2+Spool_Gap-Base_Thickness]);
        }
    }
}


///////////RENDERS///////////

build_plate(Build_Plate,X_Dimension,Y_Dimension);

translate([0,0,Bearing_Height]){
        mirror([0,0,1]){
            union(){
                rotate_extrude(){
                    inner_race();
                    outer_race();
                    sleeve();
                    spool_gap();
                    tray();
                    base();
                }
                bearing_support();
                center_supports();
                outside_supports();
            }
        }
    }