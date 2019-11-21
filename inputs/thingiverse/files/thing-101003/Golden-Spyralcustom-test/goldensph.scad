spiral_constant=5;//[1:5]
details=2;//[1:20]
elements_in_circle=20;//[4:10]
acnt=1*1;
bcnt=0.002*spiral_constant;
angleStep=360/elements_in_circle;
$fn=2+details;

module drowElem(rad) {
  stepRad=acnt*exp(bcnt*rad);
  rotate(a=rad,v=[0,0,1]) translate([stepRad,0,0]) cylinder(h=1, r=stepRad/4, center=true);
}

for(rad=[0:angleStep:360]) {
 drowElem(rad);
}