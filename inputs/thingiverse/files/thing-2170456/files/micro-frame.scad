//$fn = 64;
/* [General] */
// Duct walls
wall = 1; // [0.1:0.1:10]
// Duct connector walls
thinWall = 0.8; // [0.1:0.1:10]

/* [Duct] */
// Height of the duct
ductHeight = 12; // [1:0.1:50]
// Diameter of the duct. AKA how big are your props
ductDiameter = 48; // [1:0.1:100]

/* [Motor] */
// Motor Diameter
motorDiameter = 8.8; // [0.1:0.1:20]
// Wall of the motor holder
motorWall = 1.4; // [0.1:0.1:10]
// Height of the motor holder
motorHeight = 5; // [0.1:0.1:20]
// Arm Diameter
armDiameter = 3.8; // [0.1:0.1:20]

/* [Boardholder] */
// Length
boardHolderLength =  33.5; // [0.1:0.1:100]
// Width
boardHolderWidth =  22; // [0.1:0.1:100]
// Height
boardHolderHeight = 2; // [0.1:0.1:10]
// Depth
boardHolderWall = 3; // [0.1:0.1:10]
// How far away the motors should be
wheelbase = 63; // [0.1:0.1:120]

/* [Hidden] */
ductRadius = ductDiameter / 2;
motorRadius = motorDiameter / 2;
armRadius = armDiameter / 2;

boardHolderX = wheelbase / 2;
boardHolderY = wheelbase / 2;

z = sqrt((wheelbase * wheelbase) / 2);
x = sqrt((boardHolderWidth * boardHolderWidth) / 2);
a = z - x;
b = (boardHolderLength - boardHolderWidth ) / 2;
c = sqrt((a * a) + (b * b) - 2 * a * b * cos(45));
beta = acos(((a * a) + (c * c) - (b * b)) / (2 * a * c));

boardHolderArm = c - ductRadius + wall +2;

ducts();
ductConnectors();
boardHolder();

module duct() {
  group() {
      difference() {
        difference() {
          cylinder(r = ductRadius + wall, h = ductHeight);

          translate([0, 0, -1])
            cylinder(r = ductRadius, h = ductHeight + 2);
        }

        for(j = [1 : 1 : 2])
          for(i = [0 : 30 : 360])
            rotate([0, 0, i + 15 * j])
                translate([-ductRadius + 1, 0, ductHeight / 3 * j])
                    rotate([0, -90, 0])
                        cylinder(r = ductHeight / 6, h = wall + 2);
      }
      
      motorHolder();
      arms();
    }
}

module motorHolder() {
  difference() {
    cylinder(r=motorRadius + motorWall, h=motorHeight);

    translate([0, 0, -1])
      cylinder(r=motorRadius, h=motorHeight + 2);
  }
}

module arm() {
  rotate([0, 90, 0]) {
    group() {
      cylinder(r=armRadius, h=ductRadius + wall);

      translate([0, 0, motorRadius])
        sphere(r=armRadius * 1.8);

      translate([0, 0, ductRadius + wall])
        sphere(r=armRadius * 1.8);
    }
  }
}

module arms() {
  intersection() {
    difference() {
      cylinder(r=ductRadius + wall, h=ductHeight);

      translate([0, 0, -1])
        cylinder(r=motorRadius, h=ductHeight + 2);
    }
  
    group() {
      for(i = [0 : 120 : 240])
          rotate([0, 0, i])
            arm();
    }
  }
}

module boardHolder() {
    translate([boardHolderX, boardHolderY, boardHolderHeight / 2]) {
        difference() {
            cube([boardHolderLength, boardHolderWidth, boardHolderHeight], center=true);
            cube([boardHolderLength - boardHolderWall * 2, boardHolderWidth - boardHolderWall * 2, boardHolderHeight + 2], center = true);
        }
        
        translate([boardHolderX, boardHolderY, 0])
            rotate([0, 0, 45 + beta])
                translate([-ductRadius - (c - ductRadius) / 2 - 2, 0, 0])
                    cube([boardHolderArm, armDiameter, boardHolderHeight], center = true);
        
        
        translate([-boardHolderX, boardHolderY, 0])
            rotate([0, 0, 135 - beta])
                translate([-ductRadius - (c - ductRadius) / 2 - 2, 0, 0])
                    cube([boardHolderArm, armDiameter, boardHolderHeight], center = true);
        
        translate([-boardHolderX, -boardHolderY, 0])
            rotate([0, 0,-135 + beta])
                translate([-ductRadius - (c - ductRadius) / 2 - 2, 0, 0])
                    cube([boardHolderArm, armDiameter, boardHolderHeight], center = true);
        
        translate([boardHolderX, -boardHolderY, 0])
            rotate([0, 0, -45 - beta])
                translate([-ductRadius - (c - ductRadius) / 2 - 2, 0, 0])
                    cube([boardHolderArm, armDiameter, boardHolderHeight], center = true);
        
        translate([6, boardHolderWidth / 2 - 0.5, -boardHolderHeight / 6])
            hook();
        
        translate([6,- boardHolderWidth / 2 + 0.5, -boardHolderHeight / 6])
            rotate([180,0,0])
                hook();
                
        translate([-6, boardHolderWidth / 2 - 0.5, -boardHolderHeight / 6])
            rotate([0, 180, 0])
                hook();
        
        translate([-6,- boardHolderWidth / 2 + 0.5, -boardHolderHeight / 6])
            rotate([180, 180, 0])
                hook();                
    }
}

module hook() {
    difference() {
        group() {
            cube([5, 4, boardHolderHeight / 3 * 2], center = true);
            translate([0, 2, 0])
                cylinder(r = 2.4, h = boardHolderHeight / 3 * 2, center = true);
        }

        translate([1.7, 0, 0]) {
            translate([0, -0.5, 0])
                cube([5, 5, boardHolderHeight + 2], center = true);
            translate([-1.3, 2, 0])
                cylinder(r = 1.2, h = boardHolderHeight + 2, center = true);
        }
    }
}

module ducts() {
    rotate([0, 0, 45 + beta]) duct();
    translate([wheelbase, 0, 0]) rotate([0, 0, 135 - beta]) duct();
    translate([0, wheelbase, 0]) rotate([0, 0, -45 - beta]) duct();
    translate([wheelbase, wheelbase, 0]) rotate([0, 0, -135 + beta]) duct();
}

module ductConnector() {
    translate([0, 0, ductHeight / 2])
        cube([wheelbase - (ductDiameter), thinWall, ductHeight], center = true);
}

module ductConnectors() {
    translate([wheelbase / 2, 0 ,0]) ductConnector();
    translate([wheelbase / 2, wheelbase ,0]) ductConnector();
    translate([0, wheelbase / 2, 0]) rotate([0, 0, 90]) ductConnector();
   translate([wheelbase, wheelbase / 2, 0]) {
        difference() {
            rotate([0, 0, 90]) ductConnector();
            translate([-wall / 2 - 1, 0, ductHeight / 2])
                rotate([0, 90, 0])
                    cylinder(r=ductHeight / 7, h = wall + 2);
        }
    }
}
