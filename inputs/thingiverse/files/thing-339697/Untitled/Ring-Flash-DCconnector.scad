/*
  RV05.5
*/


include <MCAD/boxes.scad>
/* [Global] */
//Rounded Box Corner Radius
corner=2; //[0:5]
//Curve Refinement
$fn=36; 

module WireBox(boxX=30, boxY=30, boxZ=20, ft=2.5, posts=1, wallThick=2, lid=0) {
  screwD=3;
  ovr=0.001; //overage for cutting

  boxDim=[boxX, boxY, boxZ];
  cutDim=[boxX-wallThick*2, boxY-wallThick*2, boxZ];
  
  union() {
    //add a stopper at the front of the box to hold the dc connector
    difference() {
      translate([boxX/3-wallThick/2, 0, 0]) 
        cube([boxX/3, boxY-wallThick, boxZ/2], center=true); 
      // cut out a screw hole
      translate([boxX/2-wallThick-screwD, boxY/2-wallThick-screwD, wallThick]) 
        cylinder(r=screwD/2.5, h=boxZ, center=true);
    }

    //add a stopper at the top and back of the DC connector 
    translate([boxX/2-boxX/3, -boxY/2+boxY/4, 0])
      cube([boxX/2-wallThick, boxY/2-wallThick, boxZ/2], center=true);
    
    // draw the actual box 
    difference() {
      roundedBox(boxDim, corner, sidesonly=1);
      //cut out the inside of the box
      translate([0, 0, ft]) roundedBox(cutDim, corner, sidesonly=1);
      // poke holes in the base for the screws opposite of the dc connector
      translate([-boxX/4, boxY/5, wallThick]) cylinder(r=screwD/2, h=boxZ, center=true);
      translate([-boxX/4, -boxY/5, wallThick]) cylinder(r=screwD/2, h=boxZ, center=true);

    }
    //add wire posts & screw holes
    difference() {
      //screw holes
      translate([-boxX/4, boxY/5, 0]) cylinder(r=screwD*posts, h=boxZ, center=true);
      translate([-boxX/4, boxY/5, ovr]) cylinder(r=screwD/2.3, h=boxZ, center=true);
    } // end diff
    difference() {
      //wire posts
      translate([-boxX/4, -boxY/5, 0]) cylinder(r=screwD*posts, h=boxZ, center=true);
      translate([-boxX/4, -boxY/5, ovr]) cylinder(r=screwD/2.3, h=boxZ, center=true);
    } // end diff

    // cut a hole in the lid for the DC connector and screw holes
    if (lid==1) {
      translate([7.5, -2, 0])
        rotate([-90, 0, 180]) scale([1.19, 1.19, 1.19]) DCconnector();
      // screw holes
      translate([-boxX/4,  boxY/5, boxZ/2]) 
        cylinder(r=screwD/2*1.09, h=boxZ, center=true);
      translate([-boxX/4, -boxY/5, boxZ/2]) 
        cylinder(r=screwD/2*1.09, h=boxZ, center=true);
      translate([boxX/2-wallThick-screwD, boxY/2-wallThick-screwD, wallThick]) 
        cylinder(r=screwD/2*1.09, h=boxZ, center=true);
      
    } //end if lid==1
  } // end union
  
  
} // end WireBox


// lid for wire box 
module WireBoxLid(boxX=30, boxY=30, boxZ=20, thick=3, wall=2){
  screwD=3.1; //screw diameter
  boxDim=[boxX, boxY, thick]; //box dimensions
  difference() {
    roundedBox(boxDim, corner, sidesonly=1);
    
    //cut out holes in the lid
    //translate([-boxX/4, boxY/5, 0]) cylinder(r=screwD/2, h=boxZ, center=true);
    //translate([-boxX/4, -boxY/5, 0]) cylinder(r=screwD/2, h=boxZ, center=true);

    //cut out a wirebox to make a lip with a lip (slightly larger wall thickness)
    // scale the box slightly larger in the X and Y to cut away the entire wall
    translate([0, 0, boxZ/2]) rotate([180, 0, 0]) 
      scale([1.001, 1.001, 1]) WireBox(boxX, boxY, boxZ, posts=1.1, wallThick=wall*1.1, lid=1); 
  }

} //end WireBoxLid

// DC barrel connector
module DCconnector(){
  ovr=0.0001;
  barrelD=8.2;    //barrel diameter
  barrelH=10.1;   //barel length
  faceX=3.5;      //front face X
  faceY=9.1;      //front face Y
  faceZ=10.9;     //front face Z 
  baseX=13.6;     //base X
  baseY=faceY;    //base Y
  baseZ=6.8;      //base Z
  baseEarX=1;     //small ears on the back
  baseEarZ=3.4;   
  baseEarY=faceY;
  contactX=2.5;   //contact dimensions
  contactY=0.5;
  contactZ=8.2;
  cBoxX=6.5;      //make a box over the contacts
  cBoxY=6.3;
  cBoxZ=4.2;

  //Stick it all together
  union() {
    // face
    translate([-barrelH/2-faceX/2, 0, 0])cube([faceX, faceY, faceZ], center=true);
    // barrel
    translate([0, 0, faceZ/8-0.2]) rotate([0, 90, 0]) 
      cylinder(h=barrelH+ovr, r=barrelD/2, center=true); //barrel
    // base
    translate([-faceX/2, 0, -faceZ/2+baseZ/2]) cube([baseX, baseY, baseZ], center=true);
    // ears on back
    translate([barrelH/2+baseEarX/2-ovr, 0, -faceZ/2+baseEarZ/2]) 
      cube([baseEarX, baseEarY, baseEarZ], center=true);
    //right contact
    color("silver")
      translate([barrelH/2-contactX/2-1.6, -faceY/2-contactY/2, -faceZ/2]) 
      cube([contactX, contactY+ovr, contactZ], center=true);
    //back contact
    color("silver")
      translate([barrelH/2, 0, -faceZ/2]) 
      rotate([0, 0, 90]) cube([contactX, contactY+ovr, contactZ], center=true);
    //front contact
    color("silver")
      translate([-1, 0, -faceZ/2]) 
      rotate([0, 0, 90]) cube([contactX, contactY+ovr, contactZ], center=true);

    color("green")
      translate([barrelH/2-cBoxX/2+contactY/2, -faceY/2+cBoxY/2-contactY, -faceZ/2-cBoxZ/2])
      cube([cBoxX, cBoxY,cBoxZ+ovr], center=true);
      
  } //end union
} //end DCconnector



//Assemble Electrical Connections Box
module AssembleElectrical() {
  wireH=3; //wire hole 
  lidTh=4; //lid thickness
  wX=32;
  wY=24;
  wZ=12;
  ft=5;
  wall=2; //wall thickness
  support=0.2;

  
  union(){
    difference() {
      WireBox(wX, wY, wZ, ft, wallThick=wall); //create the wire box
      // add in the DC connector and roate appropriately
      translate([7.5, -2, 0]) 
        rotate([-90, 0, 180]) scale([1.07, 1.07, 1.07]) DCconnector();


      // cut a hole for the light wires
      translate([-(wX/2), 0, 0])
        rotate([0, 90, 0]) cylinder(r=wireH/2, h=wX*2, center=true);
      
      //subtract the lid from the top to get rid of any thing extra above DC connector
      //scale the wirebox lid slightly to cut away everything 
      //translate([0, 0, 20]) scale([1.001, 1.001, 1.01]) #WireBoxLid(wX, wY, wZ, lidTh);
      
      translate([wX/2-wall/2, -2, 3]) cube([wall+.001, 12, 15], center=true);

    } //end difference
    //add a support for the hole cut by the DC connector
    //translate([wX/2-wall/2, 0, 0]) #cube([support, wY-wall, wZ], center=true);
  }
  
  //create a lid
  translate([0, wY*1.2, -wZ/2+(lidTh)/2]) WireBoxLid(wX, wY, wZ, thick=lidTh, wallThick=wall);
  

} //end Assemble Electrical

AssembleElectrical();
