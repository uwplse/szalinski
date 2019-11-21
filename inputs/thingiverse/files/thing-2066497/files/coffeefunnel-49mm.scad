$fn=128;

r = 24.7;
basketRimR = 2.2;
outerR = r + 2*basketRimR;
funnelHeight = 20;
insideHeight = 4.5;
funnelR = 13;
wallThickness = 1.8;
eps = 0.01;

difference(){
union(){
//translate([0,0,lipHeight-eps]) thinCyn(funnelHeight,r,r+funnelR);
    thinCyn(funnelHeight, outerR, outerR + funnelR);
    translate([0,0,insideHeight]) thinCyn(funnelHeight - insideHeight, r, outerR + funnelR);
    

rotate_extrude(convexity = 10, $fn = 100)
translate([r+basketRimR, 0, 0])
difference(){
difference(){
union(){
    basketRimOuterR = basketRimR + wallThickness;

    polygon(points=[[-basketRimR, 0],[-basketRimR, insideHeight],[-basketRimR + wallThickness, insideHeight],[-basketRimR + wallThickness, 0]]);
    circle(r = basketRimOuterR, $fn = 100);
}
circle(r = basketRimR, $fn = 100);
}
translate([-4,-8,0])
square(8,8);
}
}

translate([0,0,-eps])
union(){//cube([50,50,50]);
    //cylinder(basketRimR, r+basketRimR,r+basketRimR);
    cylinder(funnelHeight+eps,r-2*eps,r-2*eps);
}
}

module thinCyn(h,r1,r2){
  difference(){
	  cylinder(h,r1+wallThickness,r2+wallThickness);
	  translate([0,0,-eps])
        cylinder(h+2*eps,r1,r2);
  }
}

