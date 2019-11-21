
//width of hook
wth=25;
//thickness of material
thk=10;
//Ledge size
ldg=10;
//length
length=150;
//hook inside radius
r=20;
//angle of hook (default 160)
a=160;
//poly (decrease to less than 15 for more square look)
$fn=8;

module length(){
difference(){    
cube([ldg+thk*2,ldg+thk*2,wth]);
translate([thk,thk,0])cube([ldg,ldg*2,wth]); 
}   
cube([thk,length-r-thk,wth]);
}
module hook(){
    translate([-r-thk/2,length-r-thk,0])rotate (a=0, v=[2,0,0]) {
    translate([0,0,0]) rotate_extrude(angle = a, convexity=10)
    translate([r+thk/2,0,0]) square([thk,wth]);
    }}
    
length();
hook();