//Choose which part to render
part_render=1; //[1:Hex Key T Handle & Clip, 2:Hex Key Handle, 3: Hex Key Clip]
//Diameter of the Hex Key
hex_key_diameter=3; 
//The length of the short leg of the Hex Key
hex_key_short_length=23;
//Length of the handles. This is added to the short length times two
handle_length=70;
//Thickness of the handle. added to the diameter of the hex Key
handle_thickness=7;
//Resolution of the Handle
resolution=55;
//ignore variable values
$fn=resolution;


if (part_render==1)
{
   hex_key_t_handle();
translate([handle_thickness+2*hex_key_diameter+10,0,0])hex_key_clip();
} 

if (part_render==2)
{
   hex_key_t_handle();
} 
if (part_render==3)
{
hex_key_clip();
} 






module hex_key_clip(){
rotate([90,0,0]){
translate([0,(((hex_key_short_length*2)+hex_key_diameter)/-2)+8,0]){
difference(){
hull(){
rotate([90,0,0])translate([0,(hex_key_diameter+handle_thickness)/2-1,(hex_key_short_length+(hex_key_diameter/2))/-1])cylinder(8,((hex_key_diameter+handle_thickness)/2)+2,((hex_key_diameter+handle_thickness)/2)+2);
translate([0,0,-.5]){
rotate([90,0,0])translate([0,((hex_key_diameter+handle_thickness)/2)-6,(hex_key_short_length+(hex_key_diameter/2))/-1])cylinder(8,((hex_key_diameter+handle_thickness)/2)+1.75,((hex_key_diameter+handle_thickness)/2)+1.75);
}


}
difference(){
translate([0,0,-1]){
hull(){
rotate([90,0,0])translate([0,(hex_key_diameter+handle_thickness)/2,(hex_key_short_length+(hex_key_diameter/2))/-1])cylinder((hex_key_short_length*2)+hex_key_diameter,(hex_key_diameter+handle_thickness)/2-.5,(hex_key_diameter+handle_thickness)/2-.5);
rotate([90,0,0])translate([0,((hex_key_diameter+handle_thickness)/2)-4.25,(hex_key_short_length+(hex_key_diameter/2))/-1])cylinder((hex_key_short_length*2)+hex_key_diameter,(hex_key_diameter+handle_thickness)/2-1.25,(hex_key_diameter+handle_thickness)/2-1.25);
}

translate([0,0,(handle_thickness/-2)-2])cube([(hex_key_short_length*2)+hex_key_diameter+handle_thickness*3,(hex_key_short_length*2)+hex_key_diameter+handle_thickness*3,handle_thickness],center=true);
}
}
}
}
}
}


module hex_key_t_handle(){
union(){
translate([0,0,-.5]){
difference(){
rotate([90,0,0])translate([0,(hex_key_diameter+handle_thickness)/2,(hex_key_short_length+(hex_key_diameter/2))/-1])cylinder((hex_key_short_length*2)+hex_key_diameter,(hex_key_diameter+handle_thickness)/2,(hex_key_diameter+handle_thickness)/2);
rotate([0,0,90])translate([0,0,(hex_key_diameter+handle_thickness)-(.5+hex_key_diameter)/2])hex_key();
rotate([0,0,-90])translate([0,0,(hex_key_diameter+handle_thickness)-(.5+hex_key_diameter)/2])hex_key();
cube([(hex_key_short_length*2)+hex_key_diameter+handle_thickness*3,(hex_key_short_length*2)+hex_key_diameter+handle_thickness*3,1],center=true);

}
}
difference(){
translate([0,(((hex_key_short_length*2)+hex_key_diameter)/-2)+1,-.5])hex_key_t_handle_extension();
translate([0,((hex_key_short_length*2)+hex_key_diameter)/-2,-1])cube([(hex_key_short_length*2)+hex_key_diameter+50,(hex_key_short_length*2)+hex_key_diameter+50,2],center=true);
}



difference(){
translate([0,(((hex_key_short_length*2)+hex_key_diameter)/2)-1,-.5])rotate([0,0,180])hex_key_t_handle_extension();
translate([0,(((hex_key_short_length*2)+hex_key_diameter)/2)+1,-1])cube([(hex_key_short_length*2)+hex_key_diameter+50,(hex_key_short_length*2)+hex_key_diameter+50,2],center=true);
}
}
}
module hex_key(){
rotate([0,0,360/6]){
rotate([90,0,360/12])translate([0,0,0])hexagon(hex_key_short_length,(hex_key_diameter+.5)/2);
rotate([90,0,360/12])translate([0,-1.5,0])cylinder(hex_key_short_length/2,(hex_key_diameter+1)/2,0);
rotate([0,0,360/12])translate([0,0,(-hex_key_short_length)+(hex_key_diameter/2)+.5])hexagon(hex_key_short_length,(hex_key_diameter+1)/2);

}
translate([0,(hex_key_diameter+.5)/-2,0])cube([hex_key_short_length,hex_key_diameter+.5, hex_key_diameter]);
}

module hex_key_t_handle_extension(){
rotate([90,0,0])translate([0,(hex_key_diameter+handle_thickness)/2,0]){
translate([0,0,.1*handle_length])cylinder(.5*handle_length-(.1*handle_length),(hex_key_diameter+handle_thickness+2)/2,(hex_key_diameter+handle_thickness+2)/2);
translate([0,0,0])cylinder((.1*handle_length), (hex_key_diameter+handle_thickness)/2,(hex_key_diameter+handle_thickness+2)/2);
translate([0,0,(5/10)*handle_length])sphere((hex_key_diameter+handle_thickness+2)/2);
}
}


module reg_polygon(sides,radius)
{
  function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt((r*2^2)/2) if only we had an exponention op
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) circle(r=radius,$fn=sides);
}

module hexagonf(radius)
{
  reg_polygon(6,radius);
}

module hexagon(height,radius) 
{
  linear_extrude(height=height) hexagonf(radius);
}