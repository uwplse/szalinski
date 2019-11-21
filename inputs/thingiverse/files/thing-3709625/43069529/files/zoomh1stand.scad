// Angle of the Zoom H1 mic
mic_angle=35;


leg_angle=55+0;

$fn=60+0;

t=3+0;

zw=36+0;
zh=23.6+0;
zl=3*25.4;
overhang=zh-10;

leg_dia1=10+0;
leg_dia2=zw*1.6;
leg_length=90+0;

module mic_cutout() {
  union() {
    translate([t, t, t+0.1])
      cube([zw, zh, zl*2]);
    translate([-0.1-zw, (zh+t*2)/2-overhang/2, t+0.1])
      cube([zw*2, overhang, zl*2]);
    translate([-0.1-zw, t, 20])
      cube([zw*2, zh, zl*2]);
    translate([-zw/2, -zh/2, zl-21])
    rotate([0, -20, 0])
      cube([zw*2, zh*2, 30]);
  }
}

module mic_mount() {
  hull() {
    sphere(d=leg_dia2*1.25);
    translate([0, 0, zl])
      sphere(d=zw+t*2);
    }
}



module mic_leg() {
  hull() {
    scale([1, 1, 0.6])
    sphere(d=leg_dia2);
    translate([leg_length, 0, 0])
      cylinder(d=leg_dia1, h=t);
  }
}

module mic_legs() {
  mic_leg();
  rotate([0, 0, leg_angle])
    mic_leg();
}

module mic_stand_raw() {
  difference() {
    union() {
      rotate([0, mic_angle, 0])
        mic_mount();

      translate([-6, 0, 0])
      rotate([0, 0, -leg_angle/2])
        mic_legs();
    }

    translate([0, 0, 4])
    rotate([0, mic_angle, 0])
      translate([-zh/2-t*4-3, -zw/2+t, 10])
      mic_cutout();
    
  }
}

module mic_stand() {
  difference() {
    mic_stand_raw();
    translate([-150, -150, -300])
    cube([300,300,300]);
  }
}

mic_stand();
