height = 30;
wireDiameter = 5;
// Mean coil diameter (diameter that center of wire goes through.  Actual outer diameter will be larger by wireDiameter/2)
coilDiameter = 10;
turns = 3;
// How many vertices in the wire's calculated end section
endSectionDetail = 100;
// How vertical slices per turn, for linear extrude operation
slicesPerTurn = 100;

HelicalCoil(height, wireDiameter, coilDiameter, turns, slicesPerTurn, endSectionDetail);


module HelicalCoil(height, wireDiameter, coilDiameter, turns, slicesPerTurn, endSectionDetail) {
  spacing = height / turns;
  r1 = coilDiameter / 2;
  r2 = wireDiameter / 2;
  pitchAngle = atan( spacing / (2 * PI * r1));
  //difference() { // verify that cross section at z=0 is more or less a circle
    //translate([0,0,-spacing]) 
    linear_extrude(height=height, twist=360*turns, slices=slicesPerTurn*turns)
      HelicalCoilEndSection(r1, r2, height, spacing, endSectionDetail);
    //rotate([-pitchAngle, 0, 0]) translate([0,height/2, 0]) cube(size=height, center=true);
  //}
}

module HelicalCoilEndSection(r1, r2, length, spacing, detail) {
  dt = 360 / detail;
   
  // generate a circle from trapezoidal sections
  // x is offset by r1, the coil radius
  /*
  for(t = [-90: dt : 90]) {
    polygon(points = [ 
      [r1 + r2 * cos(t), r2 * sin(t)], 
      [r1 + r2 * cos(t + dt), r2 * sin(t + dt)], 
      [r1 - r2 * cos(t + dt), r2 * sin(t + dt)], 
      [r1 - r2 * cos(t), r2 * sin(t)], 
    ]); 
  } 
  */
  
  // modify the above to generate an ellipse 
  // this represents the cross section of a straight wire angled through the plane
  pitchAngle = atan( spacing / (2 * PI * r1));
  scaleY = 1 / sin(pitchAngle); // scale y to get angled cross section
  /*
  for(t = [-90: dt : 90]) {
    polygon(points = [ 
      [r1 + r2 * cos(t), scaleY * r2 * sin(t)], 
      [r1 + r2 * cos(t + dt), scaleY * r2 * sin(t + dt)], 
      [r1 - r2 * cos(t + dt), scaleY * r2 * sin(t + dt)], 
      [r1 - r2 * cos(t), scaleY * r2 * sin(t)], 
    ]); 
  } 
  */
  
  
  // using the above parametric equation for cross section of angled wire:
  // x1 = r1 + r2 * cos(t)
  // y1 = scaleY * r2 * sin(t)
  // now need to wrap this function around a circle.  
  //   -interpret y1 as arc length as it is wrapped around the larger circle, convert to angle degrees
  //      angle = 360 * y1 / (2 * PI * r1)  => 360 * (scaleY * r2 * sin(t)) / (2 * PI * r1)
  //   -simplify out the constants so that   angle = c * sin(t)
  c = 360 * scaleY * r2 / (2 * PI * r1);
  //   -interpret x1 as the radius in new circle calculation
  // xWrapped = x1 * cos(angle) => (r1 + r2 * cos(t)) * cos(c * sin(t))
  // yWrapped = x1 * sin(angle) => (r1 + r2 * cos(t)) * sin(c * sin(t))
  // now plug these xWrapped and yWrapped equations into the loop
  ///*
  for(t = [-90: dt : 90]) {
    polygon(points = [ 
      [(r1 + r2 * cos(t)) * cos(c * sin(t)), (r1 + r2 * cos(t)) * sin(c * sin(t))], 
      [(r1 + r2 * cos(t + dt)) * cos(c * sin(t + dt)), (r1 + r2 * cos(t + dt)) * sin(c * sin(t + dt))],
      [(r1 - r2 * cos(t + dt)) * cos(c * sin(t + dt)), (r1 - r2 * cos(t + dt)) * sin(c * sin(t + dt))],
      [(r1 - r2 * cos(t)) * cos(c * sin(t)), (r1 - r2 * cos(t)) * sin(c * sin(t))] 
    ]); 
  }
  //*/
  
}