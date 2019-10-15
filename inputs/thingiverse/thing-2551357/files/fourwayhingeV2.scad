// original from: https://www.thingiverse.com/thing:2550244

// the radius of the bar between the small spheres
barRadius = 1.75;
// the extra gap to allow hinge to rotate about the bar
gap=0.4;
// the thickness of the wall of the outer sphere to hold the inner shere
wall=0.85;
//the radius of the largest sphere
socketRadius = 6;
// the distance from the center of the bar to the center of the large spheres
// and the distance between the centers of the small spheres
widthSpacing = 12;



//[hidden]
$fn=20;
hingeOuterRadius=socketRadius-gap;
// used only when printing more than one
nodespacing = widthSpacing *2;

module outerBallcutout(){
     union(){
       
        sphere(r=socketRadius - wall);
        
        rotate([0,0,90])
        translate([0,2,0])
        rotate([90,0,0])
        cylinder(h=socketRadius+5,r=hingeOuterRadius-wall-gap,center=true);
    }
}
//!outerBallcutout();
module bar(){
    translate([0,widthSpacing,0])
    sphere(r=socketRadius- wall-gap);
    
    translate([0,-widthSpacing,0])
    sphere(r=socketRadius- wall-gap);
    
    rotate([90,0,0])
    cylinder(h=widthSpacing*2,r=barRadius,center=true);
}
//!bar();
module hingeBar(offset=0){
    hull(){
        translate([-widthSpacing,0,0])
        sphere(2);
        
        translate([0,offset,0])
        rotate([90,0,0])
        cylinder(h=1,r=hingeOuterRadius,center=true);
    }
}
//!hingeBar(-1);
module outerHinge(){
    difference(){
        union()
        {
            translate([0,-1.9,0])
            hingeBar(-1);

            translate([0,1.9,0])
            hingeBar(1);
        }
        rotate([90,0,0])
        cylinder(h=10,r=barRadius + gap,center=true);
    }
}
//!outerHinge();
module centerHinge(){
    rotate([0,180,0])
    difference(){
        hingeBar();
        
        rotate([90,0,0])
        cylinder(h=10,r=barRadius + gap,center=true);
    }
}
//!centerHinge();

module outerHingeBase(){
    union(){
        translate([-widthSpacing,0,0])
        sphere(r=socketRadius);
        
        outerHinge();
    }
}
//!outerHingeBase();
module innerHingeBase(){
    union(){
        translate([widthSpacing,0,0])
        sphere(r=socketRadius);
        centerHinge();
    }
}
//!innerHingeBase();
module 4wayHinge(){
    difference(){
        union(){
          difference(){
            innerHingeBase();
              
            translate([widthSpacing,0,0])
              rotate([0,0,180])
              outerBallcutout();
          }
          difference(){
              outerHingeBase();
              
              translate([-widthSpacing,0,0])
              outerBallcutout();
          }
          bar();
        }
        translate([-widthSpacing,0,-5.4])
        cube([60,60,4],center=true);
    }
}

module hingeGridnode(){
    4wayHinge();
    translate([nodespacing,0,0])rotate([0,0,90])4wayHinge();
    translate([0,-nodespacing,0])rotate([0,0,90])4wayHinge();
    translate([nodespacing,-nodespacing,0])4wayHinge();
}
 //4wayHinge();
hingeGridnode();
