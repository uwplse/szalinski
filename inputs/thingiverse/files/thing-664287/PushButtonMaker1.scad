// Push button generator
// Makes round or square buttons with round or square shaft holes, and bevelled edges
// square holes are keyholed to prevent rounding of internal corners
// holes are vaulted so no support will be needed inside them
// customizer compatible

//defualt is to
// Make replacement buttons for Atlas stove
// button is a round button press fit onto a square 3.3mm shaft
// this is a standard size for "isostat" switches

/* [Global] */
//Visualising
Show="CrossSection"; //[Complete,CrossSection]
//Outside shape of button
ButtonShape="Round"; //[Round,Square,Oval]

/* [Button] */
//Length of Button
L=15;

//Outside Diameter of Round Button
ButtonOD=10.65;

//Rectangular or oval ButtonX
ButtonX=15;
//Rectangular or oval ButtonY
ButtonY=10;

//amount of bevel around top edge of button
TopBevel=1.2;
//Style of the button edge (for square buttons)
EdgeStyle="Round"; //[Radius,Bevel,Square]
//Bevel of bevelled edges. (This is X,Y distance, not the bevel face length)
EdgeBevel=1.2;
//Radius of rounded edges
EdgeR=1.2;
   
/* [Shaft Hole] */
ShaftShape="Square"; //[Square,Round]
//Length of shaft inside button. Crown of hole is vaulted for support free build
ShaftL=10;
//Side width of square shafts or diameter of round shafts
ShaftW=3.3;
//Oversize in mm for internal holes (diameter). UP printer makes internal holes small. Adjuest this for correct internal size
holeos=0;
//So that square shaft holes don't have rounded corners they must have a keyhole at the corner
ShaftKeyholeD=1.2;

KeyholeR=ShaftKeyholeD/2;

OR=ButtonOD/2;
ShaftI=ShaftW+holeos; //side length or IR
ShaftR=(ShaftW+holeos)/2; //for round shafts

//------


module SqShaft() {
    hull() { 
    translate([-ShaftI/2,-ShaftI/2,0]) 
        cube([ShaftI, ShaftI,ShaftL]);
     translate([0,0,ShaftL+ShaftI/2])
        cylinder(r=0.5,h=0.5);
    }//hull
    KHO=ShaftI/2-KeyholeR/2;
    for (A=[0:3]) {
        rotate([0,0,A*90])            
            translate([KHO,KHO,0]) 
                cylinder(r=KeyholeR, h=ShaftL,$fn=10);
    }//for

}//mod
module RoundShaft() {
    cylinder(r=ShaftR, h=ShaftL, $fn=20);
    translate([0,0,ShaftL])
        cylinder(r1=ShaftR,r2=0.1,h=ShaftR); //vault at top of hole
}//mod

module RoundButton() {
        H1=L-TopBevel;
        hull() {
            cylinder(r=OR, h=H1, $fn=50);
            translate([0,0,H1]) 
            cylinder(r=OR-TopBevel, h=TopBevel,$fn=50);  
        };//hull  
}//mod

module SquareButton() {
        H1=L-TopBevel;
        hull() {
            //translate([0,0,H1/2]) cube([ButtonX,ButtonY,H1], center=true);
            for (iX=[1,-1],iY=[1,-1]) {         
                    translate([(ButtonX/2-EdgeBevel)*iX,(ButtonY/2-EdgeBevel)*iY,H1/2]) 
                        if (EdgeStyle=="Bevel") {
                                rotate([0,0,45]) //bevels are made by using edge of these cubes at 45deg
                                    cube([EdgeBevel*sqrt(2),EdgeBevel*sqrt(2),H1],center=true);
                        } else {
                            if (EdgeStyle!="Square") {
                                cylinder(r=EdgeR, h=H1, center=true,$fn=20);
                            } else {
                                cylinder(r=0.1, h=H1, center=true,$fn=20);
                            }//if                                
                        }//if
                    }//for
            translate([0,0,H1+TopBevel/2]) 
                 cube([ButtonX-(2*TopBevel),ButtonY-(2*TopBevel),TopBevel], center=true); //bevelled top
        }//hull  
}//mod

difference() {
    if (ButtonShape=="Square") {
        SquareButton();
    } else { //round, oval
        RoundButton();
    };
    translate([0,0,-0.1])  {
        if (ShaftShape=="Round") {
            RoundShaft();
        }else{
            SqShaft();
        }//if
        if (Show=="CrossSection") {
            //MM=max(ButtonX,ButtonY);
            rotate([0,0,-125]) cube([100,100,L+1]);
    }//if
}//translate
}//difference