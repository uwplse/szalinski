part="handle"; // [handle,base,all]
size=47;
//rotate([-90,0])
if(part=="handle")
  rotate([-90,0]) handle();
else if(part=="base")
  base();
else if(part=="all")
{
  handle();
  base();
}
module handle() {
  translate([0,2.5]) rotate([90,0]) linear_extrude(5) {
    intersection()
    {
      translate([-30,-4]) square([60,100]);
      union(){
   translate([0,15]) scale([1.2,2]) difference() {
     circle(d=45,$fn=100);
     circle(d=41,$fn=90);
   }
   for(m=[0,1]) mirror([m,0]) {
   translate([-24,-4]) square([6,4]);
   translate([-26,5]) difference(){
     square([4.5,4]);
     translate([4.5,-1]) rotate([0,0,15]) square([5,6]);
   }
   }
   //polygon([[-18,48.5],[-22.5,8], [-20,8],[-20,5.6],[-23,5.6],[-23,-.4], [-20,-.4],[-20,-4],[-25,-4],[-25,5.6], [-20,50],[0,60],[20,50],[25,6],[25,-4], [20,-4],[20,-.4],[23,-.4],[23,5.6], [20,5.6],[20,8],[22.5,8],[18,48.5],[0,57]]);
    translate([0,68]) difference() {
      circle(d=20,$fn=50);
      circle(d=16,$fn=40);
    }
  }
}
  }
}
module base() {
  difference(){
    cylinder(d1=45,d2=47,h=5,$fn=100);
    translate([0,0,-.01]) cylinder(d1=36,d2=41,h=5.02,$fn=90);
  }
  for(m=[0,1]) mirror([m,0])
  translate([-26,-5])
  difference(){
    cube([5,10,5]);
    translate([-.01,2,-.01]) cube([8,6,5.2]);
  }
    
}