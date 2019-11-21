
// length of frame clamp
frameClampLength = 70;

// distance between printer frame and filament guide
guideDistance = 80;

// frame thickness
frameThickness = 6;

// height of frame clamp
frameClampHeight = 30;

// width of frame clamp 
frameClampWidth = 20;

// width of clamp
clampWidth = 10;

// width of guide
guideWidth = 10;

// height of guide
guideHeight = 50;

// thickness of guide
guideThickness = 10;

// quality
$fn = 50;

module clamp() {
  translate ([frameClampLength/2,0,clampWidth])
  rotate ([270,0,90])
  linear_extrude (height=frameClampLength)
  polygon (points=[[-frameThickness/2, 0], [frameThickness/2,0], [frameThickness/2, -frameClampWidth], [frameThickness/2+1, -frameClampWidth], [frameThickness/2+frameClampHeight/2, clampWidth], [-frameThickness/2-frameClampHeight/2, clampWidth], [-frameThickness/2-1, -frameClampWidth], [-frameThickness/2, -frameClampWidth]]);  
  
}

module guideHolder() {
  translate ([0,frameClampHeight/2,guideThickness/2-0.53])
  rotate ([270,0,0])
  linear_extrude (height=guideDistance)
  circle (d=guideThickness, $fn=6);
  /*
  translate ([0,frameClampHeight/2+guideDistance/2,guideThickness/2])
  cube ([10, guideDistance, guideThickness],center=true);*/
}

module guide() {
  linear_extrude (height=guideThickness)
  difference() {
    hull() {
      translate ([-guideHeight/2,0]) circle (d=guideWidth+guideThickness);
      translate ([guideHeight/2,0]) circle (d=guideWidth+guideThickness);
    }
    hull() {
      translate ([-guideHeight/2,0]) circle (d=guideWidth);
      translate ([guideHeight/2,0]) circle (d=guideWidth);      
    }
  }
}

module filamentGuide() {
  union() {
    translate ([0,frameClampHeight/2+guideDistance+guideWidth/2,0]) guide();
    clamp();
    guideHolder();
  }
}

filamentGuide();
