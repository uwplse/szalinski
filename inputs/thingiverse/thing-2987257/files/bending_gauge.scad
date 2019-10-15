//!OpenSCAD
//Number of bending slots
Numer_of_slots = 6;
//bending slot width in mm
slot_width = 3;
//bending slot height in mm
Slot_height = 3;
// biggest distance between the bending slots in mm (the total bending width is the biggest distance + 4mm)
Biggest_distance = 15;
//height of the cutout in the middle in mm
cutout_height = 7;
// smallest distance between the bending slots in mm
Smallest_distance = 8;
difference() {
  difference() {
    cube([(Biggest_distance + 4), (Numer_of_slots * (slot_width * 2)), ((Slot_height + 5) + 0)], center=false);

    rotate([270, 0, 0]){
      translate([((Biggest_distance + 4) / 2 - Biggest_distance / 2), ((Slot_height + 5) * -1), 0]){
        hull(){
          cube([Biggest_distance, cutout_height, 0.01], center=false);
          translate([((Biggest_distance - Smallest_distance) / 2), 0, (Numer_of_slots * (slot_width * 2))]){
            cube([Smallest_distance, cutout_height, 0.01], center=false);
          }
        }
      }
    }
  }

  for (i = [1 : abs(slot_width) : Numer_of_slots * (slot_width * 1)]) {
    translate([0, (i * 2), 5]){
      cube([100, slot_width, Slot_height], center=false);
    }
  }

}
//cutout_height;
