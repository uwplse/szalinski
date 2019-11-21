//Name: Shoe
//Created by Ari M. Diacou, April 2015
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/
//v1.1 had 153 downloads.
//v1.2 had 68 downloads: Fixed customizer errors (options need to be in quotes in declaration, commented options are not in quotes), removed some extraneous code.
//v1.3 Changed sides_radius to derived parameter, put in more reaonable inputs after my own size 46 foot, started to add code that doesnt work for a heel cup, fixed an alignment bug in tip bevel, added countersinks to the heel screw holes.

/* [Dimensions] */
//The length along the ground of the shoe (in mm)
length_of_shoe=280;
//Corresponding to the ball of your foot to the bulge below your pinky toe
widest_width=100;
//The widest dimension of the heel of your shoe
heel_width=68;
//The distance between the line travesing the widest part of your foot, and the tip of the shoe
widest_width_to_tip=85;
//A shape adjustment parameter, which pulls the heel towards the inside of the foot relative to the ceterline of the shoe.
heel_proximal_offset=25;
//The radius of the curve of the tip of the shoe
tip_radius=25;
//The distance from the heel of your foot to the ground
heel_height=70;
//The distance from your toes to the ground
sole_thickness=20;
//The height that the heelcup will rise abve the bottome of your heel
heel_cup_height=1;
//The maximum thickness of the heelcup
heel_cup_thickness=.4;


/* [Options] */
//Heel creates a heeled shoe with a gap in the middle, Wedge shoes contact the floor throughout the length, Soles Only is used to make 2D dxf files (maybe you want to laser-cut something?
type="heel";//[heel,wedge,soles_only]
//Adds a curved edge to the tips of the shoes
user_wants_beveled_tips="yes";//[yes,no]
//Adds horozontal through holes for attaching straps
these_are_sandals="yes";//[yes,no]
//Adds a vertical shaft in the heel for drilling a screw into. The author hypothizized that it would be less likely that the filament layers would shear apart if there were a metal screw in the heel, making these safer.
user_wants_heel_screws="yes";//[yes,no]
//The width of the strap holes
strap_width=30;
//The thickness of the holes that the straps will be slid through
strap_thickness=5;
//The diameter of the hole for the heel screws
screw_hole_diameter=4;
//How many flat segments make a circle for the rest of this program? ($fn=curviness)
curviness=24;
/* [Hidden] */
///// Derived Scalars /////
$fn=curviness;
ep=.01+0;
displacement=[(1/2+.1)*widest_width,0,0]; //how far to move the shoes apart, also a natural unit in x
tip=[0,+widest_width_to_tip]; //the location of the tip circle
sides_radius=widest_width/3; //The radius of the curve of the sides of the shoe (near the ball of the foot) (used to be inputable, but a pain in the ass, and doesnt adjust shape much. If sides_radius*2 >= widest_width, then hull() wont work.
inside=[-max(widest_width/2-sides_radius,0),0]; //location of the inside (ball of foot) circle
outside=[max(widest_width/2-sides_radius,0),0]; //location of the outside circle
heel=[widest_width/2-heel_width/2-heel_proximal_offset,-(length_of_shoe-widest_width_to_tip-heel_width/2)]; //location of the heel circle
rotation = 0.5*atan((outside[0]-heel[0])/(heel[1]-outside[1]))+0.5*atan((inside[0]-heel[0])/(heel[1]-inside[1])); echo(str("rotation= ",rotation)); //how much do you have to rotate the shoes to make them look like a pair out of the box. Takes the average of the inside and oustide slopes. Aesthetic only.
real_heel_height=heel_height>sole_thickness?heel_height:sole_thickness; //if the heel height is less than the sole thickness, just use the sole thickness
slope = (real_heel_height - sole_thickness) / (heel[1]-heel_width/2+sides_radius);//Used to calculate how high to make the indent of the heel
heel_angle=atan(slope); echo(str("heel angle = ",heel_angle));
///////// MAIN() //////
if(type!="soles_only") 
    difference(){
        shoes();
        if(user_wants_beveled_tips=="yes"){tip_bevel();}
        if(these_are_sandals=="yes"){strap_holes();}
        if(user_wants_heel_screws=="yes"){screw_holes2();}
        }
if(type=="soles_only"){
    translate(displacement) rotate(-rotation) right_foot();
    translate(-displacement) rotate(rotation) left_foot();
    }    
////// FUNCTIONS //////
module screw_hole(){
    //Right shoe
    translate([displacement[0]+heel[0],heel[1],sole_thickness/4]) 
        cylinder(h=real_heel_height,r=screw_hole_diameter/2);
    //Left Shoe
    translate([-displacement[0]-heel[0],heel[1],sole_thickness/4]) 
        cylinder(h=real_heel_height,r=screw_hole_diameter/2);
    }
module screw_holes2(){ //now with countersinks  
    countersink_height=real_heel_height+1*.5*heel_width*slope-(1-slope)*screw_hole_diameter;
    bottom = sole_thickness/4;
    counterbore_height=screw_hole_diameter*(1+abs(slope));
    x_translation=displacement[0]+heel[0];
    //Right shoe
    //screw shaft
    translate([x_translation,heel[1],sole_thickness/4]) 
        cylinder(h=countersink_height-bottom,r=screw_hole_diameter/2);
    //countersink
    translate([x_translation,heel[1],countersink_height-screw_hole_diameter/2]) 
        cylinder(h=screw_hole_diameter,d1=screw_hole_diameter,d2=3*screw_hole_diameter);
    //counterbore
    translate([x_translation,heel[1],countersink_height+screw_hole_diameter/2]) 
        cylinder(h=counterbore_height,d=3*screw_hole_diameter);
    
    //Left Shoe
    //screw shaft
    translate([-x_translation,heel[1],sole_thickness/4]) 
        cylinder(h=countersink_height-bottom,r=screw_hole_diameter/2);
    //countersink
    translate([-x_translation,heel[1],countersink_height-screw_hole_diameter/2]) 
        cylinder(h=screw_hole_diameter,d1=screw_hole_diameter,d2=3*screw_hole_diameter);
    //counterbore
    translate([-x_translation,heel[1],countersink_height+screw_hole_diameter/2]) 
        cylinder(h=counterbore_height,d=3*screw_hole_diameter);
    }
module strap_holes(){
    translate([0,(widest_width_to_tip+tip_radius)/2,.5*sole_thickness])
        cube([4*displacement[0],strap_width,strap_thickness],center=true);
   translate([0,(-sides_radius-strap_width*cos(heel_angle)),.5*sole_thickness-strap_width*sin(heel_angle)])
    rotate([heel_angle,0,0])
        cube([4*displacement[0],strap_width,strap_thickness],center=true);
}
module tip_bevel(){
    translate([-2*displacement[0],tip[1]+tip_radius-sole_thickness/2,sole_thickness/2-ep]) rotate([0,90,0])
//    difference(){
    difference(){
        cube([sole_thickness/2,sole_thickness/2,4*displacement[0]]);
        cylinder(h=4*displacement[0]+ep,r=sole_thickness/2);
        }
    }
module shoes(){
    //The shoes are created by extruding each 2D sole up to the heel height, and then intersecting that with the yz_profile of the shoe
    intersection(){
        linear_extrude(height=real_heel_height){
            translate(displacement) right_foot();
            translate(-displacement) left_foot();
            }
        translate(-2*displacement) 
            rotate([90,0,90]) 
                linear_extrude(height=4*displacement[0])
                    yz_profile();
        }          
    } 
module yz_profile(){
    //When looking at the shoes with the tip facing right, and the heel laying on the "ground" (y pointing right, z pointing up) the points start from the [tip,floor] and proceed clockwise to define the points which make up the profile of the shoe.
    points = [ //pairs are in [y,z] format
        [tip[1]+tip_radius,0], //[tip,floor]
        [-sides_radius,0], //place where shoe starts rising put conservatively far back over fears of the shoe breaking
        [heel[1]+heel_width/2,(type=="heel")?slope*(heel[1]+heel_width/2+sides_radius):0], //the indent of the heel, if wedge shoe, set height to zero
        [heel[1]+heel_width/2,0], //the front part of the heel
        [heel[1]-heel_width/2,0], //the back of the heel
        [heel[1]-heel_width/2,real_heel_height], //5 the top of the heel
        [-sides_radius,sole_thickness],//6 where the ball of the foot should go
        [tip[1]+tip_radius,sole_thickness] //[tip,sole]
        ];    
    *for(i=[0:len(points)-1]){ //Making points visble for debugging
        color("yellow") translate(points[i]) circle(r=.1); 
        echo(points[i]);
        }
    color("lightgreen") polygon(points); // A polygon is created from the listed points. It will then be rotated from the natural xy format of 2D shapes in openscad, to the yz plane, and then extruded to cut the side profile of the shoes
    }
module right_foot(){
    //Creates a 2D outline of the right foot. The sole of the foot is made by wrapping a string/hull around 4 circles. One around the heel, one around the ball of the foot, one near the pinky toe, and one near the toes. Shoe shape is adjusted by adjusting the position and size of these circles.
    hull(){
        translate(tip) 
            circle(tip_radius);//tip
        if(sides_radius*2<widest_width){//If you choose a sides radius that is too big the program will simply use a single circle with diameter = the width of the shoe. Used to control input error.
            translate(outside) 
                circle(sides_radius); //outside side
        translate(inside) 
            circle(sides_radius); //inside side
        }
        if(sides_radius*2>widest_width){ //same input check as above
            circle(sides_radius);
            }
        translate(heel) //the heel
            circle(heel_width/2);
        }
    }
module left_foot(){
    //The left foot is just the right foot mirrored along the yz plane. 
    mirror([1,0,0]) right_foot();
    }
    
module heel_cup(){
    difference(){
        linear_extrude(height=real_heel_height){ //extrude the soles again
            translate(displacement) right_foot();
            translate(-displacement) left_foot();
            }
        heel_yz_removal();
        heel_xy_removal();
        }        
    }
module heel_yz_removal(){
    translate([-2.5*displacement[0],heel[1],real_heel_height*-0.1]) 
        cube([5*displacement[0],length_of_shoe,real_heel_height*1.2]);
    }
module heel_xy_removal(){ //Doesn't work yet
    //Substracts an extruded ellipse from the heel. The ellipse has the same width as the circle used to make the heel, but is shortened in the length direction. This allows the heel cup to go from a maximum thickness by the achilles tendon, to a minimum at the ankle bone.
    ellipse_eccentricity=(heel_width-2*heel_cup_thickness)/heel_width; //The ellipse is a scaled circle. The scaling factor is chosen to shorten the ellipse by the "heel_cup_thickness" selected in parameters.
    x=heel[0]+displacement[0]; //the x placement of the elliipses
    y=heel[1]; //the y placement of the elliipses

    //Right foot
    linear_extrude(height=real_heel_height)
        translate([x,y])
            scale([1,ellipse_eccentricity,1])
                circle(r=heel_width/2);
    //Left foot
    linear_extrude(height=real_heel_height)
        translate([-x,y])
            scale([1,ellipse_eccentricity,1])
                circle(r=heel_width/2);
    }
