// Adaptor for iPhone6 on iPhone 4/5 Brodit Mount

length = 50;  // body for iPhone6
width = 9;    // slot for iPhone6 with case

difference(){
  cube([77,length,14],center=true);  // body for iPhone 6
  translate([0,0,0]) cube([66,length,10],center=true);
  translate([0,-4,0]) cube([72,length,width],center=true);  // slot
  translate([0,0,10]) cube([66,length,10],center=true);
  translate([40,0,7]) rotate([0,45,0]) cube([5,length,5],center=true);  // phase top
  translate([-40,0,7]) rotate([0,45,0]) cube([5,length,5],center=true);  // phase top
}

translate([0,((length/2)*-1)+20,-9]) cube([50,40,4],center=true); // middle part
difference(){
  translate([0,((length/2)*-1)+20,-15]) cube([59,40,8],center=true); // adaptor iPhone 5
  translate([30,((length/2)*-1)+38,-11]) rotate([-20,0,0]) cube([10,5,2],center=true);  // phase
  translate([-30,((length/2)*-1)+38,-11]) rotate([-20,0,0]) cube([10,5,2],center=true); // phase
  translate([-24,((length/2)*-1),-17]) rotate([90,0,0]) linear_extrude(height = 1 , convexity = 110) text("iPhone 6", size=4, font="Liberation Sans");
}

