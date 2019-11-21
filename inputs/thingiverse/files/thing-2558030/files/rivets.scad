////////////////////////////////////////
//rivet diameter
 od=4; //rivet pin diameter mm
 len=6; //rivet length mm excluding the head
 tolerance=0.5; //clearance between ring and pin
 n=5; //number of rivet sets
 

//////////////////////////////////////////


 module hollow(od=25,id=20,l1=62){
 len=l1;

 translate([0,0,0])
 difference(){
    // union(){
   translate([0,0,0])
         cylinder(r=od/2,h=len, $fn=100); 
 translate([0,0,0]) cylinder(r=id/2,h=len, $fn=100); 
 }
 }


//rivet
 module rivet(od=4.4,len=5.6){
difference(){
union(){
    cylinder(r=od/2,h=len,$fn=100); //pin
    cylinder(r=od/2+2,h=1,$fn=100);  //rim
//head
translate([0,0,len]) 
cylinder(r1=od/2+0.4, r2=od/2*0.6,h=2,$fn=100);
}
//cutout slot
 translate([0,0,od*0.22*len]) 
 cube([od*2,1,od*len*.25], center=true);
} }

module rivet_ring(od=4.4,tol=0.5){
    
//ring
translate([od*2,0,0])
hollow(od=od*1.1+2,id=od+tol,l1=1);
}

//tool to hammer the ring on the pin
module tool(od=od){
translate([-3*od,0,0])
hollow(od=od+3,id=od+0.5,l1=30);
}

//display the items
for (x=[0:1:n-1]){
    translate([0, 3*x*od,0]) rivet(od=od,len=len);
    translate([0, 3*x*od,0])rivet_ring(od=od,tol=tolerance);   
}

tool(od=od);

