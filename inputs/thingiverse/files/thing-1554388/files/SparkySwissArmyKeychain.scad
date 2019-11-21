$fn = 20;
include<honeycomb.scad>
include<nutsnbolts/cyl_head_bolt.scad>


/* [Global] */
//Part(s):
parts = "all"; //[lower,upper,usb-drawer,all]
//Do you wan't a Keyring?
keyring = "Yes"; //[Yes,No,I'm Chuck Norris]
//Distance between the screws
length = 85;  //[30:150]
//With of all parts
width = 30;   //[10:50]
//Thickness of the main parts
thickness = 3.5;  //[1:0.1:5]

/* [Bevel] */
//Bevel height of the main part
bevel_height = 1.2; //[0:0.1:5]
//Bevel offset of the main part
bevel_offset = 1.2; //[0:0.1:5]
//Bevel height of finger holes
finger_bevel_height = 1.2; //[0:0.1:5]
//Bevel offset of finger holes
finger_bevel_offset = 1.2; //[0:0.1:5]
//should the middle hole have a bevel?
middle_hole_bevel = true; //[Yes:true,No:false]

/* [Honeycomb Pattern] */
//distance between screws and the begin of the pattern (on each side)
honeycomb_pattern_offset = 8; //[3:75]
//vertical hex-segments
hex_segments = 6; //[2:1:25]
//thickness of the hex-pillars
hex_pattern_thickness = 1; //[0.4:0.1:3]
//width of the hex-pattern (experimental)
hex_pattern_width = 18.9; //[3:0.1:45]

/* [Text] */
//style of the text on the usb-drawer
usb_text_style = "in"; //[in,out]
//font of the text on the usb-drawer, all of Google's fonts are supported in Customizer
font_usb = "";

/* [Hidden] */
//epsilon (prevents flickering), don't change unless you know what you're doing
e = 0.001;
/*//text on the lower part
your_text = "free as in freedom (CC-BY-SA)";
//font of the text on the lower part
font = "Ubuntu Mono";*/

module FlashDriveDrawer() {
    //a is the legth of one side of the hexagon of the main parts
    a = width*sin(30);
    dx = cos(30)*(a/2);
    dy = sin(30)*(a/2);

    difference()
    {
        cylinder(6.6, d=width, $fn=6);
        translate([0,0,-e])cylinder(thickness*2,d=4);
        union()
        {
          translate([-5.95,0,1])cube([11.9,20,4.6]);
        }
        if(usb_text_style == "indented" || usb_text_style == "in")
        {
          translate([width/2-dy,dx,3.3]) rotate([90,0,120])translate([0,0,-0.49])linear_extrude(height = .5)text("USB",4,halign="center", valign="center");
          translate([-width/2+dy,dx,3.3])rotate([90,0,-120])translate([0,0,-0.49])linear_extrude(height = 0.5)text("USB",4,halign="center", valign="center");
        }
    }
    if(usb_text_style == "outdented" || usb_text_style == "out")
    {
      translate([width/2-dy,dx,3.3]) rotate([90,0,120])translate([0,0,0])linear_extrude(height = .5)text("USB",4,halign="center", valign="center");
      translate([-width/2+dy,dx,3.3])rotate([90,0,-120])translate([0,0,0])linear_extrude(height = 0.5)text("USB",4,halign="center", valign="center");
    }

}

module MainPart(part)
{
  difference() {
      union()
      {
        //main part
        hull()
        {
          //big lower part of bevel
          translate([0,0,0])cylinder(thickness-bevel_height, d=width, $fn=6);
          translate([0,length,0])cylinder(thickness-bevel_height, d=width, $fn=6);
          //small upper part of bevel
          translate([0,0,thickness-bevel_height])cylinder(bevel_height, d=width-2*bevel_offset, $fn=6);
          translate([0,length,thickness-bevel_height])cylinder(bevel_height, d=width-2*bevel_offset, $fn=6);
        }
        //keyring
        if(part == "upper" && keyring=="Yes") translate([-17,-6,0])cylinder(3.5, d=17, $fn=6);
      }
      //screw holes
      translate([0,0,-e])cylinder(8, d=3);
      translate([0,length,-e])cylinder(8, d=3);


      //holes for the upper part like nut holes and finger holes
      if(part == "upper")
      {
        //nut holes
        hull()translate([0,length,thickness+.1])nut("M3");
        hull()translate([0,0,thickness+.1])nut("M3");

        //keyring hole
        translate([-17,-6,-e])cylinder(thickness*2, d=9, $fn=6);

        //finger holes
        translate([-14,length*(2/3),-e])cylinder(thickness*2, d=17, $fn=6);
        translate([14,length*(1/3),-e])cylinder(thickness*2, d=17, $fn=6);
        translate([0,length/2,-e])cylinder(thickness*2, d=14, $fn=6);
        //finger hole bevels
        finger_hole_bevel_height = thickness-finger_bevel_height;
        hull(){
          translate([-14,length*(2/3),finger_hole_bevel_height])cylinder(e, d=17, $fn=6);
          translate([-14,length*(2/3),thickness])cylinder(e, d=17+2*bevel_offset, $fn=6);
        }
        hull(){
          translate([14,length*(1/3),finger_hole_bevel_height])cylinder(e, d=17, $fn=6);
          translate([14,length*(1/3),thickness])cylinder(e, d=17+2*bevel_offset, $fn=6);
        }
        if(middle_hole_bevel == true)
        {
          hull(){
            translate([0,length/2,finger_hole_bevel_height])cylinder(e, d=14, $fn=6);
            translate([0,length/2,thickness])cylinder(e, d=14+2*bevel_offset, $fn=6);
          }
        }
      }
      //holes for the lower part like hex-pattern
      if(part == "lower")
      {
        hex_element_size =(length-2*honeycomb_pattern_offset-(hex_segments+1)*hex_pattern_thickness)/hex_segments;
        translate([-hex_pattern_width/2,honeycomb_pattern_offset,0])
          antiHoneycomb(hex_pattern_width, length-2*honeycomb_pattern_offset, 10, hex_element_size
          , hex_pattern_thickness);
        //translate([-10.5,length/2,0.49])rotate([0,180,90])linear_extrude(height = 0.5) text("Designed by Mattis Männel",4,"Ubuntu",halign="center");

        //translate([10.4,length/2,0.49])rotate([0,180,90])linear_extrude(height = 0.5) text(your_text,3.8,"Ubuntu Mono",halign="center", valign="top");
        //screw head spaces
        translate([0,0,thickness-2+e])cylinder(2, d1=3, d2=6);
        translate([0,length,thickness-2+e])cylinder(2, d1=3, d2=6);
      }
  }
}

if(parts == "usb-drawer" || parts == "usb_drawer")
{
  FlashDriveDrawer();
}

if(parts == "upper" || parts == "lower")
{
  MainPart(parts);
}

if(parts ==  "all")
{
  translate([-width/2-3,0,0])MainPart("upper");
  translate([width/2+3,0,0])MainPart("lower");
  translate([0,-width,0])FlashDriveDrawer();
}
