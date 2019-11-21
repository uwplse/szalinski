/*

Version 0.4

Headphone end mold

    |  | -----Upper Diameter
    |  |
    |  |
    /  \ 
   |    | ----Lower Diameter
   |    |
   |    |
   |    |----Lower Taper (this makes it easier to fit into phone jacks)
    \__/
     == ----Butt End
     ||
     ||
     ||
     \/
TODO
* make transitions slopes equal to ~20% of length

*/

/*[Jack Sheath Dimensions]*/
lowerDia=10; //Lower Dia
upperDia=6; //Upper Dia
lowerLength=15; //Lower Length
upperLength=35; //Upper Length
cableDia=2; //Cable Diameter
jackTexture=.5; //Texture depth
jackDia=3.6; //Jack Diameter 
jackLen=14; //Jack Length
buttEndDia=4.5; //Diameter of butt end
lengthButtEnd=1; //Thickness of butt end
//lowerTaper=1; //[0:True, 1:False]
lowerTaperPct=30;

/*[Closure]*/
boltD=3.1; //Bolt Diameter

/*[Overages]*/
pctOvr=1.1;

/*[Hidden]*/
lRad=lowerDia/2;
uRad=upperDia/2;
jackRad=jackDia/2*pctOvr; //add a bit to the jack diameter to account for swelling
cableRad=cableDia/2;
moldX=upperLength+lowerLength*2;
moldY=lowerDia*2.5;
moldZ=lowerDia*1.5;
buttEndRad=buttEndDia/2;
boltRad=boltD/2*pctOvr;
lTaper=lowerTaperPct/100;
echo(1-lTaper);
$fn=36;


module jSheath() {
  union() {
    //lower sectioa
    translate([0, 0, lowerLength*lTaper/2])
      cylinder(r=lRad, h=lowerLength*(1-lTaper), center=true);
    translate([0, 0, lowerLength*-lTaper-(lowerLength/2)+lowerLength*lTaper])
      cylinder(r2=lRad, r1=buttEndRad, h=lowerLength*lTaper, center=false);



    //tappered section between upper and lower
    translate([0, 0, lowerLength/2])
      cylinder(r1=lRad, r2=uRad, h=upperLength*.2);  

    //upper section 
    translate([0, 0, lowerLength/2]) 
      cylinder(r=uRad, h=upperLength-upperLength*.2);

    //tapered top
    translate([0, 0, lowerLength/2+upperLength-upperLength*.2])
      cylinder(r1=uRad, r2=cableRad, h=upperLength*.2);

    //cable
    translate([0, 0, lowerLength/2+upperLength])
      cylinder(r=cableRad, h=lowerLength+upperLength);

    //jack
    translate([0, 0, -jackLen-lowerLength/2])
      cylinder(r=jackRad, h=jackLen);

    //butt end
    translate([0, 0, -lowerLength/2-lengthButtEnd])
      cylinder(r=buttEndRad*pctOvr, h=lengthButtEnd*pctOvr);
  }
  
}


module texture() {
  difference() {
    jSheath();
    for (i = [1 : jackTexture*2 : lowerLength-jackTexture ]) {
      translate([-lRad, 0, -lowerLength/2+jackTexture/2+i])
        rotate([90, 0, 0])
        cylinder(r=jackTexture, h=upperDia, center=true);
        //#cube([jackText, upperDia, jackText], center=true);
      translate([lRad, 0, -lowerLength/2+jackTexture/2+i])
        rotate([90, 0, 0])
        //#cube([jackText, upperDia, jackText], center=true);
        cylinder(r=jackTexture, h=upperDia, center=true);
    }

  }
}


module jackPositive() {
  rotate([0, 90, 0])
  translate([0, 0, -lowerLength])
  texture();
}

module mNut(dia, cent=false) {
  m=0.8*dia;
  f=1.8*dia;
  r=(f*1/cos(30))/2;
  c=0.2*dia;
  difference() {
    cylinder(r=r, h=m, $fn=6, center=false);
    translate([0, 0, -m/2]) cylinder(r=dia/2, h=m*3, center=false);
  }

}


module mold(nut=false) {
  difference() {
    translate([0, 0, -moldZ/4])
      cube([moldX, moldY, moldZ/2], center=true);

    //Upper left
    translate([moldX/2-boltD, uRad*1.2+boltRad, 0]) 
      cylinder(r=boltRad, h=moldZ+pctOvr, center=true);

    //Lower left
    translate([-moldX/2+boltD, cableRad*1.2+boltD, 0]) 
      cylinder(r=boltRad, h=moldZ+pctOvr, center=true);

    //Lower right
    translate([-moldX/2+boltD, -cableRad*1.2-boltD, 0]) 
      cylinder(r=boltRad, h=moldZ+pctOvr, center=true);

    //Upper right
    translate([moldX/2-boltD, -uRad*1.2-boltRad, 0]) 
      cylinder(r=boltRad, h=moldZ+pctOvr, center=true);

    translate([0, lRad*1.2+boltRad, 0])
      cylinder(r=boltRad, h=moldZ+pctOvr, center=true);
    translate([0, -lRad*1.2-boltRad, 0])
      cylinder(r=boltRad, h=moldZ+pctOvr, center=true);

     translate([0, 0, 0])
      jackPositive();
    

  }
}

module main() {
  translate([0, -moldY/1.5, 0])
    mold();
  translate([0, moldY/1.5, 0])
    mold(nut=true);
}

//!jackPositive();
main();
