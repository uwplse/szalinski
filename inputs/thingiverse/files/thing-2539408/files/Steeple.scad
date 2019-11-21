//Steeple
//Ari M Diacou
//September 17, 2017

//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

////////////////////// Parameters ////////////////////////
//of your steeple in mm
width=20;
//of your steeple in mm
height=60;
//of the base of your steeple
num_sides=8;
//the character displayed (use \uWXYZ for unicodes)
my_char="\u2620";
//of the character (suggest DejaVu Sans or Segoe UI Symbol)
my_font="Segoe UI Symbol";
/////////////////// Derived Parameters ///////////////////
suggested_filename=str("Steeple-",num_sides,"-w",width,"h",height,"-",my_char);
echo(suggested_filename);
a=apothem(width/2,num_sides);
theta_adj=180/num_sides;
//////////////////////// Main ////////////////////////////
cone(w=width,h=height, sides=num_sides);
faces();
////////////////////// Functions /////////////////////////
module cone(w=1, h=4, sides=4){  
    adcr=2*apothem(w/2,sides)/w; //Apothem Divided by CircumRadius
    rotate([0,0,theta_adj])
        cylinder(d1=w/adcr,d2=0,h=h,$fn=sides);
    }

module face(){
    r=width/height;
    diameter=(1-r)*a*2*tan(180/num_sides);
    engrave_ratio=0.2;
    cylinder_height=width/2;
    translate([0,0,(1+r)*(1-r)*(width/2)]) 
        rotate([90-.5*atan(width/height),0,0])
            difference(){
                cylinder(d=diameter,$fn=24,h=cylinder_height);
                translate([0,0,(1-engrave_ratio+.01)*cylinder_height])
                #color("black") linear_extrude(0.1*width)
                    text(my_char,font=my_font,halign="center",valign="center",size=.667*diameter);
                }
    }
module faces(){
    for(i=[0:num_sides-1])
        rotate([0,0,i*360/num_sides+90])
            face();
    }
    
function apothem(circumradius,sides)=circumradius*cos(180/sides);