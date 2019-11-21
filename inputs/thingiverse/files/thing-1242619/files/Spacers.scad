//Spacers for Wanhao Duplicator 4S
//Used to align the cover with the frame
//Ari M. Diacou
//January 2016
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

inch=25.4+0;//In case you want to specify distances in inches (1"=25.4mm).
//The hole these will fit into is roughly hexagonal. Measure the widest corner to corner distance.
widest_corner_to_corner_distance=19.3;
//Measure the distance between the corners in a direction outward from the top-center of the printer. This direction should be perpendicular to the one just measured.
corner_to_corner_distance_in_outward_direction=10;
//Measure the depth/height of the curled over part of the top frame. 
base_depth=7;
//How high would you like your spacer to rise off the frame?
tip_height=7;
//What is the left-right distance of the gap between the frame angle bars?
frame_width=366.7;
//What is the distance of the gap between the frame angle bars, in the front to back direction? 
frame_depth=219.1;
//What is the inside left-right distance of your cover?
cover_width=412.8;
//What is the inside front-back distance of your cover?
cover_depth=266.7;
//A tolerance distance that makes the dimensions smaller by relative but appropriate? amounts. 1 = 1mm shaved off the widest corner to corner distance, .5mm in the corner to corner distance in outward direction, and would give a 3mm tolerance in the width, and 2mm in the depth directions.
tolerance=.2;
/*[Hidden]*/
///////////////// Derived Parameters ////////////////////////
b=corner_to_corner_distance_in_outward_direction-tolerance/2; 
a=(min(cover_width-frame_width-3*tolerance,cover_depth-frame_depth-2*tolerance)-sqrt(2)*b)*sqrt(2)/2; 
c=widest_corner_to_corner_distance-corner_to_corner_distance_in_outward_direction-tolerance; 
A=[0,a+c/2];
B=[c/2,a];I=left(B);
C=[c/2,0];H=left(C);
D=[c/2+b/2,-b/2];G=left(D);
E=[c/2,-b];F=left(E);
TIP=[A,B,C,H,I];
BASE=[C,D,E,F,G,H];
/////////////////// Testing Output //////////////////////////
echo(str("cover width-frame width(x)=",cover_width-frame_width," mm"));
echo(str("cover depth-frame depth(y)=",cover_depth-frame_depth ," mm"));
echo(str("a=",a," mm"));
echo(str("b=",b," mm"));
echo(str("c=",c," mm"));
echo(str("tip length=",A[1]," mm"));
echo(str("total length=",A[1]+b," mm"));
echo(str("total width=",D[0]*2," mm"));
echo(str("total height=",tip_height+base_depth," mm"));
echo(str("suggested filename = spacer a=",a,",b=",b,",c=",c,",z=",tip_height));
/////////////////////// Main() //////////////////////////////
color("red") linear_extrude(tip_height) polygon(TIP);
translate([0,.01,0]) color("brown") linear_extrude(tip_height+base_depth) polygon(BASE);
//////////////////// Functions //////////////////////////////
function left(RIGHT)=[-RIGHT[0],RIGHT[1]];