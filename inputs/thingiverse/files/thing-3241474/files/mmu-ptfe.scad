/*
  Quick release ptfe tube holder for "MMU2 filament control" by pmeyer
  https://www.thingiverse.com/thing:3184377

  If you have already printed the Final_body.stl, you can print the
  holder and super glue it to the Final_body. That's what I've done.
  If not, then you can leave load_body set to true, and it should be
  one solid piece.
*/

// Which one would you like to see?
part = "both"; //[block,holder,both]

// ptfe tube hole diameter
tube_diameter = 4.1; //[1:0.1:8]
// Outer width of holder. Should be 65.
width = 65; //[22:95.5]
// Height of holder. If too tall, it will prevent removing the block.
height = 31.5; //[23:0.1:35]
// The thickness of the block
thick = 10; //[2:20]

/* [Hidden] */
$fn=100;
// Merge the Final_body.stl mesh with the holder as one piece.
// Note: Customizer doesn't support importing stl files.
load_body = true; //[Yes,false]

module tubeHoles() {
  union() {
    translate([-1, 11.5, 31]) {
      // Note: Support up to 8 holes for no real reason
      for(i = [0 : 1 : 7]) {
        translate([0, 10.5*i])
        rotate([0,90])
        cylinder(h=thick+2, d=tube_diameter);
      }
    }
  }
}

// ptfe tube block
if (part == "block" || part == "both") {
  difference() {
    color("green") translate([0, width-5, 20]) rotate([90,0]) linear_extrude(width-10) polygon([
      [0,0],
      [thick-2, 0],
      [thick, 2],
      [thick, 11.5+tube_diameter],
      [2, 31.5],
      [0, 31.5]]);
    tubeHoles();
  }
}

union() {
  // holder for the tube block
  if (part == "holder" || part == "both") {
    // base
    cube([thick+5, width, 20]);
    // side walls
    cube([thick+5, 4.5, height]);
    translate([0, width-4.5,0]) cube([thick+5, 4.5, height]);
    // Edge that locks the block in
    translate([thick+0.5, 0]) {
      translate([0, 4.5]) cube([4.5, 2, height]);
      translate([0, width-2-4.5]) cube([4.5, 2, height]);
      //translate([0,0,20]) cube([4.5, width, 2]);
    }
  }

  if (load_body == true) {
    color("grey")
    rotate([0, 0, 180])
    translate([0, -65])
    import("Final_body.stl");
  }
}