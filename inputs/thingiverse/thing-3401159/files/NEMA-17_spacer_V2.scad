//NEMA 17 spacer
//20190203 P. de Graaff
//20190219 Aussparung für Motorflansch

//outer diameter in mm
outerDiameter=10;


$fn=50;
//height of baseplate in mm
plate=2;

//total height with baseplate included in mm
space=11;


//right
difference(){
    hull(){
        translate([31/2,-31/2,0])cylinder(d=outerDiameter,h=plate);
        translate([31/2,31/2,0])cylinder(d=outerDiameter,h=plate);
    }
    translate([31/2,-31/2,-1])cylinder(d=3.2,h=plate+2);//drill for screw
    translate([31/2,31/2,-1])cylinder(d=3.2,h=plate+2);
    flansch();
}
difference(){
    translate([31/2,-31/2,0])cylinder(d=outerDiameter,h=space);
    translate([31/2,-31/2,-1])cylinder(d=3.2,h=space+2);
}
difference(){
    translate([31/2,31/2,0])cylinder(d=outerDiameter,h=space);
    translate([31/2,31/2,-1])cylinder(d=3.2,h=space+2);
}
//bottom
difference(){
    hull(){
        translate([31/2,-31/2,0])cylinder(d=outerDiameter,h=plate);
        translate([-31/2,-31/2,0])cylinder(d=outerDiameter,h=plate);
    }
    translate([31/2,-31/2,-1])cylinder(d=3.2,h=plate+2);
    translate([-31/2,-31/2,-1])cylinder(d=3.2,h=plate+2);
    flansch();
}
difference(){
    translate([-31/2,-31/2,0])cylinder(d=outerDiameter,h=space);
    translate([-31/2,-31/2,-1])cylinder(d=3.2,h=space+2);
}
//left
difference(){
    hull(){
        translate([-31/2,-31/2,0])cylinder(d=outerDiameter,h=plate);
        translate([-31/2,31/2,0])cylinder(d=outerDiameter,h=plate);
    }
    translate([-31/2,-31/2,-1])cylinder(d=3.2,h=plate+2);
    translate([-31/2,31/2,-1])cylinder(d=3.2,h=plate+2);
    flansch();
}
difference(){
    translate([-31/2,31/2,0])cylinder(d=outerDiameter,h=space);
    translate([-31/2,31/2,-1])cylinder(d=3.2,h=space+2);
}
module flansch (){
    translate([0,0,-1])cylinder(d=23,h=20,$fn=50);
}