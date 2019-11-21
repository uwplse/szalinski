// preview[view:south east, tilt:top diagonal]

/* [Basic Settings] */
case_type = "custom"; // [arduino:Arduino Uno,custom:Custom]
feet = "none"; // [raised:Raised,mag:Magnetic,hole:Holes,wing:Wings,none:None]
attachment_type = "nothread"; // [hotinsert:Hot Insert,nothread:Undersized Hole]
rib_type = "outer"; // [inner:Inner,outer:Outer,none:None]
bolt_size = 2.5; // [2.5:2.5mm,3:3mm,4:4mm]

/* [Case Options] */
// Include a slot for the PCB at the bottom of the case
bottom_board_cutout = "include"; // [include:Include,exclude:Exclude]
// Add an extra slot for a PCB at the top of the case
top_board_cutout = "exclude"; // [include:Include,exclude:Exclude]
// Add an extra slot for a PCB at mid-height
middle_board_cutout = "exclude"; // [include:Include,exclude:Exclude]
// Include the top of the case
top_cap = "include"; // [include:Include,exclude:Exclude]
// Include the two end caps
end_caps = "include"; // [include:Include,exclude:Exclude]
// Include vents in the top of the case (if available)
vents = "exclude"; // [include:Include,exclude:Exclude]

/* [Custom PCB Dimensions] */
// PCB width in mm
custom_width = 65;
// Case height above PCB in mm
custom_height = 30;
// PCB length in mm
custom_length = 75;
// PCB thickness in mm
pcb_height = 1.6; // Height of all PCB's in mm

/* [Print Details] */
// Wall thickness in mm
wall = 1.5; 
// Percent of shrink in non-threaded holes
hole_shrink = 0.85; 
// Clearance in mm around X, Y and Z of PCB cutouts
pcb_clearance = 0.3; // The clearance amount for the PCB in mm
// Clearance in mm around hot insert holes
hot_insert_clearance = 0.25; // The clearance amount for hot inserts in mm

/* [Hidden] */
hole = bolt_size/2;
fillet = hole * (attachment_type == "hotinsert" ? 4.5 : 4.5);
width = custom_width;
height = custom_height;
length = custom_length;
width = case_type == "arduino" ? 53.50 : custom_width;
height = case_type == "arduino" ? 30 : custom_height;
length = case_type == "arduino" ? 68.7 : custom_length;

color("orange")
union() {
  if (feet == "raised") {
    rotate([90,0,180]) 
      translate([width/2-10,length-10,-(height/2)-wall-1])
      cylinder(h=2, r1=2.5, r2=5, center=false, $fn = 20);
    rotate([90,0,180]) 
      translate([-width/2+10,length-10,-(height/2)-wall-1])
      cylinder(h=2, r1=2.5, r2=5, center=false, $fn = 20);
    rotate([90,0,180]) 
      translate([width/2-10,10,-(height/2)-wall-1])
      cylinder(h=2, r1=2.5, r2=5, center=false, $fn = 20);
    rotate([90,0,180]) 
      translate([-width/2+10,10,-(height/2)-wall-1])
      cylinder(h=2, r1=2.5, r2=5, center=false, $fn = 20);
  }
  else if (feet == "mag") {
    difference() {
      rotate([90,0,180]) 
        translate([width/2-10,length-10,-(height/2)-wall-1])
        cylinder(h=2, r1=3, r2=5, center=false, $fn = 20);
      
      rotate([90,0,180]) 
        translate([width/2-10,length-10,-(height/2)-wall])
        cylinder(2,2.75,2.75,true, $fn = 20);
    }
    difference() {
      rotate([90,0,180]) 
        translate([-width/2+10,length-10,-(height/2)-wall-1])
        cylinder(h=2, r1=3, r2=5, center=false, $fn = 20);
      
      rotate([90,0,180]) 
        translate([-width/2+10,length-10,-(height/2)-wall])
        cylinder(2,2.75,2.75,true, $fn = 20);
    }
    difference() {
      rotate([90,0,180]) 
        translate([width/2-10,10,-(height/2)-wall-1])
        cylinder(h=2, r1=3, r2=5, center=false, $fn = 20);
      
      rotate([90,0,180]) 
        translate([width/2-10,10,-(height/2)-wall])
        cylinder(2,2.75,2.75,true, $fn = 20);
    }
    difference() {
      rotate([90,0,180]) 
        translate([-width/2+10,10,-(height/2)-wall-1])
        cylinder(h=2, r1=3, r2=5, center=false, $fn = 20);
      
      rotate([90,0,180]) 
        translate([-width/2+10,10,-(height/2)-wall])
        cylinder(2,2.75,2.75,true, $fn = 20);
    }
  }
  else if (feet == "wing") {
    translate([width/2,-height/2-wall/2,0])
      difference() {
        cube(size = [8,wall,length]);
        translate([4,0,10])
          rotate([90,90,0])
          cylinder(200,hole,hole,true,$fn=20);
        translate([4,0,length-10])
          rotate([90,90,0])
          cylinder(200,hole,hole,true,$fn=20);
      }
    translate([-(width/2)-8,-height/2-wall/2,0])
      difference() {
        cube(size = [8,wall,length]);
        translate([4,0,10])
          rotate([90,90,0])
          cylinder(200,hole,hole,true,$fn=20);
        translate([4,0,length-10])
          rotate([90,90,0])
          cylinder(200,hole,hole,true,$fn=20);
      }
  }

  difference() {
    linear_extrude(length) {
     // Draw two squares and offset to shell
     difference() {
        offset(r = (wall/2)) {
            square([width+pcb_clearance,height], center = true);
        }
        offset(delta = -(wall/2), chamfer = true) {
            square([width+pcb_clearance,height], center = true);
        }        
      }
      
      // Draw the corners for the attachment holes
      polygon(points=
        [[-(width/2)+fillet,(height/2)],
        [-(width/2),(height/2)-fillet],
        [-(width/2),(height/2)]]
      );
      polygon(points=
        [[(width/2)-fillet,-(height/2)],
        [(width/2),-(height/2)+fillet],
        [(width/2),-(height/2)]]
      );
      polygon(points=
        [[(width/2)-fillet,(height/2)],
        [(width/2),(height/2)-fillet],
        [(width/2),(height/2)]]
      );
      polygon(points=
        [[-(width/2)+fillet,-(height/2)],
        [-(width/2),-(height/2)+fillet],
        [-(width/2),-(height/2)]]
      );          
    }
    
    // Drill the holes for the attachment points, size depends on type
    if (attachment_type == "hotinsert")   
      drill_holes(hole+hot_insert_clearance);  
    else if (attachment_type == "undersize") 
      drill_holes(hole*hole_shrink);  
    else
      drill_holes(hole);
    
    // Carve out the inner ribs
    if (rib_type == "inner")
        make_ribs();  
    
    // Extrude the bottom board for later difference
    if (bottom_board_cutout) {
      translate([0,-(height/2-fillet-2),length/2])
        rotate([90,0,0]) {
          linear_extrude(pcb_height+pcb_clearance) {  
            square([width+pcb_clearance,length+pcb_clearance], center=true);
          }
        }
    }
    
    // Extrude the top board for later difference
    if (top_board_cutout == "include") {
      translate([0,(height/2-fillet-2),length/2])
        rotate([90,0,0]) {
          linear_extrude(pcb_height+pcb_clearance) {  
            square([width+pcb_clearance,length+pcb_clearance], center=true);
          }
        }
    }  
    
    // Extrude the middle board for later difference
    if (middle_board_cutout == "include") {
    translate([0,0,length/2])
      rotate([90,0,0]) {
        linear_extrude(pcb_height+pcb_clearance) {  
          square([width+pcb_clearance,length+pcb_clearance], center=true);
        }
      }
    }
    
    // Remove the top if selected
    if (top_cap == "exclude") {
      translate([0,(height/2)+(wall/2)+1,length/2]) {
        rotate([90,0,0]) {
          linear_extrude(wall+2) {  
            square([width-(fillet+(wall/2)*2),length], center=true);
          }
        }
      }
    }    
    
    // Make holes feet if selected
    if (feet == "hole") {        
      rotate([90,0,180]) 
        translate([width/2-10,length-10,-(height/2)-0])
        cylinder(5,hole,hole,true, $fn = 20, $fn = 20);
      rotate([90,0,180]) 
        translate([-width/2+10,length-10,-(height/2)-wall])
        cylinder(5,hole,hole,true, $fn = 20, $fn = 20);
      rotate([90,0,180]) 
        translate([width/2-10,10,-(height/2)-wall])
        cylinder(5,hole,hole,true, $fn = 20, $fn = 20);
      rotate([90,0,180]) 
        translate([-width/2+10,10,-(height/2)-wall])
        cylinder(5,hole,hole,true, $fn = 20, $fn = 20);
    }  
    
    if (vents == "include") {
      for (a =[0:4]) {
        translate([-(width/5)+(a*(width/11)),10,height/3])
        cube([2,10,length*.66]);
      }
    }      
  }

  // Extrude ribs if selected
  if (rib_type == "outer")
      make_ribs();  
}

color("gray")
if (end_caps == "include") {
  translate([0,height*2.50,wall])
  difference() {
    translate([0,0,-wall])
    linear_extrude(wall) {
      offset(r = (wall/2)) {
          square([width,height], center = true);
      }
    }
    drill_holes(hole);
    if (case_type == "arduino") {
      translate([width/2-5.5-9.8,-(height/2-fillet-2)+5.5,0])
        cube(size = [12.5,11,10], center = true);
      translate([-width/2+4.5+3.3,-(height/2-fillet-2)+5.5,0])
        cube(size = [9,11,10], center = true);
    }
  }
  
  translate([0,height*1.25,-length])
  difference() {
    translate([0,0,length])
    linear_extrude(wall) {
      offset(r = (wall/2)) {
          square([width,height], center = true);
      }
    }
    drill_holes(hole);
  }
}

module make_ribs() {  
  rib_count = height >= 40 ? 2 : 1;

  if (rib_count > 0) {
    for (a =[-rib_count:rib_count]) {
      linear_extrude(length) {
        translate([-(width/2)-wall/2,4*a,0])
        circle(1, $fn = 5);
      }
    }
    
    for (a =[-rib_count:rib_count]) {
      linear_extrude(length) {        
        translate([(width/2)+wall/2,4*a,0])
        rotate([0,0,35])
        circle(1, $fn = 5);
      }
    }
  }
}

module drill_holes(drill_size) {    
  echo(drill_size);
  translate([0,0,-wall]) {
    linear_extrude(length+wall*2) {
      translate([-(width/2)+fillet/4,(height/2)-fillet/4,0])
      circle(drill_size, $fn = 20);
    }
    
    linear_extrude(length+wall*2) {
      translate([(width/2)-fillet/4,(height/2)-fillet/4,0])
      circle(drill_size, $fn = 20);
    }
    linear_extrude(length+wall*2) {
      translate([(width/2)-fillet/4,-(height/2)+fillet/4,0])
      circle(drill_size, $fn = 20);
    }
    linear_extrude(length+wall*2) {
      translate([-(width/2)+fillet/4,-(height/2)+fillet/4,0])
      circle(drill_size, $fn = 20);
    }
  }
}

