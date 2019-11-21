baseWidth = 25;
baseDepth = 18;
baseHeight = 4.05;

cutoutWidth = 21.5;
cutoutDepthOffset = 2;
cutoutHeight = 5;

tabR = 5;
tabOut = 2;

thumbDent = 7;
thumbDentOffset = 9.5;

$fn=50;

difference () {
  union () {
  // outside
    cube([baseWidth,baseDepth,baseHeight], 0);
  // tab
    translate([baseWidth/2,tabOut,0])
    difference() {
      cylinder(h=baseHeight, r=tabR);
      translate([0, 0, thumbDentOffset]) sphere(r=thumbDent);
    }
  };

  // cut
  translate([(baseWidth-cutoutWidth)/2, cutoutDepthOffset, 0]) 
    cube([cutoutWidth,baseDepth,cutoutHeight], -1);

};
 