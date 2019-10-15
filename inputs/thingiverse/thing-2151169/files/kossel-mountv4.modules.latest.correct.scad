//this is a Kossel Hardrive Bearring Mount for the top of the printer
pipedia = 13.8;
attachoff = 3.5;
screwsize = 2.3;//2 is screw tight, 2.1 tight but not enough, 
complete();
//union(){
//attach();
//  translate([55,0,2.5]){
//  cube([20,2*(pipedia+2),2], center=true);
//  };
//}

module platform() {
difference(){
  union(){
    myhull(h=4);
    myhull2(h=8,r=42);
    difference(){
      myhull2(h=8,r=60);
      translate([0,0,4]){
        myhull2(h=4,r=55);};
      };
      rotate([0,0,60]){
translate([32,0,4]){
cube([15,5,8], center=true);
};
};

rotate([0,0,180]){
translate([32,0,4]){
cube([15,5,8], center=true);
};
};

rotate([0,0,300]){
translate([32,0,4]){
cube([15,5,8], center=true);
};
};
  };
  union(){
    cylinder(h = 2.2, r1 = 31.5, r2 = 31.5);
    cylinder(h = 6.23, r1 = 25, r2 = 25);
  };

  translate([40,0,pipedia+attachoff]){
    rotate([0,90,0]){
     cylinder(h = 30, r1 = pipedia, r2 = pipedia);
    };
  };

  rotate([0,0,120]){
    translate([40,0,pipedia+attachoff]){
      rotate([0,90,0]){
       cylinder(h = 30, r1 = pipedia, r2 = pipedia);
      };
    };
  };

    rotate([0,0,-120]){
    translate([40,0,pipedia+attachoff]){
      rotate([0,90,0]){
       cylinder(h = 30, r1 = pipedia, r2 = pipedia);
      };
    };
  };
  //base hole
  cylinder(h = 25, r1 = 15, r2 = 15);
};

};

module complete(){
union(){
  platform();
  attach();
  rotate([0,0,120]){
    attach();
  };
  rotate([0,0,-120]){
    attach();
  };
};
};

module myhull2(h=8, r=70, mangl=15){
  difference(){
  hull(){
    cylinder(h = h, r1=r, r2 = r, $fn=3);
    rotate([0,0,15]){
       cylinder(h = h, r1 = (r-2), r2 =  (r-2), $fn=3);};
    rotate([0,0,-15]){
      cylinder(h = h, r1 = (r-2), r2 = (r-2), $fn=3);};
    rotate([0,0,-7]){
      cylinder(h = h, r1 = r, r2 = r, $fn=3);};
    rotate([0,0,7]){
      cylinder(h = h, r1 = r, r2 = r, $fn=3);};
    };
  };
};

module myhull(h=8, r=70, mangl=15){
  difference(){
  hull(){
    cylinder(h = h, r1=r, r2 = r, $fn=3);
    rotate([0,0,15]){
       cylinder(h = h, r1 = (r-2), r2 =  (r-2), $fn=3);};
    rotate([0,0,-15]){
      cylinder(h = h, r1 = (r-2), r2 = (r-2), $fn=3);};
    rotate([0,0,-7]){
      cylinder(h = h, r1 = r, r2 = r, $fn=3);};
    rotate([0,0,7]){
      cylinder(h = h, r1 = r, r2 = r, $fn=3);};
      };
    };
};

module attach(){
translate([45,0,pipedia+attachoff]){
  rotate([0,90,0]){
    outerdiameter = (pipedia+2);
    supportradius = pipedia+2;//1.9;
    screwzoff = pipedia+2.5;
    difference(){
      union(){
      cylinder(h = 20, r1 = (pipedia+2), r2 = (pipedia+2));
        translate([-1.5,-supportradius,0]){
        cube([17,(2*supportradius),4]);//cube([17,30.8,4]);//, center=true);
        };
        translate([-1.5,-supportradius,16]){
        cube([17,(2*supportradius),4]);//30.8,4]);//, center=true);
        };
        rotate([0,0,90]){
        translate([0,screwzoff,10]){
        cube([10,10,10], center=true);
        };
      };
  };
  rotate([0,0,90]){
      cylinder(h = 20, r1 = pipedia, r2 = pipedia);
     translate([0,25,10]){
     rotate([90,0,0]){
     cylinder(h=25, r1 =screwsize, r2= screwsize);
     };
   };
 };
    };
  };

};
}

//rotate([0,0,120]){
//translate([40,0,17]){
//  rotate([0,90,0]){
//   cylinder(h = 30, r1 = 13.5, r2 = 13.5);
//  };
//};
//};
//
//rotate([0,0,-120]){
//translate([40,0,17]){
//  rotate([0,90,0]){
//   cylinder(h = 30, r1 = 13.5, r2 = 13.5);
//  };
//};
//};
//rotate([0,0,15]){
//cylinder(h = 8, r1 = 70, r2 = 70, $fn=3);}
//translate([0, 0, 20]){
  //scale([1.5, 1, 1]){
    //cylinder(h = 40, r1 = 20, r2 = 0);}}

//cube([10, 20, 15], center = true);
//sphere(r = 20);
//union(){
//  myhull2(h=8,r=40);
//difference(){
//myhull2(h=8,r=60);
//  translate([0,0,4]){
//  myhull2(h=4,r=55);};
//}
//};

//cube([5,20,5], center=true);


//rotate([0,0,60]){
//translate([32,0,4]){
//cube([15,5,8], center=true);
//};
//};
//
//rotate([0,0,180]){
//translate([32,0,4]){
//cube([15,5,8], center=true);
//};
//};
//
//rotate([0,0,300]){
//translate([32,0,4]){
//cube([15,5,8], center=true);
//};
//};
