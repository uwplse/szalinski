
base_top_diameter = 26;
base_bottom_diameter = 28;
base_height = 2;

grip_height = 10;

slot_width = 25.2;
slot_thickness = 0.8;
slot_deepness = 10.4;

module slot() {    
  translate([0, 0, grip_height + base_height - slot_deepness / 2 + 0.01]) {
    cube(size=[slot_width, slot_thickness, slot_deepness], center=true);
  }
}

module stand() {
  cylinder(h=base_height, d1=base_bottom_diameter, d2=base_top_diameter, center=false);
}

module grip() {
  translate([0, 0, grip_height - grip_height / 2 + base_height / 2]) {
    cube(size=[base_bottom_diameter, 2.8, grip_height + base_height], center=true);
  }
}

module main_body() {
  intersection(){
    union() {
      stand();
      grip();
    }
    union(){
      cylinder(h=base_height + grip_height, d1=base_bottom_diameter + 5, d2= slot_width - 1, center=false);
    }
  };
}

module main() {
  difference() {
    main_body();
    slot();
  }
}

//stand();
//grip();
//slot();
main();
