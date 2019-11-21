 $fn=100;
 panel_width=1;
 module aviation_connector(panel_width){
     color("lightgrey"){
   cylinder(h=47,d=6);
   cylinder(h=5,d=9); 
  translate([0,0,5]) cylinder(h=8,d=15.5);   
  translate([0,0,10-panel_width]) cylinder(h=3,d=21.42,$fn=6); 
  translate([0,0,13]) cylinder(h=9,d=18);   
  translate([0,0,22]) cylinder(h=12,d=12.6);  
  translate([0,0,34]) cylinder(h=4,d=13.7);   
  translate([0,0,38]) cylinder(h=3.7,d=9.3);  
  translate([0,0,41.7]) cylinder(h=3.6,d=13.5,$fn=6);  
  translate([0,0,45.3]) cylinder(h=1,d=10.1);  
     } 
 } 
 
 aviation_connector(panel_width);