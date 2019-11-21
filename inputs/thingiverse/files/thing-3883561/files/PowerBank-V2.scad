////PowerBank_V2.scad
////OpenSCAD version 2015.03-2
////Kijja Chaovanakij
////2019.09.26

/*[Var]*/
//number of fragments
$fn=60; //[30:low,60:medium,90:high,180:quality]
//tolerance
tol=0.5;
//display part
part=0; //[0:all,1:batt holder,2:frame,]

/*[Li-ion battery var]*/
//battery diameter[18]
bat_dia=18;
//battery length[65]
bat_len=65;
//terminal space[1.6]
terminal_spc=1.6;
//number of piles[6]
n_pile=6;

/*[holder var]*/
//wall height[15-18]
h_wall_hi=15;
//wall thickness[2.4]
h_wall_thi=2.4;
//bottom thickness[1.8]
h_bottom_thi=1.8;
//make screw hole[0]
make_screw_hole=1; //[0:No,1:Yes]

/*[frame var]*/
//lid inner x size[162]
lid_inner_xsize=162;
//lid inner y size[99.3]
lid_inner_ysize=99.3;
//lid inner z size[7.5]
lid_inner_zsize=7.5;
//lid corner radius[6]
lid_corner_rad=6;
//case inner x size[166.3]
case_inner_xsize=166.3;
//case inner y size[102.5]
case_inner_ysize=102.2;
//case inner z size[9]
case_inner_zsize=9;
//case inner radius[8.5]
case_corner_rad=8.5;
//fram wall thickness[1.9]
fwall_thi=1.9;

/*[port var]*/
//port y size[83]
port_ysize=83;
//port z size[6.5]
port_zsize=6.5;
//port y location meature from left side of case to middle of port[52]
port_ylocate=52;

/*[switch var]*/
//switch x size[10]
switch_xsize=10;
//switch z size[3]
switch_zsize=3;
//swich x location meature from right side of case to middle of switch[25]
switch_xlocate=25;
//switch z location meature from bottom side of case to middle of switch[4]
switch_zlocate=4;

////translate var
holder_xsize=n_pile*(bat_dia+tol)+h_wall_thi*2;
echo("holder_xsize=",holder_xsize);
//
holder_ysize=bat_len+tol+terminal_spc*2+h_wall_thi*2;
echo("holder_ysize=",holder_ysize);
//
holder_zsize=h_wall_hi+h_bottom_thi;
echo("holder_zsize=",holder_zsize);
//
frame_xsize=case_inner_xsize+fwall_thi*2+tol;
echo("frame_xsize=",frame_xsize);
//
frame_ysize=case_inner_ysize+fwall_thi*2+tol;
echo("frame_ysize=",frame_ysize);
//
frame_zsize=case_inner_zsize+lid_inner_zsize;
echo("frame_zsize=",frame_zsize);

////main
if (part==1)
  holder();
else if (part==2)
  //rotate([0,180,0])
  //translate([0,0,-case_inner_zsize-lid_inner_zsize])
  frame();
else{
  holder();
  frame();
}//e
////end main

module holder(){
translate([0,-holder_ysize*0.6,0])
difference(){
//make box
  linear_extrude(height=holder_zsize,convexity=10)
    square([holder_xsize,holder_ysize],center=true);

//make batt room
  translate([0,0,h_bottom_thi*2.5])
    linear_extrude(height=holder_zsize,convexity=10)
      square([holder_xsize-h_wall_thi*2,holder_ysize-h_wall_thi*2],center=true);

//make batt groove
  rotate([90,0,0])
    translate([0,(bat_dia+tol)/2+h_bottom_thi,-holder_ysize/2+terminal_spc+h_wall_thi])
      batt_pile();

//make wall opening
  rotate([0,90,0])
    translate([-holder_ysize/2-h_bottom_thi,0,-holder_xsize/2-tol/2])
      linear_extrude(height=holder_xsize+tol,convexity=10)
        circle(d=holder_ysize);

//make wire hole
  rotate([0,90,0])
  for (i=[holder_ysize/2-h_wall_thi-1,-holder_ysize/2+h_wall_thi+1])
    translate([-h_bottom_thi*2.5-1,i,-holder_xsize/2-tol/2])
      linear_extrude(height=holder_xsize+tol,convexity=10)
        circle(d=2);

//make screw hole
  if (make_screw_hole==1){
    if (n_pile>1)
      for (i=[holder_xsize/2-h_wall_thi-bat_dia-tol,-holder_xsize/2+h_wall_thi+bat_dia+tol])
        for (j=[holder_ysize/3,-holder_ysize/3]){
////+h_bottom_thi shallow screw hole
////-h_bottom_thi through screw hole
          translate([i,j,-h_bottom_thi])
            linear_extrude(height=h_bottom_thi*4,convexity=10)
              circle(d=3);
          translate([i,j,+h_bottom_thi*2])
            cylinder(h_bottom_thi/2+0.1,1.5,3);
        }//f
  }//i
}//d
}//m
//

module frame(){
translate([0,case_inner_ysize*0.6,0])
difference(){
//make box
  extrude_round_corner_square(frame_xsize,frame_ysize,frame_zsize,case_corner_rad+fwall_thi);

//make case room
  color("orange")
  translate([0,0,-0.1])
    extrude_round_corner_square(case_inner_xsize+tol,case_inner_ysize+tol,case_inner_zsize+0.1,case_corner_rad);

//make lid room
  color("yellow")
  translate([0,0,case_inner_zsize-0.1])
    extrude_round_corner_square(lid_inner_xsize+tol,lid_inner_ysize+tol,lid_inner_zsize+0.2,lid_corner_rad);

//make port
  translate([frame_xsize/2-fwall_thi/2,-case_inner_ysize/2-tol/2+port_ylocate,-0.1])
    linear_extrude(height=port_zsize+tol*2,convexity=10)
      square([fwall_thi*3,port_ysize+tol*4],center=true);

//make switch port
  translate([case_inner_xsize/2+tol/2-switch_xlocate,-frame_ysize/2+fwall_thi/2,switch_zlocate-switch_zsize/2-tol*1.5])
    linear_extrude(height=switch_zsize+tol*3,convexity=10)
      square([switch_xsize+tol*4,fwall_thi*3],center=true);
}//d
}//m
//

module batt_pile(){
for (i=[-n_pile/2+1/2:1:n_pile/2])
  translate([i*(bat_dia+tol),0,0])
    linear_extrude(height=bat_len+tol,convexity=10)
      circle(d=bat_dia+tol);
}//m
//

module extrude_round_corner_square(xwid,ywid,height,radius){
hull(){
  for (i=[-xwid/2+radius,xwid/2-radius])
    for (j=[-ywid/2+radius,ywid/2-radius]){
      translate([i,j,0])
        linear_extrude(height=height,convexity=10)
          circle(radius);
    }//f
}//h
}//m
//