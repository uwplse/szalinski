////----2PartFanAdapter.scad----
////----OpenSCAD 2015.03-2----
////----2018.8.21----
////----By Kijja Chaovanakij----
////
////----The dapter size must be bigger than the fan size.

/*[Basic] */
//number of fragments[40=low:60=medium:90=high]
$fn=40;
//generate parts.[The print test is find the fit of inner duct and outer duct.]
part=4; //[1:print test,2:fan frame,3:adapter frame,4:both frame]

/*[Adapter]*/
//adapter size must greater than fan size
adapter_select=3; //[0:fan25,1:fan30,2:fan40,3:fan50,4:fan60,5:fan70,6:fan80,7:fan92,8:fan120,9:fan140]
//adapter plate thickness[2]
adapter_thi=2; //[1.6:0.2:3.2]
//adapter grill type
adapter_grill_type=0; //[0:no grill,1:circular,2:line]

/*[Fan]*/
//fan size must be smaller than adapter size
fan_select=2; //[0:fan25,1:fan30,2:fan40,3:fan50,4:fan60,5:fan70,6:fan80,7:fan92,8:fan120,9:fan140]
//fan plate thickness[2]
fan_thi=2; //[1.6:0.2:40]
//fan grill type
fan_grill_type=0; //[0:no grill,1:circular,2:line]

/*[Grill]*/
//grill line size[1.8]
grill_size=1.8; //[1.2:0.2:3.2]
//grill line thickness[1.8]
grill_thi=1.8; //[1.2:0.2:3.2]
//grill space factor[3.5]
grill_sp_factor=3.5; //[3.0:0.25:5.0]

/*[Border, Duct and Gap]*/
//minimum border size of fan plate and adapter plate or duct wall thickness 
min_border=1; //[1:0.2:2]
//overlap duct height
duct_hi=8; //[8:1:15]
//fit between inner duct size and inner duct size
duct_tol=0.3; //[0.2,0.3,0.4,0.5]
//The gap between the adapter and the fan, if the item is not up to an automatic size, the script will use the automatic size.
adapter_fan_gap=5; //[5:1:60]
//gap x offset from center, [center=0,align to edge=the difference of fan size devided by two]
gap_xoffset=5; //[0:1:15]
//gap y offset from center, [center=0,align to edge=the difference of fan size divided by two]
gap_yoffset=0; //[0:1:15]

/*[Hidden]*/
size=25;
bolt_c2c=20;
hole_dia=2.9;
//do not edit this section
fan25=[[size,25],[bolt_c2c,20],[hole_dia,2.9]];
fan30=[[size,30],[bolt_c2c,24],[hole_dia,3.3]];
fan40=[[size,40],[bolt_c2c,32],[hole_dia,3.4]];
fan50=[[size,50],[bolt_c2c,40],[hole_dia,4.3]];
fan60=[[size,60],[bolt_c2c,50],[hole_dia,4.3]];
fan70=[[size,70],[bolt_c2c,61.5],[hole_dia,4.3]];
fan80=[[size,80],[bolt_c2c,72],[hole_dia,4.3]];
fan92=[[size,92],[bolt_c2c,82.5],[hole_dia,4.3]];
fan120=[[size,120],[bolt_c2c,105],[hole_dia,4.3]];
fan140=[[size,140],[bolt_c2c,126],[hole_dia,4.3]];
fan_list=[fan25,fan30,fan40,fan50,fan60,
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
cone_hi=max(adapter_fan_gap,(asize-fsize)/2+max(gap_xoffset,gap_yoffset));
echo("cone_hi",cone_hi);

////----main----
/*translate([fsize*2*0-5,-5,adapter_thi+adapter_fan_gap+duct_hi*2+fan_thi-1])
rotate([0,180,0])
small_fan();
adapter_plate();
cone();
//*/

if (part==1)
  print_test();
else if (part==2)
  small_fan();
else if (part==3){
  adapter_plate();
  cone();
}//e
else{
  translate([fsize*0.6,0,])
    small_fan();
  translate([-asize*0.6,0,])
    {adapter_plate();cone();}//t
}//e
////----end main----

module print_test(){
  color("orange")
  translate([-fsize*0.6,0,duct_hi/2])  
  difference(){
//outer duct
    cylinder(duct_hi,fsize/2,fsize/2,true);      
//cut outer duct
    cylinder(duct_hi+0.01,fsize/2-min_border,
      fsize/2-min_border,true);
  }//d
  
  color("yellow")
  translate([fsize*0.6,0,fan_thi/2+duct_hi/2])  
  difference(){
//inner duct
    cylinder(fan_thi+duct_hi,
      fsize/2-min_border-duct_tol,
      fsize/2-min_border-duct_tol,true);
//cut inner duct
    cylinder(fan_thi+duct_hi+0.01,
      fsize/2-min_border*2-duct_tol,
      fsize/2-min_border*2-duct_tol,true);
    }//d
}//m
//

module adapter_plate(){
  color("tan")
  difference(){
    union(){
//fan plate
      translate([0,0,adapter_thi/2])
        frame(ac2c,adapter_thi,
          ainner_rad,acorner_rad,true);
//circular grill
      if (adapter_grill_type==1)
        translate([0,0,grill_thi/2])
          circular_grill(asize,ainner_rad);
//line grill
      else if (adapter_grill_type==2)
        translate([0,0,grill_thi/2])
          line_grill(asize,ac2c);
    }//u
//cut fan bolt hole
    translate([0,0,adapter_thi/2])
      tetra_cylinder(ac2c,ac2c,
        adapter_thi+0.01,ahole_rad,true);
  }//d
}//m
//

module small_fan(){
  color("yellow")
  difference(){
    union(){
//fan plate
      translate([0,0,fan_thi/2])
        frame(fc2c,fan_thi,finner_rad-duct_tol,
          fcorner_rad-duct_tol,true);
//circular grill
      if (fan_grill_type==1)
        translate([0,0,grill_thi/2])
          circular_grill(fsize,finner_rad);
//line grill
      else if (fan_grill_type==2)
        translate([0,0,grill_thi/2])
          line_grill(fsize,fc2c);
    }//u
//cut fan bolt hole
    translate([0,0,fan_thi/2])
      tetra_cylinder(fc2c,fc2c,
        fan_thi+0.01,fhole_rad,true);
  }//d

  color("yellow")
  translate([0,0,fan_thi/2+duct_hi/2])  
  difference(){
//inner duct
    cylinder(fan_thi+duct_hi,
      fsize/2-min_border-duct_tol,
      fsize/2-min_border-duct_tol,true);
//cut inner duct
    cylinder(fan_thi+duct_hi+0.01,
      fsize/2-min_border*2-duct_tol,
      fsize/2-min_border*2-duct_tol,true);
    }//d
}//m
//

module cone(){
  color("orange")
  difference(){
//cone 
    hull(){
      translate([0,0,adapter_thi])
        cylinder(0.001,asize/2,asize/2,true); 
      translate([gap_xoffset,gap_yoffset,adapter_thi+cone_hi])  
        cylinder(0.001,fsize/2,fsize/2,true); 
    }//h
//cut cone
    hull(){
      translate([0,0,adapter_thi])
        cylinder(0.003,asize/2-min_border,asize/2-min_border,true); 
      translate([gap_xoffset,gap_yoffset,adapter_thi+cone_hi])  
        cylinder(0.003,fsize/2-min_border,fsize/2-min_border,true); 
    }//h
  }//d

  color("orange")
  translate([gap_xoffset,gap_yoffset,adapter_thi+cone_hi+duct_hi/2])  
  difference(){
//outer duct
    cylinder(duct_hi,fsize/2,fsize/2,true);      
//cut outer duct
    cylinder(duct_hi+0.01,fsize/2-min_border,
      fsize/2-min_border,true);
  }//d
}//m
//

module circular_grill(size,rad){
//diagonal line
  for (i=[45,135])
    rotate([0,0,i])
      cube([size-min_border,grill_size*1.5,
        grill_thi],true);
//circular line
  for (i=[rad-grill_size*grill_sp_factor:
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

module line_grill(size,c2c){
//x axis line
  for (i=[0:grill_size*grill_sp_factor:c2c/2])
    translate([0,i,0])
      cube([size-min_border,grill_size,
        grill_thi],true);
  for (i=[0:-grill_size*grill_sp_factor:
      -c2c/2])
    translate([0,i,0])
      cube([size-min_border,grill_size,
        grill_thi],true);
//y axis line
  if (size > 80)
    for (i=[-size/6,size/6])
      translate([i,0,0])
        cube([grill_size*1.5,
          size-min_border,grill_thi],true);
  else if (size > 40)
    cube([grill_size*1.5,
      size-min_border,grill_thi],true);
}//m
//

module frame(c2c,height,inner_rad,c_rad,truth){
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