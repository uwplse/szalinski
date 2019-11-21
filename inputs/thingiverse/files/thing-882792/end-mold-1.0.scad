// Headphone end-mold replacement 90 deg bend

/*
Revision 1
  -increased diameter and length of lower end
*/
/*
   |  |
   |  |   -----Upper Taper
   /  \ 
  |    |  -----Lower Diameter
  |    |
  |    |
  |    |  -----Lower Taper
   \__/ 
    ==    -----Butt End
    ||
    ||
    ||
    ||
    \/           
            --------------------Taper: 4(len)  
           /   -----------------Texture: 15(len) 
          /   /      -----------Cable: 4.6(dia); 29(len)
   _____ /   /      /   --------Wire: 2.5(dia)
  |     \___/_____ /   /
  |      _________|===== -------Top: 6.6(dia); 9.3(len)
  |_  __/ 
   |  |   ----------------------Lower End: 6.2(dia); 6(thick)
   |__|
    ==    ----------------------Butt End: 4.5(dia); 1.1(thick)
    ||
    ||
    ||    ----------------------Jack: 3.6(dia)
    ||
    \/

*/

/*[Jack Sheath Dimensions]*/
model=1;//[1:model, 0:mold]
jackDia=3.6; //Jack Diameter
jackLen=14; //Jack Length

buttEndDia=4.5; //butt end diameter
buttEndThick=1.1; //butt end thickness

lowerEndDia=8.5; //original 6.2
lowerEndThick=7.5; //original 6

topDia=10; //original 6.6
topLen=9.5;

taperLen=4;

cableDia=6.5; //original 5
cableLen=29;

wireDia=2.5;


texture=1;
textureSpacer=texture*1.5;
textureLen=15;


/*[Closure]*/
//boltD=3.2;
boltD=3.3;

/*[Overages]*/
pctOvr=1.08;

/*[Layout]*/
separation=5;

/*[Hidden]*/
$fn=60; //curve refinement
//position the top cylinder so it precisely intersects with the top of the 
//bottom cylinder using chord length=2*sqrt(r^2-d^2) where d is the displacement
chordDisp=sqrt(pow(topDia/2, 2)-pow(lowerEndDia,2)/4);

//Top displacement to make lowerEnd the correct length
topDisp=buttEndThick/2+lowerEndThick+topDia/2-chordDisp-0.1;

//mold dimensions
moldX=topLen+cableLen;
moldY=lowerEndThick+buttEndThick/2+topDia-chordDisp;
moldZ=topDia*1.5;

 
module cableTexture() {
  difference() {
    cylinder(r=cableDia/2, h=cableLen);
    for (i = [0 : texture+textureSpacer : textureLen ]) {
      translate([cableDia/2-texture/2, 0, i+taperLen+texture/2])
        rotate([90, 0, 0])
        //cylinder(r=texture/2, h=cableDia, center=true);
        cube([2*texture, texture, cableDia], center=true);

      translate([-cableDia/2+texture/2, 0, i+taperLen+texture/2])
        rotate([90, 0, 0])
        cube([2*texture, texture, cableDia], center=true);

    }
  }
}

module jSheath() {
  union() {
    //phono jack
    translate([0, 0, -jackLen])
      color("silver")
      cylinder(r=jackDia/2*pctOvr, h=jackLen);
    //butt end
    translate([0, 0, 0])
      color("gray")
      cylinder(r=buttEndDia/2*pctOvr, h=buttEndThick);
    //lower end
    translate([0, 0, buttEndThick/2])
      color("red")
      cylinder(r=lowerEndDia/2, h=lowerEndThick);
    //top 
    translate([-topLen/2, 0, topDisp])
      rotate([0, 90, 0])
      color("blue")
      cylinder(r=topDia/2, h=topLen);
    
    //cable
    translate([topLen/2, 0, topDisp])
      rotate([0, 90, 0])
      color("green")
      cableTexture();
      //cylinder(r=cableDia/2, h=cableLen);

    //cable taper
    translate([topLen/2, 0, topDisp])
      rotate([0, 90, 0])
      color("yellow")
      cylinder(r2=cableDia/2, r1=topDia/2, h=taperLen);

    //wire 
    translate([topLen/2, 0, topDisp])
      rotate([0, 90, 0])
      color("purple")
      cylinder(r=wireDia/2*pctOvr, h=cableLen*5);


  }
}

module mold(orientation=-1) {

/*
  ---------------------
  | A      B         C|


    G      F     
                E    D 
  |___________________|

*/



  difference() {
    translate([(moldX)/2-topLen/2, -moldY/2, orientation*moldZ/4])
      cube([moldX+boltD*4, moldY+boltD*4, moldZ/2], center=true);

    //create negative for mold
    rotate([90, 0, 0])
      jSheath();

    //bolt holes
    //A
    translate([(topLen/2+cableLen), (topDisp+boltD*2)*-1, 0])
      cylinder(r=boltD/2, h=moldZ*3, center=true);

    //B
    translate([(topLen/2+boltD+cableLen/6), (topDisp+boltD*2)*-1, 0])
      cylinder(r=boltD/2, h=moldZ*3, center=true);

    //C
    translate([(topLen/2+boltD)*-1, (topDisp+topDia/2+boltD/2)*-1, 0])
      cylinder(r=boltD/2, h=moldZ*3, center=true);

    //D
    translate([(lowerEndDia/2+boltD)*-1, 0, 0])
      cylinder(r=boltD/2, h=moldZ*3, center=true);


    //E
    translate([lowerEndDia/2+boltD, 0, 0])
      cylinder(r=boltD/2, h=moldZ*3, center=true);


    //F
    translate([topLen/2+boltD+cableLen/6, -topDisp+boltD*2, 0])
      cylinder(r=boltD/2, h=moldZ*3, center=true);

    //G
    translate([(topLen/2+cableLen), -topDisp+boltD*2, 0])
      cylinder(r=boltD/2, h=moldZ*3, center=true);

  }
}


module layout(model=0) {
  if (model==0) {
    mold(orientation=-1);

    translate([0, moldY+separation, 0])
      rotate([180, 0, 0])
      mold(orientation=1);
  } else {
    jSheath();
  }
}

layout(model);
//cableTexture();
//jSheath();

