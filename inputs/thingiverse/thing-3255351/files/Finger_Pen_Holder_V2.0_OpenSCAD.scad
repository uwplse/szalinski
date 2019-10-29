
/////////////////////////////////////////////////////////////////
//Remix by W. Englert 12/02/2018/////////////////////////////////
//Finger_Pen_Holder_V2.0_OpenSCAD////////////////////////////////
//Maker's Making Change /////////////////////////////////////////
//http://www.makersmakingchange.com//////////////////////////////
//Remix of Finger Pen Holder (Vertical) by makersmakingchange////
//Published on February 28, 2018/////////////////////////////////
//www.thingiverse.com/thing:2802074//////////////////////////////


/*[variables]*/

//Length of the Ring
Ring_L = 18.0; // [10:0.5:40]

//Ring hole size (mm)
Ring_HD = 21.0; // [10:0.5:40]

//Ring Edge Cutout (mm)
Ring_C =9.0; // [0:0.5:40]

//Thickness of the Ring (mm)
Ring_T = 2.5; // [2:0.1:4]

//Length of the pen holder (mm)
Pen_L = 18; // [10:0.5:40]

//Pen hole size (mm)
Pen_HD = 10.1; // [1:0.1:40]

//Pen Edge Cutout
Pen_C = 9.5; // [0:0.1:40]

//Thickness of Pen holder
Pen_T = 2.5; // [2:0.1:4]

//Angle of Pen holder (degrees)
Pen_A =45; // [0:1:359]

//Additional distance from ring to pen
Distance = 0;// [0:0.5:40]

/*[Hidden]*/
//Total width for top and bottom trimming
Total_W = Ring_HD+(Ring_T*2)+(Pen_HD*2)+(Pen_T*2)+(Distance*2);

//facet Number
$fn=50;


//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//Renders
difference(){
Outer_Structure();
holes();
}


//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

//modules

module Outer_Structure (){
//Ring Outer
    cylinder(d1=Ring_T+Ring_HD,d2=Ring_T+Ring_HD, h=Ring_L);

//Ring and Pen outer structure    
hull(){
//hull attachment point on the ring
    cylinder(d1=Ring_T+Ring_HD,d2=Ring_T+Ring_HD, h=Pen_L);

// Pen holder Outer    
    translate([(Ring_HD*0.5)+(Pen_HD*0.5)+(Ring_T*0.5)+(Pen_T*0.5)+Distance,0,(Pen_L*.5)])rotate([Pen_A,0,0]){
    cylinder(d1=Pen_HD + Pen_T,d2=Pen_HD + Pen_T,h=Pen_L, center=true);}
}
}
module holes(){
// Ring Hole
    cylinder(d1=Ring_HD, d2=Ring_HD, h=Ring_L);
    
// Pen Hole    
    translate([(Ring_HD*0.5)+(Pen_HD*0.5)+(Ring_T*0.5)+(Pen_T*0.5)+Distance,0,(Pen_L*.5)])rotate([Pen_A,0,0]){
    cylinder(d1=Pen_HD,d2=Pen_HD,h=Pen_L*2, center=true);}

// Cutout for Pen Hole   
    translate([(Ring_HD*0.5)+(Pen_HD)+(Ring_T*0.5)+(Pen_T*0.5)+Distance,0,Pen_L*.5])rotate([Pen_A,0,0]){
    cube([Pen_HD,Pen_C,Pen_L*2],center=true);}

// Cutout for Ring Hole    
    translate([-Ring_HD,-Ring_C*.5,0])cube([Ring_HD,Ring_C,Ring_L]);

// Trim Bottom of device Flush with Table    
    translate([0,0,-Ring_L])cylinder(d1=Total_W,d2=Total_W,h=Ring_L);

// Trim Top of device Flush    
    translate([0,0,Ring_L])cylinder(d1=Total_W,d2=Total_W,h=Ring_L);
}

/////////////////////////////////////////////////////////////////
//Remix by W. Englert 12/02/2018/////////////////////////////////
//Finger_Pen_Holder_V2.0_OpenSCAD////////////////////////////////
//Maker's Making Change /////////////////////////////////////////
//http://www.makersmakingchange.com//////////////////////////////
//Remix of Finger Pen Holder (Vertical) by makersmakingchange////
//Published on February 28, 2018/////////////////////////////////
//www.thingiverse.com/thing:2802074//////////////////////////////
