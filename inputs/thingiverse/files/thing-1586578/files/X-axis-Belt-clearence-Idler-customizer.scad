
/* [Idler profile] */
//Render, choose idler to render
Part=1;//[0:X home idler,1:X end idler,2:Spacers]

//Idler type
Type=1;//[1:teeth,0:toothless]

//bearing holding type
BHT=0;//[0:captive,1:plug-in]


/* [Bearing profile] */
//Outer diameter
OD=22;
//bearing width
width=7;
//Inner diameter (for spacers only)
ID=8;



/* [Tuning] */
//printer accuracy, positive value will create MORE space to plug the bearing (0.15 is a good value)
tolerance=0.15;

//definition
$fn=30;//[30:Low,60:medium,100:High]


////////////////////////////////////////////////////////

module Idler(a,b) {
    if(a==0) {
        for(i=[0,180]) rotate([i,0,0]) translate([0,0,-5]) cylinder(d1=21.15+4,d2=21.15,h=1.75);
        difference() {
            cylinder(d=21.15,h=10,center=true);
            for(i=[0:360/34:360]) rotate([0,0,i]) translate([0,21.15/2,0]) scale([0.875,1.15,b]) cylinder(d=1.6,h=12,$fn=50,center=true);
        }
    }
    else if(a==1) {
        for(i=[0,180]) rotate([i,0,0]) translate([0,0,-5]) cylinder(d1=27.5+4,d2=27.5,h=1.75);
        difference() {
            cylinder(d=27.5,h=10,center=true);
            for(i=[0:360/44:360]) rotate([0,0,i]) translate([27.3/2,0,0]) scale([1,0.875,b]) cylinder(d=1.6,h=12,$fn=50,center=true);
        }
    }
    else {}
    
}

module Bearing(a) {
    if((a>=0)&&(a<=1)) {
        cylinder(d=OD+2*tolerance,h=width+0.2,center=true);
        cylinder(d=OD-2.5,h=12,center=true);
        translate([0,0,0.05+width/2]) cylinder(d1=OD+2*tolerance,d2=OD-2.5,h=(10-width)/4);
        scale([1,1,BHT]) difference() {
            cylinder(d=OD+2*tolerance,h=width+0.2);
            translate([0,0,width/2+0.25]) rotate_extrude() translate([OD/2+tolerance,0,0]) circle(d=0.5);
        }
    }
    else {}
}

module Spacers(a) {
    if(a==2) {
        for(i=[10,-10]) translate([i,0,0]) difference() {
            union() {
                cylinder(d=ID+3.5,h=(14-width)/2);
                cylinder(d=ID-2*tolerance,h=7-0.2);
                }
            translate([0,0,-1]) cylinder(d=3.4,h=9);
            }
        }
    else{}
}

difference() {
    Idler(Part,Type);
    Bearing(Part);
}

Spacers(Part);

