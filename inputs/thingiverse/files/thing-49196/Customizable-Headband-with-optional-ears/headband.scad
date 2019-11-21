// Head diameter (ear-to-ear) in mm
head_size=140;  // [20:200]

// Ear style
ear_style=5; // [0:None,1:pointy,2:round solid,3:round hollow,4:floppy,5:heart]

// Determintes how tall the ears are.
pointyness=40; // [25:70]

// Number of polygons that make up headband. Too many makes customizer slow.
faces=48; // [10:100]

// (pointy ear) Angle from top of head to ear.
ear_angle1=20; // [0:90]

// (pointy ear) Angle from top of head to bottom of ear.
ear_angle2=70; // [0:90]

// (pointy ear) Angle from top of head to point of ear.
ear_angle3=40; // [0:90]

// preview[view:south, tilt:bottom]

band_thickness=sqrt(head_size/2.2);


module ear1_shape() {
  a1=ear_angle1;
  a2=ear_angle2;
  a3=ear_angle3;
  mirror([0,0,-1]) scale(head_size) {
    polyhedron(
      points=[ [sin(a1)/2,-cos(a1)/2,0],
               [sin(a2)/2,-cos(a2)/2,0],
               [sin(a3) * pointyness/50,-cos(a3)* pointyness/50,0],
               [sin(a3)/2,-cos(a3)/2,-1/6]  ],
      triangles=[ [0,1,2], [1,0,3], [2,1,3], [0,2,3] ]
    );
  }
}

module ear1() {
  minkowski() {
    difference() {
      translate([0,0,-band_thickness/2+1.5]) ear1_shape();
      translate([0,0,-band_thickness/2]) ear1_shape();
    }
    sphere(r=2, $fn=10);
  }
}


module ear2() {
  translate([head_size * 0.707/2, -head_size * 0.707/2,0]) rotate([-pointyness,-20,0]) 
      cylinder(r=head_size/5, h=head_size, center=true, $fn=100);
}

module ear3() {
  difference() {
    translate([head_size * 0.707/2, -head_size * 0.707/2,0]) rotate([-pointyness,-20,0]) 
        cylinder(r=head_size/5, h=head_size, center=true, $fn=100);
    translate([head_size * 0.707/2, -head_size * 0.707/2,0]) rotate([-pointyness,-20,0]) 
        cylinder(r=head_size/5-5, h=head_size, center=true, $fn=100);
  }
}

module ear4() {
  a = 70;
  offset = head_size* 0.55;
  difference() {
    translate([offset * sin(a), -offset * cos(a),0]) rotate([-pointyness,30,0]) 
        cylinder(r=head_size/5, h=head_size, center=true, $fn=100);
    translate([offset * sin(a), -offset * cos(a),0]) rotate([-pointyness,30,0]) 
        cylinder(r=head_size/5-4, h=head_size, center=true, $fn=100);

    rotate([30,0,-20]) translate([0,head_size*0.1,-head_size]) cube([head_size, head_size, head_size*2]);
  }
}

module ear5() {
  heart_size=head_size * 0.1;
  rotate([0,0,30])
  translate([0,-head_size/2,0])
  intersection() {
    minkowski() {
      linear_extrude(height=1.0)
      union() {
        hull() {
           translate([heart_size,-2.2*heart_size,0]) circle(r=heart_size + 1);
           circle(r=2);
       }
        hull() {
           translate([-heart_size,-2.2*heart_size,0]) circle(r=heart_size + 1);
           circle(r=2);
        }
      }
      sphere(r=band_thickness * 9/16);
    }
    translate([-150,-150,-300]) cube([300,300,300 + band_thickness/2]);
  }
}


module head() {
  hull() {
    circle(r=head_size/2, $fn=faces);
    translate([0,head_size*2/3,0]) {
     circle(r=head_size/3, $fn=faces);
    }
  }
}

module basic_shape() {
  intersection() {
    head();
    translate([-head_size/2-1, -head_size/2-1]) square([head_size+2, head_size]);
  }
}


module ear() {
  if (ear_style == 0) {
    // no ears
  }
  if (ear_style == 1) {
    ear1(); // pointy ears
  }
  if (ear_style == 2) {
    ear2(); // round ears
  }
  if (ear_style == 3) {
    ear3(); // round hollow
  }
  if (ear_style == 4) {
    ear4(); // round hollow
  }
  if (ear_style == 5) {
    ear5(); // hearts
  }
}

module headband() {
  intersection() {
    difference() {
      union() {
        ear();
        mirror([1,0,0]) ear();
        intersection() {
          minkowski() {
            linear_extrude(height=1.0) basic_shape();
            sphere(r=band_thickness * 9/16);
          }
          translate([-150,-150,-300]) cube([300,300,300 + band_thickness/2]);
        }
      }
      translate([0,0,-50]) linear_extrude(height=300) head();
    }
    translate([-150,-150,-band_thickness/2]) cube([300,300,300]);
  }

  for (rot=[-40:10:40]) {
    rotate([0,0,rot]) {
      translate([0,-head_size/2,0]) rotate([-90,0,0]) cylinder(r1=3, r2=0, h=3, $fn=4, center=true);
    }
  }
}

headband();
