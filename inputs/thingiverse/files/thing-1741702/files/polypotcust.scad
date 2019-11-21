/*******************************************************************************  
* Program Name:  POLYPOT
* Created Date:  8/20/2016
* Created By:  M. Graham Cottone
* Purpose: Geometric planter with dranage dish
******************************************************************************** 
POLYPOT (c) by M. Graham Cottone

POLYPOT is licensed under a
Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.

You should have received a copy of the license along with this
work. If not, see <http://creativecommons.org/licenses/by-nc-sa/4.0/>.
*******************************************************************************/


//radus of outer width of widest part of main object(top most part)(radus of dish += 5)
rad=40;
//inner radus of the planter
centerHole = 20;
//radus of dranage hole in center of pot
drainHole = 3;
//height of base 
baseHeight= 8;
//half of the width of dranage pipes running through the base
drainPipeWidth= 5;
//depth of the dranage dish 
dishDepth= 5;



//this variable affects the number of sides of the object based on the angle and some fancy trigonometric functions, the math is set for this to be 40, some parts may not align properly if this number is changed.
angle = 40;




//the main object (planter its self)
difference() {
    
    translate ([0, 0, .63*(rad*cos(.5*angle)-1) ])
        sphere($fa=angle, rad );

//cuts out the center hole for plants to live in 
    translate([0,0,3,])
        cylinder($fa=angle, 2*rad,centerHole,centerHole);
        
//cuts extra off bottom at edge
    translate([-rad,-rad,-rad])
        cube([2*rad,2*rad,rad]);

//cuts out drainage hole
     translate([0,0,-3,])
        cylinder($fa=angle, 2*rad,drainHole,drainHole);
}


//the base
difference() {
    translate([0,0,-baseHeight,])
        cylinder($fa=angle, baseHeight+.1,.9*rad,.813*rad);
    
//continues the drainage hole into the base
    translate([0,0,-baseHeight,])
        cylinder($fa=angle, 2*rad,drainHole,drainHole);

//cutout for drain pipe one
    rotate([0,90,0])
 translate([baseHeight-.5*drainPipeWidth,0,-rad,])
        cylinder( 2*rad,drainPipeWidth,drainPipeWidth);

//cutout for drain pipe two
    rotate([90,0,0])
    translate([0,.5*drainPipeWidth-baseHeight,-rad,])
        cylinder( 2*rad,drainPipeWidth,drainPipeWidth);  
}

//the bottom dish
translate ([0, 0,-baseHeight-2 ])
difference() {
    
    translate ([0, 0,0 ])
        cylinder($fa=angle, dishDepth+3,rad+5,rad+5);
       
   
    translate ([0, 0,3 ])
        cylinder($fa=angle, dishDepth+3,rad+2,rad+2);
}


