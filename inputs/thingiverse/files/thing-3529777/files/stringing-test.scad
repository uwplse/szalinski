/* [Dimensions] */
// Cylinder diameter
diameter = 4;
// Cylinder height
height = 20;
// Distance betwen the two cylinders
separation = 20;
// Cylinder to edge distance
edge = 1;
// Base thickness
thickness = 1;

/* [Text] */
// Retraction settings:
//"RetractionDistance/RetractionSpeed/TravelSpeed"
settings = "2/20/200";
textSize = 3.8;
textDepth = 0.4;

/* [Hidden] */
length = separation+2*diameter+2*edge;
width = diameter+1.5*2*edge;


difference(){
  
  union(){
    
    translate([-length/2,-width/2,0])
      cube([length,width,thickness]);

    translate([-length/2+diameter/2+edge,0,thickness])
      cylinder(r=diameter/2, h=height, $fn=32);

    translate([length/2-diameter/2-edge,0,thickness])
      cylinder(r=diameter/2, h=height, $fn=32);
  
  }

  translate([0,0,thickness-textDepth])
    linear_extrude(height = textDepth+0.1)
      text(settings, size=textSize , halign="center", valign ="center");

}