// r = outer radius of the spacer
// h = height of the spacer
// borderHeight and borderGap are used for the small border that prevents the spool from dropping of the spacer
// using thick spools, it might be possible to inset the spool rod to avoid a collision with the print table
module spacer(r=53/2,h=75, borderHeight=2, borderGap=2, spoolRodInset=0) {
// radius of the hole for the spool rod
innerRad  = 10;
// thickness of the inner wall between spool rod an spokes  
innerWall = 3;
// thickness of the outer wall between spokes and outer radius
outerWall = 3;
// number of segments 
numSegments = 12;  
// Spoke width 
spokeInner = 3;
spokeOuter = 4;
  
  uOut = 2*(r-outerWall)*PI;
  uIn =  2*(innerRad)*PI;
  innerLen = (uIn - numSegments * spokeInner) / numSegments;
  outerLen = (uOut - numSegments * spokeOuter) / numSegments; 
  height = r-innerRad-outerWall;

  p = [[(outerLen-innerLen)/2,0],[(outerLen-innerLen)/2+innerLen,0],[outerLen,height],[0,height]];
  echo(p);

  difference(){
    union() {
     translate([0,0,borderHeight])cylinder(r=r, h=h);
     cylinder(r=(r+borderGap),h=borderHeight);
    }

    union() { 
      cylinder(r=r-outerWall+1,h=spoolRodInset);
      cylinder(r=innerRad,h=h+borderHeight);
      intersection(){
          cylinder(r=r-outerWall,h=h+borderHeight);
        difference(){
        for(i=[0:numSegments-1])
          rotate([0,0,(360/numSegments)*i])
            translate([-(outerLen/2),innerRad,0])
              linear_extrude(h=h)
                polygon(points=p);
          cylinder(r=innerRad+innerWall,h=h+borderHeight);
        }
      }
    }
  }
}


$fn=180;
spacer();