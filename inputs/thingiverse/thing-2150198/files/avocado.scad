$fn = 50;

// Avocado holder params
AVOCADO_RADIUS =      21;
PERCENT_UNDERWATER =  0.3; // Must be <= 0.5, otherwise avocado will pass through
DISK_RADIUS =         AVOCADO_RADIUS + 1;
DISK_HEIGHT =         15;

// Branches params
BRANCH_THICKNESS_MAX =  6;
BRANCH_WIDTH =          4;
BRANCH_LENGTH =         25;
NB_BRANCHES =           3;

module avocado_holder() {
  difference() {
    sphere_center = AVOCADO_RADIUS - (PERCENT_UNDERWATER * AVOCADO_RADIUS * 2);

    // Main cylinder
    cylinder(r=DISK_RADIUS, h=DISK_HEIGHT);
    // Extruding cylinder, only usefull for thick disks
    translate([0,0,sphere_center]) cylinder(r=AVOCADO_RADIUS, h=DISK_HEIGHT);
    // Inside sphere for a smooth holding
    translate([0,0, sphere_center]) sphere(AVOCADO_RADIUS);
  }
}

module branch(length, width, thickness_max) {
  difference() {
    // Branch body
    translate([0,-width/2,0])
      cube([length, width, thickness_max]);

    // Extruding cylinder
    translate([length/2,width/2+1,0]) rotate([90,0,0])
      scale([BRANCH_LENGTH/2+1,thickness_max/1.3,1]) cylinder(r=1, h=width+2);
  }
}

avocado_holder();

// Populate branches
for (num_branch = [0:NB_BRANCHES - 1]) {
  difference() {
    rotate([0,0,num_branch * (360 / NB_BRANCHES)]) {
      translate([DISK_RADIUS, 0, DISK_HEIGHT-BRANCH_THICKNESS_MAX])
        rotate([0,-25,0])
          branch(BRANCH_LENGTH, BRANCH_WIDTH, BRANCH_THICKNESS_MAX);
    }
    cylinder(r=DISK_RADIUS, h=DISK_HEIGHT);
    cylinder(r=AVOCADO_RADIUS, h=DISK_HEIGHT+BRANCH_LENGTH);
  }
}
