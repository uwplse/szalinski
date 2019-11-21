// - Half of the width of the inside of the cup (mm)
cupRadius=45; // [1:999]
// - Dpeth of the inside (mm)
cupDepth=55; // [1:999]
// - The width of the arm of the couch (mm)
handleDepth=60; //[1:999]
// - How thick to make the cup holder wall (mm)
wallThickness=5; // [.01:999]
// - How thick to make the handle wall (mm)
handleThickness=5; // [.01:999]
// - How long to make the clip (mm)
clipLength=35; // [1:999]
// - The angle of the clip (mm)
clipAngle=5; // [1:89]
// - How tall the text should be (mm)
textSize = 10;
// - The message to display on the handle
message = "HIS";
/* [Hidden] */
$fn=100;
support_radius = handleThickness/4;
textThickness=5;

module inner_cup() {
  translate([0, 0, wallThickness]) {
      // plus one for preview
      cylinder(cupDepth +  1, cupRadius, cupRadius);
  }
}

module cup_holder() {
  difference() {
    outer_cupDepth=cupDepth + wallThickness;
    outer_cupRadius=cupRadius + wallThickness;
    cylinder(outer_cupDepth, outer_cupRadius, outer_cupRadius);

    inner_cup();
  }
}

module handle() {
    difference(){
        union(){
            difference() {
              translate([-cupRadius/4, 0, cupDepth]) {
                difference(){
                    cube([cupRadius/2, handleDepth + cupRadius + wallThickness, handleThickness]);

                }
              }

              inner_cup();
            }
            handle_cup_support();
            handle_clip_support();
        }
        
        translate([textSize/2,
                    cupRadius+wallThickness+handleDepth/4,
                    cupDepth+handleThickness/2])
        {
            rotate([0,0,90]){
                linear_extrude(textThickness){text(message,size=textSize);}
            }
        }        
    }
}

module clip() {
  translate([-cupRadius/4, handleDepth + cupRadius + wallThickness, cupDepth]) {
    rotate([- clipAngle - 180 , 0, 0]) {
      cube([cupRadius/2, handleThickness, clipLength]);
    }
  }
}

module handle_cup_support(){
    translate([-cupRadius/4, cupRadius+wallThickness-support_radius/2, cupDepth]) {      
        rotate([0,90,0]){
            cylinder(h=cupRadius/2,r=support_radius);
        }
    }
}

module handle_clip_support(){
    translate([0,handleDepth-handleThickness+support_radius/2,0]){
        handle_cup_support();   
    }
}

union() {
  cup_holder();
  handle();
  clip();
}
