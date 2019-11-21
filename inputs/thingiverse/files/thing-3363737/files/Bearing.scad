////////NOTES///////

///////////INCLUDES/////////

include<utils/build_plate.scad>

//////////PARAMETERS////////////

/*[Build Plate Specifications]*/

//Build plate X dimension in mm.
X_Dimension=220;
//Build plate Y dimension in mm.
Y_Dimension=220;

/*[Spool Measurements]*/

//Total height of the top spool in mm, measured at the inner diameter.
Top_Spool_Height=60.3;
//Diameter of the hole in the middle of the top spool, measured in mm.
Top_Spool_Inner_Diameter=57.6;
//Total height of the bottom spool in mm, measured at the inner diameter.
Bottom_Spool_Height=60.3;
//Diameter of the hole in the middle of the bottom spool, measured in mm.
Bottom_Spool_Inner_Diameter=57.6;

/*[Hidden]*/

Build_Plate=3;
Bottom_Spool_Radius=Bottom_Spool_Inner_Diameter/2;
Bottom_Spool_Sleeve=Bottom_Spool_Height/2;
Top_Spool_Radius=Top_Spool_Inner_Diameter/2;
Top_Spool_Sleeve=Top_Spool_Height/2;
Bearing_Diameter=Bottom_Spool_Radius*.5;

$fn=360;

/*[Additional Specifications]*/

//Thickness of every wall except the the tray and bearing, measured in mm.
Wall_Thickness=2;
//Extra width added to hold the top spool, measured in mm.
Top_Spool_Tray=10;
//Thickness of the tray that supports the top spool, measured in mm.
Tray_Thickness=2;
//Gap between the bottom spool and the tray that supports the top spool, measured in mm.
Spool_Gap=3;
//A gap in the bearing to allow for movement, measured in mm.
Race_Gap=.5; //[.1:.05:.5]
//Height of the bearing, measured in mm.
Bearing_Height=10;

/*[Supports]*/

//Number of supports that hold the bottom tray away from the top tray.
Center_Supports=10;
//Number of supports inside the sleeve that originate on the build plate.
Bottom_Inside_Supports=8;
//Number of supports outside the sleeve that originate on the build plate.
Bottom_Outside_Supports=15;
//Width of the supports in mm.
Support_Width=.96;
//Distance between the bottom supports and the vertical walls to allow for easy removal. Measured in mm.
Horizontal_Support_Gap=.5;
//Distance between all supports and the layers above and/or below them. Should be a multiple of your layer height. Measured in mm.
Vertical_Support_Gap=.3;

//////////MODULES//////////////
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
        square([Bottom_Spool_Inner_Diameter/2,Bearing_Height]);
        union(){
            square([Race_Gap,Bearing_Height]);
            translate([Race_Gap,-Race_Gap,0])
            scale([1,Race_Gap/(Bearing_Height/2)+1,1])
                inner_race();
                bearing_radius();
        }
    }
}

module bottom_sleeve(){
    translate([Bottom_Spool_Radius-Wall_Thickness,0,0])
        square([Wall_Thickness,Bottom_Spool_Sleeve]);
}

module spool_gap(){
    translate([(Bearing_Height+Bearing_Diameter)/2-Wall_Thickness,-Spool_Gap,0])
        square([Wall_Thickness,Spool_Gap]);
}

module tray(){
    translate([0,-Spool_Gap-Tray_Thickness,0])
        square([Top_Spool_Radius+Top_Spool_Tray,Tray_Thickness]);
}

module top_sleeve(){
    translate([Top_Spool_Radius-Wall_Thickness,-Spool_Gap-Top_Spool_Sleeve-Tray_Thickness,0])
        square([Wall_Thickness,Top_Spool_Sleeve]);
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
                    cube([Bottom_Spool_Radius,Support_Width,Spool_Gap-Vertical_Support_Gap*2]);
                translate([0,-.5,-Spool_Gap])
                    cube([(Bearing_Height+Bearing_Diameter)/2+Wall_Thickness,Support_Width+1,Spool_Gap+1]);
            }
        }
    }
}

module bottom_outside_supports(){
    for(s=[0:1:Bottom_Outside_Supports]){
        rotate([0,0,s*360/Bottom_Outside_Supports]){
            translate([Top_Spool_Radius+Horizontal_Support_Gap,0,-Top_Spool_Sleeve-Spool_Gap-Tray_Thickness])
                cube([Top_Spool_Tray-Horizontal_Support_Gap,Support_Width,Top_Spool_Sleeve-Vertical_Support_Gap]);
        }
    }
}

module bottom_inside_supports(){
    for(s=[0:1:Bottom_Inside_Supports]){
        rotate([0,0,s*360/Bottom_Inside_Supports]){
            translate([0,0,-Top_Spool_Sleeve-Spool_Gap-Tray_Thickness])
                cube([Top_Spool_Radius-Wall_Thickness-Horizontal_Support_Gap,Support_Width,Top_Spool_Sleeve-Vertical_Support_Gap]);
        }
    }
}

module top_inside_supports(){
    for(s=[0:1:Bottom_Inside_Supports]){
        rotate([0,0,s*360/Bottom_Inside_Supports]){
            translate([0,0,-Bottom_Spool_Sleeve])
                cube([Bottom_Spool_Radius-Wall_Thickness-Horizontal_Support_Gap,Support_Width,Bottom_Spool_Sleeve-Vertical_Support_Gap-Bearing_Height]);
        }
    }
}

module top_outside_supports(){
    for(s=[0:1:Bottom_Outside_Supports]){
        rotate([0,0,s*360/Bottom_Outside_Supports]){
            translate([Bottom_Spool_Radius+Horizontal_Support_Gap,0,-Bottom_Spool_Sleeve])
                cube([Bottom_Spool_Sleeve-Horizontal_Support_Gap,Support_Width,Bottom_Spool_Sleeve+Spool_Gap-Vertical_Support_Gap]);
        }
    }
}

/*module top_outside_supports(){
    for(s=[0:1:Bottom_Outside_Supports]){
        rotate([0,0,s*360/Bottom_Outside_Supports])
    }
}*/

//////////RENDERS//////////////

build_plate(Build_Plate,X_Dimension,Y_Dimension);

if (Top_Spool_Sleeve<=Bottom_Spool_Sleeve+Spool_Gap){
    translate([0,0,Spool_Gap+Bottom_Spool_Sleeve+Tray_Thickness]){
        union(){
            rotate_extrude(){
                inner_race();
                outer_race();
                bottom_sleeve();
                spool_gap();
                tray();
                top_sleeve();
            }
            bearing_support();
            center_supports();
            bottom_inside_supports();
            bottom_outside_supports();
        }
    }
}
else {
    translate([0,0,Bottom_Spool_Sleeve]){
        union(){
            rotate_extrude(){
                rotate([180,0,0]){
                    inner_race();
                    outer_race();
                    bottom_sleeve();
                    spool_gap();
                    tray();
                    top_sleeve();
                }
            }
            rotate([180,0,0]){
                bearing_support();
                center_supports();
            }
            top_inside_supports();
            top_outside_supports();
        }
    }
}

//////////GAUGES///////////////

/*
//Bearing height
color("blue")
    %cube([.5,Bearing_Height,.5]);
//Bottom Spool Sleeve Width
color("red")
    *cube([Bottom_Spool_Radius,.5,.5]);
//Bottom Spool Sleeve Height
color("green")
translate([Bottom_Spool_Radius,0,0])
    %cube([.5,Bottom_Spool_Sleeve,.5]);
//Top Spool Sleeve Height
color("orange")
translate([Top_Spool_Radius-Wall_Thickness,-Spool_Gap-Top_Spool_Sleeve-Tray_Thickness,0])
    %cube([.5,Top_Spool_Sleeve,.5]);
//Race Gap
color("purple")
translate([Bearing_Height+Bearing_Diameter/2,Bearing_Height/2-.25,0])
    %cube([Race_Gap,.5,5]);
    
*/
    
    
    