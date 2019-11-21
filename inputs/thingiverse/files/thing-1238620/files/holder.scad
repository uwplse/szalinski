
// height of remote control
height=87;

// width of remote control
width=40;

// depth of remote control
depth=7.1;

// width of clamp
clampWidth=10;

// depth of clamp plate
clampDepth=3;

// notch of clamp
clampNotch=1;

// percentage of horizontal clamp position 0 to 1
clampPosition=0.3;

// quality
$fn=100;

module enforce() {
  difference() {
    cube ([clampWidth,clampWidth,clampDepth], center=true);
    translate ([-clampWidth/2,clampWidth/2,-clampDepth/2-0.05]) cylinder (d=clampWidth*2, h=clampDepth+0.1); 
  }
}

module body() {
  difference() {
    union() {
      cube ([clampWidth,height,clampDepth], center=true);
      translate ([0,(clampPosition-0.5)*height/1.5,0]) cube ([width,clampWidth,clampDepth], center=true);
      translate ([-clampWidth,(clampPosition-0.5)*height/1.5+clampWidth,0]) enforce();
      translate ([-clampWidth,(clampPosition-0.5)*height/1.5-clampWidth,0]) rotate ([180,0,0]) enforce();
      translate ([clampWidth, (clampPosition-0.5)*height/1.5+clampWidth,0]) rotate ([0,180,0]) enforce();
      translate ([clampWidth,(clampPosition-0.5)*height/1.5-clampWidth,0]) rotate ([180,180,0]) enforce();
      translate ([0,height/2+(clampDepth+clampNotch)/2,clampNotch/2]) cube ([clampWidth,clampNotch+clampDepth,clampNotch+clampDepth], center=true);
    }
    translate ([0,(clampPosition-0.5)*height/1.5,0]) cylinder (d=clampWidth, h=clampDepth+0.1,center=true);
  }
}

module clamp() {
  translate ([-clampWidth/2,-clampDepth/2,-clampDepth/2])
  rotate ([90,0,90])
  linear_extrude (height=clampWidth)
  polygon (points=[[0,0],[clampDepth,0],[clampDepth,clampDepth+depth+clampNotch],[clampDepth+clampNotch,clampDepth+depth+clampNotch*2], [0,clampDepth+depth+clampNotch*2]]);
}

union() {
  body();
  translate ([0,-height/2,0]) clamp();
  translate ([width/2+clampDepth/2, (clampPosition-0.5)*height/1.5, 0]) rotate ([0,0,90]) clamp();
  translate ([-width/2-clampDepth/2, (clampPosition-0.5)*height/1.5, 0]) rotate ([0,0,270]) clamp();
}

