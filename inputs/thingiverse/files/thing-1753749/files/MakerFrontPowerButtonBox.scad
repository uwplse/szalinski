//by Eric Hughes specifically for a MakerFront i3Pro
//circle precision
$fn=20;
//inner switch width
ix=28.5;//28.3
//inner switch depth
iy=13.9;
//wall thickness
wt=1.3;//1.2
//motor + bracket height
mbz= 43.14;
//customize height lower than motor in front and sides (covers wires, zero if flush with motor)
mz = 5;
//customize height lower than motor in back (zero if flush)
mzb = 1;
//distance between both scres holes
hx=31;
//overhang into motermount bracket
mby=10;
//overhang into motermount bracket
mbx=40;

rotate([0,180,0]){
difference(){
    union(){
        TopPlate();
        cube([2*wt+ix, 2*wt+iy, mbz+mz], center=true);
    }
    cube([ix, iy, 100], center=true);
    LeftTriangleCut();
    RightTriangleCut();
    screwholes();
    BottomCut();
}}

module BottomCut(){
    translate([0,wt+.01,-50-(mbz+mz)/2+(mz-mzb)])
     cube([ix, iy, 100], center=true);
}


module TopPlate(){
translate([0,mby/2,(mbz+mz+wt)/2]){
cube([mbx,mby+2*wt+iy, wt],center=true);}}

module RightTriangleCut(){
linear_extrude(height=100, center=true){
 polygon(points=[[-(2*wt+ix)/2,-(2*wt+iy)/2-.001],[-(mbx)/2-.001,-(2*wt+iy)/2-.001],[-(mbx)/2,(2*wt+iy)/2]]);}}

module LeftTriangleCut(){
    mirror([1,0,0]) RightTriangleCut();
}

module screwholes(){
translate([0,(2*wt+iy)/2+5.25,]){
translate([hx/2,0,0]){
 cylinder(100, d=3.2, center=true);
}
translate([-hx/2,0,0]){
 cylinder(100, d=3.2, center=true);
}}}