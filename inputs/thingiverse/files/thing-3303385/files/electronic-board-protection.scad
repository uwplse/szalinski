/*
Electronic board bottom protection
(C) Pierre Delore
12/2018
*/

// Board length in mm
length=20;
// Board width in mm
width=20;
// XY clearance in mm (clearance between the board and the part)
xy_clearance=0.3;
// Clearance under the board in mm (higher than the pins height)
board_clearance=2;
// Clearance over the board in mm (space between the top of the board and the top of the part
top_clearance=0.5;
// Board tickness in mm
board_tick = 1.4; //Board tickness in mm
// Support in the center
pad_in_center = "yes"; //[yes,no]

/* [Hidden */
//-- internal --------------------------------------------------


$fn=64;
ep=0.01;
ep2=0.02;
tick=4; //Tickness in mm
tick_h=2;
heigth=tick_h+board_clearance+board_tick+top_clearance; //box heigth in mm
length_c=length+xy_clearance;
width_c=width+xy_clearance;
l=length_c+tick*2;
w=width_c+tick*2;



//---------------------------------------------------------------
module roundbox(wx, wy, wz, radius) {
	hull() {
		translate([radius, radius, 0])
			cylinder(r=radius, h=wz);

		translate([wx-radius, radius, 0])
			cylinder(r=radius, h=wz);

		translate([radius, wy-radius,0])
			cylinder(r=radius,h=wz);

		translate([wx-radius,wy-radius,0])
			cylinder(r=radius,h=wz);
	}
}

//---------------------------------------------------------------
module board() {
  union() {
    difference() {
      union() {
        //-- External box
        roundbox(l,w,heigth,2);
      }
      //Internal box
      translate([tick, tick, tick_h])
        cube([length_c, width_c, heigth]);
      
      //-- Length slots 
      nl=floor(length_c/4);
      for(x=[0:nl-1]) {
        translate([2+tick+x*4, (tick-2)/2, 0.4])
          cube([2,2,heigth+ep2]);
        translate([2+tick+x*4, w-tick+(tick-2)/2, 0.4])
          cube([2,2,heigth+ep2]);
      }

      //-- Width slots
      nw=floor(width_c/4);
      for(y=[0:nw-1]) {
        translate([(tick-2)/2, 2+tick+y*4, 0.4])
          cube([2,2,heigth+ep2]);
        
        translate([l-tick+(tick-2)/2, 2+tick+y*4, 0.4])
          cube([2,2,heigth+ep2]);
      }
    }
    //Pads
    translate([tick, tick, tick_h])
      cube([2,2,board_clearance]);
    
    translate([l-tick-2, tick, tick_h])
      cube([2,2,board_clearance]);

    translate([tick, w-tick-2, tick_h])
      cube([2,2,board_clearance]);
    
    translate([l-tick-2, w-tick-2, tick_h])
      cube([2,2,board_clearance]);
    
    if (pad_in_center=="yes")
      translate([(l-2)/2, (w-2)/2, tick_h])
        cube([2,2,board_clearance]);      
  }
}


//---------------------------------------------------------------
module locker() {
  cube([1.8, 1.8*3, 1.8]);
  
  translate([0, 1.8*3, 0])
    cube([1.8*3,1.8,1.8]);
}


module 4lockers() {
  translate([3, 3*1.8, 0])
    cube([5,1.8,0.2]);
  translate([3, -4*1.8-0.5, 0])
    cube([5,1.8,0.2]);
  translate([0, -3, 0])
    cube([1.8, 5, 0.2]);
  translate([1.8*5+0.5, -3, 0])
    cube([1.8, 5, 0.2]);
  
  locker();
  rotate([0,180,0])
    translate([-(1.8*6)-0.5,0,-1.8])
      locker();
  rotate([180,0,0])
    translate([0,0.5,-1.8])
      locker();
  rotate([180,180,0])
      translate([-(1.8*6)-0.5,0.5,0])
        locker();
}

module ULocker() {
  cube([1.8, 1.8*2, 1.8]);

  translate([4+0.2,0,0])
    cube([1.8, 1.8*2, 1.8]);
  
  translate([0, 1.8*2, 0])
    cube([6,1.8,1.8]);  
}

module 2ULockers() {
  ULocker();
  
  translate([0,-0.5,1.8])
    rotate([180,0,0])
      ULocker();
  
  translate([0, -3, 0])
    cube([1.8, 5, 0.2]);
  translate([4.2, -3, 0])
    cube([1.8, 5, 0.2]);

}

// Go!
board();
