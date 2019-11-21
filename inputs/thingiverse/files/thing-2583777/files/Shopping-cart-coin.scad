Text="Michi";
Size=6;


$fn=128;
difference(){
 union(){
  cylinder(r=12,h=2);
  translate([18,0,0]){
    difference(){
      union(){
        cylinder(r=5,h=2);
        translate([-18,-5,0]){
          cube([18,10,2]);
        } 
      }
      translate([0,0,-1]){
          cylinder(r=1.8,h=4);
      }
    }
  }
 }
translate([0,0,1.5]){
    rotate(270){
      linear_extrude(height=0.55){
      text(Text,size=Size,  halign=  "center", valign  ="center");
      }
    }
  }
}