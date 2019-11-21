////CableHolder+spade.scad
////OpenSCAD 2015.03-2
////Kijja Chaovanakij
////2019.10.27

/*[var]*/
//number of fragments[40=low,60=medium,90=high]
$fn=90;
//tolerance[0.2]
tol=0.2;

/*[cable holder var]*/
//holder inner diameter[10]
h_in_dia=10; //[5:0.2:50]
//holder ring width[2.4]
h_ring_wid=2.4; //[1.8:0.2:8]
//holder ring thickness[2.4]
h_ring_thi=6.4;
//holder thickness[2.4]
cus_h_thi=10.4; //[2:0.5:50]
//holder center offset from base[24]
cus_h_offset=15;
//holder rotatation
h_rot=1; //[0:middle,1:top,2:bottom]
//holder split width[2.4]
cus_h_split_wid=7.4;

/*[spade var]*/
//spade inner diameter[4]
s_in_dia=4;
//spade edge width[3.2]
s_edge_wid=3.2;
//spade thickness[1.8]
s_thi=3.8;
//spade center offset from back of holder[12]
cus_s_offset=13;

////translate var
h_out_dia=h_in_dia+h_ring_wid*2;
  echo("h_out_dia=",h_out_dia);
s_out_dia=s_in_dia+s_edge_wid*2;
  echo("s_out_dia=",s_out_dia);
h_offset=max(cus_h_offset,h_out_dia/2+s_thi);
  echo("h_offset=",h_offset);
s_offset=max(cus_s_offset,s_out_dia/2+h_in_dia/2+h_ring_wid);
  echo("s_offset=",s_offset);
min_h_thi=max(cus_h_thi,h_ring_thi/2);
h_thi=min(min_h_thi,s_out_dia);
  echo("h_thi=",h_thi);
h_split_wid=min(h_in_dia,cus_h_split_wid);
  echo("h_split_wid=",h_split_wid);
cham_size=(h_out_dia-s_out_dia)/2;
  echo("cham_size=",cham_size);

////main
if (h_rot==0){
  spade();
  holder();
  linear_extrude(s_thi){
    translate([-h_thi,s_out_dia/2,0])
      rotate([0,0,90])
        chamfer();
    translate([-h_thi,-s_out_dia/2,0])
      rotate([0,0,180])
        chamfer();
  }//l
}//i
if (h_rot==1){
  spade();
  translate([0,s_out_dia/2,0])
    rotate(90)
      holder();
  linear_extrude(s_thi){
    difference(){
      square([h_out_dia,s_out_dia],true);
      translate([h_out_dia/2,-s_out_dia/2,0])
        rotate([0,0,90])
          chamfer();
    }//d
  }//l
}//i
if (h_rot==2){
  spade();
  translate([0,-s_out_dia/2,0])
    rotate(-90)
      holder();
  linear_extrude(s_thi){
    difference(){
      square([h_out_dia,s_out_dia],true);
      translate([h_out_dia/2,s_out_dia/2,0])
        rotate([0,0,180])
          chamfer();
    }//d
  }//l
}//i
//

module spade(){
linear_extrude(s_thi)
difference(){
  hull(){
    translate([-s_offset/2,0,0])
      square([s_offset,s_out_dia],true);
    translate([-s_offset,0,0])
      circle(d=s_out_dia);
  }//h
  translate([-s_offset,0,0])
    circle(d=s_in_dia+tol);
  translate([-(s_offset+s_out_dia/4),0,0])
    square([s_out_dia/2,s_in_dia+tol],true);
}//d
}//m
//

module holder(){
rotate([0,-90,0]){
  color("yellow")
  difference(){
    linear_extrude(h_ring_thi)
      union(){
        translate([h_offset,0,0])
          circle(d=h_out_dia);
        translate([h_offset-h_out_dia/4,0,0])
          square([h_out_dia/2,h_out_dia],true);
      }//u
    translate([h_offset,0,-0.05])
      linear_extrude(h_ring_thi+0.1)
        circle(d=h_in_dia+tol);
    translate([h_offset+h_out_dia/2,0,-0.05])
      linear_extrude(h_ring_thi+0.1)
        square([h_out_dia,h_split_wid],true);
  }//d

  if (h_offset-h_out_dia/2-h_thi<=0){
    color("pink")
    hull(){
      translate([h_offset-h_out_dia/2,0,0])
        linear_extrude(h_ring_thi)
          square([0.01,h_out_dia],true);
      translate([s_thi,0,0])
        linear_extrude(h_thi)
          square([0.01,h_out_dia],true);
    }//h
    translate([s_thi/2,0,0])
      linear_extrude(h_thi)
        square([s_thi,h_out_dia],true);
  }//i

  if (h_offset-h_out_dia/2-h_thi>0){
    color("pink")
    hull(){
      translate([h_offset-h_out_dia/2,0,0])
        linear_extrude(h_ring_thi)
          square([0.01,h_out_dia],true);
      translate([h_offset-h_out_dia/2-h_thi,0,0])
        linear_extrude(h_thi)
          square([0.01,h_out_dia],true);
    }//h
    translate([(h_offset-h_out_dia/2-h_thi)/2,0,0])
      linear_extrude(h_thi)
        square([h_offset-h_out_dia/2-h_thi,h_out_dia],true);
  }//i
}//r
}//m
//

module chamfer(){
difference(){
square([cham_size,cham_size]);
translate([cham_size,cham_size,0])
  circle(d=cham_size*2);
}//d
}//m