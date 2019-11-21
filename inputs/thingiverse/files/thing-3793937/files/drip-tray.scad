// STL to view
part = "all"; // [all:Tray with risers,trayvase:Tray vase mode,riser:Risers only]

// Total height of the tray (mm)
height = 26;

// Diameter of the base (mm)
base_diameter = 100;

// Diameter of the top rim (mm). This should be greater than base_diameter but not so large that it requires support.
top_diameter = 117;

// Width of the tray wall (mm). Ignored in vase mode.
wall_width = 1.3;

// Width of the tray base (mm). Ignored in vase mode.
base_width = 1.2;

// Add risers to give space for water under the pot
add_risers = 1; // [0:false,1:true]

// Height of the risers (mm)
riser_height = 10;

// Diameter of the risers (outer edge to outer edge) (mm). This should be less than base_diameter.
riser_diameter = 70;

// Inner diameter of the risers (inner edge to inner edge) (mm). This should be between riser_diameter/2 and riser_diameter.
riser_inner_diameter = 60;

// Space between the riser segments (mm). Decrease as the riser diameter decreases.
riser_cut_width = 20;


base_radius = base_diameter/2;
top_radius = top_diameter/2;
riser_cut_height = riser_height*2+1;
riser_radius = riser_diameter/2;
riser_inner_radius = riser_inner_diameter/2;

if (part == "all") {
  everything();
}
else if (part == "trayvase") {
  trayVaseMode();
}
else if (part == "riser") {
  risers();
}


module everything() {
  $fa=1;
  union() {
    // wall
    difference() {
      cylinder(h=height, r1=base_radius, r2=top_radius);
      translate([0,0,-0.01])
      cylinder(h=height+0.02, r1=base_radius-wall_width, r2=top_radius-wall_width);
    }
    
    // base
    color("gray")
    cylinder(h=base_width, r=base_diameter/2);
    
    // risers
    if (add_risers == 1) {
      translate([0,0,base_width-0.01])
      risers();
    }
  }
}


module trayVaseMode() {
  $fa=1;
  cylinder(h=height, r1=base_radius, r2=top_radius);
}


module risers() {
  $fa=1;
  difference() {
    cylinder(h=riser_height, r=riser_radius);
    cylinder(h=riser_cut_height, r=riser_inner_radius, center=true);
    
    for (a = [0:90:270]) {
      rotate([0,0,a])
      translate([riser_inner_radius, 0, 0])
      cube(size=[riser_radius, riser_cut_width, riser_cut_height], center=true);
    }
  }
}
