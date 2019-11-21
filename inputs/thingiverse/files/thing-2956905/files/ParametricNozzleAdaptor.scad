 /* 
 Parametric Nozzle/Hose Adaptor 
 
    My wife was having trouble dring out the tube on her CPAP machine after a cleaning. 
    She was holding her hair dryer against the end of the hose because most of the air 
    was not making its way into the tube, so I decided to make one of these.
    
    The original model was just hand designed in a 3d modeling tool, which I quickly
    realized would only work for people who had exactly the same hairdryer and hose.
    
    This lead to the decision to make a parametric version. This design is set up for
    attachment to the outside of a source which plugs in to the inside of something else.
    
    If you need to, for some reason, attach it the other way around, you'll need to do
    some quick math around the diameters and the widths, but note: the optional slots 
    are only set up to be on the "source" side of the adaptor.
    
    About those slots... just a heads up, the slot goes all of the way through the
    adaptor, so there's no difference between one slot or two, because they're just
    overlapping. Similarly, 2 or 4 slots... 3 or 6... 10 or 20... etc.
 
 */
 
 // PARAMETERS START HERE ------------------------------------- //
 
 wallThickness = 3;

 // radius of source tube 
 
 sourceRadius = 20.5;
 sourceLength = 20;

 // attributes of the transition segment.  Longer transitions may make for better airflow?
 
 transitionLength = 30;
 
 // radius of output tube
 outputRadius = 12;
 outputLength = 20;

 // it might be helpful to have slots in the adaptor base.
 numSlots = 3;
 slotWidth = 4;
 slotHeight = 10;

// END OF PARAMETERS ------------------------------------- // 
 
 
difference() {

//rotate the shape around the z-axis

rotate_extrude(angle = 360,  $fn = 100) {

// 2d slice of the shape
polygon([
[sourceRadius,0],[sourceRadius+wallThickness,0],[sourceRadius+wallThickness,sourceLength],
[outputRadius,transitionLength+sourceLength],[outputRadius,transitionLength+sourceLength+outputLength],
[outputRadius-wallThickness,transitionLength+sourceLength+outputLength],
[outputRadius - wallThickness, transitionLength+sourceLength],[sourceRadius,sourceLength]
]);

}
// do subtractions

// numDegrees per slot
currentRotation = 0;
degreesPerSlot = (360/numSlots);

for (a =[0:degreesPerSlot:360]) {
    echo(a);
translate ([0,0,slotHeight/2-1]) {
  rotate([0,0,a]) {
     cube([slotWidth,(sourceRadius*2+10),slotHeight], center=true); } }

translate ([0,0,slotHeight-1]) {
  rotate([90,0,a]) {
     cylinder(h=sourceRadius*2+10, r=slotWidth/2, center=true, $fn = 20); } }

 currentRotation = currentRotation+degreesPerSlot;

 }
}



