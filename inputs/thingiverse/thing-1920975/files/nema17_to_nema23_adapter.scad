//#nema23 to nema 17 adapter plate

width  = 60;
length = 60;
height = 10 ;

nema23HoleR = 5.4/2;
nema23HoleDistance = 47.14/2;
nema23HeadR = 9/2;

nema17HoleR = 3.4/2;
nema17HoleDistance = 31/2;
nema17CenterRadius = 24.5/2;
nema17CutOuta = (nema23HoleDistance*2)-(nema23HeadR*2); //43
nema17CutOutb = 43;


$fn = 50;

difference(){
cube([width, length, height], center= true);
cylinder(r=nema17CenterRadius, h=height, center=true);
translate([nema17HoleDistance, nema17HoleDistance, 0])cylinder(r=nema17HoleR, h=height, center=true);

//nema 17 mount holes
translate([nema17HoleDistance, nema17HoleDistance, 0])cylinder(r=nema17HoleR, h=height, center=true);
translate([-nema17HoleDistance, -nema17HoleDistance, 0])cylinder(r=nema17HoleR, h=height, center=true);
translate([-nema17HoleDistance, nema17HoleDistance, 0])cylinder(r=nema17HoleR, h=height, center=true);
translate([nema17HoleDistance, -nema17HoleDistance, 0])cylinder(r=nema17HoleR, h=height, center=true);

//nema 23 mount holes
translate([nema23HoleDistance, nema23HoleDistance, 0])cylinder(r=nema23HoleR, h=height, center=true);
translate([-nema23HoleDistance, -nema23HoleDistance, 0])cylinder(r=nema23HoleR, h=height, center=true);
translate([-nema23HoleDistance, nema23HoleDistance, 0])cylinder(r=nema23HoleR, h=height, center=true);
translate([nema23HoleDistance, -nema23HoleDistance, 0])cylinder(r=nema23HoleR, h=height, center=true);
//nema23 cap soc recess
translate([-nema23HoleDistance, -nema23HoleDistance, height-1])cylinder(r=nema23HeadR, h=height, center=true);
translate([nema23HoleDistance, nema23HoleDistance, height-1])cylinder(r=nema23HeadR, h=height, center=true);
translate([nema23HoleDistance, -nema23HoleDistance, height-1])cylinder(r=nema23HeadR, h=height, center=true);
translate([-nema23HoleDistance, nema23HoleDistance, height-1])cylinder(r=nema23HeadR, h=height, center=true);

//nema 17 rounded square recess
translate([0,0,3.5])cube([nema17CutOuta, nema17CutOutb,height], center=true);
translate([0,0,3.5])cube([nema17CutOutb, nema17CutOuta,height], center=true);

translate([-nema17CutOuta/2, -nema17CutOuta/2, 3.5])cylinder(r=(nema17CutOutb-nema17CutOuta)/2, h=height, center=true, $fn=4);
translate([nema17CutOuta/2, nema17CutOuta/2, 3.5])cylinder(r=(nema17CutOutb-nema17CutOuta)/2, h=height, center=true, $fn=4);
translate([-nema17CutOuta/2, nema17CutOuta/2, 3.5])cylinder(r=(nema17CutOutb-nema17CutOuta)/2, h=height, center=true, $fn=4);
translate([nema17CutOuta/2, -nema17CutOuta/2, 3.5])cylinder(r=(nema17CutOutb-nema17CutOuta)/2, h=height, center=true, $fn=4);
    
}

