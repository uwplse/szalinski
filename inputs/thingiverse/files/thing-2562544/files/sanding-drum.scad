//Attach sanding paper with double sided tapes, tuck ends in the slot.

od=35;  //drum diameter, minimum 20 mm
 len=20; //drum length
 slotw=1; //inner slot width
outslot=2;  //outer slot width



module hex(r=15,h=10){
intersection() {
    cylinder(r=r,h, $fn=6);
    translate([0,0,h*.5-3])
    sphere(r*1.3);
}
}

module hex_hole(id=7.9,h=20,od=50){
//id=size of hex bit   
//tapered hole with 1.1 tmes taper    
difference(){
 hex(od/2,h);
 translate([0,0,0])
cylinder(r1=id/2*1.1,r2=id/2,h, $fn=6); 
    }
}




module hollow(od=25,id=20,l1=62){
 len=l1;

 translate([2,0,0])
 difference(){
    // union(){
   translate([0,0,0])
         cylinder(r=od/2,h=len, $fn=100); 
 translate([0,0,0]) cylinder(r=id/2,h=len, $fn=100); 
 }
 }
 
  module arc_hollow(slotw=2){
      rotate([0,0,12])
 intersection(){
 hollow(od*1.5,id=od*1.5-2*slotw,l1=len);
   translate([-0,0,0])cube(od);}
 }
 
 
 


 module drum(){
 difference(){
cylinder(r=od/2,h=len, $fn=100);
 
 translate([od*.3,-od/2,0]) arc_hollow(outslot);
     translate([od/4,od/30,0]) rotate([0,0,30])cube([slotw,od/2.5,20]);
     }
 }
 

 module sanding_drum(){
 intersection(){
drum();
 hex_hole(od=od*2);
}
 }
 
 sanding_drum();