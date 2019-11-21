////----CustomHandle.scad----
////----OpenSCAD 2015.03-2----
////----2018.7.7----
////----By Kijja Chaovanakij----

////----Update 2018.7.30
////----Change input size of square hole or hexagon hole from diagonal dimension to opposite side dimension.

/* [var] */
//number of fragments[30=low:40=medium:60=high]
$fn=30;
//reduce garbage in preview[0.002]
garbage=0.002;

/* [hole var] */
//diameter for round hole[8.0] or side to opposite side for square hole or hexagon hole[6.24]
hole_dia=6.24;
//open-end = hole depth[80] > total handle length[in console windows]
hole_dept=80;
//hole tolerance[0.30-0.45]
hole_tolerance=0.3;
//1=square:2=hexagon:other=round
hole_type=2;

/* [collet var] */
//collet diameter[15] >= hole diameter +5mm.
collet_dia=18;
//collet length[6]
collet_len=8;
//adjust distance between collet and holder [0.00-0.4]
offset_adjust=0.34;

/* [handle var] */
//handle diameter[25] >= hole diameter +7mm.
handle_dia=25;
//handle length[80]
handle_len=80;
//number of groove[0-8]
groove=5;
//1=flat:other=round
end_type=0;
//1=yes:other=no
hook_type=0;

/* [shield var] */
//shield thickness[2.5]
shield_thick=2.5;
//shield wing width[12]
shield_wid=12;
//1=yes:other=no
shield_type=0;
////----end customizer var----

////----translate var----
hole_rad=hole_dia/2;
col_rad=collet_dia/2;
hand_rad=handle_dia/2;
end_fillet_rad=handle_dia/4;
shield_rad=hand_rad+shield_wid-shield_thick/2;
groove_deg=360/groove;
////----end translate var----

////----main----
echo();
echo("total handle length=",handle_len+collet_len+hand_rad*(0.5+offset_adjust));
echo();
rotate([90,0,0])
handle();
////---- end main ----

module handle(){
difference(){
  union(){
    cylinder(handle_len,hand_rad,hand_rad,true);
    
    if (shield_type==1)
      add_shield();
    else
      add_collet();
    
    if (end_type==1)
      flat_end();
    else 
      translate([0,0,-handle_len/2])
        scale([1,1,0.5])
        sphere(hand_rad);
    
    if (hook_type==1)
      add_hook();
  }
  
  for (i=[0:1:groove-1]){
    translate([hand_rad*1.3*cos(i*groove_deg),  hand_rad*1.3*sin(i*groove_deg),0]){
      cylinder(handle_len+hand_rad*0,hand_rad*0.45,hand_rad*0.45,true);
      
      for (j=[-handle_len/2,handle_len/2]){
        translate([0,0,j])
          sphere(hand_rad*0.45);
      }
    }
  }
  
  translate([0,0,handle_len/2+hand_rad*offset_adjust+collet_len-hole_dept])
  if (hole_type==1){
    $fn=4;
    handle_hole(hole_dia/2*sqrt(2));
  }
  else if (hole_type==2){
    $fn=6;
    handle_hole(hole_dia/2/sin(60));
  }
  else
    handle_hole(hole_rad);
}}
////----end handle()----

module add_shield(){
color("MistyRose"){
translate([0,0,handle_len/2])
  cylinder(collet_len+hand_rad*offset_adjust,r=hand_rad);

translate([0,0,handle_len/2+hand_rad*offset_adjust+collet_len-shield_thick/2]){
  cylinder(shield_thick,shield_rad,shield_rad,true);
  rotate_extrude(convexity=5)
    translate([shield_rad,0])
      circle(d=shield_thick);
}}}
////----end add_shield----

module add_collet(){
translate([0,0,handle_len/2])
  scale([1,1,0.5])
  sphere(hand_rad);

color("PaleGreen")
translate([0,0,handle_len/2+hand_rad*offset_adjust])
  cylinder(collet_len,r=col_rad);
}
////----end add_collet----

module flat_end(){
translate([0,0,-handle_len/2-hand_rad/2+end_fillet_rad])
  rotate_extrude(convexity = 10){
    translate([hand_rad/2-end_fillet_rad/2,0])
      square([hand_rad-end_fillet_rad,end_fillet_rad*2],true);
    
    translate([hand_rad-end_fillet_rad,0])
      circle(end_fillet_rad,true);
  }
}
////----end flat_end----

module add_hook(){
translate([0,0,-handle_len/2-hand_rad*0.6])
  rotate([90,0,0])
  rotate_extrude(convexity = 10)
    translate([hand_rad-end_fillet_rad,0])
      circle(hand_rad/6,true);
}
////----end add_hook----

module handle_hole(hole_rad){
cylinder(hole_dept+garbage*2,r=hole_rad+hole_tolerance);
}
////----end handle_hole----