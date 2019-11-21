////----BedLevelTest.scad----
////----OpenSCAD 2015.03-2----
////----Kijja Chaovanakij----
////----2018.10.7----

/*[printer]*/
//bed x size[210]
bed_xsize=210;
//bed y size[270]
bed_ysize=270;
//bed margin[15]
bed_margin=15;

/*[layer and line]*/
//first layer thickness[0.24]
first_layer_thick=0.30;
//line size [multiplier of nozzle size]
line_size=2.4;

/*[element shape]*/
//element shape
element_shape=0; //[0:square,1:circle]
//element size[12]
element_size=12;
//element thickness[0.84]
element_thick=0.84;

/*[array pattern]*/
//number of array x size[3]
array_xsize=3; //[2:1:5]
//number of array y size[3]
array_ysize=3; //[2:1:5]

////----translate var---
x_c2c=bed_xsize-bed_margin*2-element_size;
y_c2c=bed_ysize-bed_margin*2-element_size;
x_space=x_c2c/(array_xsize-1);
y_space=y_c2c/(array_ysize-1);
echo("x_c2c",x_c2c);
echo("y_c2c",y_c2c);
echo("x_space",x_space);
echo("y_space",y_space);

////----main----
color("LightGreen"){
  element_shape();
  element_line();
}//c
//

module element_shape(){
  for (i=[-x_c2c/2:x_space:x_c2c/2])
    for (j=[-y_c2c/2:y_space:y_c2c/2])
      if (element_shape==0)
        translate([i,j,element_thick/2])
          cube([element_size,element_size,element_thick],true);
      else
        translate([i,j,element_thick/2])
          cylinder(element_thick,element_size/2,element_size/2,true);
}//m
//

module element_line(){
  for (i=[-x_c2c/2+x_space/2:x_space:x_c2c/2-x_space/2])
  for (j=[-y_c2c/2:y_space:y_c2c/2])
    translate([i,j,first_layer_thick/2])
      cube([x_space,line_size,first_layer_thick],true);

  for (i=[-x_c2c/2:x_space:x_c2c/2])
  for (j=[-y_c2c/2+y_space/2:y_space:y_c2c/2-y_space/2])
    translate([i,j,first_layer_thick/2])
      cube([line_size,y_space,first_layer_thick],true);
}//m
