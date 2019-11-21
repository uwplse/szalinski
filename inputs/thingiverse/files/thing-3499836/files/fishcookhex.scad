slots = 11;
disks_per_slot = 18;
disk_radius = 13;
disk_height = 1.25;

module honeycomb(slot_count, disk_count, offset=0) {
  for (i = [0:slot_count - 1]) {
    translate([i * 1.5 * disk_radius, (i % 2) * disk_radius, 0]) 
      linear_extrude(height = disk_count * disk_height)
        offset(offset)
        circle($fn = 6, r = disk_radius);
    
  }
}

difference () {
  // solid honeycomb
  honeycomb(slots, disks_per_slot, 1);
  
  // inner honeycomb to hollow out
  translate([0, 0, 1]) 
    honeycomb(slots, disks_per_slot, 0);
  
  // cubes to open up the sides
  translate([-disk_radius, -disk_radius - disk_radius/2, -3])
    cube([disk_radius * slots * 2, disk_radius, disks_per_slot * disk_height * 2]);
  
  translate([-disk_radius, disk_radius * 1.5, -3])
    cube([disk_radius * slots * 2, disk_radius, disks_per_slot * disk_height * 2]);
}
