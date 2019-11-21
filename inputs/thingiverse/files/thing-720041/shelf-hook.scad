// the thickness of the lines as as seen from above (don't recommend much more than 6 or the geometry gets messy)
thickness = 4;

// how high it will protrude from the build plate
width = 18;

// the length of the part that goes onto the shelf
length = 50;

// the shelf thickness
shelf = 18;

// how far it goes down below the bottom of the shelf (should be at least equal to thickness
hang = 5;

// diameter of hook bends
gap = 10;

// vertical part above the hook to prevent slipping off
tip = 5;

// width of the trough of the hook (wide U - positive number vs. semi-circle, 0)
trough = 30;

module hook() {
  union() {
    // the part above the shelf
    translate([-length, 0, 0])
    cube([length, width, thickness]);

	 // the part below the shelf
    translate([-length, 0, -shelf])
	 cube([length, width, thickness]);

    // the part that goes down to the hook
    translate([0, 0, -shelf-hang+thickness])
    cube([thickness, width, hang+shelf]);

    // the first round part of the hook
    difference() {
      // a big cylinder
      translate([thickness+gap/2, 0, -shelf-hang+thickness])
      rotate([270, 0, 0])
      cylinder(h=width, d=gap+2*thickness);

      // minus a smaller cylinder
      translate([gap/2+thickness, -.1, -shelf-hang+thickness])
      rotate([270, 0, 0])
      cylinder(h=width+.2, d=gap);

      // minus a cube to turn it into a semicircle
      translate([thickness, -.1, -shelf-hang+thickness])
      cube([gap+(2*thickness)+.1, width+.2, gap+2*thickness]);

		// minus another cube to turn it into a quarter circle
		translate([gap/2+thickness, -0.1, -shelf-hang-gap/2-thickness])
		cube([gap+2*thickness, width+thickness, gap+2*thickness]);
    }



    // the second round part of the hook
    
    difference() {
      // a big cylinder
      translate([trough+thickness+gap/2, 0, -shelf-hang+thickness])
      rotate([270, 0, 0])
      cylinder(h=width, d=gap+2*thickness);

      // minus a smaller cylinder
      translate([gap/2+thickness+trough, -.1, -shelf-hang+thickness])
      rotate([270, 0, 0])
      cylinder(h=width+.2, d=gap);

      // minus a cube to turn it into a semicircle
      translate([trough, -.1, -shelf-hang+thickness])
      cube([gap+(2*thickness), width+.2, gap+(2*thickness)]);

		// minus another cube to turn it into a quarter circle
		translate([trough-gap/2+thickness, -0.1, -shelf-hang-gap+thickness])
		cube([gap, width+.2, gap+2*thickness]);
    }

	 // add a bar between the two curves
	 translate([gap/2+thickness,0,-shelf-hang-gap/2])
	 cube([trough,width,thickness]);

    // add a vertical tip above the hook
    translate([thickness+gap+trough, 0, -shelf-hang+thickness])
    cube([thickness, width, tip]);

    // add a rounded tip to the hook
    translate([thickness*1.5+gap+trough, width, -shelf-hang+tip+thickness])
	 rotate([90,90,0])
    cylinder(h=width, r=thickness/2, $fs=.1);
  }
}

// comment out the rotate below before making changes to above, 
// for sanity sake
rotate([90, 0, 0])
hook();
