
// quality
$fn=25;

// length of PCB side of bracket
pcbLength = 85;

// dimension between mounting holes on PCB
pcbHolesPitch = 76.2;

// diameter of PCB mounting holes
pcbHolesDia = 3.2;

// PCB offset from botom
pcbOffset = 20;

// PCB spacer thickness
pcbDistance = 3.5;

// PCB spacer diameter
pcbDistanceDia = 8;

// angle of PCB (0...right angle, 90...horizontal)
pcbAngle = 35;

// length of clamping side of bracket
bottomLength = 60;

// dimension between mounting holes
bottomHolesPitch = 50;

// mounting holes diameter
bottomHolesDia = 5;

// mounting holes offset
bottomHolesOffset = 10;

// width of holder
width = 12;

// holder thickness
thickness = 4;



module pcbPart() {
  union() {
    difference() {
      union() {
        cube([pcbLength+pcbOffset,width,thickness], center=true);
        if (pcbDistance > 0) {
          translate([-pcbHolesPitch/2+pcbOffset/2,0,pcbDistance]) cylinder (d=pcbDistanceDia, h=pcbDistance, center=true);
          translate([pcbHolesPitch/2+pcbOffset/2,0,pcbDistance]) cylinder (d=pcbDistanceDia, h=pcbDistance, center=true);
        }
      }    
      
      translate([-pcbHolesPitch/2+pcbOffset/2,0,0]) cylinder (d=pcbHolesDia, h=100, center=true);
      translate([pcbHolesPitch/2+pcbOffset/2,0,0]) cylinder (d=pcbHolesDia, h=100, center=true);
    }
    

    translate([-(pcbLength+pcbOffset)/2,0,0])
    rotate([90,90,0])
    cylinder (d=thickness, h=width, center=true);
    
    translate([(pcbLength+pcbOffset)/2,0,0])
    rotate([90,90,0])
    cylinder (d=thickness, h=width, center=true);
  }
}

module bottomPart() {
  union() {
    difference() {
      cube([bottomLength+bottomHolesOffset,width,thickness], center=true);
      translate([-bottomHolesPitch/2+bottomHolesOffset/2,0,0]) cylinder (d=bottomHolesDia, h=100, center=true);
      translate([bottomHolesPitch/2+bottomHolesOffset/2,0,0]) cylinder (d=bottomHolesDia, h=100, center=true);
    }
    
    translate([-(bottomLength+bottomHolesOffset)/2,0,0])
    rotate([90,90,0])
    cylinder (d=thickness, h=width, center=true);

    translate([(bottomLength+bottomHolesOffset)/2,0,0])
    rotate([90,90,0])
    cylinder (d=thickness, h=width, center=true);
  }
}

module reinforcement() {
  hull() {
    translate([(bottomLength+bottomHolesOffset)/1.5,0,0])
    rotate([90,90,0])
    cylinder (d=thickness, h=width, center=true);
    
    rotate([0,-90+pcbAngle,0])
    translate([(pcbLength+pcbOffset)/1.5,0,0])
    rotate([90,90,0])
    cylinder (d=thickness, h=width, center=true);
  }  
}

module holder() {
  union() {
    rotate([0,-90+pcbAngle,0])
    translate([(pcbLength+pcbOffset)/2,0,0])
    pcbPart();

    reinforcement();
    
    translate([(bottomLength+bottomHolesOffset)/2,0,0])
    bottomPart();
  }
}

holder();

