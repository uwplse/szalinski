od=26;  //od = handle outside dimension mm
ir=10;  //ir =finger hole radius mm



module hex(r=15,h=10){
intersection() {
    cylinder(r=r,h, $fn=6);
    translate([0,0,h*.5-3])
    sphere(r*1.3);
}
}

module hex_hole(id=7.9,h=20,od=10){
//id=size of hex bit   
//tapered hole with 1.1 tmes taper    
difference(){
 hex(od/2,h);
 translate([0,0,0])
cylinder(r1=id/2,r2=id/2*1.1,h, $fn=6); 
    }
}

//id is the hex bit dimension
module mini_handle(id=7.9,h=15,od=20){
translate([0,0,od/2]){
    union(){
translate([0,0,od*.5])
hex_hole(id,h,od=20);
intersection() {
    cube(od, center=true);
    sphere(od*.7);
    }
   }
  }
}

module finger_driver(od=26,ir=10){
//od = handle outside dimension mm
//ir =finger hole radius mm
difference(){
mini_handle(od=od);  
translate([0,od/2+1,od/2]) rotate([90,0,0])
cylinder(r1=ir,r2=ir*.8, 50, $fn=10);
    
translate([0,od/2,od/2]) rotate([90,0,0])
    cylinder(r1=ir*1.02,r2=0, 20, $fn=100);
translate([0,-od/2-1,od/2]) rotate([90,0,180])
    cylinder(r1=ir,r2=0, 20, $fn=100);
}
}

//
//od = handle outside dimension mm
//ir =finger hole radius mm
finger_driver(od,ir);