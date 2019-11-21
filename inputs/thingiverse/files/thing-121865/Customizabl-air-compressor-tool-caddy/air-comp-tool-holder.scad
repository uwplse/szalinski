//air compressor tool caddy
//designed by: Andrew Herren
//modified: 7/22/13

// preview[view:east, tilt:bottom diagonal]
tools=2; //[1:10]
spacing=25.2*1.5;
center_hanger=1; //[1:On,0:Off]
pressure_guage=1; //[1:On,0:Off]



difference(){
union(){
if(center_hanger==1 || tools==1){
translate([-25.4/4,pressure_guage*spacing/2,25.4*1.4])rotate([0,90,0])cylinder(25.4/2,25.4/4,25.4/4);
}
for(i=[0:tools-1]){
translate([0,((-25.4*2-(tools-1)*spacing)/2)+25.4+(i*spacing),-25.4/8])cylinder(25.4,6.45+(25.4/8),6.45+(25.4/8));
}
difference(){
translate([25.4/4,(((tools-1)*spacing)+(25.4*1.25))/2,0])minkowski(){
translate([-25.4/4,(-(25.4*.75)-(tools-1)*spacing)/2,0])sphere(25.4/4);
translate([-25.4/4,(-25.4*1.5-(tools-1)*spacing)/2,0])cube([25.4/2,((tools-1)*spacing)+25.4+(pressure_guage*spacing),25.4]);
}
translate([-25.4,-(tools*spacing+(2*25.4))/2,-20])cube([25.4*2,tools*spacing+(2*25.4)+(pressure_guage*spacing),20]);
}
difference(){
hull(){
translate([-25.4/4,-(((tools-1)*spacing)+(25.4*2))/2,0])cube([25.4/2,((tools-1)*spacing)+(25.4*2)+(pressure_guage*spacing),25.4]);
translate([-25.4/4,-(((tools-1)*spacing)+25.4*1.5)/2,25.4*1.25])rotate([0,90,0])cylinder(25.4/2,25.4/4,25.4/4);
translate([-25.4/4,(((tools-1)*spacing)+25.4*1.5)/2+(pressure_guage*spacing),25.4*1.25])rotate([0,90,0])cylinder(25.4/2,25.4/4,25.4/4);
}
translate([-25.4/2,-(((tools-1)*spacing)+(25.4*1.75))/2,25.4/4])cube([25.4,((tools-1)*spacing)+(25.4*1.75)+(pressure_guage*spacing),25.4*.75]);
if(tools>1){
translate([-25.4/2,((-25.4/2)-(tools-1)*spacing)/2,25.4*(5/8)])cube([25.4,25.4,25.4*.75]);
translate([-25.4/2,((-25.4*1.5)+(tools-1)*spacing)/2+(pressure_guage*spacing),25.4*(5/8)])cube([25.4,25.4,25.4*.75]);
}
}
}
if(center_hanger==1 || tools==1){
translate([-25.4/2,(pressure_guage*spacing)/2,25.4*1.4])rotate([0,90,0])cylinder(25.4,25.4/10,25.4/10);
}
for(i=[0:tools-1]){
translate([0,((-25.4*2-(tools-1)*spacing)/2)+25.4+(i*spacing),-25.4/2])cylinder(25.4,6.45,6.45);
}
if(pressure_guage==1){
translate([-25.4*.25,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing)-6.5,-25.4*1.45])cube([25.42,13,50]);
translate([-25.4*.25,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing)-9.5,-25.4*1.65])cube([25.42,19,50]);
translate([-25.4*.25,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing),25.4*.65])rotate([60,0,0])translate([0,-7,0])cube([25.4,14,10]);
translate([-25.4*.25,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing),25.4*.65])rotate([0,90,0])cylinder(25.42,8,8);
}
}

if(pressure_guage==1){
difference(){
translate([-25.4*.25,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing)-8,0])cube([25.42*.75,16,6]);
translate([(25.4*.25)-4.15,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing),-2])cylinder(10,5.4,5.4);
translate([(25.4*.25)-5,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing),-2])cylinder(10,5.75,5.75);
translate([(25.4*.25)-4.85,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing)-3,-2])cube([25.42*.5,6,10]);
translate([(25.4*.5)-4.85,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing)-4.5,-2])rotate([0,0,-10])translate([-25.4*.25,0,0])cube([25.42*.5,4,10]);
translate([(25.4*.5)-4.85,((-25.4*2-(tools-1)*spacing)/2)+25.4+(tools*spacing)+4.5,-2])rotate([0,0,10])translate([-25.4*.25,-4,0])cube([25.42*.5,4,10]);
}
}



