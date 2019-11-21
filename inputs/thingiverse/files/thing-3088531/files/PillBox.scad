////----PillBox.scad----
////----OpenSCAD 2015.03-2----
////----2018.09.03----
////----Kijja Chaovanakij----
//
////----defalt box size equals credit card size.

/*[General]*/
//number of fragment[30:low,40:medium,60:high]
$fn=30;
//generate parts
part=3; //[1:box,2:lid,3:both]

/*[Box]*/
//outer box x size[54]
box_xsize=54;
//outer box y size[85.4]
box_ysize=85.4;
//outer box z size[13.45(layer 0=0.25,others=0.20)]
box_zsize=13.45;
//box bottom thickness[1.25(layer 0=0.25,others=0.20)]
box_bottom_thick=1.25;
//outer wall thickness[1.6]
box_wall=1.6;
//inner wall thickness[0.6]
inner_wall=0.6;

/*[lid]*/
//lid thickness[1.25(layer 0=0.25,others=0.20)]
lid_thick=1.25;
//lid & box fit tolerance[0.3]
lid_tol=0.3;

/*[Cell]*/
//number of cell y row[4]
cell_ynum=4;
//cell divider type
cell_divider=1; //[0:no,1:yes]

/*[Plaster Pad]*/
//Plaster Pad x size[35]
pad_xsize=35;
//Plaster Pad z size[1.2]
pad_zsize=1.2;

////----translate var----
//inner box x size
inner_xsize=box_xsize-box_wall*2;
//inner box y size
inner_ysize=box_ysize-box_wall*2;
//inner box z size
inner_zsize=box_zsize-box_bottom_thick-lid_thick;
//cell y size
cell_ysize=(inner_ysize-inner_wall*(cell_ynum-1))/cell_ynum+inner_wall;

////----main----
if (part==1)
  box();
if (part==2)
  lid();
if (part==3){
  translate([-box_xsize*0.55,0,0])
    box();
  translate([box_xsize*0.55,0,-box_zsize+lid_thick])
    lid();
}//i
//

module box(){
  color("SkyBlue"){
  difference(){
//box
    round_bottom_cube(inner_xsize,inner_ysize,box_zsize, box_wall);
//cut inner box
    translate([0,0,box_bottom_thick])
      round_bottom_cube(inner_xsize-box_wall,inner_ysize-box_wall,box_zsize,box_wall/2);
//cut open slide side
    translate([0,-box_ysize/2+box_wall/2,box_zsize-lid_thick/2])
      cube([inner_xsize,box_wall*2,lid_thick+0.002],true);
//cut lip
    translate([0,-box_wall,box_zsize-lid_thick])
      round_corner_frustum(inner_xsize-box_wall,inner_ysize-box_wall+box_wall*2,lid_thick,box_wall*0.9,box_wall/2);
  }//d
//lock
  translate([0,-box_ysize/2+box_wall,box_zsize-lid_thick-0.1])
  rotate([45,0,0])
    cube([box_xsize/5,1,1],true);
  }//c
//cell
  if (cell_divider==1)
    color("tan")
    cell();
}//m
//

module lid(){
  color("orange"){
  difference(){
//lid
    translate([0,-box_wall*2,box_zsize-lid_thick])
      round_corner_frustum(inner_xsize-box_wall,inner_ysize-box_wall+box_wall*4,lid_thick,box_wall*0.9-lid_tol,box_wall/2-lid_tol);
//cut excess lid
    translate([0,-box_ysize/2-box_wall*2,box_zsize-lid_thick/2])
      cube([inner_xsize+box_wall,box_wall*4,lid_thick+0.005],true);
//cut lock
    translate([0,-box_ysize/2+box_wall,box_zsize-lid_thick])
    rotate([45,0,0])
      cube([box_xsize/5+2,1,1],true);
  }//d
//slider bar
  translate([0,-box_ysize/2.5,box_zsize])
  rotate([0,90,0])
    cylinder(box_xsize/3,lid_thick*0.8,lid_thick*0.8,true);
  }//c
}//m
//

module cell(){
//long thin wall  
  translate([-inner_xsize/2+pad_xsize+inner_wall/2,0,inner_zsize/2+box_bottom_thick/2])
    cube([inner_wall,inner_ysize,inner_zsize],true);
//cross thin wall
  translate([-inner_xsize/2+pad_xsize/2+inner_wall/2,-inner_ysize/2-inner_wall/2,inner_zsize/2+box_bottom_thick/2])
    for (i=[1:1:cell_ynum-1])
      translate([0,cell_ysize*i,-pad_zsize/2])
        cube([pad_xsize+inner_wall/2,inner_wall,inner_zsize-pad_zsize],true);
}//m
//

module round_corner_frustum(xwid,ywid,height,bradius,tradius){
  hull(){
    for (i=[-xwid/2,xwid/2])
    for (j=[-ywid/2,ywid/2])
      translate([i,j,0])
        cylinder(height,bradius,tradius);
  }//h
}//m
//

module round_bottom_cube(xwid,ywid,height,radius){
  hull(){
    for (i=[-xwid/2,xwid/2])
    for (j=[-ywid/2,ywid/2]){
      translate([i,j,radius])
        sphere(radius);
      translate([i,j,radius])
        cylinder(height-radius,radius,radius);
    }//f
  }//h
}//m
//
