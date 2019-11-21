//-------oraginal ------------------------------------------------------
//-- Servo wheel
//-- (c) Juan Gonzalez (obijuan) juan@iearobotics.com
//-- March-2012
//-------------------------------------------------------------
//-- moded to servo pulley and to work with makerbot custiomizer 
//-- by Joel hackett (jhack) 1/4/2013
//-------------------------------------------------------------

// pulley parameters
 //pulley diameter
pulley_diameter = 35;  //[20:150] 
  //size of the grove
grove_size=6; //[3:6]                  
// the angel to cut out
OpeningAngle = 80; //[10: 180]
// the depth of the cut out
cutout=7; //[4:150]
// the hole size for the string to go though
hole_diam=2;//[1:6]
// horn type based off Futaba 3003 horns
horn_type = 1; //[1:round,2:4-arm,3:6-arm]

/* [hidden] */
wheel_or_idiam = pulley_diameter;
wheel_or_diam = grove_size;

wheel_height = 2*wheel_or_diam+0;     //-- Wheel height: change the 0 for 
                                    
//-- Parameters common to all horns
horn_drill_diam = 1.5;
horn_height = 6;        //-- Total height: shaft + plate
horn_plate_height = 2;  //-- plate height

//-- Futaba 3003 servo rounded horn parameters
rh_diam1 = 8.5;  //-- Rounded horn small diameter
rh_diam2 = 21.5; //-- Rounded horn big diameter
rounded_horn_drill_distance = 7.3;

//-- Futaba 3003 horn drills


//-- Futaba 3003 4-arm horn parameters
a4h_end_diam = 5;
a4h_center_diam = 10;
a4h_arm_length = 15;
a4h_drill_distance = 13.3;


//-- Futaba 3003 6-arm horn parameters
a6h_end_diam = 5;
a6h_center_diam = 10;
a6h_arm_length=10;
a6h_arm_base_diam=7.5;
a6h_drill_distance = 10.9;


//-------------------------------------------------------
//--- Parameters:
//-- or_idiam: O-ring inner diameter
//-- or_diam: O-ring section diameter
//-- h: Height of the wheel
//--
//--  Module for generating a raw wheel, with no drills
//--  and no servo horn
//-------------------------------------------------------
module raw_wheel(or_idiam=50, or_diam=3, h=6)
{
   //-- Wheel parameters
   r = or_idiam/2 + or_diam;   //-- Radius

  //-- Temporal points
  l = or_diam*sqrt(2)/2;

  difference() {
    //-- Body of the wheel
    cylinder (r=r, h=h, $fn=100,center=true);

    //--  wheel's inner section
 difference() {
    rotate_extrude($fn=100)
      translate([r-or_diam/2,0,0])
      polygon( [ [0,0],[l,l],[l,-l] ] , [ [0,1,2] ]);
rotate([0,0,-OpeningAngle/2]) translate([0,wheel_or_idiam/2-hole_diam/2,-wheel_height/2]) cube([wheel_height/2,wheel_height,wheel_height]);
rotate([0,0,OpeningAngle/2]) translate([-wheel_height/2+.1,wheel_or_idiam/2-hole_diam/2,-wheel_height/2]) cube([wheel_height/2,wheel_height,wheel_height]);
}


 translate([0,0,-wheel_height/2-1]){
rotate([0,0,OpeningAngle/4-0.05]) intersection() {
			rotate([0,0,OpeningAngle/4]) cube([wheel_or_idiam+wheel_or_diam+1,wheel_or_idiam+wheel_or_diam+1,wheel_height+2]);
			rotate ([0,0,-OpeningAngle/4]) translate([-(wheel_or_idiam+wheel_or_diam+1),0,0]) cube([wheel_or_idiam+wheel_or_diam+1,wheel_or_idiam+wheel_or_diam+1,wheel_height+2]);
difference() {
			cylinder(r=wheel_or_idiam/2+wheel_or_diam+1,h=wheel_height+2);
cylinder(r=(wheel_or_idiam/2+wheel_or_diam+1)-cutout,h=wheel_height+2);
}
		}
	


rotate([0,0,-OpeningAngle/4+0.05]) intersection() {
			rotate([0,0,OpeningAngle/4]) cube([wheel_or_idiam+wheel_or_diam+1,wheel_or_idiam+wheel_or_diam+1,wheel_height+2]);
			rotate ([0,0,-OpeningAngle/4]) translate([-(wheel_or_idiam+wheel_or_diam+1),0,0]) cube([wheel_or_idiam+wheel_or_diam+1,wheel_or_idiam+wheel_or_diam+1,wheel_height+2]);
difference() {
			cylinder(r=wheel_or_idiam/2+wheel_or_diam+1,h=wheel_height+2);
cylinder(r=(wheel_or_idiam/2+wheel_or_diam+1)-cutout,h=wheel_height+2);
}
		}

}
rotate([0,-90,OpeningAngle/2]) translate([0,wheel_or_idiam/2+hole_diam/2,-1]) cylinder(r = hole_diam/2, h = wheel_or_idiam,$fn=100);
rotate([0,90,-OpeningAngle/2]) translate([0,wheel_or_idiam/2+hole_diam/2,-1]) cylinder(r = hole_diam/2, h = wheel_or_idiam,$fn=100);


  }





}

//--------------------------------------------------------------
//-- Generic module for the horn's drills
//-- Parameters:
//--  d = drill's radial distance (from the horn's center)
//--  n = number of drills
//--  h = wheel height
//--------------------------------------------------------------
module horn_drills(d,n,h)
{
  union() {
    for ( i = [0 : n-1] ) {
        rotate([0,0,i*360/n])
        translate([0,d,0])
        cylinder(r=horn_drill_diam/2, h=h+10,center=true, $fn=6);  
      }
  }
}

//-----------------------------------------
//-- Futaba 3003 horn4 arm
//-- This module is just one arm
//-----------------------------------------
module horn4_arm(h=5)
{
  translate([0,a4h_arm_length-a4h_end_diam/2,0])
  //-- The arm consist of the perimeter of a cylinder and a cube
  hull() {
    cylinder(r=a4h_end_diam/2, h=h, center=true, $fn=20);
    translate([0,1-a4h_arm_length+a4h_end_diam/2,0])
      cube([a4h_center_diam,2,h],center=true);
  }
}

//-----------------------------------------
//-- Futaba 3003 horn6 arm
//-- This module is just one arm
//-----------------------------------------
module horn6_arm(h=5)
{
  translate([0,a6h_arm_length-a6h_end_diam/2,0])
  //-- The arm consist of the perimeter of a cylinder and a cube
  hull() {
    cylinder(r=a6h_end_diam/2, h=h, center=true, $fn=20);
    translate([0,-a6h_arm_length+a6h_end_diam/2,0])
    cube([a6h_arm_base_diam,0.1,h],center=true);
  }
}


//-------------------------------------------
//-- Futaba 3003 4-arm horn
//-------------------------------------------
module horn4(h=5)
{
  union() {
    //-- Center part (is a square)
    cube([a4h_center_diam+0.2,a4h_center_diam+0.2,h],center=true);

    //-- Place the 4 arms in every side of the cube
    for ( i = [0 : 3] ) {
      rotate( [0,0,i*90])
      translate([0, a4h_center_diam/2, 0])
      horn4_arm(h);
    }
  }

}

//-------------------------------------------
//-- Futaba 3003 6-arm horn
//-------------------------------------------
module horn6(h=5)
{
  union() {
    //-- The center part is a cylinder
    cylinder(r=15/2,h=h,center=true);

    //-- Place the 6 arms rotated 60 degrees
    for ( i = [0 : 5] ) {
      rotate( [0,0,i*60])
      translate([0, 15/2*cos(30), 0])
      horn6_arm(h);
    }
  }
}


//-------------------------------------------------------
//--  A Wheel for the futaba 3003 rounded horns
//--------------------------------------------------------
module Servo_wheel_rounded_horn()
{
  difference() {
      raw_wheel(or_idiam=wheel_or_idiam, or_diam=wheel_or_diam, h=wheel_height);

      //-- Inner drill
      cylinder(center=true, h=2*wheel_height + 10, r=rh_diam1/2+0.2,$fn=100);

      //-- Carved circle for the Futaba rounded horn
      translate([0,0,-wheel_height/2+horn_height-horn_plate_height]) 
       cylinder(r=rh_diam2/2+0.25, h=2*wheel_height+10,$fn=30);

      //-- small drills for the rounded horn
      horn_drills(d=rounded_horn_drill_distance, n=4, h=wheel_height);
  }

}

//-------------------------------------------------------
//--  A Wheel for the futaba 3003 4-arm horns
//--------------------------------------------------------
module Servo_wheel_4_arm_horn()
{
  difference() {
      raw_wheel(or_idiam=wheel_or_idiam, or_diam=wheel_or_diam, h=wheel_height);

      //-- Inner drill
      cylinder(center=true, h=2*wheel_height + 10, r=a4h_center_diam/2,$fn=20);

      //-- substract the 4-arm servo horn
      translate([0,0,horn_height-horn_plate_height])
        horn4(h=wheel_height);

      //-- Horn drills
      horn_drills(d=a4h_drill_distance, n=4, h=wheel_height);

  }
}

//-------------------------------------------------------
//--  A Wheel for the futaba 3003 6-arm horns
//--------------------------------------------------------
module Servo_wheel_6_arm_horn()
{
  difference() {
      raw_wheel(or_idiam=wheel_or_idiam, or_diam=wheel_or_diam, h=wheel_height);

       //-- Inner drill
      cylinder(center=true, h=2*wheel_height + 10, r=a6h_center_diam/2,$fn=20);

      //-- substract the 6-arm horn
      translate([0,0,horn_height-horn_plate_height])
      horn6(h=wheel_height);

      //-- Horn drills
      horn_drills(d=a6h_drill_distance, n=6, h=wheel_height);
  }
}


//-- select
if( horn_type== 1) Servo_wheel_rounded_horn();
if( horn_type== 2) Servo_wheel_4_arm_horn();
if( horn_type== 3) Servo_wheel_6_arm_horn();




