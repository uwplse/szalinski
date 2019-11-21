////----PhoneCase.scad----
////----OpenSCAD 2015.03-2----
////----2018.7.30----
////----By Kijja Chaovanakij----

////----feature: 1-customizable phone size (x / y / z / corner radius), 2-ear socket with selectable side, 3-two slots on back cover, 4-two slots on top, left, and right side, 5-three slots on bottom side, 6-array holes on back cover, 7-text on back cover, 8-round corner on back cover, 9-test print some part of the case.

/* [var] */
//number of fragments[30=low:40=medium:60=high]
$fn=30;
//fit between case and phone[0.25]
fit_tol=0.25;
//adjust slot clearance[0.8]
slot_cl_adj=0.8;
//adjust the depth of slot, for the slot close to the phone's round corner[0.25-2.00]
slot_dep_adj=0.25;
//cut array holes on the back cover[0=no:1=yes]
array_hole=0;
//text chars on the back cover[""=no text]
chars="Mupa Academy";
//x factor of the text location[-0.3 to 0.3]
text_xlocat_factor=0;
//y factor of the text location[-0.45 to 0.45]
text_ylocat_factor=-0.35;
//factor of the test print part[-0.5 to 0.5 =top or bottom part:0=no test print part]
test_print=0;

/* [phone dimension var] */
//phone width[72.36]
phone_wid=72.36;
//phone length[143.82]
phone_len=143.82;
//phone thickness[9.1]
phone_thk=9.1;
//phone corner radius[5.0]
phone_rad=5.0;

/* [case var] */
//case's back cover thickness[1.2]
case_thk=1.2;
//case's wall thickness[1.0]
case_wall_thk=1.0;
//case's front lip size[1.2]
case_lip=1.2;
//inner rounding radius between back cover and case wall[1.2]
rounding=1.2;

/* [ear socket var] */
//side of ear socket[1=top:2=bottom:3=left:4=right]
es_side=1;
//ear socket diameter[3.6]
es_dia=3.6;
//phone's left edge to ear socket's edge[41.5]
es_xoffset=41.5;
//phone's bottom edge to ear socket's edge[143.8]
es_yoffset=143.8;
//phone's back cover to ear socket's edge[1.3]
es_zoffset=1.3;

/* [back cover var] */
//number of back cover slot[0-2]
bc_num=2;
//back cover slot 1 x size[9.0]
bc1_xsize=9;
//back cover slot 1 y size[17.5]
bc1_ysize=17.5;
//back cover slot 1 x offset from left edge[54.5]
bc1_xoffset=55.0;
//back cover slot 1 y offset from bottom edge[122.8]
bc1_yoffset=122.8;
//back cover slot 2 x size[14.4]
bc2_xsize=14.4;
//back cover slot 2 y size[2.0]
bc2_ysize=2.0;
//back cover slot 2 x offset from left edge[35.0]
bc2_xoffset=35.0;
//back cover slot 2 y offset from bottom edge[12.0]
bc2_yoffset=12.0;

/* [top edge var] */
//number of top edge slot[0-2]
te_num=0;
//top edge slot 1 x size
te1_xsize=4;
//top edge slot 1 z size
te1_zsize=1.4;
//top edge slot 1 x offset from left edge
te1_xoffset=24;
//top edge slot 1 z offset from back cover
te1_zoffset=4;
//top edge slot 2 x size
te2_xsize=4;
//top edge slot 2 z size
te2_zsize=1.4;
//top edge slot 2 x offset from left edge
te2_xoffset=54;
//top edge slot 2 z offset from back cover
te2_zoffset=4;

/* [bottom edge var] */
//number of bottom edge slot[0-3]
be_num=1;
//bottom edge slot 1 x size[12]
be1_xsize=12;
//bottom edge slot 1 z size[2.5]
be1_zsize=2.5;
//bottom edge slot 1 x offset from left edge[53]
be1_xoffset=53;
//bottom edge slot 1 z offset from back cover[3.3]
be1_zoffset=3.3;
//bottom edge slot 2 x size
be2_xsize=12;
//bottom edge slot 2 z size
be2_zsize=2.5;
//bottom edge slot 2 x offset from left edge
be2_xoffset=8;
//bottom edge slot 2 z offset from back cover
be2_zoffset=3.2;
//bottom edge slot 3 x size
be3_xsize=15;
//bottom edge slot 3 z size
be3_zsize=3.6;
//bottom edge slot 3 x offset from left edge
be3_xoffset=28.2;
//bottom edge slot 3 z offset from back cover
be3_zoffset=2.5;

/* [left edge var] */
//number of left edge slot[0-2]
le_num=1;
//left edge slot 1 y size[18.8]
le1_ysize=18.8;
//left edge slot 1 z size[1.3]
le1_zsize=1.3;
//left edge slot 1 y offset from bottom edge[105]
le1_yoffset=105;
//left edge slot 1 z offset from back cover[4.5]
le1_zoffset=4.5;
//left edge slot 2 y size
le2_ysize=4;
//left edge slot 2 z size
le2_zsize=1.4;
//left edge slot 2 y offset from bottom edge
le2_yoffset=24;
//left edge slot 2 z offset from back cover
le2_zoffset=4;

/* [right edge var] */
//number of right edge slot[0-2]
re_num=1;
//right edge slot 1 y size[9.9]
re1_ysize=9.9;
//right edge slot 1 z size[1.3]
re1_zsize=1.3;
//right edge slot 1 y offset from bottom edge[111]
re1_yoffset=111;
//right edge slot 1 z offset from back cover[4.5]
re1_zoffset=4.5;
//right edge slot 2 y size
re2_ysize=4;
//right edge slot 2 z size
re2_zsize=1.4;
//right edge slot 2 y offset from bottom edge
re2_yoffset=24;
//right edge slot 2 z offset from back cover
re2_zoffset=4;

////----translate var----
//center to center of x corner radius
c2c_xwid=phone_wid-phone_rad*2;
//center to center of y corner radius
c2c_ywid=phone_len-phone_rad*2;
//case hight
case_hi=phone_thk+case_thk+case_lip/2;
//top edge slot 1 y offset from bottom edge
te1_yoffset=phone_len;
//top edge slot 2 y offset from bottom edge
te2_yoffset=phone_len;
//right edge slot 1 x offset from left edge
re1_xoffset=phone_wid;
//right edge slot 2 x offset from left edge
re2_xoffset=phone_wid;

////----main----
difference()
{
union(){
  difference(){
    translate([phone_rad,phone_rad,-case_thk])
      hull(){
        for (i=[0,c2c_xwid])
          for (j=[0,c2c_ywid])
            translate([i,j,0])
              roundCylinder(
                phone_thk+case_thk+case_lip/2,
                phone_rad+fit_tol+case_wall_thk,
                rounding+case_wall_thk);
      }

    //cut inside case
    translate([phone_rad,phone_rad,0])
      color("orange")
      hull(){
        for (i=[0,c2c_xwid])
          for (j=[0,c2c_ywid])
            translate([i,j,0])
              roundCylinder(
                phone_thk+case_lip,
                phone_rad+fit_tol,
                rounding);
      }

    //cut ear jack hole
    ear_jack();

    //cut back cover slot
    back_cover();

    //cut top edge slot
    top_edge();

    //cut bottom edge slot
    bottom_edge();

    //cut left edge slot
    left_edge();

    //cut right edge slot
    right_edge();

    //cut back cover array hole
    if (array_hole==1)
    translate([
        phone_wid/2,
        phone_len/2,
        -case_thk-0.1])
      for (i=[-phone_wid/3:phone_wid/6:phone_wid/3])
        for (j=[
            -phone_len/4:
            phone_len/8:
            phone_len/4])
          translate([i,j-3,0])
            scale([1,1.5,1])
              cylinder(2,phone_wid/19,phone_wid/19);

    //cut back cover text
    color("red")
      translate([
          phone_wid/2-phone_wid*text_xlocat_factor,
          phone_len/2+phone_len*text_ylocat_factor,
          -case_thk/2])
        rotate([0,180,0])
          linear_extrude(
              height=case_thk,
              //center=true,
              convexity=10)
            text(
              chars,
              size=phone_wid/10,
              font="LiberationMono-Bold",
              halign="center",
              valign="center");
  }

  //add top edge lip
  translate([
      phone_rad+c2c_xwid/2,
      phone_len+fit_tol,
      phone_thk+case_lip/2])
    rotate([0,0,180])
      resize ([c2c_xwid*2/3,0,0])
        lip();

  //add bottom edge lip
  translate([
      phone_rad+c2c_xwid/2,
      -fit_tol,
      phone_thk+case_lip/2])
    resize ([c2c_xwid*2/3,0,0])
      lip();

  //add left edge lip
  translate([
      -fit_tol,
      phone_rad+c2c_ywid/4,
      phone_thk+case_lip/2])
    rotate([0,0,-90])
      resize ([c2c_ywid/3,0,0])
        lip();
  translate([
      -fit_tol,
      phone_rad+c2c_ywid*3/4,
      phone_thk+case_lip/2])
    rotate([0,0,-90])
      resize ([c2c_ywid/3,0,0])
        lip();

  //add right edge lip
  translate([
      phone_wid+fit_tol,
      phone_rad+c2c_ywid/4,
      phone_thk+case_lip/2])
    rotate([0,0,90])
      resize ([c2c_ywid/3,0,0])
        lip();
  translate([
      phone_wid+fit_tol,
      phone_rad+c2c_ywid*3/4,
      phone_thk+case_lip/2])
    rotate([0,0,90])
      resize ([c2c_ywid/3,0,0])
        lip();    
}    
////----end main----

//cut test print
if (test_print!=0)
  translate([
      phone_wid/2,
      phone_len/2-phone_len*test_print,
      phone_thk/2])
    cube([
      phone_wid+4,
      phone_len+4,
      phone_thk+4],
      true);
}
//

module lip(){
translate([0,case_lip/2,-case_lip/2])
rotate([-45,0,0])
  difference(){
    rotate([45,0,0])
      cube([1,case_lip,case_lip],true);
    translate([-1,0,-1])
      cube([2,2,2]);
  }
}
//

module right_edge(){
if (re_num>=1)
  translate([
    re1_xoffset+case_wall_thk/2+fit_tol*1,
    re1_yoffset+re1_ysize/2,
    re1_zoffset+re1_zsize/2])
  rotate([0,-90,0])
  xe_slot(
    re1_ysize,
    re1_zsize,
    case_wall_thk+slot_dep_adj);

if (re_num==2)
  translate([
    re2_xoffset+case_wall_thk/2+fit_tol*1,
    re2_yoffset+re2_ysize/2,
    re2_zoffset+re2_zsize/2])
  rotate([0,-90,0])
  xe_slot(
    re2_ysize,
    re1_zsize,
    case_wall_thk+slot_dep_adj);
}
//

module left_edge(){
//left edge slot 1 x offset from left edge
le1_xoffset=0;
//left edge slot 2 x offset from left edge
le2_xoffset=0;

if (le_num>=1)
  translate([
    le1_xoffset-case_wall_thk/2-fit_tol*1,
    le1_yoffset+le1_ysize/2,
    le1_zoffset+le1_zsize/2])
  rotate([0,90,0])
  xe_slot(
    le1_ysize,
    le1_zsize,
    case_wall_thk+slot_dep_adj);

if (le_num==2)
  translate([
    le2_xoffset-case_wall_thk/2-fit_tol*1,
    le2_yoffset+le2_ysize/2,
    le2_zoffset+le2_zsize/2])
  rotate([0,90,0])
  xe_slot(
    le2_ysize,
    le1_zsize,
    case_wall_thk+slot_dep_adj);
}
//

module xe_slot(ysize,zsize,thick){
hull(){
  for (i=[-ysize/2+zsize/2,ysize/2-zsize/2])
    translate([0,i,0])
    cylinder(
      thick,
      zsize/2+slot_cl_adj*3.2,
      zsize/2+slot_cl_adj*1.6,
      true);
 }
}
//

module bottom_edge(){
//bottom edge slot 1 y offset from bottom edge
be1_yoffset=0;
//bottom edge slot 2 y offset from bottom edge
be2_yoffset=0;
//bottom edge slot 3 y offset from bottom edge
be3_yoffset=0;

if (be_num>=1)
  translate([
    be1_xoffset+be1_xsize/2,
    be1_yoffset-case_wall_thk/2-fit_tol*1,
    be1_zoffset+be1_zsize/2])
  rotate([-90,0,0])
  ye_slot(
    be1_xsize,
    be1_zsize,
    case_wall_thk+slot_dep_adj);

if (be_num>=2)
  translate([
    be2_xoffset+be2_xsize/2,
    be2_yoffset-case_wall_thk/2-fit_tol*1,
    be2_zoffset+be2_zsize/2])
  rotate([-90,0,0])
  ye_slot(
    be2_xsize,
    be2_zsize,
    case_wall_thk+slot_dep_adj);  

if (be_num==3)
  translate([
    be3_xoffset+be3_xsize/2,
    be3_yoffset-case_wall_thk/2-fit_tol*1,
    be3_zoffset+be3_zsize/2])
  rotate([-90,0,0])
  ye_slot(
    be3_xsize,
    be3_zsize,
    case_wall_thk+slot_dep_adj);  
}
//

module top_edge(){
if (te_num>=1)
  translate([
    te1_xoffset+te1_xsize/2,
    te1_yoffset+case_wall_thk/2+fit_tol*1,
    te1_zoffset+te1_zsize/2])
  rotate([90,0,0])
  ye_slot(
    te1_xsize,
    te1_zsize,
    case_wall_thk+slot_dep_adj);

if (te_num==2)
  translate([
    te2_xoffset+te2_xsize/2,
    te2_yoffset+case_wall_thk/2+fit_tol*1,
    te2_zoffset+te2_zsize/2])
  rotate([90,0,0])
  ye_slot(
    te2_xsize,
    te2_zsize,
    case_wall_thk+slot_dep_adj);  
}
//

module ye_slot(xsize,zsize,thick){
hull(){
 for (i=[-xsize/2+zsize/2,xsize/2-zsize/2])
   translate([i,0,0])
   cylinder(
     thick,
     zsize/2+slot_cl_adj*3.2,
     zsize/2+slot_cl_adj*1.6,
     true);
 }
}
//

module back_cover(){
if (bc_num>=1)
  translate([
    bc1_xoffset+bc1_xsize/2,
    bc1_yoffset+bc1_ysize/2,
    -case_thk/2])
  bc_slot(
    bc1_xsize,
    bc1_ysize,
    case_thk+slot_dep_adj);

if (bc_num==2)
  translate([
    bc2_xoffset+bc2_xsize/2,
    bc2_yoffset+bc2_ysize/2,
    -case_thk/2])
  bc_slot(
    bc2_xsize,
    bc2_ysize,
    case_thk+slot_dep_adj);  
}
//

module bc_slot(xsize,ysize,thick){
  if (xsize >= ysize)
    hull(){
      for (i=[-xsize/2+ysize/2,xsize/2-ysize/2])
        translate([i,0,0])
        cylinder(
          thick,
          ysize/2+slot_cl_adj,
          ysize/2+slot_cl_adj,
          true);
    }
  else
    hull(){
      for (i=[-ysize/2+xsize/2,ysize/2-xsize/2])
        translate([0,i,0])
        cylinder(
          thick,
          xsize/2+slot_cl_adj,
          xsize/2+slot_cl_adj,
          true);
    }  
}
//

module ear_jack(){
if (es_side==1){
  translate([
    es_xoffset+es_dia/2,
    es_yoffset+case_wall_thk/2+fit_tol*1,
    es_zoffset+es_dia/2])
  rotate([90,0,0])
  cylinder(
    case_wall_thk+slot_dep_adj,
    es_dia/2+slot_cl_adj*2.5,
    es_dia/2+slot_cl_adj,
    true);
}
if (es_side==2)
  translate([
    es_xoffset+es_dia/2,
    es_yoffset-case_wall_thk/2-fit_tol*1,
    es_zoffset+es_dia/2])
  rotate([-90,0,0])
  cylinder(
    case_wall_thk+slot_dep_adj,
    es_dia/2+slot_cl_adj*2.5,
    es_dia/2+slot_cl_adj,
    true);

if (es_side==3)
  translate([
    es_xoffset-case_wall_thk/2-fit_tol*1,
    es_yoffset+es_dia/2,
    es_zoffset+es_dia/2])
  rotate([0,90,0])
  cylinder(
    case_wall_thk+slot_dep_adj,
    es_dia/2+slot_cl_adj*2.5,
    es_dia/2+slot_cl_adj,
    true);

if (es_side==4)
  translate([
    es_xoffset+case_wall_thk/2+fit_tol*1,
    es_yoffset+es_dia/2,
    es_zoffset+es_dia/2])
  rotate([0,-90,0])
  cylinder(
    case_wall_thk+slot_dep_adj,
    es_dia/2+slot_cl_adj*2.5,
    es_dia/2+slot_cl_adj,
    true);
}
//

module roundCylinder(height,radius,rounding){
  hull(){
    translate([0,0,height-rounding])
    cylinder(r=radius,h=rounding);

    translate([0,0,rounding])
    rotate_extrude(convexity=10)
      translate([radius-rounding,0,0])
      circle(rounding);
  }
}
//