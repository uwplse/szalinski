part = "all"; // [right, left, all]

// depth of wrench slot
sloth = 14;

// slot width (i.e. max wrench thickness+clearance)
slotw = 6;

// slot angle
slota = 20;

// slot bevel (approx angle of rack)
slotb = 15;

// space between wrench slots
slotsp = 12;

// rack height = slotbase + sloth
slotbase = 8;

// number of wrenches in rack
nwrench = 8;   // [1:30]

// mouting screw hole diameter
screwd = 5;

// thickness of rack
rackt = 3;

rackl = (slotw + slotsp) * (nwrench + 1);
rackh = slotbase + sloth;

module screw_tab() {
   d = screwd * 3;
   rotate([90,0,0]) translate([d/2,d/2+rackt,-rackt])
   difference() {
      hull() {
         cylinder(d=d,h=rackt);
         translate([-d/2,-d/2,rackt-slotbase]) cube([d, 0.1, slotbase]);
      }
      translate([0,0,rackt-slotbase+.1]) cylinder(d=screwd,h=slotbase);
   }
}

module rack() {
   difference() {
      union() {
         hull() {
            translate([rackh/2,rackh/2,0]) cylinder(d=rackh, h=rackt);
            translate([rackl-rackh/2,rackh/2,0])
               cylinder(d=rackh, h=rackt);
            cube([rackl,0.1,rackt]);
         }
         
         // needs a bit of stiffening
         cube([rackl,rackt,rackt*2]);
         
         // screw mounting tabs
         screw_tab();
         translate([rackl-screwd*3,0,0]) screw_tab();
      }
      for(i=[1:nwrench]) {
         x = i*(slotsp+slotw);
         translate([x,slotbase,-rackt*2])
            // note: -slotb as we want the mounting tabs on the inside
            // of each rail...
            rotate([0,-slotb,slota])
               cube([slotw, sloth*2, rackt*4]);
      }
   }
}

if( part == "left" || part == "all" ) {
   rack();
}
if( part == "right" || part == "all" ) {
   translate([0,-10,0]) mirror([0,1,0]) rack();
}
