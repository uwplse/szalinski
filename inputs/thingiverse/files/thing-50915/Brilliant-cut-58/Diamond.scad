module sea_urchin()
difine();
//valiable data

//Diamond_size_d
dd=20;//[10:40]

//Diamond_hight_retio
hr=0.615;

// ignore variable values
pag1=42.45*1;//Pavillion_angle1
pag2=40.75*1;////Pavillion_angle2
cag3=40.16*1;////Crown_angle3
cag4=34.5*1;////Crown_angle4
cag5=24.35*1;////Crown_angle4
dh=dd*hr;//Diamond_hight_retio

difference() {
			translate([0,0,-dd*0.431])cylinder(h=dh,r=dd/2,$fn=48);	
union(){
	for (i = [ 0 : 8-1] ) {
				rotate([0,0,360/8*i]) translate([dd/2,0,-5/cos(pag1)]) rotate([0,90-pag1,0])cube(size=[dd/2,dd/2,1.1*dd], center=true);
							}
for (i = [ 0 : 8-1] ) {
				rotate([0,0,360/8*i+22.5]) translate([dd/2,0,-5/cos(pag1)]) rotate([0,90-pag1,0])cube(size=[dd/2,dd/2,1.1*dd], center=true);
							}
	for (i = [ 0 : 8-1] ) {
				rotate([0,0,360/8*i+11.25]) translate([dd/2,0,-5/cos(pag1)]) rotate([0,90-pag2,0])cube(size=[dd/2,dd/2,dd], center=true);
							}
}
union(){
	for (i = [ 0 : 8-1] ) {
		rotate([0,0,360/8*i]) translate([dd/2,0,5/cos(cag3)]) rotate([0,90-cag3,180])cube(size=[dd/2,dd/2,dd], center=true);
							}
for (i = [ 0 : 8-1] ) {
		rotate([0,0,360/8*i+22.5]) translate([dd/2,0,5/cos(cag3)]) rotate([0,90-cag3,180])cube(size=[dd/2,dd/2,dd], center=true);
							}
}
union(){
	for (i = [ 0 : 4-1] ) {
		rotate([0,0,360/4*i+11.25]) translate([dd/2,0,5/cos(cag4)+0.0085*dd]) rotate([0,90-cag4,180])cube(size=[dd/2,dd/2,dd], center=true);
							}
for (i = [ 0 : 4-1] ) {
		rotate([0,0,360/4*i+11.25+45]) translate([dd/2,0,5/cos(cag4)+0.0085*dd]) rotate([0,90-cag4,180])cube(size=[dd/2,dd/2,dd], center=true);
							}
	for (i = [ 0 : 8-1] ) {
	rotate([0,0,360/8*i-11.25]) translate([dd/2,0,5/cos(cag5)+0.060*dd]) rotate([0,90-cag5,180])cube(size=[dd/2,dd/2,dd], center=true);
							}
		}
			}
module sea_urchin();



	
