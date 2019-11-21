widgetWidth = 20; // [15:40]
widgetThickness = 20; // [15:50]
widgetHeight = 50; // [40:70]
stepSize = 3; // [2:5]

module theL(theWidth, theThickness, theHeight, theStep) {
  cylinder(h=theWidth, r=theThickness/2, center=true);
  translate(v=[0, 80, 0]) cube(size=[theThickness, 160, theWidth], center=true);  // long side
  translate(v=[60, 0, 0]) cube(size=[120, theThickness, theWidth], center=true);   // short side

  for (i = [1:55]) {
    translate(v=[-1*theThickness/2, i*theStep*1.2+1, 0]) cylinder(h=theWidth, r=theStep/2, center=true);
  }

  for (i = [1:5]) {
    translate(v=[i*theWidth/3, -1*theThickness/2, -1*theWidth/3]) sphere(r = theWidth/8);
    translate(v=[i*theWidth/3, -1*theThickness/2, 0]) sphere(r = theWidth/8);
    translate(v=[i*theWidth/3, -1*theThickness/2, 1*theWidth/3]) sphere(r = theWidth/8);
  }
}

 
difference() {
  translate(v=[widgetThickness/2-widgetHeight, -0.5*widgetThickness, 0]) rotate([0, 0, -30]) theL(widgetWidth, widgetThickness, widgetHeight, stepSize);
  translate(v=[200, 50, 0]) cube(size=[400, 800, 100], center=true);
}


// preview[view:south west, tilt:top diagonal]