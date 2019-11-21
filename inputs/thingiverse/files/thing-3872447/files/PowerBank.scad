////PowerBank.scad
////OpenSCAD version 2015.03-2
////Kijja Chaovanakij
////2019.09.16

/*[Var]*/
//number of fragments
$fn=40; //[30:low,40:medium,60:high,90:quality]
//tolerance
tol=0.5;
//display part
part=0; //[0:all,1:box,2:lid,3:botton,4:lid and botton]

/*[box var]*/
//wall thickness[2.4]
wall_thi=2.4;
//internal wall thickness[1.2]
inwall_thi=1.2;
//corner radius[3]
corner_rad=3;
//top-bottom thickness[2.0]
bottom_thi=2.0;

/*[Li-ion battery var]*/
//number of piles[3]
np=3;
//battery diameter[18]
bat_dia=18;
//battery length[65]
bat_len=65;
//terminal space[1.6/2.0]
terminal_spc=2;

/*[push button var]*/
//push button x size[14]
button_xsize=14;
//push button y size[14]
button_ysize=14;
//push botton corner radius[1]
botton_rad=1;

/*[charger pcb var]*/
//pcb x size[35.1]
pcb_xsize=35.1;
//pcb y size[25.4]
pcb_ysize=25.4;
//pcb z size[18.6]
pcb_zsize=18.6;

/*[LED var]*/
//LED diameter[5]
LED_dia=5;
//LED length[6]
LED_len=6;

/*[LED location var measure from bottom-left of pcb]*/
//LED x location[17]
LED_xlocat=17;
//LED z location[12]
LED_zlocat=12;

/*[usb port var]*/
//usb port x size[14.5]
usb_xsize=14.5;
//usb port y size[10]
usb_ysize=10;
//usb port z size[7]
usb_zsize=7;

/*[usb port location var measure from bottom-left of pcb]*/
//usb port x location[10.5]
usb_xlocat=10.5;
//usb port z location[4.5]
usb_zlocat=4.5;

/*[micro usb port var]*/
//musb port x size[7.6]
musb_xsize=7.6;
//musb port y size[5.5]
musb_ysize=5.5;
//musb port z size[3]
musb_zsize=3;

/*[micro usb port location var measure from bottom-left of pcb]*/
//musb port x location[26.8]
musb_xlocat=26.8;
//musb port z location[]
musb_zlocat=5;

////translate var
box_xsize=max(np*(bat_dia+tol)+wall_thi*2,pcb_xsize+tol+wall_thi*2);
echo("box_xsize=",box_xsize);
//
box_ysize=bat_len+tol+terminal_spc*2+wall_thi*2+inwall_thi+pcb_ysize+tol;
echo("box_ysize=",box_ysize);
//
box_zsize=max(bat_dia+tol+bottom_thi*2,pcb_zsize+tol+bottom_thi*2);
echo("box_zsize=",box_zsize);

////main
if (part==1)
  box();
else if (part==2)
  lid();
else if (part==3)
  botton();
else if (part==3){
  lid();
  botton();
}//e
else{
  box();
  lid();
  botton();
}//e
////end main

module box(){
translate([-box_xsize*0.6,0,0])
difference(){
//make box
  round_corner_cube(box_xsize,box_ysize,box_zsize,wall_thi);

//make batt room
  translate([0,-box_ysize/2+(bat_len+tol+terminal_spc*2)/2+wall_thi,bottom_thi*2])
    linear_extrude(height=box_zsize,convexity=10)
      square([np*(bat_dia+tol),bat_len+tol+terminal_spc*2],center=true);

//make batt groove
  rotate([90,0,180])
    translate([0,(bat_dia+tol)/2+bottom_thi,-box_ysize/2+terminal_spc+wall_thi])
      batt_pile();

//make pcb room
  translate([0,box_ysize/2-(pcb_ysize+tol)/2-wall_thi,bottom_thi])
    linear_extrude(height=box_zsize+bottom_thi,convexity=10)
      square([np*(bat_dia+tol),pcb_ysize+tol],center=true);

//make port
  translate([0,box_ysize/2-(pcb_ysize+tol)/2-wall_thi,box_zsize/2])
   pcb();

//make lid groove
  translate([0,-wall_thi*1.25,box_zsize-bottom_thi])
    case_lid(box_xsize-wall_thi*1.25,box_ysize+wall_thi*1.25,bottom_thi);

//make wire opening
  translate([0,-wall_thi,box_zsize-bottom_thi*3])
    linear_extrude(height=bottom_thi*2+tol,convexity=10)
      square([box_xsize-wall_thi*2,box_ysize-wall_thi*4],center=true);
}//d
}//m
//

module lid(){
translate([box_xsize*0.6,-wall_thi*1.25/4,0])
  color("Violet")
  difference(){
    case_lid(box_xsize-wall_thi*1.25-tol,box_ysize-wall_thi*1.25/2-tol,bottom_thi);
    translate([0,box_ysize/2-(pcb_ysize+tol)/2-wall_thi+tol,-0.1])
      push_botton(button_xsize+tol,button_ysize+tol,bottom_thi+tol,botton_rad);
  }//d
}//m
//

module botton(){
color("DeepSkyBlue"){
  translate([box_xsize*0.6,box_ysize*0.7,0])
    cube([button_xsize+6,button_ysize+6,0.4],true);
  translate([box_xsize*0.6,box_ysize*0.7,0.4])
    push_botton(button_xsize,button_ysize,bottom_thi,botton_rad);
}//c
}//m
//

module batt_pile(){
for (i=[-np/2+1/2:1:np/2])
  translate([i*(bat_dia+tol),0,0])
    linear_extrude(height=bat_len+tol,convexity=10)
      circle(d=bat_dia+tol);
}//m
//

module case_lid(xwid,ywid,height){
hull(){
  for (i=[-xwid/2+height,xwid/2-height])
    for (j=[-ywid/2+height,ywid/2-height]){
      translate([i,j,0])
        cylinder(height,height,height*0.5);
    }//f
}//h
}//m
//

module push_botton(xwid,ywid,height,rad){
hull(){
  for (i=[-xwid/2+rad,xwid/2-rad])
    for (j=[-ywid/2+rad,ywid/2-rad]){
      translate([i,j,0])
        cylinder(height,rad,rad);
    }//f
}//h
}//m
//

module pcb(){
union(){
  translate([0,0,-(pcb_zsize+tol)/2])
    linear_extrude(height=pcb_zsize+tol,convexity=10)
      square([pcb_xsize+tol,pcb_ysize+tol],center=true);
  translate([(pcb_xsize+tol)/2-LED_xlocat,(pcb_ysize+tol)/2,LED_zlocat-(pcb_zsize+tol)/2])
      LED();
  translate([(pcb_xsize+tol)/2-usb_xlocat,(pcb_ysize+tol)/2,usb_zlocat-(pcb_zsize+tol)/2])
      usb_port();
  translate([(pcb_xsize+tol)/2-musb_xlocat,(pcb_ysize+tol)/2,musb_zlocat-(pcb_zsize+tol)/2])
      musb_port();
}//u
}//m
//

module LED(){
translate([0,-LED_len/2,0])
  rotate([-90,0,0])
    linear_extrude(height=LED_len,convexity=10)
      circle(d=LED_dia+tol);
}//m
//

module usb_port(){
translate([0,0,-(usb_zsize+tol)/2])
  linear_extrude(height=usb_zsize+tol,convexity=10)
    square([usb_xsize+tol,usb_ysize],center=true);
}//m
//

module musb_port(){
translate([0,0,-(musb_zsize+tol)/2])
  linear_extrude(height=musb_zsize+tol,convexity=10)
    square([musb_xsize+tol,musb_ysize],center=true);
}//m
//

module round_corner_cube(xwid,ywid,height,radius){
hull(){
  for (i=[-xwid/2+radius,xwid/2-radius])
    for (j=[-ywid/2+radius,ywid/2-radius]){
      translate([i,j,radius])
        sphere(radius);
      translate([i,j,height-radius])
        sphere(radius);
    }//f
}//h
}//m
//