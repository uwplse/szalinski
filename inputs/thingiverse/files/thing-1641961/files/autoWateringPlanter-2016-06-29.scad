use <utils/build_plate.scad>

// variable description
//Which one would you like to see?
part = "both"; // [reservoir:Reservoir Only,pot:Pot Only,both:Reservoir and Pot,view:Reservoir and Pot only for display]
radius = 35; // [25:5:75]
height = 50; // [25:5:150]
thickness = 3; //[3,5,7]
sides_number = 8; // [4,6,8,12,20]

// variables used by the script
gap = 0.1*1;
clearance_factor = 0.1*1;
radius_inner=radius-thickness;
bottom_thickness = thickness*1.5;
pot_head_height = height*0.10;
conduct_radius = radius*0.25;
conduct_height = height-bottom_thickness+pot_head_height*1;
offset_view=height*1;
holes_number=sides_number;
max_holes_number=8*1;

//Display the build plate, It doesn't contribute to final object
build_plate_selector = 3*1;
build_plate_manual_x = 200*1;
build_plate_manual_y = 200*1;
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//preview[view:south east, tilt:top diagonal]

module water_conduct(boring) {  
  if (boring == true) {
    difference() {
      cylinder(r=conduct_radius,h=conduct_height,$fn=sides_number);
      translate([0,0,-gap])
        cylinder(r=conduct_radius-thickness/2,h=conduct_height+gap*2,
        $fn=sides_number);
      translate([-conduct_radius,0,-gap])
      rotate([0,45,0])
        cube(conduct_radius*2.5,center=true);
    }
  }
  else {
    cylinder(r=conduct_radius,h=conduct_height,$fn=sides_number);
  }
}

module reservoir() {
  color("Orange") { 
    difference() {
      cylinder(r=radius,h=height,$fn=sides_number);
      translate([0,0,bottom_thickness])
        cylinder(r=radius_inner,h=height-bottom_thickness+gap*2,$fn=sides_number);
    }
    intersection() {
    translate([radius-conduct_radius,0,bottom_thickness])
        water_conduct(boring=true);
      cylinder(r=radius-thickness,h=conduct_height+bottom_thickness,$fn=sides_number);
    }
  } 
}

module pot_body (boring) {
  pot_radius_1 = radius;
  pot_radius_2 = radius - thickness - clearance_factor*5;
  pot_radius_3 = radius*0.2;
  
  pot_height_1 = pot_head_height;
  pot_height_2 = (height-bottom_thickness) * 0.15;
  pot_height_3 = (height-bottom_thickness) * 0.75;
  
  if (boring == true) {
    rotate([180,0,90])
    translate([0,0,-height-pot_height_1]) {
      difference() {
        color("red")
        cylinder(r=pot_radius_1,h=pot_height_1,$fn=sides_number);
        translate([0,0,-gap])
        cylinder(r=pot_radius_2-thickness,h=pot_height_1+2*gap,$fn=sides_number); 
      }
      translate([0,0,pot_height_1])
      difference() {
        color("blue")
        cylinder(r=pot_radius_2,h=pot_height_2,$fn=sides_number);
        translate([0,0,-gap])
        cylinder(r=pot_radius_2-thickness,h=pot_height_2+2*gap,$fn=sides_number);
      }
      translate([0,0,pot_height_1+pot_height_2-gap*0.1])
      difference() {
        color("gold")
        cylinder(r1=pot_radius_2,r2=pot_radius_3,h=pot_height_3,$fn=sides_number);
        translate([0,0,-gap])
        cylinder(r1=pot_radius_2-thickness,r2=pot_radius_3,
              h=pot_height_3+2*gap-thickness,$fn=sides_number);
        if(holes_number<=6) {
          for(i=[1:1:holes_number-1])
            rotate([0,0,i*360/holes_number])
            translate([0,(pot_radius_2+pot_radius_3)/1.75-thickness,pot_height_3/2])
              cylinder(r=radius*0.075,h=thickness*4,$fn=holes_number,center=true);
          }
        else {    
          for(i=[1:1:max_holes_number-1]){
            rotate([90,0,i*360/max_holes_number-180]) 
            translate([0,(pot_radius_2+pot_radius_3)/1.75-thickness,pot_height_3/2])
              cylinder(r=radius*0.075,h=thickness*8,$fn=holes_number,center=true);
          }
        }
      }  
    }
  }
  else {
    rotate([180,0,90])
    translate([0,0,-height-pot_height_1]) {
        color("red")
        cylinder(r=pot_radius_1,h=pot_height_1,$fn=sides_number);
      translate([0,0,pot_height_1])
        color("blue")
        cylinder(r=pot_radius_2,h=pot_height_2,$fn=sides_number);
      translate([0,0,pot_height_1+pot_height_2-gap*0.1])
        color("gold")
        cylinder(r1=pot_radius_2,r2=pot_radius_3,h=pot_height_3,$fn=sides_number);
    }
  }
}

module pot () {
  difference() {
    pot_body(boring=true);
    translate([radius-conduct_radius-gap*5,0,bottom_thickness+gap])
      scale([1.1,1.1,1])
        water_conduct(boring=false);  
  }
  intersection() {
    pot_body(boring=false);
    translate([radius-conduct_radius-gap*1,0,bottom_thickness+gap*1])
      scale([1.35,1.35,1])
        water_conduct(boring=true);
  }
}

module reservoir_stl(){
  reservoir();
}

module pot_stl(){
  rotate([180,0,0])
  translate([0,0,-height-pot_head_height])
    pot();
}

// Generate the reservoir and pot for print
module print_part() {
  if (part == "reservoir") {
    reservoir_stl();
  } else if (part == "pot") {
    pot_stl();
  } else if (part == "both") {
    translate([-radius*1.25,0,0])
      reservoir_stl();
    translate([radius*1.25,0,0])
      pot_stl();
  } else if (part == "view") {
    reservoir();
    translate([0,0,offset_view])
      pot();
  } else {
    translate([-radius*1.25,0,0])
      reservoir_stl();
    translate([radius*1.25,0,0])
      pot_stl();
  } 
}

print_part();


