////----BlowerTip.scad----
////----OpenSCAD 2015.03-2----
////----2018.7.12----
////----By Kijja Chaovanakij----
////Base's parameters refer to Delta dc brushless fan model BFB1012H
////----2018.7.20----
////----revise translation var

/* [var] */
//number of fragments[30=low:40=medium:60=high]
$fn=30;
//view angle
$vpr=[65,0,75];

/* [base var] */
//fit tolerance between base and blower fan[0.3]
fit_tol=0.3;
//inner base or outer object x size[32.9]
base_xsize=32.9;
//inner base or outer object y size[57.8]
base_ysize=57.8;
//inner base or outer object z overlap[11]
base_zsize=11;
//inner base or outer object corner radius[2.5]
base_rad=2.5;

/* [tip var] */
//tip thickness[1.6]
tip_thk=1.6;
//inner tip x size[32]
tip_xsize=24;
//inner tip y size[12]
tip_ysize=12;
//inner tip radius[7]
tip_rad=7;
//tip z size[14]
tip_zsize=14;
//tip y offset from center of the fan's discharge port [0-100]
tip_yoffset=15;
//tip type[1=rectangular:2=slot:other number=round]
tip_type=2;
//rotate tip[1=verical:other number=horizontal]
tip_rotate=0;
//chamfered length between base and tip. It should be almost twice of the fan's bigger base size.[115.6]
cham_zsize=90;

////----translate var----
bxc2c=base_xsize-base_rad*2;
byc2c=base_ysize-base_rad*2;
txc2c=tip_xsize-base_rad*2;
tyc2c=tip_ysize-base_rad*2;

////----main----
hollow_base();
translate([0,0,base_zsize])
  hollow_chamfer();
translate([0,tip_yoffset,base_zsize+cham_zsize])
  hollow_tip(tip_zsize);
//

module hollow_base(){
  difference(){
    tetra_round_box(bxc2c,byc2c,base_zsize,base_rad+tip_thk);

    translate([0,0,-0.001])
    tetra_round_box(bxc2c,byc2c,base_zsize+0.005,base_rad+fit_tol);
  }
}
//

module hollow_chamfer(){
  color("Orange")
  difference(){
    hull(){
      tetra_round_box(bxc2c,byc2c,0.01,base_rad+tip_thk);

      translate([0,tip_yoffset,cham_zsize])
      if (tip_rotate==1)
        rotate([0,0,90])
        outer_tip(0.01);
      else
        outer_tip(0.01);
    }

    hull(){
      translate([0,0,-0.001])
      tetra_round_box(bxc2c,byc2c,0.015,base_rad+fit_tol);

      translate([0,tip_yoffset,cham_zsize-0.001])
      if (tip_rotate==1)
        rotate([0,0,90])
        inner_tip(0.015);
      else
        inner_tip(0.015);
    }
  }
}
//

module hollow_tip(tip_zsize){
  if (tip_rotate==1)
    rotate([0,0,90])
    difference(){
      outer_tip(tip_zsize);
      translate([0,0,-0.001])
      inner_tip(tip_zsize+0.005);
    }
  else
    difference(){
      outer_tip(tip_zsize);
      translate([0,0,-0.001])
      inner_tip(tip_zsize+0.005);
    }
}
//

module outer_tip(tip_zsize){
  if (tip_type==1)
    tetra_round_box(txc2c,tyc2c,tip_zsize,base_rad+tip_thk);
    
  else if (tip_type==2)
    dual_round_box(txc2c,tip_zsize,tip_rad+tip_thk);

  else
     cylinder(tip_zsize,tip_rad+tip_thk,tip_rad+tip_thk);
}
//

module inner_tip(tip_zsize){
  if (tip_type==1)
    tetra_round_box(txc2c,tyc2c,tip_zsize,base_rad+fit_tol);
    
  else if (tip_type==2)
    dual_round_box(txc2c,tip_zsize,tip_rad+fit_tol);

  else
     cylinder(tip_zsize,tip_rad+fit_tol,tip_rad+fit_tol);
}
//

module tetra_round_box(xsize,ysize,height,rounding){
  hull(){
    for (i=[-xsize/2,xsize/2])
      for (j=[-ysize/2,ysize/2])
        translate([i,j,0])
        cylinder(height,rounding,rounding);
  }
}
//

module dual_round_box(xsize,height,rounding){
  hull(){
    for (i=[-xsize/2,xsize/2])
      translate([i,0,0])
      cylinder(height,rounding,rounding);
  }
}
//