/*
  Toggle Switch Library

  Aaron Ciuffo - aaron . ciuffo 2 gmail com

  2014 Nov 15

  Paramaters:
    nut1H - height of nut 1 on screw 
    nut2H - height of nut 2 OVER nut 1
    cener = body/nut


*/

/*[Base Dimensions]*/
bX=29.5;
bY=18.4;
bZ=17.35;

/*[Tabs]*/
//Dimensions
tabX=4.3;
tabY=0.5;
tabZ=6;
//position of center terminals
centerX=0;
centerY=14.7/2;
endX=21/2;
endY=8.8/2;


/*[Screw Mount]*/
screwDia=11.8;
screwZ=10;

/*[Toggle Dimensions]*/
tgDia2=4.8; //diamter at top
tgDia1=2; //diameter at bottom
tgZ=13.4;
swAngle=20;

/*[Mounting Nut]*/
nutFlat=14; //distance across flats
nutThick=2; //thickness

module body() {
  translate([]) 
    cube([bX, bY, bZ], center=true);
}

module toggle() {
  union() {
    cylinder(h=screwZ, r=screwDia/2);
    rotate([0, swAngle, 0])
    union() {
      translate([0, 0, screwZ-5]) rotate([0, 0, 0])
        cylinder(h=tgZ+5, r1=tgDia1, r2=tgDia2);
      translate([0, 0, screwZ+tgZ])
        sphere(r=tgDia2, center=true);
    }

  }
}

module nut() {
  nutRad=nutFlat/2*1/cos(30);
  cylinder(r=nutRad, h=nutThick, $fn=6);
}


module tab() {
  cube([tabX, tabY, tabZ], center=true);
}

module placeTabs(mir=1) {
  //center terminal
  translate([mir*centerX, mir*centerY, 0])
    tab();
  translate([mir*endX, mir*endY, 0])
    tab();
  translate([-1*mir*endX, mir*endY, 0])
    tab();
}

module assemble(nut1H=0, nut2H=nutThick) {
  union() {
    color("gray") body();
    translate([0, 0, bZ/2])
      color("blue") toggle();
    translate([0, 0, -bZ/2-tabZ/2])
      color("silver") placeTabs();
    translate([0, 0, -bZ/2-tabZ/2])
      color("silver") placeTabs(mir=-1);
    translate([0, 0, bZ/2+nut1H])
      color("red") nut();
    translate([0, 0, bZ/2+nut2H+nutThick
    ])
      color("yellow") nut();

  }

}

module switch(nut1H=0, nut2H=nutThick, center="body") {
  if (center=="nut") {
    translate([0, 0, -bZ/2-nut1H-nutThick])
      assemble(nut1H, nut2H);
    
  } else {
    assemble(nut1H, nut2H);
  }
}


switch(nut1H=0, nut2H=4, center="nut");
