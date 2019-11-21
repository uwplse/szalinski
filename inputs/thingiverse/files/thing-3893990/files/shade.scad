//bulb shade
H=200;    //shade height
bd=200;   //bottom diameter
td=100;   //top diameter
sd=40;   //support diameter
th=3;    //shade thickness
module lampshade(){
    rotate([0,180,0]){
        translate([0,0,-H]){
    difference(){
    cylinder(h=H,r1=bd,r2=td);
        cylinder(h=H, r1=bd-th,r2=td-th);
    }
    //top support
    translate([0,0,195])
    difference(){  
        cylinder(h=5,r=td);
        cylinder(h=5,r=40);
    }}
}}
lampshade();
