/* [Global] */
Porta_Filter_Outside_Diameter = 71; // [10:150]
Porta_Filter_Inside_Diameter = 60; //[10:150]
Reach_Into_Porta_Filter_x_10 = 24; //[0:100]
Outside_Wall_Height_x_10 = 36; //[0:100]
/* [Hidden] */
Clearance = 0.5;
Smoothness=40;
pf_r = Porta_Filter_Outside_Diameter/2;
circle_thickness = 3;
support_height=6;
tab_height=Outside_Wall_Height_x_10/10;
central_column_h = 5;
central_column_r = 1.5;

wiper_height = support_height+Reach_Into_Porta_Filter_x_10/10;
wiper_thickness = 1.8;

union(){

difference(){
	cylinder(h=support_height+tab_height,r=pf_r+circle_thickness+Clearance,$fn=Smoothness);//outer
	cylinder(h=support_height+tab_height,r=pf_r+Clearance,$fn=Smoothness);//inner
}
difference(){
	cylinder(h=support_height,r=pf_r+Clearance+0.1,$fn=Smoothness);//inner
	cylinder(h=support_height,r=pf_r-circle_thickness,$fn=Smoothness);//outer
}

intersection(){
union(){
cylinder(h=wiper_height,r=Porta_Filter_Inside_Diameter/2-Clearance,$fn=Smoothness);//inner
cylinder(h=support_height,r=pf_r-circle_thickness+0.01,$fn=Smoothness);//inner

}
union(){
translate([-Porta_Filter_Inside_Diameter/2+wiper_thickness/2,0,0])difference(){
	cylinder(h=wiper_height,r=Porta_Filter_Inside_Diameter/2,$fn=Smoothness);//inner
	cylinder(h=wiper_height,r=Porta_Filter_Inside_Diameter/2-wiper_thickness,$fn=Smoothness);//outer
	//translate([Porta_Filter_Outside_Diameter*2,0,0])cube([Porta_Filter_Outside_Diameter*4,Porta_Filter_Outside_Diameter*4,support_height*4],center=true);
	translate([0,-Porta_Filter_Outside_Diameter*2+0.01,0])cube([Porta_Filter_Outside_Diameter*4,Porta_Filter_Outside_Diameter*4,wiper_height*4],center=true);
}
translate([Porta_Filter_Inside_Diameter/2-wiper_thickness/2,0,0])difference(){
	cylinder(h=wiper_height,r=Porta_Filter_Inside_Diameter/2,$fn=Smoothness);//inner
	cylinder(h=wiper_height,r=Porta_Filter_Inside_Diameter/2-wiper_thickness,$fn=Smoothness);//outer
	//translate([Porta_Filter_Outside_Diameter*2,0,0])cube([Porta_Filter_Outside_Diameter*4,Porta_Filter_Outside_Diameter*4,support_height*4],center=true);
	translate([0,Porta_Filter_Outside_Diameter*2-0.01,0])cube([Porta_Filter_Outside_Diameter*4,Porta_Filter_Outside_Diameter*4,wiper_height*4],center=true);
}
}
}
}
