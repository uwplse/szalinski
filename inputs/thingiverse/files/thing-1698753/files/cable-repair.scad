// Headphone end-mold replacement 90 deg bend

/*

                                     ---------Taper            
                                    / 
             _-_-_-_-_-_-_-_-_-_-_ /     -----Wire
            /                     \     /
   =========|                     |========= 
            \_-_-_-_-_-_-_-_-_-_-_/
                \              \
                 \              \--------------Sheath
                  \
                   \---------------------------Texture
*/  

/*[Jack Sheath Dimensions]*/
//mold or sheath
part = "mold"; //[mold, sheath]

//overall length of sheath (green)
sheathLen = 35.5; //[1:100] 

//diameter of sheath (green)
sheathDia = 8; //[2:20]

//length of tapered ends (red)
taperLen = 4; //[0:10]

//wire diameter (purple)
wireDia = 3.6; //[.5:10]

//texture depth and width (orange)
texture = 1; //[.5:.5:5]

//alignmnet bolt hole diameter (yellow)
boltD=3.3; 

//amount to separate the halves by
separation=5; //[1:10]


/*[Hidden]*/
$fn=60; //curve refinement

// increase by this much
pctOvr=1.08;

//spacers between the texture
textureSpacer=texture*1.5;

//mold dimensions
moldX = sheathLen*1.2;
moldY = sheathDia*1.2+boltD*3;
moldZ = sheathDia/2+2;
mold = [moldX, moldY, moldZ];

//calculated radii
boltR = boltD/2;
sheathR = sheathDia/2;
wireR = wireDia/2;

 
module cableTextureX(cableLen = 20) {
  difference() {
    cylinder(r=cableDia/2, h=cableLen);
    for (i = [0 : texture+textureSpacer : textureLen ]) {
      translate([cableDia/2-texture/2, 0, i*(texture)])
        rotate([90, 0, 0])
        //cylinder(r=texture/2, h=cableDia, center=true);
        cube([2*texture, texture, cableDia], center=true);

      translate([-cableDia/2+texture/2, 0, i*texture])
        rotate([90, 0, 0])
        cube([2*texture, texture, cableDia], center=true);

    }
  }
}

module cableTexture(sheathLen = 20, texture = 1) {
  translate([0, 0, -sheathLen/2])
  difference() {
    color("green")
    cylinder(r = sheathR, h = sheathLen, center = false);
    for (i = [0: texture+textureSpacer: sheathLen]) {
      for (j = [-1,1]) {
        translate([j*sheathR, 0, i*texture])
          color("orange")
          cube([2*texture, sheathDia, texture], center = true);
      }
    }

  }
}


module sheath() {
  centralLen = sheathLen - 2*taperLen;

  rotate([0, 90, 0]  )
  union() {
    // textured central portion
    cableTexture(sheathLen = centralLen, texture = texture);

    //taper on top and bottom
    color("red") {
    translate([0, 0, centralLen/2+taperLen/2])
      cylinder(r1 = sheathR, r2 = wireR, h = taperLen, center = true);
    translate([0, 0, -1*(centralLen/2+taperLen/2)])
      cylinder(r2 = sheathR, r1 = wireR, h = taperLen, center = true);
    }
    //wire
    color("purple")
    cylinder(r = wireR, h = sheathLen*2, center = true);



  }
}

module mold() {
  difference() {
    translate([0, 0, -mold[2]/2]) 
      color("gray")
      cube(mold, center = true);
    sheath();
    for (i = [-1,1]) {
      for (j = [-1, 1]) {
        translate([i*(mold[0]/2-boltD), j*(mold[1]/2-boltD), -mold[2]/2])
          color("yellow")
          cylinder(r = boltR, h = mold[2]*2, center = true);
      }
    }
  }
}

module layout() {
  for (i = [-1, 1]) {
   translate([0, i*(mold[1]/2+separation/2)])
      mold();
  }

}


//sheath();
//cableTexture();

if (part == "mold") {
  layout();
} else {
  sheath();
}

