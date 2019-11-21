$fs=0.5;
$fa=6;

BUILD_TYPE = "preview"; // [test, top, bottom, preview]



M3_THREAD_LENGTH = 17.6;
M3_HEAD_HEIGHT = 2.2;

SHAFT_DIA = 6.1;
SHAFT_SMALL_WIDTH = 5.5; 
SHAFT_LENGTH = 10;
SHAFT_TOTAL_LENGTH = 12;

//Knob outer diameter - calculated to be flush with M3 screw head
OUTER_DIA = 2*(M3_THREAD_LENGTH + M3_HEAD_HEIGHT) + SHAFT_DIA;
OUTER_HEIGHT = 25;

M5_NUT_DIA = 8.79;

//M5_NUT_HOLE = 3.869;
M5_NUT_HEIGHT = 4.7;
M5_NUT_COUNT = 7;
M5_NUT_ROTATE = 180;

//M3_NUT_WIDTH = 5.5;
M3_NUT_DIA = 6.01;
M3_NUT_HEIGHT = 2.4;
M3_HEAD_DIA = 6.5;
M3_HOLE_DIA = 3.8;
M3_TAP_DIA = 2.8;

// length without head
M3_LENGTH = M3_THREAD_LENGTH; 



BOTTOM_HEIGHT = SHAFT_LENGTH + 3;
TOP_HEIGHT = OUTER_HEIGHT - BOTTOM_HEIGHT;
PRESS_FIT_DIA = OUTER_DIA/6;
PRESS_FIT_HEIGHT = TOP_HEIGHT*0.75;

CLEARANCE = 0.04;

BOTTOM_COLOR = "green";
TOP_COLOR = "yellow";
SHAFT_COLOR = "gray";

echo("OUTER_DIA:", OUTER_DIA);

module shaft() {
  
  OFFSET = SHAFT_SMALL_WIDTH - (SHAFT_DIA/2);
  difference() {
   translate([0,0,SHAFT_TOTAL_LENGTH/2- (SHAFT_TOTAL_LENGTH - SHAFT_LENGTH)])
    cylinder(h=SHAFT_TOTAL_LENGTH, d=SHAFT_DIA, center=true);
  
  translate([OFFSET, -SHAFT_DIA/2, 0])
    cube([SHAFT_DIA, SHAFT_DIA, SHAFT_LENGTH+1]);
  }
}


module m5nut() {
  difference() {
    cylinder(h=M5_NUT_HEIGHT * (1+CLEARANCE), d=M5_NUT_DIA * (1+CLEARANCE), $fn=6, center=true);
    //cylinder(h=3*M5_NUT_HEIGHT, d=M5_NUT_HOLE, center=true);
  }

  
}

module m3nut_slot(h = 5*M3_NUT_HEIGHT) {

  module m3nut() {
    rotate([90,0,0])
     cylinder(h=M3_NUT_HEIGHT * (1+CLEARANCE), d=M3_NUT_DIA * (1+CLEARANCE), $fn=6, center=true);
  }
  
  hull() {
    translate([0,0,h]) m3nut();
    m3nut();
  }      
  
}




function sinr(x) = sin(180 * x / PI);
function cosr(x) = cos(180 * x / PI);

module m5nuts()
{
  
  n = M5_NUT_COUNT;
  dia = OUTER_DIA/1.5;
  r = dia/2;
  
  delta = (2*PI)/n;
  rotate([0,0,M5_NUT_ROTATE])
    for (step = [0:n-1]) {
      translate([r * cosr(step*delta), r * sinr(step*delta), 0])
        m5nut(); 
    }
  
}

module m3mounts(h=3*OUTER_HEIGHT, d=M3_HOLE_DIA) {
  
  n = M5_NUT_COUNT;
  dia = OUTER_DIA/1.5;
  r = dia/2;
  
  delta = (2*PI)/n;
  rotate([0,0,M5_NUT_ROTATE])
    for (step = [0:n-1]) {
      translate([r * cosr(step*delta), r * sinr(step*delta), 0])
        cylinder(h=h, d=d, center=true); 
    }
  
  
}

//!m3mounts();

module pin(d, h, t=0, $fn=$fn)
{
  base = h-t;
  translate([0,0,(base/2) - h/2])
   hull()
   {
      color("red",0.5)cylinder(d=d, h=base, center=true);
      translate([0,0,base/2 + t/2])
        color("blue", 0.5) cylinder(d=d/2, h=t, center=true);
    }
  
}

module bottom() {
    
  CLR = 1+CLEARANCE;
  
  difference() {
    hull() {
      translate([0,0,0.1*BOTTOM_HEIGHT]) cylinder(d=OUTER_DIA, h=0.9*BOTTOM_HEIGHT);
      cylinder(d=OUTER_DIA*0.97, h=0.1*BOTTOM_HEIGHT);
    }
      
    scale([CLR, CLR, CLR])shaft();
    translate([0,0,(-M5_NUT_HEIGHT/2) + SHAFT_LENGTH + 3.1]) scale([CLR, CLR, CLR]) m5nuts();
    m3mounts();
  
  
    union() {
      translate([OUTER_DIA/2,0,SHAFT_LENGTH/2])
        rotate([0, 90,0])
          cylinder(d=M3_HOLE_DIA, h= OUTER_DIA, center=true);
      translate([OUTER_DIA/2 + M3_LENGTH + (SHAFT_DIA/3), 0, SHAFT_LENGTH/2])  
        rotate([0,90,0])
          cylinder(d=M3_HEAD_DIA, h = OUTER_DIA, center=true);
    
    }
    
    translate([SHAFT_DIA/2 + M3_LENGTH/3,0,SHAFT_LENGTH/2])
    rotate([0,0,90])
      m3nut_slot(2*OUTER_HEIGHT);
  
  }
  
  module press_fit() {
    h = PRESS_FIT_HEIGHT * (1-CLEARANCE);
    d = PRESS_FIT_DIA * (1-CLEARANCE);
    
    translate([0,0,BOTTOM_HEIGHT - 0.01 + (h/2)])
    pin(d=d, h=h, t=0.15*h, $fn=6);
  }
  hull() {
  translate([0,PRESS_FIT_DIA/2,0]) press_fit();
  translate([0,-PRESS_FIT_DIA/2,0]) press_fit();
  }
  

  
}


module press_fit_slot() {
  hull() {   
      translate([0,PRESS_FIT_DIA/2,-0.01]) cylinder(d=PRESS_FIT_DIA, h=PRESS_FIT_HEIGHT*(1+CLEARANCE));
      translate([0,-PRESS_FIT_DIA/2,-0.01]) cylinder(d=PRESS_FIT_DIA, h=PRESS_FIT_HEIGHT*(1+CLEARANCE));
    
    //wider base
    translate([0,(PRESS_FIT_DIA*1.1)/2,-0.01]) cylinder(d=PRESS_FIT_DIA, h=0.1);
    translate([0,-(PRESS_FIT_DIA*1.1)/2,-0.01]) cylinder(d=PRESS_FIT_DIA, h=0.1);
    
  }
  
  
}

//!press_fit_slot();

module top() {

  
  translate([0,0,BOTTOM_HEIGHT*1.5])
    difference() {
      
       hull() {
         cylinder(d=OUTER_DIA, h=TOP_HEIGHT*0.8);
         cylinder(d=OUTER_DIA*0.9, h=TOP_HEIGHT);
      }
      
     press_fit_slot();
      
     translate([0,0,(TOP_HEIGHT*0.8)/2 - 0.01]) m3mounts(h=TOP_HEIGHT*0.8, d=M3_TAP_DIA);
      
    }
  
}  


if ("test" == BUILD_TYPE) {
  H = 1.5*M5_NUT_HEIGHT;
  difference() {
    translate([0,0,-H/2 + (M5_NUT_HEIGHT/2) - 0.1])
      cylinder(d=2*M5_NUT_DIA, h=H, center=true);
    m5nut();
  }
  
  translate([1.8*M5_NUT_DIA,0,0]) difference() {
    translate([0,0,-H/2 + (M5_NUT_HEIGHT/2) - 0.1])
      cylinder(d=2*M5_NUT_DIA, h=H, center=true);
    translate([0,M5_NUT_DIA,0])rotate([0, 90,90])
          cylinder(d=M3_HOLE_DIA, h= 2*M5_NUT_DIA, center=true);
    translate([0,0,-M3_NUT_HEIGHT/2]) m3nut_slot(2*H);
  }
  
  
} else if ("bottom" == BUILD_TYPE) {
  color(BOTTOM_COLOR, 0.8) bottom();
  %top();
  %shaft();
} else if ("top" == BUILD_TYPE) {
  %bottom();
  color(TOP_COLOR, 0.8) top();
  %shaft();
  
} else {
  color(BOTTOM_COLOR, 0.6) bottom();
  color(TOP_COLOR, 0.6) top();
  color(SHAFT_COLOR, 0.6) shaft();
  
}


