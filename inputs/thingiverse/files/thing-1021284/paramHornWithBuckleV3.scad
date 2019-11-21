//	   Customizable Horn with TAB and constant wall thickness
//		    Steven Veltema
//		    September 18, 2015
//
//      With inspiration from:
//	    Customizable Horn - Steve Medwin
//      http://www.thingiverse.com/thing:347425
//
//      And Adafruit LED Fire Horns
//      http://www.thingiverse.com/thing:344412

//higher = smoother, larger files
HORN_FACE_NUMBER = 8; //[6:1:100]

HORN_LENGTH=100.0;// [10:5:300]
//base inner radius
HORN_INNER_RADIUS=25.0;// [10:1:100]
//constant across horn height
HORN_WALL_THICKNESS=4.0;//	[1:1:50]

HORN_TWIST_X_AXIS=0;// [-720:5:720]
HORN_TWIST_Y_AXIS=0; // [-720:5:720]
HORN_TWIST_Z_AXIS=90;// [-720:5:720]

HORN_TIP_OFFSET_X=-30.0;// [-100:5:100]
HORN_TIP_OFFSET_Y=-30.0;// [-100:5:100]
HORN_ROTATE = 0.0;// [0:5:360]

//lower = more detailed, larger files
HORN_VERT_RESOLUTION = 4.0;//[2:1:10]

BASE_HEIGHT = 10.0; // [2:1:100]

INCLUDE_TAB = "true"; // [true,false]
TAB_HEIGHT = 5; // [2:1:10]
TAB_ROTATE = 0.0;// [0:5:360]

$fn = HORN_FACE_NUMBER;

module ring(inner_rad, height){
    linear_extrude(height = height, center = false){
        difference() {
            circle(r = inner_rad+HORN_WALL_THICKNESS);
            circle(r = inner_rad);
        }
    }
}
 
module base() {
    translate([0,0,-BASE_HEIGHT+0.01])  rotate([0,0,HORN_ROTATE]) ring(HORN_INNER_RADIUS,BASE_HEIGHT);
}

module TAB() {
    shortSide = HORN_INNER_RADIUS+HORN_WALL_THICKNESS;
    longSide = shortSide*2.5;
    height          = TAB_HEIGHT;
    TABHoleDepth = TAB_HEIGHT;
    
    difference() {
       translate([-longSide/2,-shortSide/2,-BASE_HEIGHT]){
            minkowski() {
                cube(size=[longSide,shortSide,height]);
                cylinder(r=shortSide/4);
            }
         }
      
         translate([longSide-longSide/2-TABHoleDepth,-shortSide/2,-height-BASE_HEIGHT]) cube(size=[TABHoleDepth,shortSide,height*4]);
         translate([-longSide/2,-shortSide/2,-height-BASE_HEIGHT]) cube(size=[TABHoleDepth,shortSide,height*4]);
        
        rotate([0,180,0]) translate(0,0,-height) cylinder(h=height*3,r=HORN_INNER_RADIUS);
    }
}

module horn()
{
    fn=floor(HORN_LENGTH/HORN_VERT_RESOLUTION);
        
    twistX = HORN_TWIST_X_AXIS/fn;
    twistY = HORN_TWIST_Y_AXIS/fn;
    twistZ = HORN_TWIST_Z_AXIS/fn;
    
    offsetX = HORN_TIP_OFFSET_X/fn;
    offsetY = HORN_TIP_OFFSET_Y/fn;
    offsetZ = HORN_LENGTH/fn;
    
    rotate([0,0,HORN_ROTATE]) {    
       difference() {
           //outershell
            for (i=[0:fn-1]) {                
                hull() { 
                    rotate([twistX*i,twistY*i,twistZ*i])
                        translate([offsetX*i,offsetY*i,offsetZ*i])
                            linear_extrude(height = 0.1, center = true, convexity = 10, twist = 0)
                                circle(HORN_INNER_RADIUS+HORN_WALL_THICKNESS-(i*(HORN_INNER_RADIUS)/fn));
          
                    rotate([twistX*(i+1),twistY*(i+1),twistZ*(i+1)])
                        translate([offsetX*(i+1),offsetY*(i+1),offsetZ*(i+1)])
                            linear_extrude(height = 0.1, center = true, convexity = 10, twist = 0)
                                circle(HORN_INNER_RADIUS+HORN_WALL_THICKNESS-((i+1)*(HORN_INNER_RADIUS)/fn));                   
                 }
            }
           //innershell
             for (i=[0:fn-1]) {                
                hull() { 
                    lowerOffsetZ = offsetZ*i;
                    if (i==0) {lowerOffsetZ = lowerOffsetZ - 0.1;} //make sure base hole is properly removed
                    rotate([twistX*i,twistY*i,twistZ*i])
                        translate([offsetX*i,offsetY*i,lowerOffsetZ])
                            linear_extrude(height = 0.1, center = true, convexity = 10, twist = 0)
                                circle(HORN_INNER_RADIUS-(i*(HORN_INNER_RADIUS)/fn));
          
                    rotate([twistX*(i+1),twistY*(i+1),twistZ*(i+1)])
                        translate([offsetX*(i+1),offsetY*(i+1),offsetZ*(i+1)])
                            linear_extrude(height = 0.1, center = true, convexity = 10, twist = 0)
                                circle(HORN_INNER_RADIUS-((i+1)*(HORN_INNER_RADIUS)/fn));

                }
            }
        } //diff
    } //rotate
}

union() {
    horn();
    base();
    if (INCLUDE_TAB != "false") {
        rotate([0,0,TAB_ROTATE]) TAB();
    }
}

