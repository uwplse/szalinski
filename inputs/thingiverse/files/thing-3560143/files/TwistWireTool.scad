////TwistWireTool.scad
////OpenSCAD 2015.03-2
////Kijja Chaovanakij
////2019.04.3

/*[var]*/
//number of fragments[60=low,90=medium,120=high]
$fn=60; //[60,90,120]

/*[axle]*/
//axle radius [3]
axle_rad=3; //[3:0.5:6]
//axle length [24]
axle_len=24; //[20:4:60]
//axle type [0=round,1=hexagon]
axle_type=1; //[0,1]

/*[plate]*/
//plate thickness [3.2]
plate_thi=3.2; //[3:0.2:6]
//space between axle and plate hole [8]
axle_space=8; //[6:1:12]
//plate hole diameter [3]
plate_hole_dia=3; //[2:1:6]
//number of plate hole [6]
num_hole=6; //[2:1:9]
//space between plate edge and plate hole [4]
edge_space=4; //[3:1:9]

////translate var
//hexagon radius
hex_rad=axle_rad/cos(30);
echo("<b>hex_rad=</b>",hex_rad);
//plate radius
plate_rad=axle_rad+axle_space+plate_hole_dia+edge_space;
echo("<b>plate_rad=</b>",plate_rad);
//plate hole location radius
plate_hole_locat=axle_rad+axle_space+plate_hole_dia/2;
//plate hole angle
plate_hole_ang=360/num_hole;

////main
translate([0,0,plate_thi/2])
  rotate_extrude(convexity=10)
    translate([plate_rad-plate_thi/2,0,0])
      circle(r=plate_thi/2);

difference(){
  linear_extrude(height=plate_thi,convexity=10)
    circle(r=plate_rad-plate_thi/2);
  for(i=[1:num_hole])
////my testing
//translate([plate_hole_locat*cos(i*plate_hole_ang),plate_hole_locat*sin(i*plate_hole_ang),+0.2])
////actual command
translate([plate_hole_locat*cos(i*plate_hole_ang),plate_hole_locat*sin(i*plate_hole_ang),-0.05])
    linear_extrude(height=plate_thi+0.1,convexity=10)
      circle(r=plate_hole_dia/2);
}//d  

color("DarkSeaGreen")
translate([0,0,plate_thi])
  if(axle_type==0)
    cylinder(axle_space-2,axle_rad+axle_space-2,axle_rad);
  else
    cylinder(axle_space-2,axle_rad+axle_space-2,hex_rad);

difference(){
  translate([0,0,plate_thi+axle_space-2])
    linear_extrude(height=axle_len,convexity=10)
      if(axle_type==0)
        circle(r=axle_rad);
      else{
        $fn=6;
        circle(r=hex_rad);
      }//e
  translate([0,0,plate_thi+axle_space-2+axle_len-axle_rad*1.5])
      rotate([90,0,0])
        linear_extrude(height=axle_rad*2+0.1,convexity=10,center=true)
          circle(r=axle_rad/3);
}//d