/*
Customizable Y shaped mold for repairing headphones
version 3 RV 0 
*/

/*[Dimensions]*/
//wire diameter
wireDiameter=2;
//sheath diameter
sheathDia=7;
//ear end sheath length
earSheathLen=10;
//jack end sheath length
jackSheathLen=15;
//sheath texture
texture=1;
//central joint diameter
jointDia=13;
//degrees of seperation for ear-piece wires
earAngle=70;
//bolt diameter
boltDiameter=3;
//overages
ovr=1.05;

/*[Hidden]*/
textureSpacer=texture*1.5;
boltDia=boltDiameter*ovr;
wireDia=wireDiameter*ovr;
//mX=(jointDia+cos(earAngle/2)*sheathLen)*1.3;
//mY=(jointDia+sheathLen+sin(earAngle/2)*sheathLen)*1.3;
//mZ=(jointDia+3)/2;

module texturedCyl(len=10) {
  union() {
    difference() {
      cylinder(d=sheathDia, h=len, center=true);

      for (i = [0 : texture+textureSpacer: len]) {
        translate([sheathDia/2-texture/2, 0, i+texture/2-(len/2)])
          rotate([90, 0, 0])
          cube([2*texture, texture, sheathDia], center=true);
        translate([-sheathDia/2+texture/2, 0, 1+i+texture/2-(len/2)])
          rotate([90, 0, 0])
          cube([2*texture, texture, sheathDia], center=true);
        
      }

    } //end difference
  } //end union
}

module wireSheath(len=10, rot=-1) {
  position= rot!=0 ? -1 : 1;
  //shift the sheath position so it perfectly intersects the joint sphere
  chordShift=(sqrt(pow(jointDia/2, 2)-pow(sheathDia/2, 2)));

    rotate([90, 0, -earAngle/2*rot])
      translate([0, 0, position*len/2-(chordShift)*-position]) 
      //cylinder(d=sheathDia, h=sheathLen, center=true);
      texturedCyl(len);

    //add space for wire
    rotate([90, 0, -earAngle/2*rot])
      translate([0, 0, position*len*1-(jointDia/2)*-position])
      cylinder(d=wireDia, h=len, center=true);

         
  
}

module yMoldPositive() {
  $fn=50;
  union() {
    sphere(d=jointDia);
    //negative rotation
    wireSheath(len=earSheathLen, rot=-1);
    //positive rotation
    wireSheath(len=earSheathLen, rot=1);
    //zero rotation
    wireSheath(len=jackSheathLen, rot=0);
  }
  
}

module moldNegative(rot=1) {
  $fn=36;
  //percent over to multiply by
  pOver=1.5;
  //height of mold
  moldZ=jointDia/2+1.5;

  jDia=jointDia*pOver;
  eSLen=earSheathLen*pOver*1.2;
  jSLen=jackSheathLen*pOver*1;
  sWidth=sheathDia*pOver;
  
    difference() {
    union() {
      translate([0, 0, -moldZ/2*rot])
        cylinder(d=jDia, h=moldZ, center=true);

      //jack sheath mold negative
      translate([0, -(jSLen/2), -moldZ/2*rot])
        cube([sWidth, jSLen, moldZ], center=true);

      for (i = [-1, 1]) {
        rotate(i*earAngle/2)
          translate([0, eSLen/2, -moldZ/2*rot])
          cube([sWidth, eSLen, moldZ], center=true);
      }
      
      rotate([0, 0, 90])
        translate([0, 0, -moldZ/2*rot])
        cube([sWidth, jDia*1.5, moldZ], center=true);
      
    }
    for (j = [-1, 1]) {
      translate([j*jDia*1.5/3, 0, 0])
        cylinder(h=moldZ*5, d=boltDia, center=true);
    }
    yMoldPositive();
  }

}

//yMoldPositive();

translate([jointDia*3/2, 0, 0])
  moldNegative();

translate([-jointDia*3/2, 0, 0])
  rotate([0, 180, 0])
  moldNegative(-1);

