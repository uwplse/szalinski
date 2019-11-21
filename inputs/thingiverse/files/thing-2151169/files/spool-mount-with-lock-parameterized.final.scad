//this is a Delta hard drive Bearring Mount for the top of the printer
//Put your measurements here:
drive_bearing_measure_A = 53; //largest bearing diameter
drive_bearing_measure_B = 2; //depth of largest diameter
drive_bearing_measure_C = 39; //52//secondary bearing diameter
drive_bearing_measure_D = 6.75; //depth of secondary diameter

screw_measure_A = 4.6;//example 4.6 is diameter of M4 with threads, loose fit
screw_measure_B = 9;   //example 9 is diameter of M4 nut, loose fit

pvc_measure_A = 27.6;//outer PVC diameter plus fit
pvc_measure_B = 0;      //inner PVC diameter plus fit

pipe_radius = pvc_measure_A/2;//13.8; //you can adjust this to fit the pvc, 13.7 seems to work with prints from my ultimaker at 0.2mm for 3/4" pvc
pvc_attachment_offset = 3.5;//1.5;//3.5; //how high the pvc connection sits above the platform
support_thickness = 4;//5;//3;//2;//thickness of pvc ring,
screw_radius = screw_measure_A/2;//2.3;//2 is screw tight, 2.1 tight but not enough
//drive bearing sizes
drive_bearing_radius1 = drive_bearing_measure_A/2;//32.5; //largest outer radius
drive_bearing_depth1 = drive_bearing_measure_B;
drive_bearing_radius2 = drive_bearing_measure_C/2;//26;//27;//25;  //inner radius
drive_bearing_depth2 =drive_bearing_measure_D;
drive_bearing_depth3 = 25;  //no need to measure this, just make sure it's large enough to cut through entire model
drive_bearing_radius3 = 15; //clearance radius - some bearings have protrusions on the bottom, this hole proivides final clearance

inch_conversion = 24.5; // 1 inch is equal to 24.5 millimeters source: http://www.wikihow.com/Convert-Inches-to-Millimeters

useNuts = false;//to enable nut for attachment, set this to true
nutsize= 9;//nutsize is the diameter of the nut plus  the gap needed
createLock = true;//false;//true

//Render complete platform
render_complete_platform();
lock_mechanism();

module lock_mechanism(){
  collar();
  latch();
  lock_bar();
};

module collar(){
  translate([15,-52,0]){
    translate([0,0,-2.5]){
      rotate([0,0,30]){
        union(){
          difference(){
            cylinder(r1=5.5,r2=5.5,h=1.5, $fn=32);
            cylinder(r1=2.5,r2=2.5,h=10, $fn=32);
            translate([-3,0,0]){
              cube([6,14,5], center=true);
              };
          };
          translate([-2.25,3.5,.75]){
            cube([6,4,1.5], center=true);
          };
          translate([-2.25,-3.5,.75]){
            cube([6,4,1.5], center=true);
          };
        };
      };
    };
  };
};

module latch(){
  translate([15,-52,0]){
    translate([0,0,-4]){
      rotate([0,0,30]){
        difference(){
          cylinder(r1=2.5,r2=2.5,h=10, $fn=32);
          translate([0,3.5,2.5]){
            cube([6,4,2], center=true);
          };
          translate([0,-3.5,2.5]){
            cube([6,4,2], center=true);
          };
        };
      };
    };
  };
  translate([5,-34.65,30]){
    difference(){
      union(){
        rotate([0,0,30]){
          translate([0,-5,-8]){
            cube([16,10,4], center=true);
            translate([0,-5.75,-2.5]){
              //latch height
              cube([16,4,9], center=true);
            };
          };
        };
        translate([0,-0,-10]){
          cylinder(r1=8,r2=8,h=4, $fn=32);
        };
      };
      translate([0,0,-12]){
        cylinder(r1=3,r2=3,h=20, $fn=32);
      };
    };
  };
  difference(){
    translate([15,-52,4]){
      union(){
        rotate([0,0,30]){
          translate([0,5.5,7]){
            cube([16,11.5,14], center=true);
          };
        };
        cylinder(r1=8,r2=8,h=14, $fn=32);
      };
    };
    //latch slot
    translate([35,-72,8.5]){
      rotate([0,0,42.5]){
        cube([10,52,6]);
      };
    };
  };
};

module lock_bar(){
  difference(){
    union(){
     translate([5,-35,-8]){
       cylinder(r1=2.5,r2=2.5,h=38, $fn=32);
     };
     translate([35.5,-72,9]){
       rotate([0,0,42.5]){
         cube([5,52,5]);
       };
     };
   };
   translate([35.5,-72,9]){
     rotate([0,0,42.5]){
       translate([-4,26,2]){
         cube([10,54,50],center=true);};
       };
     };
   };
 };

//create the platform with pvc pvc_attachmentments
module render_complete_platform(){
  union(){
    platform();
    for(i=[0:2]){
      rotate([0,0,(i*120)]){
        pvc_attachment(support_thickness, useNuts);
      };
    };
    if(createLock == true){
      translate([15,-52,0]){
        difference(){
          union(){
            rotate([0,0,30]){
              translate([0,4,2]){
                cube([16,8,4], center=true);
              };
            };
            cylinder(r1=8,r2=8,h=4, $fn=32);
          };
          translate([0,0,-2]){
            cylinder(r1=3,r2=3,h=20, $fn=32);
          };
        };
      };
    };
  };
};

//create the main platform
module platform() {
  difference(){
    union(){
      platform_triagular_hull(h=4);
      platform_triagular_hull(h=8,r=42);
      difference(){
        platform_triagular_hull(h=8,r=60);
        translate([0,0,4]){
          platform_triagular_hull(h=4,r=55);};
        };
        for(i=[0:2]){
          rotate([0,0,60+(i*120)]){
            translate([32,0,4]){
              cube([15,5,8], center=true);
            };
          };
        };
    };
    //cutout for pvc pipes
    pvc_cutouts();
    //drive bearing holes
    drivebering_hole(drive_bearing_depth1, drive_bearing_radius1,drive_bearing_depth2, drive_bearing_radius2, drive_bearing_depth3, drive_bearing_radius3);
    if(createLock == true){
      translate([5,-35,-2]){
        cylinder(r1=3,r2=3,h=20, $fn=32);};
    };
  };
};

//flat triagular peice of platform
module platform_triagular_hull(h=8, r=70, mangl=15){
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

//drive bearing hole
module drivebering_hole(drive_bearing_depth1 = 2.2, drive_bearing_radius1 = 31.5,drive_bearing_depth2 = 6.23, drive_bearing_radius2 = 25, drive_bearing_depth3 = 25, drive_bearing_radius3 = 15){
  union(){
      cylinder(h = drive_bearing_depth1, r1 = drive_bearing_radius1, r2 = drive_bearing_radius1);
      cylinder(h = drive_bearing_depth2, r1 = drive_bearing_radius2, r2 = drive_bearing_radius2);
      cylinder(h = drive_bearing_depth3, r1 = drive_bearing_radius3, r2 = drive_bearing_radius3);
    };
};

//pvc platform cutout for pvc pipes
module pvc_cutouts(){
  for(i=[0:2]){
    rotate([0,0,(i*120)]){
      pvc_cutout();
    };
  };
};

module pvc_cutout(){
  translate([40,0,pipe_radius+pvc_attachment_offset]){//+support_thickness
    rotate([0,90,0]){
      cylinder(h = 30, r1 = pipe_radius, r2 = pipe_radius);
    };
  };
};

//pvc pvc_attachmentment point
module pvc_attachment(support_thickness = 2, useNuts=false){
  outerdiameter = (pipe_radius+support_thickness);
  supportradius = pipe_radius+support_thickness;//1.9;
  screwzoff = pipe_radius+2.5;
  translate([45,0,pipe_radius+pvc_attachment_offset]){//+support_thickness
    rotate([0,90,0]){
      difference(){
        union(){
          cylinder(h = 20, r1 = outerdiameter, r2 = outerdiameter);
          translate([-1.5,-supportradius,0]){
            cube([17,(2*supportradius),4]);//cube([17,30.8,4]);//, center=true);
          };
          translate([-1.5,-supportradius,16]){
            cube([17,(2*supportradius),4]);//30.8,4]);//, center=true);
          };
          rotate([0,0,90]){
            translate([0,screwzoff,10]){
              cube([10,10,10], center=true);//screw holder
            };
          };
        };
        rotate([0,0,90]){
          translate([0,0,-1]){
            cylinder(h = 25, r1 = pipe_radius, r2 = pipe_radius);//increased from h=20
          };
          translate([0,25,10]){
            rotate([90,0,0]){
              //screw holes for pvc attachment
              cylinder(h=25, r1 =screw_radius, r2= screw_radius);
              if(useNuts == true){
                translate([0,0,6]){
                  cylinder(h=8, r1 =nutsize/2, r2= nutsize/2, $fn=6);
                };
              };
            };
          };
        };
        //clip outer diameter above 3 mm
        translate([(pipe_radius+3),0,10]){
          cube([support_thickness,(2*supportradius),20], center=true);
        };
      };
    };
  };
};
