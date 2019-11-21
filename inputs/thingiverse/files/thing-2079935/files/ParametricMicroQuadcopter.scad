// Which one would you like to make?
part="quadcopter"; // [quadcopter:Quadcopter,sizetest:Size Test Block]

// Motor Hole Diameter
dia=6.2; // [5.8:0.1:9]

// diameter is 8.5x20 == 8.6mm in nylon  6x15mm == 6.2mm(maybe!)

// Motor Mount Thickness
t=0.8; // [0:0.05:3]

// Frame Thickness
frame=2.4; // [0:0.1:5]

// Wingspan
span=110; //[60:150]

// Battery Height (5.5 for 150mah / 7.8 for 500mah)
bat_height=5.5;

// Battery Width (11.5 for 150mah / 19 for 500mah)
bat_width=11.5;   

// 7.8 x 19 for 500mah
// 5.5 x 11.5 for 200mah

// Guard Diameter (50 for Nano, 54 for Hubson x4, 0 to disable)
guard_diameter=50;
  

$fn=60*1;
height=frame+bat_height+frame/2;
sides=sqrt(span*span/2);
curve_scale=(sides-25)/2 / (sides/2) * 1.1;
guard_rad=guard_diameter/2;  // hubson==28, nano == 25


module boardMount(length, width) {
  difference() {
    cube([length, width, frame]);
  }
}

module propGuard() {
  union() {
    difference() {
      cylinder(r=guard_rad+t*2, h=t*2);
      cylinder(r=guard_rad, h=t*2);
    }
    rotate([0, 0, 220-35]) translate([0,-t/2,0])
      cube([guard_rad, t*2, t*2]);
    rotate([0, 0, 220+85]) translate([0,-t/2,0])
      cube([guard_rad, t*2, t*2]);
  }
}

module motorMount(d, h, t) {
  difference() {
    union() {
      cylinder(r=d/2+t, h=h, $fn=24);
      propGuard();
    }
    translate([0, 0, -1])
      cylinder(r=d/2, h=h+2, $fn=24);
    translate([0, 0, -1])
      cylinder(r=d/2-t, h=h, $fn=24);

  }
  
}

module sideArm() {
  difference() {
    translate([sides/2, 0, 0])
      scale([1, curve_scale, 1])
      cylinder(d=sides, h=frame);

    translate([sides/2, -frame/2, -1])
      scale([1, curve_scale, 1])
      cylinder(d=sides-frame*2, h=frame*3);

    translate([0, -sides*curve_scale/2, -1])
      cube([sides, sides*curve_scale/2, frame*3]);

    translate([0,0,-1])
      cylinder(r=dia/2+t-0.2, h=height*3);
    translate([sides, 0, -1])
      cylinder(r=dia/2+t-0.2, h=height*3);

  }
}

module batteryBay(w, h, l) {
  difference() {
    translate([0,l,0])
      cube([w+frame, l, h+frame/2]);
    translate([frame/2, l, 0])
      cube([w, l, h]);
  }
}


module quadcopter() {
  difference() {
    union() {
      rotate([0,0,-10]) 
        motorMount(dia, height, t);
    
      translate([sides, 0, 0])
        rotate([0,0,60])
        motorMount(dia, height, t);

      translate([0, sides, 0])
        rotate([0,0,-120])
        motorMount(dia, height, t);

      translate([sides, sides, 0])
        rotate([0,0,170])
        motorMount(dia, height, t);

      sideArm();

      translate([0, sides , frame])
        rotate([180,0, 0])
        sideArm();


      translate([sides/2-12.5, sides/2-12.5, 0])
        boardMount(25, 25);

      translate([sides/2-bat_width/2-frame/2, sides/2+12.5/2-frame, frame])
        batteryBay(bat_width, bat_height, frame*2);

      translate([sides/2-bat_width/2-frame/2, sides/2-12.5-frame*2, frame])
        batteryBay(bat_width, bat_height, frame*2);

    }

    translate([sides/2-18.5/2-6.6/2, sides/2-25/2+14/2, -1])
      union() {
      cube([6.6, 14, 12]);
      translate([18.5, 0, 0])
        cube([6.6, 14, 12]);
    }
  }
}

module motorHoleTest() {
  difference() {
    cube([20, 33, 5]);

    translate([5, 6, 0])
      cylinder(d=6, h=5);
    translate([5, 6+10, 0])
      cylinder(d=6.2, h=5);
    translate([5, 6+20, 0])
      cylinder(d=6.4, h=5);

    translate([14, 6, 0])
      cylinder(d=8.5, h=5);
    translate([14, 6+10, 0])
      cylinder(d=8.7, h=5);
    translate([14, 6+20, 0])
      cylinder(d=8.9, h=5);
  }
}


if (part == "quadcopter") {
  quadcopter();
} else {
  motorHoleTest();
}




