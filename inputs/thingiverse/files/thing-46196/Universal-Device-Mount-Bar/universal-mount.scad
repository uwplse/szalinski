// Generate universal plate or screw connector
connector="universal"; // [universal:Universal connector plate,screw:M6 hole connector]

// Width of device, measured from outside of fixation bracket to outside of second bracket
device_width=100;

/* [Hidden] */
// Development values for testing
//Xperia Active
device_width=87.2;


bar_height=20;
bar_width=4;
latch_space=10;
connector_depth=2.4;

module hook () {
  linear_extrude(height=bar_height)translate([0,-2,0])polygon(points=[[-latch_space,0],[0,0],[0,-0.8],[0.4,-0.8],[1.2,0],[12.5,0],[12.5, 0.5],[-latch_space+2,2],[-latch_space,bar_width/2]]);

}

module latch () {
  hook();
  mirror([0,1,0])hook();
};

module cutout () {
  translate([0,connector_depth,0])rotate([90,0,0])linear_extrude(height=connector_depth*2)polygon(points=[[0,0],[12,0],[12,5.4],[5,5.4],[5,2.9],[0,2.9]]);
}

module beam () {
  beam_length=device_width/2-latch_space;

  linear_extrude(height=bar_height)polygon(points=[[0,0],[beam_length-bar_width,0],[beam_length,bar_width],[beam_length,2*bar_width],[beam_length-(bar_width*2-connector_depth),connector_depth],[0,connector_depth]]);
}

// Universal connector plate. See www.dx.com for hundreds of gooseneck connectors.
module universal_connector () {
 difference() {
  union () {
    translate([-55/2,0,0])cube([55,connector_depth,30]);
    beam();
    mirror()beam();
  }
  translate([-21,0,3])union() {
    union() {
      cutout();
      translate([30,0,0])cutout();
    }
    translate([0,0,23.8])mirror([0,0,1]) {
      cutout();
      translate([30,0,0])cutout();
    }
  }
 }
}

module m6_connector () {
  beam();
  mirror()beam();

  difference() {
    hull() {
      translate([0,-18,0])cylinder(r=6,h=4, $fn=40);
      translate([0, -1.75, 2])cube([19.4, 3.5, 4], center=true);
    }
    translate([0,-18,-1])cylinder(r=3.5,h=6, $fn=40);
  }

  difference () {
    difference () {
      translate([0, -1.75, 2])cube([26.4, 3.5, 4], center=true);
      translate([14.5, -4.8, -1])cylinder(r=5, h=6, $fn=40);
    }
    translate([-14.5, -4.8, -1])cylinder(r=5, h=6, $fn=40);
  }
};

translate([device_width/2,bar_width*1.5,0])latch();
translate([-device_width/2,bar_width*1.5,0])mirror()latch();

if (connector=="universal") {
  universal_connector();
} else {
  m6_connector();
};