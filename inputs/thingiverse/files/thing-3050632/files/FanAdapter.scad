////----FanGrill.scad----
////----OpenSCAD 2015.03-2----
////----2018.08.13----
////----By Kijja Chaovanakij----
////----Revise 2019.01.5.Add fan 35,45 mm. in the fan list.

////----The dapter size must be bigger than the fan size.

/*[Basic] */
//number of fragments[40=low:60=medium:90=high]
$fn=60;
//type of fan adapter
adapter_type=1; //[0:spacer,1:adapter]

/*[Adapter And Fan]*/
//adapter size[4] must greater than fan size
adapter_select=5; //[0:fan25,1:fan30,2:fan35,3:fan40,4:fan45,5:fan50,6:fan60,7:fan70,8:fan80,9:fan92,10:fan120,11:fan140]
//adapter thickness[2]
adapter_thi=2; //[1.6:0.2:3.2]
//The gap between the adapter and the fan, if the item is not up to an automatic size, the script will use the automatic size.
adapter_fan_gap=5; //[3:1:80]

//fan size[3] must be smaller than adapter size
fan_select=3; //[0:fan25,1:fan30,2:fan35,3:fan40,4:fan45,5:fan50,6:fan60,7:fan70,8:fan80,9:fan92,10:fan120,11:fan140]
//fan spacer thickness[2]
fan_thi=2; //[1.6:0.2:40]
//minimun border size[1.0]
min_border=1.0; //[0.8:0.2:2.0]
//degree of fan base rotation to avoid intersection of holes.[15]
fan_rotate=15; //[0:0.5:25]

/*[Grill]*/
//type of grill
grill_type=1; //[0:no grill,1:line,2:circular]
//grill line size[1.8]
grill_size=1.8; //[1.2:0.2:3.2]
//grill line thickness[1.8]
grill_thi=1.8; //[1.2:0.2:3.2]
//grill space factor[3.5]
grill_sp_factor=3.5; //[3.0:0.25:5.0]

/*[Hidden]*/
size=25;
bolt_c2c=20;
hole_dia=2.9;
//do not edit this section
fan25=[[size,25],[bolt_c2c,20],[hole_dia,2.9]];
fan30=[[size,30],[bolt_c2c,24],[hole_dia,3.2]];
fan35=[[size,35],[bolt_c2c,29],[hole_dia,3.2]];
fan40=[[size,40],[bolt_c2c,32],[hole_dia,3.4]];
fan45=[[size,45],[bolt_c2c,37],[hole_dia,4.3]];
fan50=[[size,50],[bolt_c2c,40],[hole_dia,4.3]];
fan60=[[size,60],[bolt_c2c,50],[hole_dia,4.3]];
fan70=[[size,70],[bolt_c2c,61.5],[hole_dia,4.3]];
fan80=[[size,80],[bolt_c2c,72],[hole_dia,4.3]];
fan92=[[size,92],[bolt_c2c,82.5],[hole_dia,4.3]];
fan120=[[size,120],[bolt_c2c,105],[hole_dia,4.3]];
fan140=[[size,140],[bolt_c2c,126],[hole_dia,4.3]];
fan_list=[fan25,fan30,fan35,fan40,fan45,fan50,fan60,
          fan70,fan80,fan92,fan120,fan140];

////----translate var----
adapter_size=fan_list[adapter_select];
asize=lookup(size,adapter_size);
ac2c=lookup(bolt_c2c,adapter_size);
ahole_rad=lookup(hole_dia,adapter_size)/2;
acorner_rad=(asize-ac2c)/2;
ainner_rad=asize/2-min_border;

fan_size=fan_list[fan_select];
fsize=lookup(size,fan_size);
fc2c=lookup(bolt_c2c,fan_size);
fhole_rad=lookup(hole_dia,fan_size)/2;
fcorner_rad=(fsize-fc2c)/2;
finner_rad=fsize/2-min_border;
cone_hi=max(adapter_fan_gap,(asize-fsize)/2);
echo("cone_hi",cone_hi);

////----main----
if (adapter_type==1)
  adapter();
else
  spacer();
////----end main----

module adapter(){
  difference(){
    union(){
//adapter plate
      color("tan")
      translate([0,0,adapter_thi/2])
        frame(asize,ac2c,
          adapter_thi,ainner_rad,
          acorner_rad,true);
//fan plate
      color("yellow")
      translate([0,0,
        adapter_thi+cone_hi+fan_thi/2])
      rotate([0,0,fan_rotate])
        frame(fsize,fc2c,fan_thi,
          finner_rad,fcorner_rad,true);
//fan plate support
      translate([0,0,adapter_thi+cone_hi/2])
      rotate([0,0,fan_rotate])
        frame(fsize,fc2c,cone_hi,
          finner_rad,fcorner_rad,true);
//cone
      translate([0,0,adapter_thi+cone_hi/2])
        cylinder(cone_hi,asize/2,fsize/2,true);
    }//u
//cut inner fan plate support
    translate([0,0,adapter_thi+cone_hi/2])
      cylinder(cone_hi+0.01,ainner_rad,
        finner_rad,true);
//cut adapter bolt hole
    translate([0,0,adapter_thi/2])
      tetra_cylinder(ac2c,ac2c,
        adapter_thi+0.01,ahole_rad,true);
//cut fan bolt hole
    translate([0,0,adapter_thi+cone_hi/2+fan_thi/2])
    rotate([0,0,fan_rotate])
      tetra_cylinder(fc2c,fc2c,
        cone_hi+fan_thi+0.01,fhole_rad,true);
  }//d
}//m
//

module spacer(){
  color("GreenYellow")
  difference(){
    union(){
//fan plate
      translate([0,0,fan_thi/2])
        frame(fsize,fc2c,fan_thi,
          finner_rad,fcorner_rad,true);
//add line grill
      if (grill_type==1)
        translate([0,0,grill_thi/2])
          line_grill();
//add circular grill
      if (grill_type==2)
        translate([0,0,grill_thi/2])
          cicular_grill();
    }//u
//cut fan bolt hole
    translate([0,0,fan_thi/2])
      tetra_cylinder(fc2c,fc2c,
        fan_thi+0.01,fhole_rad,true);
  }//d
}//m
//

module cicular_grill(){
//diagonal line
  for (i=[45,135])
    rotate([0,0,i])
      cube([fsize-min_border,grill_size*1.5,
        grill_thi],true);
//circular line
  for (i=[finner_rad-grill_size*grill_sp_factor:
      -grill_size*grill_sp_factor:0])
    difference(){
      cylinder(grill_thi,i+grill_size/2,
        i+grill_size/2,true);
      if (i > grill_size*4)
        cylinder(grill_thi+0.01,
          i-grill_size/2,i-grill_size/2,true);
    }//d
}//m
//

module line_grill(){
//x axis line
  for (i=[0:grill_size*grill_sp_factor:
      fc2c/2])
    translate([0,i,0])
      cube([fsize-min_border,grill_size,
        grill_thi],true);
  for (i=[0:-grill_size*grill_sp_factor:
      -fc2c/2])
    translate([0,i,0])
      cube([fsize-min_border,grill_size,
        grill_thi],true);
//y axis line
  if (fsize > 80)
    for (i=[-fsize/6,fsize/6])
      translate([i,0,0])
        cube([grill_size*1.5,
          fsize-min_border,grill_thi],true);
  else if (fsize > 40)
    cube([grill_size*1.5,
      fsize-min_border,grill_thi],true);
}//m
//

module frame(size,c2c,height,inner_rad,c_rad,truth){
  difference(){
    hull(){
      for (i=[-c2c/2,c2c/2])
      for (j=[-c2c/2,c2c/2])
        translate([i,j,0])
      cylinder(h=height,r=c_rad,
        r=c_rad,center=truth);
    }//h
    cylinder(height+0.01,inner_rad,inner_rad,truth);
  }//d
}//m
//

module tetra_cylinder(xwid,ywid,height,rad,truth){
  for (i=[-xwid/2,xwid/2])
  for (j=[-ywid/2,ywid/2])
    translate([i,j,0])
    cylinder(h=height,r=rad,r=rad,center=truth);
}//m
//