//Funnel Adapter_v1.0
//by: Brett Mattas
//date: May 25, 2018
//units: mm
//description:
//Holds a funnel on top of a circular container

/////////////////////////////////////////////
/////////  PARAMETERS ///////////////////////
/////////////////////////////////////////////

//Global Parameters
Global_Scale = 1;
$fn = 200;
EPS = 0.001; //Small number to avoid coincident faces
TOL = 1; //Tolwerance for fitting around lip



height = 20; //Offset of funnel circle above base cricle
thickness = 3;
funnel_inside_diameter = 60; //
base_inside_diameter = 104; //Inside diameter to fit around
base_lip_width = 5.5; //For fitting around lid
lip_height = 2; //Depth of lip
supports = 4; //Number of supports


/////////////////////////////////////////////
/////////  RENDERS //////////////////////////
/////////////////////////////////////////////

//Driver

scale(Global_Scale){

    Main();

}
/////////////////////////////////////////////
/////////  FUNCTIONS ////////////////////////
/////////////////////////////////////////////

function parabola(x, a1, a2, a3) = a1*pow(x,2) + a2*x + a3;



/////////////////////////////////////////////
/////////  MODULES //////////////////////////
/////////////////////////////////////////////


//Template Module
module Main()
{
    bot_width = 2*thickness + base_lip_width + TOL;
    bot_height = lip_height + thickness;
    
    difference(){
        //Elements added
        union(){
            
            //Top lip
            translate([0, 0, lip_height + height])
            rotate_extrude()
                translate([funnel_inside_diameter/2, 0])
                    square([thickness, thickness], center=false);
            
            //Bottom Lip
            rotate_extrude()
                translate([base_inside_diameter/2-thickness - TOL/2, 0])
                square([bot_width, bot_height], center=false);
            
            //Supports
            dist = sqrt(pow(height, 2) + 
                pow(base_inside_diameter / 2 - funnel_inside_diameter/2, 2));
            sup_angle = atan(2*height / 
                    (base_inside_diameter - funnel_inside_diameter));
            echo(sup_angle);
            for (isup = [1:supports]){
                angle = (isup-1) * 360 / supports;
                rotate([0, 0, angle])
                    translate([funnel_inside_diameter/2, 
                        -thickness/2, lip_height + height])
                    rotate([0, sup_angle, 0])
                    cube([dist, thickness, thickness]);
            }
        }
        
        //Elements removed
        union(){
            //Groove at bottom lip
                translate([0, 0, -EPS])
                rotate_extrude()
                    translate([base_inside_diameter/2-thickness - TOL/2, 0])
                    translate([bot_width/2-base_lip_width/2-TOL/2, 0])
                    square([base_lip_width+TOL, lip_height], center=false);
        }
    }
}

*translate([base_inside_diameter/2, 0])
    Lip();
module Lip()
{
    width = 2*thickness + base_lip_width + TOL;
    height = lip_height + thickness;
    translate([-thickness - TOL/2, 0])
        difference(){
            square([width, height], center=false);
            translate([width/2-base_lip_width/2-TOL/2, 0])
                square([base_lip_width+TOL, lip_height], center=false);
        }
}

