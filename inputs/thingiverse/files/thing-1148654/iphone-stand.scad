
// base length of foot
footLength=80; // [50:150]

// height of iPhone 
iClampDia = 8.5; // [7:0.1:10]

// lenght of clip
iClampLen = 15; // [7:0.1:100]


module banner() {
}

bottomPlateSize=10;
bottomPlateWidth=8;
bottomPlateHeight=3;
holeDiameter=4.5;
iClampWidth = 3;
iClampHeight = 24.5;
plateSpace=4.2;
iRbHookWidth = 5;
footDiameter=8;

module bottomPlate(x=bottomPlateHeight, y=bottomPlateSize) {
  difference() {
    union() {
      cylinder (h=x, d=y);
      translate ([-bottomPlateWidth,-y/2,0]) cube ([bottomPlateWidth, y, x]);
    }   
    cylinder (h=x+0.2, d=holeDiameter);
  }
}

module clamp() {
  linear_extrude (height=iClampHeight) {
    translate ([-iClampDia/2,iClampDia/2+iClampWidth])
    difference() {
      union() {
        translate ([-iClampWidth,0]) square ([iClampWidth, iClampLen]);
        translate ([-2*iClampWidth, iClampLen - iClampWidth]) square ([iRbHookWidth, iClampWidth]);
        translate ([-3*iClampWidth, iClampLen - iRbHookWidth]) square ([iClampWidth, iRbHookWidth]);
        translate ([2*iClampWidth + iRbHookWidth - (8.5-iClampDia), iClampLen - iClampWidth]) square ([iRbHookWidth, iClampWidth]);
        translate ([3*iClampWidth + iRbHookWidth + 0.5 - (8.5-iClampDia), iClampLen - iRbHookWidth]) square ([iClampWidth, iRbHookWidth]);
        translate ([iClampDia/2,0])
        difference() {
          circle (iClampDia/2+iClampWidth);
          circle (iClampDia/2);
        }
        translate ([iClampDia,0]) square ([iClampWidth, iClampLen]);
      }
      square ([iClampDia,iClampHeight+iClampDia]);
    }
  }
}

module body() {
  translate ([-10,35,22])
  rotate ([0,270,0])
  union() {
    pom = bottomPlateSize;
    bottomPlate(y=pom);
    translate ([0,0,plateSpace+bottomPlateHeight]) bottomPlate(y=pom);
    translate ([0,0,2*(bottomPlateHeight+plateSpace)]) bottomPlate(y=pom);
    translate ([0,0,3*(bottomPlateHeight+plateSpace)]) bottomPlate(y=pom);
    translate ([-5,0,0]) rotate ([0,0,90]) clamp();
  }
}

module foot30() {
  translate ([0,0,15])
  rotate ([0,270,0])
  difference() {
    union() {
      difference() {
        hull() {
          cube ([footLength,footDiameter,footDiameter]);
          translate ([-12,footDiameter/2,footDiameter/2]) sphere (d=footDiameter);
        }
        translate ([-23,0,0]) cube ([footDiameter,footDiameter,footDiameter]);
      }
    
      translate ([footLength+4, footDiameter/2, -3]) rotate ([0,30,0]) bottomPlate (x=plateSpace-0.15,y=footDiameter);
    }
    translate ([60+(footLength-80), 0, 15.55]) rotate ([0,30,0]) cube ([30, 10, 10]);
  }
}

module foot() {
  translate ([0,0,12.8])
  rotate ([0,270,0])
  union() {
    difference() {
      hull() {
        cube ([footLength,footDiameter,footDiameter]);
        translate ([-10,footDiameter/2,footDiameter/2]) sphere (d=footDiameter);
      }
      translate ([-21,0,0]) cube ([footDiameter,footDiameter,footDiameter]);
      translate ([footLength-6.9, 0, 10.1]) rotate([0,30,0]) cube ([footDiameter,footDiameter,footDiameter]);
      translate ([footLength, 0, -7.3]) rotate([0,-30,0]) cube ([footDiameter,footDiameter,footDiameter]);
    }
    translate ([footLength+8, footDiameter/2, 2]) bottomPlate (x=plateSpace-0.15,y=footDiameter);
  }
}

foot();
translate ([15,0,0]) foot30();
translate ([-15-8,8,0]) rotate ([0,0,180]) foot30();
translate ([20,0,iClampLen-10]) body();
