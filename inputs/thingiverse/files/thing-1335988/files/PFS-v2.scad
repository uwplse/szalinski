//	   Customizable slingshot model
//		    Steven Veltema
//		    January 20, 2016
//

/* [HANDLE] */
DEPTH     = 20; // [15:1:30]
CORNER_RADIUS = 6; //[1:.5:6]

//handle shape, round or square
ROUND_HANDLE = "true"; // [true,false]
HANDLE_LENGTH = 35; // [20:5:50]
//sq top and fork lower width
HANDLE_TOP_WIDTH = 30; //[10:2:50]
//sq bottom and round handle diameter
HANDLE_BOTTOM_WIDTH = 50; //[40:2:70]

//set to zero for no hole
LANYARD_HOLE_RADIUS = 6; //[0:1:10]
LANYARD_HOLE_ROUNDING = 6; //[1:1:10]

/* [FORKS] */
FORKS_LENGTH = 65; // [50:5:100]
FORKS_OUTER_WIDTH = 60; // [40:1:80]
FORK_GAP = 15; // [10:1:40]

//band groove size
GROOVE_DEPTH = 2; //[0:.5:5]
GROOVE_WIDTH = 5; //[0:.5:10]

module fork_left() {
  fork_width = (FORKS_OUTER_WIDTH - FORK_GAP)/2-CORNER_RADIUS; 
  union() {
  difference() {
    hull () {
      //bottom
      translate([-(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS,0+CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([-(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS,0+CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS]) sphere(CORNER_RADIUS);

      translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS+FORKS_LENGTH/3,0+CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS+FORKS_LENGTH/3,DEPTH-CORNER_RADIUS]) sphere(CORNER_RADIUS);
     
      //top
      outer = FORKS_OUTER_WIDTH/2 - CORNER_RADIUS;
      translate([-outer,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS,CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([-outer,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS]) sphere(CORNER_RADIUS);
       
      inner = outer - fork_width + CORNER_RADIUS;
      translate([-inner,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS,CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([-inner,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS]) sphere(CORNER_RADIUS);
    }
 
    //band groove
    translate([-FORKS_OUTER_WIDTH,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS-GROOVE_WIDTH-1,DEPTH*1.25]) 
    rotate([0,90,0])
    cube([DEPTH*1.5,GROOVE_WIDTH,FORKS_OUTER_WIDTH]);    

  } 
        
  //inner core
  hull () {
    //bottom
    translate([-(HANDLE_TOP_WIDTH/2-CORNER_RADIUS-GROOVE_DEPTH),HANDLE_LENGTH-CORNER_RADIUS,0+CORNER_RADIUS+GROOVE_DEPTH]) sphere(CORNER_RADIUS);
    translate([-(HANDLE_TOP_WIDTH/2-CORNER_RADIUS-GROOVE_DEPTH),HANDLE_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS-GROOVE_DEPTH]) sphere(CORNER_RADIUS);
    translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS-GROOVE_DEPTH),HANDLE_LENGTH-CORNER_RADIUS,0+CORNER_RADIUS+GROOVE_DEPTH]) sphere(CORNER_RADIUS);
    translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS-GROOVE_DEPTH),HANDLE_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS-GROOVE_DEPTH]) sphere(CORNER_RADIUS);

    translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS-GROOVE_DEPTH),HANDLE_LENGTH-CORNER_RADIUS+FORKS_LENGTH/3,0+CORNER_RADIUS+GROOVE_DEPTH]) sphere(CORNER_RADIUS);
    translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS-GROOVE_DEPTH),HANDLE_LENGTH-CORNER_RADIUS+FORKS_LENGTH/3,DEPTH-CORNER_RADIUS-GROOVE_DEPTH]) sphere(CORNER_RADIUS);
   
    //top
    outer = FORKS_OUTER_WIDTH/2 - CORNER_RADIUS-GROOVE_DEPTH;
    translate([-outer,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS,CORNER_RADIUS+GROOVE_DEPTH]) sphere(CORNER_RADIUS);
    translate([-outer,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS-GROOVE_DEPTH]) sphere(CORNER_RADIUS);
     
    inner = outer - fork_width + CORNER_RADIUS+GROOVE_DEPTH*2;
    translate([-inner,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS,CORNER_RADIUS+GROOVE_DEPTH]) sphere(CORNER_RADIUS);
    translate([-inner,HANDLE_LENGTH+FORKS_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS-GROOVE_DEPTH]) sphere(CORNER_RADIUS);
  }
}
  
  
}

module handle() {
  if (ROUND_HANDLE == "true") {
    sphere_r = HANDLE_BOTTOM_WIDTH/2.0 - CORNER_RADIUS;
    minkowski() {
      translate([0,sphere_r+CORNER_RADIUS,CORNER_RADIUS]) cylinder(r=sphere_r, h=DEPTH-2*CORNER_RADIUS);
      sphere(r=CORNER_RADIUS);
    }
  } else {
    
    hull() {
        
      //bottom
      multiple = 1;
      translate([-(HANDLE_BOTTOM_WIDTH/2-(CORNER_RADIUS*multiple)),(CORNER_RADIUS*multiple),CORNER_RADIUS*multiple]) sphere(CORNER_RADIUS*multiple);
      translate([-(HANDLE_BOTTOM_WIDTH/2-CORNER_RADIUS*multiple),(CORNER_RADIUS*multiple),DEPTH-(CORNER_RADIUS*multiple)]) sphere(CORNER_RADIUS*multiple);
      translate([(HANDLE_BOTTOM_WIDTH/2-CORNER_RADIUS*multiple),(CORNER_RADIUS*multiple),CORNER_RADIUS*multiple]) sphere(CORNER_RADIUS*multiple);
      translate([(HANDLE_BOTTOM_WIDTH/2-CORNER_RADIUS*multiple),(CORNER_RADIUS*multiple),DEPTH-(CORNER_RADIUS*multiple)]) sphere(CORNER_RADIUS*multiple);
          
      //top
      translate([-(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS,0+CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([-(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS,0+CORNER_RADIUS]) sphere(CORNER_RADIUS);
      translate([(HANDLE_TOP_WIDTH/2-CORNER_RADIUS),HANDLE_LENGTH-CORNER_RADIUS,DEPTH-CORNER_RADIUS]) sphere(CORNER_RADIUS);
    
      } //hull end
    }    
}
    
  $fn=50;

  union() {
    difference() {     

      union() {   
        handle();
        union() {
          fork_left();
          mirror([1,0,0])  fork_left();
        }
      }
    
      //lanyard hole
      if (LANYARD_HOLE_RADIUS > 0) {
        if (ROUND_HANDLE == "true") {
          translate([0,HANDLE_BOTTOM_WIDTH/2,0]) cylinder(h = DEPTH, r = LANYARD_HOLE_RADIUS);
          translate([0,HANDLE_BOTTOM_WIDTH/2,0]) cylinder(h = LANYARD_HOLE_ROUNDING, r = LANYARD_HOLE_RADIUS+LANYARD_HOLE_ROUNDING);
          translate([0,HANDLE_BOTTOM_WIDTH/2,DEPTH-LANYARD_HOLE_ROUNDING]) cylinder(h = LANYARD_HOLE_ROUNDING, r = LANYARD_HOLE_RADIUS+LANYARD_HOLE_ROUNDING);
        } else {
          translate([0,HANDLE_LENGTH/2,0]) cylinder(h = DEPTH, r = LANYARD_HOLE_RADIUS);
          translate([0,HANDLE_LENGTH/2,0]) cylinder(h = LANYARD_HOLE_ROUNDING, r = LANYARD_HOLE_RADIUS+LANYARD_HOLE_ROUNDING);
          translate([0,HANDLE_LENGTH/2,DEPTH-LANYARD_HOLE_ROUNDING]) cylinder(h = LANYARD_HOLE_ROUNDING, r = LANYARD_HOLE_RADIUS+LANYARD_HOLE_ROUNDING);

        }
      }
    }
      
    if (LANYARD_HOLE_RADIUS > 0) {
      if (ROUND_HANDLE == "true") {

        //round out lanyard holes
        translate([0,HANDLE_BOTTOM_WIDTH/2,LANYARD_HOLE_ROUNDING])
        rotate_extrude(convexity = 10)
        translate([LANYARD_HOLE_RADIUS+LANYARD_HOLE_ROUNDING, 0, 0])
        circle(r=LANYARD_HOLE_ROUNDING);

        translate([0,HANDLE_BOTTOM_WIDTH/2,DEPTH-LANYARD_HOLE_ROUNDING])
        rotate_extrude(convexity = 10)
        translate([LANYARD_HOLE_RADIUS+LANYARD_HOLE_ROUNDING, 0, 0])
        circle(r=LANYARD_HOLE_ROUNDING);       
      } else {
        //round out lanyard holes
        translate([0,HANDLE_LENGTH/2,LANYARD_HOLE_ROUNDING])
        rotate_extrude(convexity = 10)
        translate([LANYARD_HOLE_RADIUS+LANYARD_HOLE_ROUNDING, 0, 0])
        circle(r=LANYARD_HOLE_ROUNDING);

        translate([0,HANDLE_LENGTH/2,DEPTH-LANYARD_HOLE_ROUNDING])
        rotate_extrude(convexity = 10)
        translate([LANYARD_HOLE_RADIUS+LANYARD_HOLE_ROUNDING, 0, 0])
        circle(r=LANYARD_HOLE_ROUNDING);        
      }
                           
    }
  }
