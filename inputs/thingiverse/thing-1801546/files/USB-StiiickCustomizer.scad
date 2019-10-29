//count of fragments for cylinders etc.
$fn=50;
//plug dimensions (including 1mm tolerance)
PLen=27; 
//width and height - for perfect sit, file down (including 0.8mm tolerance)
PWit=15.8;
PHig=8.8;
//cable diameter
CDia=4; 
//additional cutout right (including 0.8mm tolerance)
ACutR=8.8; 
//screwdriver/stick diameter (including 1mm tolerance)
StDia=8;

rotate([0,270,0]) //suggested print orientation - alternatively enable print support below - hint: if you print in other direction, possibly you have to change the tolerances
difference(){
    translate([0,0,0])
    cube([PLen+2,PWit+4+StDia,PHig+4]);
    
    //cable
    translate([-5,PWit/2,2])
    cube([PLen+12,CDia,PHig+4]);
    
    //plug
    translate([-2,2,2])
    cube([PLen+2,PWit,PHig]);
    
    //additional cutout right
    translate([10,(PWit+4-ACutR)/2,(PHig+4-ACutR)/2])
    cube([PLen,ACutR,ACutR]);
    
    //hole for stick
    translate([StDia,PWit+3+StDia/2,(PHig+4)/2])
    rotate([0,90,0])
    cylinder(h=PLen,d=StDia);
    //slits
    translate([2,PWit+3,PHig/2+1]){
        cube([StDia+1,StDia,2]);
        translate([0,StDia/2+1,-(StDia)/2+1])
        rotate([90,0,0])
        cube([StDia+1,StDia,2]);
    }
}

/*/print support inside
translate([3,4,2.8])
PrnSupport(PLen-6,PWit-4,PHig-1,5); //*/

module PrnSupport(x,y,z,step) {
    for (xl=[0:step:x]) {
        translate([xl,0,0])
        cube([0.5,y,z]);
    }
}

