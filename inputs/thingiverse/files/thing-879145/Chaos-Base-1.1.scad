//Name: Chaos Base
//Created by Ari M. Diacou, June 2015
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

/* [Base Parameters] */
//The number of sides on the base
sides=8;
//The height of the base in mm
base_height=7;
//The widest width of the base
base_width=40;
//The top face has a diameter which is factor*base_width
factor=.7;
//Your God
god="Khorne";//[Khorne,Slannesh,Nurgle,Tzeench]

/* [Arrow Parameters] */
//The tip of the arrow [origin to edge, radius, polar position angle] e.g. [1,5,35]
set1=[1,5,35];      
//The back of the arrow tip [origin to edge, radius, polar position angle] e.g. [0,10,75]
set2=[0,10,65];     
//The sides of the shaft [origin to edge, radius, polar position angle] e.g. [.5,10,0]
set3=[.5,10,0];      
//The back of the shaft [origin to edge, radius, polar position angle] e.g. [-1.5,10,60]
set4=[-3,10,50];
//Height of your arrow, use 0 offline to output a DXF file
height=1;

/* [Slot Parameters] */
//do you want a slotted base?
user_wants_a_slotted_base = "no";//[yes,no]
//Do you want your slot aligned with edges or faces?
slot_allignment="edge";//[edge,face]
//The thickness of the base, 2mm (for GW minis) + tolerance
slot_thickness=2.5;
//The width of the slot 
slot_width=20;
//The depth of your slot
slot_depth=5;


/* [HIDDEN] */
//////// Derived Parameters ///////
ep=0+0.1; //epsilon, a small number
arrow_tip= intersection(set1,[set1[0],set1[1],180-set1[2]]); echo(str("arrow_tip=",arrow_tip));
arrow_back=intersection(set3,set4); echo(str("arrow_back = ",arrow_back));
arrow_side=intersection(set1,set2); echo(str("arrow_side = ",arrow_side));
arrow_length=arrow_tip[1]-arrow_back[1]; echo(str("arrow_length = ",arrow_length));
arrow_width=2*max(arrow_side[0],arrow_back[0]); echo(str("arrow_width = ", arrow_width));
inradius_factor=cos(180/sides); echo(str("inradius_factor=",inradius_factor)); //When openscad makes a cylinder with a low number of sides, the radius is measured to the corners not the sides. The inradius_factor factor is how much closer the sides are to the origin than the corners. Taken from http://mathworld.wolfram.com/Octagon.html solved for (r/R) (the inradius/circumradius).
yz_rotation=-atan(base_height/((1-factor)*(base_width/2))); echo(str("yz_rotation = ", yz_rotation)); //how steep are the sides of the base?
centering_translation=[ 0,-arrow_tip[1]+arrow_length/2,-0*height/2]; //Centers the arrow based on length
extra_angle=sides%2==0 ? 180/sides : 90; //Rotates the arrows to the faces
arrow_translation=[0,(1+factor)*base_width/4-ep,base_height/2-ep]; //Lines up the arrows on the faces

//These are the color schemes for the four gods of chaos. Ten lines of code and 30 minutes were spent on this idiotic fluff.
c1= (god=="Tzeench")  ? "DeepSkyBlue" : //Fluff. Your base color
    (god=="Nurgle")   ? "OliveDrab" :
    (god=="Slannesh") ? "DarkViolet" :
    "DarkRed";
c2= (god=="Tzeench")  ? "Aquamarine" :  //Fluff. The arrow color.
    (god=="Nurgle")   ? "Goldenrod" :
    (god=="Slannesh") ? "Fuchsia" :
    "DarkGoldenrod";
////////////// MAIN() ////////////
difference(){
    base();
    if(user_wants_a_slotted_base=="yes") slot();
    }
/////////// Functions() //////////
module slot(){
    rot=(slot_allignment=="edge") ? [0,0,0] : [0,0,extra_angle];
    translate([0,0,base_height-slot_depth/2+ep])
        rotate(rot)
            color(c2) cube([slot_width,slot_thickness,slot_depth],center=true);
    }
module base(){  
    intersection(){
        //Cone with 8 sides
        color(c1) cylinder(r1=(1-inradius_factor/2)*base_width,r2=factor*(1-inradius_factor/2)*base_width,h=base_height,$fn=sides);
        //Truncating cylinder to make edges round
        color(c1) cylinder(r=base_width/2,h=base_height,$fn=60);
        }
    //The arrows along the sides
    for(i=[0:sides-1]){    
        rotate([0,0,360*i/sides+1*extra_angle])
            translate(arrow_translation) 
                rotate([yz_rotation,0,0])
                    color(c2) 
                        linear_extrude(height) 
                            translate(centering_translation) 
                                arrow();
        }
    }
module test_circle(x){
    #linear_extrude(base_height*1.1){
        difference(){
            circle(x);
            circle(x-ep);
            }
        }
    }
//INSTRUCTIONS:
/* The code below produces an arrow with curvy edges. It does this by intersecting and taking the difference of 4 pairs of circles. 2 circles form the tip of the arrow (set1), and 2 form the back of the tip of the arrow(set2). The sides of the shaft are formed by set3, and the tail of the arrow is formed by set 4. 

The circles are specified by a modified polar coordinate system called "easy_form" which is ={distance from origin to circle edge, radius of circle, angle between +x-axis and circle center in degrees}. This coordinate system is SLIGHTLY easier to get a grasp of entering values. Changing the first value will push a curve farther from the origin (the center of the arrow). Lowering the 2nd number will make a line more curvy (by lowering the radius of the circle it creates). Raising the 2nd number will make a line more flat (by increasing the radius of the circle it creates). Changing the 3rd number is how you get position control. The 3rd number is the angle that the angle that the line connecting the origin and the center of the circle will make with the x-axis.Both the first and the third parameters can be negative. Negative radii will fail silently.

It is highly reccommended that this program be used in OpenSCAD and not customizer. There is no input checking, and a lot of edge cases where circles will not intersect. If instead of an arrow looking thing, customizer or OpenSCAD show you two circles floating in space, it means that the circles are not intersecting, and the program is failing silently. If you wish to make a 2D file, use 0 for the height (I don't think this works in customizer). Offline, the program will also suggest a filename based on your parameters.

The last 4 functions in this program are used to calculate the points where the circles intersect, which is used to calculate the length and width of the arrow. This information is available through the echo function, and not visible in customizer. So if you want to know the dimensions of your arrow, use OpenSCAD.*/


///////// FUNCTIONS /////////
function intersection(circle1,circle2)=(norm(intersections(circle1,circle2)[0])<=norm(intersections(circle1,circle2)[1]))?intersections(circle1,circle2)[0]:intersections(circle1,circle2)[1];
function xyr_form(easy_form)=[
    //easy_form={distance from origin to circle edge, radius of circle,angle between +x-axis and cicle center}
    //xyr_form={x-cooridante of center,y-coordinate of center,radius of circle}
    (easy_form[0]+easy_form[1])*cos(easy_form[2]), //x=(diff+r)*cos(theta)
    (easy_form[0]+easy_form[1])*sin(easy_form[2]), //y=(diff+r)*sin(theta)
    easy_form[1] //r
    ];
module arrow(){
    top();
    bottom();
    }
module top(){ //The tip of the arrow
    difference(){
        intersection(){
            square(2*arrow_tip[1],center=true);
            pair(set2,$fn=200); //The back of the arrow
            }
        pair(set1,$fn=100); //The tip of the arrow
        }
    }
module bottom(){ //The shaft of the arrow
    difference(){
        intersection(){
            translate([0,-2.5,0])
                square(5,center=true);
            pair(set4,$fn=200); //The sides of the shaft
            }
        pair(set3,$fn=100); //The backof the shaft
        }
    }
function chord_of_circle_intersection(d,r,R)=(1/d)*sqrt(4*d*d*R*R-pow(d*d-r*r+R*R,2)); //from: http://mathworld.wolfram.com/Circle-CircleIntersection.html, Equation 8
module pair(triplet){
    /* Makes a pair of circles on the x-y plane for making the 8 arcs of the arrow. An array "triplet" is passed into the function which specifies the position and size of the circles. The 2nd parameter is the radius of the circles, the third is the angle that the line connecting the origin and the center of the circle will make with the x-axis, and the first parameter of the array is the distance between the origin and the nearest edge of the circle. Both the first and the third parameters can be negative. Negative radii will fail silently.*/
    radius=triplet[1]; 
    x=xyr_form(triplet)[0];
    y=xyr_form(triplet)[1];
    translate([x,y,0])
        circle(radius);
    translate([-x,y,0])
        circle(radius);
}
function intersections(circle1,circle2)=[
    [x1sol(xyr_form(circle1)[0],xyr_form(circle1)[1],xyr_form(circle1)[2],xyr_form(circle2)[0],xyr_form(circle2)[1],xyr_form(circle2)[2]),
    y1sol(xyr_form(circle1)[0],xyr_form(circle1)[1],xyr_form(circle1)[2],xyr_form(circle2)[0],xyr_form(circle2)[1],xyr_form(circle2)[2])],
    [x2sol(xyr_form(circle1)[0],xyr_form(circle1)[1],xyr_form(circle1)[2],xyr_form(circle2)[0],xyr_form(circle2)[1],xyr_form(circle2)[2]),
    y2sol(xyr_form(circle1)[0],xyr_form(circle1)[1],xyr_form(circle1)[2],xyr_form(circle2)[0],xyr_form(circle2)[1],xyr_form(circle2)[2])]
    ];
//The following are the solutions to the intersection of two circles with arbitrary radius and coordinates. Solved with Mathematica (9 Student/Home) on a Raspberry Pi using the algorithm discussed here: http://mathematica.stackexchange.com/questions/80695/formatting-an-equation-xy-to-powx-y, Many thanks to all the respondants. A circle intersects another at 0, 1 or 2 points. If circles do not intersect, then the following solutions would ideally be complex numbers. If they intersect at 1 point then (x1sol,x2sol)=(x2sol,y2sol). In the case of sensible inputs which create an arrow like we have in this program, there will be 2 solutions. In our case we will take the one that is closer to the origin. This will allow us to calculate the length and width of the arrow, so it can be scaled later.
function x1sol(x1,y1,r1,x2,y2,r2)=x1 + (r1*(((-x1 + x2)*(-((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))) + sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))))/(2.*r1) + ((-y1 + y2)*sqrt((1 + ((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)) - sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)))/2.)*(1 + (-((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))) + sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)))/2.)))/r1))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2));
function y1sol(x1,y1,r1,x2,y2,r2)=y1 + (r1*(((-y1 + y2)*(-((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))) + sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))))/(2.*r1) - ((-x1 + x2)*sqrt((1 + ((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)) - sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)))/2.)*(1 + (-((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))) + sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)))/2.)))/r1))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2));
function x2sol(x1,y1,r1,x2,y2,r2)=x1 + (r1*(((-x1 + x2)*(-((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))) + sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))))/(2.*r1) - ((-y1 + y2)*sqrt((1 + ((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)) - sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)))/2.)*(1 + (-((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))) + sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)))/2.)))/r1))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2));
function y2sol(x1,y1,r1,x2,y2,r2)=y1 + (r1*(((-y1 + y2)*(-((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))) + sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))))/(2.*r1) + ((-x1 + x2)*sqrt((1 + ((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)) - sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)))/2.)*(1 + (-((-1 + pow(r2,2)/pow(r1,2))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2))) + sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2)))/2.)))/r1))/sqrt(pow(-x1 + x2,2)/pow(r1,2) + pow(-y1 + y2,2)/pow(r1,2));