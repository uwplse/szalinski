 
 $fn=100;
 //TAPA
 union(){
cylinder(r=12,h=6);
  translate([0,0,6]) 
cylinder(r1=9.5, r2=8.5, h=18);
    
}

//BASE
//difference(){
 //   rotate([0,0,0])
 //      translate([30,0,0]) 
//cylinder(r=10.8, h=60);
 //      translate([30,0,2]) 
//cylinder(r=8.8, h=60);
//}