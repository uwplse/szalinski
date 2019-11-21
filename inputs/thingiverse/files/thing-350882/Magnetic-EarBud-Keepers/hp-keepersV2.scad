//Magnetic Headphone Keeper
include <MCAD/boxes.scad>

/* [Global] */
//Type of Headphone Cord
type=1; //[0:Rectangular, 1:Round]
//Wall Thickness
wallTh=1.3;
//Height
height=6;
//Facets
$fn=36;

/* [Cord Dimensions] */
//Cord Diameter
cordDia=2;

/* [Headphone Holder Dimensions] */
//Cord Thickness (rectangular)
xDim=4.4;
//Cord Width (rectangular)
yDim=1.5;
//Corner Radius (rectangular)
corner=2;
//Headphone Cord Diameter (round)
headPhDia=2;


/* [Hidden] */
//overage for cutting and joining
ovr=0.001;
//cord radius
cordR=cordDia/2;
//headphone cord radius
headPhR=headPhDia/2;


module cordHolder() {
  difference() {
    cylinder(r=cordR+wallTh, h=height, center=true);
    cylinder(r=cordR, h=height+ovr, center=true);
  } //end diff
} //end cordHolder


module rectHolder() {
  difference() {
    //outter box
    roundedBox([xDim+wallTh*2, yDim+wallTh*2, height], corner, sidesonly=1);
    //cutout 
    cube([xDim, yDim, height+ovr], center=true);
    //opening slot
    translate([0, -xDim/2, 0]) cube([yDim, xDim, height+ovr], center=true);

  } // end diff
} //end rect holder


module roundHolder() {
  difference() {
    cylinder(r=headPhR+wallTh, h=height, center=true);
    cylinder(r=headPhR, h=height+ovr, center=true);
    translate([0, -headPhR, 0]) cube([headPhR*1.3, headPhR*3, height+ovr], center=true);
  }
} //end round holder

module joinParts(type=0) {
  union() {
    cordHolder();
    if (type==0) {
      translate([cordR+wallTh+(xDim+wallTh*2)/2.5, 0, 0]) rectHolder();      
    } //end rectangular

    if (type==1) {
      translate([cordR+wallTh+(cordR+wallTh*2)/2.5, 0, 0]) roundHolder();
    } //end round
  } //end union
} //end join parts

joinParts(type);
translate([0, (cordDia+wallTh)*2, 0]) joinParts(type);
