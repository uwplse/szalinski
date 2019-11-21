//Mark Peeters ChessBoard multi color 
// CC-BY-NC-SA Mark G. Peeters 3-17-2018
//https://www.youmagine.com/designs/chess-checkers-board-toolpath-painting
//https://www.thingiverse.com/thing:2853484
/*
I used a bit of CC0 Public Domain code to make my stars from here:
http://files.openscad.org/examples/Functions/recursion.html
 Written in 2015 by Torsten Paul <Torsten.Paul@gmx.de>
*/
/******************************************************
----------------
the idea is to print in at least 3 colors.
----------------
the registation dots are so that the slicer will place the different STL files in the exact same place on the bed.
----------------
When printing the star inside you can choose high shell count in cura and get a cool pattern.
----------------
When printing the background use low shell count like 1 and you will get basic lines
----------------
Backing will be printed in quarters on top of face parts
----------------
all face parts the same for the 4 quasters
----------------
the inner boarder is the same on all and can be trimmed off treated like a brim before assembly
----------------
Different colored stars should face in different directions, so I'm flipping them 180deg
----------------
note on code: I used a few %2. That's modulus division, which is handy for a number of things. Basically, you divide the number, and the remainder is what you have. So it's a great way to check if even or odd.
----------------

*******************************************************/

//size of squares (mm)
side=41;
//the surface thickness the board (mm) (1st layer, set in slicer)
thick=0.6;
//thickness of the whole board (mm)(including 1st layer)
thickFull=3;
//outer boarder thickness (mm)
edge_thick=5;
//inner boarder thickness, lines between squares(mm)normally 2*nozzle
lines=1.6;//nice if this is a multiple of the nozzle, 
//number of star points
start_points=5;
//star shrink (mm) so start fits inside the squares
star_shrink=0.8*4;//lines*4
//register dots spacing (mm) gap for registering dots
regspace=4;
//x num for grid (how many squares in X direction)
xnum=4;
//ynum for grid (how many squares in Y direction)
ynum=4;

//render? (1st layer) Choose which color squares to render
color2make=3;// [0:color#1 (stars no rotation), 1:color#2 (stars 180deg rotation), 3:both colors]
//render? (1st layer) Choose which inner part to render 
part2make=4;//[1:square outer, 2:square inner (stars), 4:inner boarder lines, 3:all inner parts (for visualization) , 5:no 1st layer inner objects]
//render? (1st layer) Choose which outer boarder quadrant to render
quadrant=5;//[1:Q1 outer boarder 1st layer,2:Q2 outer boarder 1st layer,3:Q3 outer boarder 1st layer,4:Q4 outer boarder 1st layer,5:all corners (1st layer), 6:no 1st layer outer boarder]
//render? (body, 2nd layer and up) Choose which quadrant for main part
quadrantMain=6;//[1:Q1 body 2nd layer and up,2:Q2 body 2nd layer and up,3:Q3 body 2nd layer and up,4:Q4 body 2nd layer and up,5:all corners body 2nd layer and up, 6:no body 2nd layer and up]


//YOU WILL NEED TO RENDER THE FOLLOWING PARTS FOR PRINTING
/*
[color2make,part2make,quadrant,quadrantMain]
visualize surface render=[3,3,5,6]
color1_outer=[0,1,6,6] //same for all quadrants
color1_inner=[0,2,6,6] //same for all quadrants
color2_outer=[1,1,6,6] //same for all quadrants
color2_inner=[1,2,6,6] //same for all quadrants
lines surface=[3,4,5,6] //same for all quadrants trim extra
body_Q1=[?,5,6,1] //1st quardant (first variable is ignored)
body_Q2=[?,5,6,2] //1st quardant (first variable is ignored)
body_Q3=[?,5,6,3] //1st quardant (first variable is ignored)
body_Q4=[?,5,6,4] //1st quardant (first variable is ignored)
*/

//////////////////////////////////////////////////////////////
////////////////make things///////////////////////////////////
//////////////////////////////////////////////////////////////
makeSquares(xnum,ynum,color2make,part2make);//(1st layer) make inner parts
make_boarder(quadrant,thick);//(1st layer) add the outer boarders
mainPart(quadrantMain);//(body, 2nd layer and up) main body part
reg_points();//(1st layer) registration points


//////////////////////////////////////////////////////////////
////////////////modules    ///////////////////////////////////
//////////////////////////////////////////////////////////////
module makeSquares(xnum,ynum,color2make,part2make){
for (x = [0:xnum-1]) {
for (y = [0:ynum-1]) {   
 //  echo(x+y,(x+y)%2,180*((x+y)%2));
    if (3==color2make){//start if for all visual
    
    if ((x+y)%2==0) {
translate([x*side,y*side,0]) rotate([0,0,180*((x+y)%2)]) 
section(side,thick,start_points,part2make); } 
else
   {
translate([x*side,y*side,0]) rotate([0,0,180*((x+y)%2)]) 
section1(side,thick,start_points,part2make); } 
}//end if for all visual
else
if ((x+y)%2==color2make) {//start if make colors
translate([x*side,y*side,0]) rotate([0,0,180*((x+y)%2)]) 
section(side,thick,start_points,part2make); }//end if make colors 
    }//end Y
}//end X
}//end modules make squares

module mainPart(quadrantMain){
//make main part 2nd layer and up
    if (quadrantMain!=6){
translate([-side/2,-side/2,thick])
cube([side*xnum,side*ynum,thickFull-thick]);}
translate([0,0,thick])
make_boarder(quadrantMain,thickFull-thick);
}//end module main part

module make_boarder(quad,z){
if ((quad==3) || (quad==5)) LB_boarder(z);
if ((quad==4) || (quad==5)) RB_boarder(z);
if ((quad==2) || (quad==5)) LT_boarder(z);
if ((quad==1) || (quad==5)) RT_boarder(z);}

//modules to make boarders/////////////
module LB_boarder(z){
 //bottom edge
translate([-side/2,-edge_thick-side/2,0])
color("black")cube([side*xnum,edge_thick,z]); 
  //left edge
translate([-edge_thick-side/2,-side/2,0])
color("black")cube([edge_thick,side*ynum,z]);
  //bottom-left corner
translate([-edge_thick-side/2,-edge_thick-side/2,0])
color("black")intersection(){
    cube([edge_thick,edge_thick,z]);
    translate([edge_thick,edge_thick,0])cylinder(r=edge_thick,h=z);}
    }//end mod LB_boarder

module RB_boarder(z){
 //bottom edge
translate([-side/2,-edge_thick-side/2,0])
color("black")cube([side*xnum,edge_thick,z]); 
  //right edge
translate([side*(xnum-0.5),-side/2,0])
color("black")cube([edge_thick,side*ynum,z]); 
   //bottom-right corner
translate([side*(xnum-0.5),-edge_thick-side/2,0])
color("black")intersection(){
    cube([edge_thick,edge_thick,z]);
    translate([0,edge_thick,0])cylinder(r=edge_thick,h=z);} 
}//end mod RB_boarder

module LT_boarder(z){
  //top edge
translate([-side/2,side*(ynum-0.5),0])
color("black")cube([side*xnum,edge_thick,z]); 
   //left edge
translate([-edge_thick-side/2,-side/2,0])
color("black")cube([edge_thick,side*ynum,z]);
   //top-left corner
translate([-edge_thick-side/2,side*(ynum-0.5),0])
color("black")intersection(){
    cube([edge_thick,edge_thick,z]);
    translate([edge_thick,0,0])cylinder(r=edge_thick,h=z);} 
}//end mod LT_boarder

module RT_boarder(z){
  //top edge
translate([-side/2,side*(ynum-0.5),0])
color("black")cube([side*xnum,edge_thick,z]); 
   //right edge
translate([side*(xnum-0.5),-side/2,0])
color("black")cube([edge_thick,side*ynum,z]);
   //top-right corner
translate([side*(xnum-0.5),side*(ynum-0.5),0])
color("black")intersection(){
    cube([edge_thick,edge_thick,z]);
    translate([0,0,0])cylinder(r=edge_thick,h=z);} 
}//end mod LB_boarder

module reg_points(){
//register points for squares/////////////////////////////////////////
//bottom-left corner
translate([-lines*2-regspace-edge_thick-side/2,-lines*2-regspace-edge_thick-side/2,0])cube([lines*2,lines*2,thick]);
//top-left register
translate([-lines*2-regspace-edge_thick-side/2,edge_thick+regspace+(ynum-0.5)*side,0])cube([lines*2,lines*2,thick]);
//bottom-right register
translate([regspace+edge_thick+(xnum-0.5)*side,-lines*2-regspace-edge_thick-side/2,0])cube([lines*2,lines*2,thick]);
//top-right register
translate([regspace+edge_thick+(xnum-0.5)*side,edge_thick+regspace+(ynum-0.5)*side,0])cube([lines*2,lines*2,thick]);

echo("print bed size needed (mm) [x,y]",regspace+edge_thick+(xnum-0.5)*side+lines*2+regspace+edge_thick+side/2,
lines*2+regspace+edge_thick+side/2+edge_thick+regspace+(ynum-0.5)*side);
}//end mod reg_points

module section(side,thick,start_points,what){
    //what=1 outer, 2 inner, 3 every thing
if (what==1){
difference(){
translate([0,0,thick/2])cube([side-lines,side-lines,thick],center=true);
translate([0,0,-1])star(start_points,side/2-star_shrink,side/4-star_shrink,thick+2);}}//end if what==1

if (what==2){
intersection(){
translate([0,0,thick/2])cube([side,side,thick],center=true);
translate([0,0,-1])star(start_points,side/2-star_shrink,side/4-star_shrink,thick+2);}}//end if what==2

if (what==3){   
color("black")translate([0,0,thick/2])cube([side,side,thick],center=true);
translate([0,0,thick/2])color("WhiteSmoke")cube([side-lines,side-lines,thick+0.2],center=true);    
color("white")translate([0,0,0])star(start_points,side/2-star_shrink,side/4-star_shrink,thick+0.4);
    }//end if what==3
    
if (what==4){
color("black")difference(){    
translate([0,0,thick/2])cube([side,side,thick],center=true);    
translate([0,0,thick/2])cube([side-lines,side-lines,thick+2],center=true);    
    }//end diff
}//end if what=4
}//end module section

//module section1 is just to get a color change when rendering all
module section1(side,thick,start_points,what){
    //what=1 outer, 2 inner, 3 every thing
if (what==1){
difference(){
translate([0,0,thick/2])cube([side-lines,side-lines,thick],center=true);
translate([0,0,-1])star(start_points,side/2-star_shrink,side/4-star_shrink,thick+2);}}//end if what==1

if (what==2){
intersection(){
translate([0,0,thick/2])cube([side,side,thick],center=true);
translate([0,0,-1])star(start_points,side/2-star_shrink,side/4-star_shrink,thick+2);}}//end if what==2

if (what==3){   
color("black")translate([0,0,thick/2])cube([side,side,thick],center=true);
translate([0,0,thick/2])color("DodgerBlue")cube([side-lines,side-lines,thick+0.2],center=true);    
color("DeepSkyBlue")translate([0,0,0])star(start_points,side/2-star_shrink,side/4-star_shrink,thick+0.4);
    }//end if what==3
    
if (what==4){
color("black")difference(){    
translate([0,0,thick/2])cube([side,side,thick],center=true);    
translate([0,0,thick/2])cube([side-lines,side-lines,thick+2],center=true);    
    }//end diff
}//end if what=4
}//end module section

module star(points, outer, inner,height) {
// With recursive functions very complex results can be generated,
// e.g. calculating the outline of a star shaped polygon. Using
// default parameters can help with simplifying the usage of functions
// that have multiple parameters.
function point(angle) = [ sin(angle), cos(angle) ];
function radius(i, r1, r2) = (i % 2) == 0 ? r1 : r2;
function starP(count, r1, r2, i = 0, result = []) = i < count
    ? starP(count, r1, r2, i + 1, concat(result, [ radius(i, r1, r2) * point(360 / count * i) ]))
    : result;


    translate([0, 0, 0])
        linear_extrude(height = height)
            polygon(starP(points*2, outer, inner));


//http://files.openscad.org/examples/Functions/recursion.html
// Written in 2015 by Torsten Paul <Torsten.Paul@gmx.de>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
}//end module star