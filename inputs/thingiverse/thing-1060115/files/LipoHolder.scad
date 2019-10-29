//	   Customizable lipo battery holder
//		    Steven Veltema
//		    October 8, 2015
//
//      Adapted from the Adafruit 500mAh Lipo Pocket
//      http://www.thingiverse.com/thing:1018762

//reduce by amount to stick up past sleeve
LIPO_HEIGHT     = 40; // [10:1:200]
LIPO_WIDTH      = 31; // [10:1:200]
LIPO_THICKNESS  = 6;  // [3:1:50]
WALL_THICKNESS  = 2;  // [1:.5:4]
//increase lipo size in all directions for print tuning
AFFORDANCE      = 0.5;  // [0:0.5:3]
//add holders, file down to match battery size
USE_HOLDOWNS = "false"; // [true,false]

module shell() {
   difference() {
       difference() {
            //rounded outer frame
           hull() {
                sphere(d=WALL_THICKNESS);
                translate([LIPO_WIDTH+WALL_THICKNESS*2+AFFORDANCE,0,0]) sphere(d=WALL_THICKNESS);
                translate([0, LIPO_THICKNESS+WALL_THICKNESS*2+AFFORDANCE,0]) sphere(d=WALL_THICKNESS);
                translate([0,0,LIPO_HEIGHT+WALL_THICKNESS+AFFORDANCE]) sphere(d=WALL_THICKNESS);
                translate([LIPO_WIDTH+WALL_THICKNESS*2+AFFORDANCE,
                    LIPO_THICKNESS+WALL_THICKNESS*2+AFFORDANCE,
                    LIPO_HEIGHT+WALL_THICKNESS+AFFORDANCE]) sphere(d=WALL_THICKNESS);
                translate([0,LIPO_THICKNESS+WALL_THICKNESS*2+AFFORDANCE,
                    LIPO_HEIGHT+WALL_THICKNESS+AFFORDANCE]) sphere(d=WALL_THICKNESS);
                translate([LIPO_WIDTH+WALL_THICKNESS*2+AFFORDANCE,0,
                    LIPO_HEIGHT+WALL_THICKNESS+AFFORDANCE]) sphere(d=WALL_THICKNESS);
                translate([LIPO_WIDTH+WALL_THICKNESS*2+AFFORDANCE,
                    LIPO_THICKNESS+WALL_THICKNESS*2+AFFORDANCE,0]) sphere(d=WALL_THICKNESS);
           }
                
            //inner
            translate([WALL_THICKNESS,WALL_THICKNESS,WALL_THICKNESS])
                cube([LIPO_WIDTH+AFFORDANCE,
                    LIPO_THICKNESS+AFFORDANCE,
                    LIPO_HEIGHT+AFFORDANCE+10]);
       }
       
       //bottom vent
       translate([WALL_THICKNESS+AFFORDANCE*.5+LIPO_WIDTH*.25,
            WALL_THICKNESS+AFFORDANCE*.5+LIPO_THICKNESS*.25,
            -WALL_THICKNESS]) 
            cube([LIPO_WIDTH*.5,LIPO_THICKNESS*.5,WALL_THICKNESS*3]);
       
       //upper holder hole
      translate([(LIPO_WIDTH+WALL_THICKNESS*2+AFFORDANCE)/2,
            LIPO_THICKNESS+WALL_THICKNESS*2+AFFORDANCE+5,
            LIPO_HEIGHT+WALL_THICKNESS+AFFORDANCE+(LIPO_WIDTH-WALL_THICKNESS)*.1]) //slight offset to make edge softer
            rotate([90,0,0]) 
                cylinder(h=LIPO_THICKNESS+WALL_THICKNESS*2+AFFORDANCE+10,d=(LIPO_WIDTH-WALL_THICKNESS)*.6);
       
       //attach holes
       hole_size = WALL_THICKNESS > 2 ? WALL_THICKNESS : 2;
       
       translate([WALL_THICKNESS*2+AFFORDANCE,
            WALL_THICKNESS+AFFORDANCE,
            hole_size*2+AFFORDANCE])  
            attachHoles();
       
       translate([LIPO_WIDTH,
            WALL_THICKNESS+AFFORDANCE,
            hole_size*2+AFFORDANCE])  
            attachHoles();

       translate([WALL_THICKNESS*2+AFFORDANCE,
            WALL_THICKNESS+AFFORDANCE,
            LIPO_HEIGHT-(hole_size*3)])  
            attachHoles();

        translate([LIPO_WIDTH,
            WALL_THICKNESS+AFFORDANCE,
            LIPO_HEIGHT-(hole_size*3)])  
            attachHoles();
    }

 
}

module attachHoles() {
    //attachement holes
    hole_size = WALL_THICKNESS > 2 ? WALL_THICKNESS : 2;

    echo("WALL_THICKNESS:",WALL_THICKNESS);
    echo("hole_size:",hole_size);
    
    rotate([90,0,0]) cylinder(h=hole_size+AFFORDANCE+2,d=hole_size);
    translate([0,0,hole_size*2]) rotate([90,0,0]) cylinder(h=hole_size+AFFORDANCE+2,d=hole_size);
}

module holderBalls() {
   //add holder balls
    translate([(LIPO_WIDTH+WALL_THICKNESS*2+AFFORDANCE)*.5,
        WALL_THICKNESS/2.0+AFFORDANCE,
        (LIPO_HEIGHT+WALL_THICKNESS+AFFORDANCE)*.5])  sphere(d=WALL_THICKNESS*1.2);

  //add holder balls
    translate([(LIPO_WIDTH+WALL_THICKNESS*2+AFFORDANCE)*.5,
        3*WALL_THICKNESS/2.0+LIPO_THICKNESS,
        (LIPO_HEIGHT+WALL_THICKNESS+AFFORDANCE)*.5])  sphere(d=WALL_THICKNESS*1.2);
}

$fn=50;

union() {
shell();
if (USE_HOLDOWNS != "false") {
    holderBalls();
}
}
