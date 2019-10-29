BaseHeight = 4;
BaseWidth = 23.5;
HoleRadius = 1.5;
LMRadius = 8;

/* [HIDDEN] */
$fn = 50;

translate([0,0,12])
    rotate([180,0,0])
        comFuro();

module base(){
    translate([0,0,9+BaseHeight/2]) 
        cube([22,BaseWidth,BaseHeight],center=true);
    translate([0,0,8]) 
        cube([20,14,6],center=true);
    rotate([0,90,0]){
        difference(){
            cylinder(h=20,r=LMRadius+1,center=true);            
            translate([8,0,0])cube([23,23,32],center=true);
        }
    }
}
module comFuro(){
    difference()
    {
        y = (BaseWidth/2)-1-HoleRadius;
        base();
        rotate([0,90,0])
            cylinder(h=24,r=LMRadius,center=true);        
        translate([0,y,10]) 
            cylinder(r=HoleRadius,h=5,center=true);
        translate([0,-y,10]) 
            cylinder(r=HoleRadius,h=5,center=true);
    }
}