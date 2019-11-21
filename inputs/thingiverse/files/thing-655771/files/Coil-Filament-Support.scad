//preview[view:south east, tilt:top diagonal]
/*[Support]*/
//40mm to 100mm :
support_diameter=53; //[40:100]
// the diameter tolerance you need (+/-) 1mm to 10mm :
support_taper=1; //[1:10]
/*[Bearing]*/
//10mm to 25mm :
bearing_external_diameter=19; //[10:25]
//5mm to 10mm :
bearing_internal_diameter=8; //[5:10]
//5mm to 20mm :
bearing_height=7; //[5:20]
/*[CD]*/
cd_width=(((support_diameter+support_taper)-bearing_external_diameter)/2)/2;
Support();
module Support(){
 support_height=bearing_height+5;
 support_radius1=(support_diameter-support_taper)/2;
 support_radius2=(support_diameter+support_taper)/2;
 difference(){
  union(){
   for (i=[1:4]){
    rotate([0,0,i*360/4]) translate([(bearing_external_diameter/2)+0.001,-(cd_width/3)*1.5,0]) cube([(support_radius1-(bearing_external_diameter)/2)-5+0.001,((cd_width/3)*2)*1.5,support_height]);
   }
   difference(){
     translate([0,0,0]) cylinder(r1=support_radius1,r2=support_radius2,h=support_height,$fn=300);
    difference(){
     translate([0,0,-1]) cylinder(r=support_radius1-5,h=support_height+2,$fn=300);
     translate([0,0,-1]) cylinder(r=(bearing_external_diameter/2)+5,h=support_height+2,$fn=300);
    }
    translate([0,0,5]) cylinder(r=bearing_external_diameter/2,h=bearing_height+1,$fn=300);
    translate([0,0,-1]) cylinder(r=bearing_internal_diameter/2,h=bearing_height+7,$fn=300);
   }
  }
  for (i=[1:4]){
   rotate([0,0,i*360/4]) translate([(bearing_external_diameter/2)+cd_width,0,support_height-1]) CD(2,((support_diameter+support_taper-bearing_external_diameter)/2)/2);
  }
 }
}
module CD(cd_height,cd_width){
 cd_x1=cd_width;
 cd_x2=cd_x1-((cd_width/7)*2);
 cd_x3=(cd_x1-cd_x2)/2;
 cd_x4=cd_width/20;
 cd_y1=((cd_width/3)*2);
 cd_y2=cd_y1-((cd_width/7)*2);
 cd_y3=cd_y1/4;
 cd_y4=cd_y1+2;
 cd_z1=cd_height;
 cd_z2=cd_height+2;
 union(){
  difference(){
   translate([0,0,0]) resize([cd_x1,cd_y1,cd_z1]) cylinder($fn=300);
   translate([0,0,-1]) resize([cd_x2,cd_y2,cd_z2]) cylinder($fn=300);
   translate([-cd_x4/2,-cd_y4/2,-1]) cube([cd_x4,cd_y4,cd_z2]);
  }
  translate([-cd_x3-(cd_x4/2),+cd_y3/2,0]) cube([cd_x3,cd_y3,cd_z1]);
  translate([-cd_x3-(cd_x4/2),-cd_y3*1.5,0]) cube([cd_x3,cd_y3,cd_z1]);
  translate([cd_x4/2,-cd_y3*1.5,0]) cube([cd_x3,cd_y3*3,cd_z1]);
 }
}
