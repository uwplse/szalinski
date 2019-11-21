////----ExtrudeFan.scad----
////----OpenSCAD 2015.03-2----
////----2018.8.7----
////----By Kijja Chaovanakij----

/* [var] */
//number of fragments[30=low:40=medium:60=high]
$fn=60;
//print test the exact location of bolt hole
print_test=0; //[0:false,1:true]

/* [fan var] */
//fan size[50]
fan_size=50; //[40,50,60]
//fan thickness[15]
fan_thi=15; //[10,12,15,20,25]

/* [bolt var] */
//bolt diameter[3.8]
bolt_dia=3.8; //[2.7:M3,3.8:M4]
//bolt hole clearance[0.3]
bolt_hole_cl=0.3;
//X width between bolt 1 center to bolt 2 center[18]
bolt1_2_c2c=18;
//X width between bolt 2 center to bolt 3 center[14]
bolt2_3_c2c=14;
//X width between bolt 3 center to bolt 4 center[18]
bolt3_4_c2c=18;

/* [vertical plate var] */
//x offset between left or right edge and bolt edge[3]
vplate_lre_xoffset=3; //[3:0.5:5]
//z offset between bolt hole center and bottom of fan[8]
vplate_te_zoffset=8; //[6:1:12]

/* [horizontal plate var] */
//y offset between inner verical plate and fan edge[11]
hplate_vf_yoffset=11; //[8:1:20]
//x offset factor between middle of verical plate and center of fan[-0.5 to 0.5:0=no offset]
hplate_xoffset_factor=0.5; //[-0.6:0.1:0.6]

////----translate var----
vplate_c2c=bolt1_2_c2c+bolt2_3_c2c+bolt3_4_c2c;

////----main----
color("orange"){
  vertical_plate();
  horizontal_plate();
}//c
////----end main----

module horizontal_plate(){
  plate_thi=2;
  if (print_test==0){
    translate([
      0,
      plate_thi/2,
      vplate_te_zoffset+fan_thi+plate_thi/2]){
    
      hull(){
        cube([
          vplate_c2c+bolt_dia+vplate_lre_xoffset*2,
          0.01,
          plate_thi],
          true);
        translate([
          fan_size*hplate_xoffset_factor,
          -hplate_vf_yoffset,
          0])
        rotate([0,0,2.5])
          cube([fan_size*0.85,0.01,plate_thi],true);
      }//h
    
      translate([
        fan_size*hplate_xoffset_factor,
        -hplate_vf_yoffset-fan_size/2+1,
        -plate_thi/2])
      fan_guard(fan_size,plate_thi);
    }//t
  }//i
}//m
//

module vertical_plate(){
  plate_thi=2;
  rotate([90,0,0])
  difference(){
    hull(){
      tetra_cylinder(
        vplate_c2c,
        0,
        plate_thi,
        bolt_dia/2+vplate_lre_xoffset,
        true);
      
      if (print_test==0)
      translate([
        0,
        (vplate_te_zoffset+fan_thi+plate_thi)/2,    0])
      cube([
        vplate_c2c+bolt_dia+vplate_lre_xoffset*2,
        vplate_te_zoffset+fan_thi+plate_thi,
        plate_thi],
        true);
    }//h

    for (i=[
      -bolt1_2_c2c-bolt2_3_c2c/2,
      -bolt2_3_c2c/2,
      bolt2_3_c2c/2,
      bolt3_4_c2c+bolt2_3_c2c/2])
    translate([i,0,0])
    cylinder(
      plate_thi+0.02,
      bolt_dia/2+bolt_hole_cl,
      bolt_dia/2+bolt_hole_cl,
      true);
  }//d
}//m
//

module fan_guard(fan_size,fan_thi){
  if (fan_size==60){
    fan_bolt_hole_dia=4.2;
    fan_hub_dia=33;
    fan_e2e=45.9;
    fan(
      fan_size,
      fan_thi,
      fan_bolt_hole_dia,
      fan_hub_dia,
      fan_e2e);
  }//i

  else if (fan_size==50){
    fan_bolt_hole_dia=4.2;
    fan_hub_dia=27;
    fan_e2e=35.9;
    fan(
      fan_size,
      fan_thi,
      fan_bolt_hole_dia,
      fan_hub_dia,
      fan_e2e);
  }//e

  else if (fan_size==40){
    fan_bolt_hole_dia=3.3;
    fan_hub_dia=26;
    fan_e2e=28.6;
    fan(
      fan_size,
      fan_thi,
      fan_bolt_hole_dia,
      fan_hub_dia,
      fan_e2e);
  }//e
}//m
//

module fan(fan_size,fan_thi,fan_bolt_hole_dia,fan_hub_dia,fan_e2e){
  fan_c2c=fan_e2e+fan_bolt_hole_dia;
  fan_bolt_offset_rad=fan_size/2-fan_c2c/2;
  difference(){
    hull(){
      tetra_cylinder(
        fan_c2c,
        fan_c2c,
        fan_thi,
        fan_bolt_offset_rad,
        false);
    }//h

    translate([0,0,-0.01]){
      tetra_cylinder(
        fan_c2c,
        fan_c2c,
        fan_thi+0.02,
        fan_bolt_hole_dia/2,
        false);
      cylinder(
        fan_thi+0.02,
        fan_size/2-1.2,
        fan_size/2-1.2,
        false);
    }//t
  }//d

  cylinder(
    fan_thi,
    fan_hub_dia/2,
    fan_hub_dia/2,
    false);
  for (i=[45:90:315])
    translate([
      (fan_size/4+fan_hub_dia/4)*cos(i),
      (fan_size/4+fan_hub_dia/4)*sin(i),
      fan_thi/2])
    rotate([0,0,i])  
    cube([
      fan_size/2-fan_hub_dia/2+1,
      fan_bolt_hole_dia,
      fan_thi],
      true);
}//m
//

module tetra_cylinder(xwid,ywid,height,rad,truth){
  for (i=[-xwid/2,xwid/2])
  for (j=[-ywid/2,ywid/2])
    translate([i,j,0])
    cylinder(h=height,r=rad,r=rad,center=truth);
}//m
//
