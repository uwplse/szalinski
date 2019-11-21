//Bird House
//Ari M Diacou
//May 5, 2018

//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0
////////////////////// Parameters ////////////////////////
//in inches
U_Channel_width=3.25;
//of the bird house in mm(not the back plate, which will be bigger by at least 1 inch)
height=113;
//of the bird house in mm, this can be bigger or smaller than the U-Channel width)
width=85;
//of the bird house in mm
depth=57;
//is the size of the hole in the bird house in mm
bird_width=25;
//in mm. More givess more insulation, but less space for chicks
birdouse_thickness=5;
//in mm, is provided to remove water
drip_hole_diameter=3;
//is loosely how curvy your bird house is, higher increases rendering time
$fn=12;
//This should be 9.525 (3/8") for american U-channel posts
bolt_width=9.525;
//The wedge is for the chinese joinery that this thing uses instead of nuts/bolts
wedge_angle=10;

/////////////////// Derived Parameters ///////////////////
hole=bird_width;
INCH=25.4+0;
backplate_width=U_Channel_width*INCH;
//This changes the height of the backplate so that the holes will line up with the ones on the post, which are placed every inch.
backplate_height=roundto(height+1.5*INCH+1.41*bolt_width,INCH);
backplate_hole_distance=backplate_height-1*INCH;
//epsilon, a small distance used for aligning parts
ep=0.05+0;
wedge_width=bolt_width/3;
//Could be shorter I guess
wedge_length=2*INCH;
//Might need tweaking
bolt_length=.6*backplate_width+birdouse_thickness+wedge_length*sin(wedge_angle);
bolt_seperation=max(backplate_width,width)/2+2*bolt_width;
//////////////////////// Main ////////////////////////////
translate([1.0*bolt_seperation,0,.5*.7071*bolt_width])
    rotate([0,-90,90])
        mybolt();
translate([1.5*bolt_seperation,0,.5*.7071*bolt_width])
    rotate([0,-90,90])
        mybolt();
translate([1.0*bolt_seperation,wedge_length+2*bolt_width,0])
    rotate([0,0,-90])
        wedge();        
translate([1.5*bolt_seperation,wedge_length+2*bolt_width,0])
    rotate([0,0,-90])
        wedge();          
difference(){
    union(){
        translate([0,(height-width)/2,0])
            back_plate();
        half_egg($fn=30);
        perch();
        }
    drip_hole();
    translate([0,0,birdouse_thickness+ep]) 
        cylinder(d=hole,h=depth);
    
    }
////////////////////// Functions /////////////////////////
module wedge(){
    //This function creates the wedges for the chinese joinery
    L=wedge_length;
    A=[0,0];
    B=[L*cos(wedge_angle),0];
    C=[L*cos(wedge_angle),L*sin(wedge_angle)];
    R=.333*.7071*bolt_width/2;
    
    linear_extrude(wedge_width)
    hull(){
        translate(A) circle(R);
        translate(B) circle(R);
        translate(C) circle(R);
        }
    }

module mybolt(){
    //Creates the squarish bolts for use in the chinese joinery. The .7071, and 1.41 factors running around are used so that the square bolts will fit inside of the circular bolt holes on the post.
    mod_bolt_width=.7071*bolt_width;
    
    translate([-.5,-1.5,-1.41+ep]*mod_bolt_width)
        cube([1,3,1/.7071]*mod_bolt_width);
    difference(){
        translate([-.5,-0.5,0]*mod_bolt_width)
            cube([1,1,0]*mod_bolt_width+[0,0,1]*bolt_length);
        translate([-.85*wedge_length,wedge_width/2,bolt_length-1.5*wedge_length*sin(wedge_angle)])
        rotate([90,0,0])
            wedge();
        }
    }
    
module back_plate(){
    //The back plate has it's height adjusted so that it is larger than the bird house so that the bolts will fit inside the post holes which are spaced every inch in the USA
    linear_extrude(birdouse_thickness){
        difference(){
            square([backplate_width,backplate_height],center=true);
            translate([0,+backplate_hole_distance/2]) square(.8*bolt_width,center=true);
            translate([0,-backplate_hole_distance/2]) square(.8*bolt_width,center=true);
            }        
        }    
    }
module perch(){
    //Sized and positioned based on the bird's width parameter above
    d1=.33*hole;
    d2=.4*d1;
    difference(){
    linear_extrude(depth+hole)
        hull(){
            translate([0,-hole/2-1.3*d1,0]) circle(d=d1);
            translate([0,-width/2+d2/2]) circle(d=d2);
            }
        translate([0,0,-ep]) egg();    
        }
    }
module drip_hole(){
    //If water gets inside the bird house, it will drip through the bottom, keeping chicks warm and dry
    translate([0,-width/2+1.5*birdouse_thickness,birdouse_thickness])
    rotate([90,0,0])
        cylinder(d=drip_hole_diameter,h=2*birdouse_thickness);
    }
module test_thickness(){
    //used during testing to see the thickness of the bird house
    intersection(){
        hollow(width,thickness=5) egg();
        cube(width*[1,0.01,1],center=true);
        }      
}
module half_egg(){
    //makes the half egg shape that gets mounted to the backplate, from the fuinction egg()
    hollow(width,thickness=birdouse_thickness){
    intersection(){        
        cylinder(h=width+height,r=width+height) ;   
        egg();
        }    }
    intersection(){        
        cylinder(h=birdouse_thickness,r=width+height) ;   
        egg();
        }    
    }

module egg(){
    //The basic egg shape
    a=.6;
    d1=width;
    d2=a*width;
    h1=height-(d1+d2)/2;
    scale([1,1,2*depth/width])
    hull(){
        translate([0,h1,0]) sphere(d=d2);
        translate([]) sphere(d=d1,$fn=$fn/a);
        }
    }

module hollow(dimension=100, thickness=1){
    //Acts on a child function to hollow it out. "Dimension" is a dimesion of your child object, doesnt really matter which one. This fucntion then differences a scaled copy of the child object such that there is a hollow child object with a shell of "thickness".
    difference(){
        children(0);
        scale(1-(2*thickness)/dimension)
            children(0);
        }
    }

function roundto(input, precision)=
    round(pow(10,-log(precision))*input)*pow(10,log(precision)); 
    //Rounds "input" to the nearest "precision", works with non-integer powers of 10, like .333, or 20.    