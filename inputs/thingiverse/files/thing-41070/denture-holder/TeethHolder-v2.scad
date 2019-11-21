//all measurements are in mm unless stated otherwise
//base cup,  top cover, and both
1_part="both";				// [top,bottom,both]
//width in mm of dentures including gums at widest point,molar to molar 
2_width=71;
//it might help to place dentures on a table and use a flat object to find the very top
3_height=23.5;
//measure in the direction food goes down, include gums
4_length=56;
//distance from the very front to the canine teeth in the length axis only
5_curve=30;
//thickness of the denture box's walls, 1.5mm works well
6_wall_thickness=1.5;
//gap to allow the top part to fit the bottom, in 0.01mm intervals, currently =
7_Top_Smudge_Factor=5;		// [0:20]

width=2_width+1-1;
height=3_height+1-1;
length=4_length+1-1;
curve=5_curve+1-1;
wallthickness=6_wall_thickness+1-1;

//calculations
lc=length-curve;
cyl=width/2;
curcyl=curve/cyl;
fingz=height/2;
fingw=fingz/2;
fingh=width+2+wallthickness*4;
$fn = 164 + 1;
TopSmugeFactor=7_Top_Smudge_Factor/100;

if( 1_part == "top" ){
	top();
}else {
if( 1_part == "bottom" ){
	bottom();
}else {
	translate([-(length+wallthickness*6)/2,0,0])top();
	translate([(length+wallthickness*6)/2,0,0])bottom();
}}

module top(){
	translate([-(length+wallthickness*4+TopSmugeFactor)/2,-(width+wallthickness*4+TopSmugeFactor)/2,0])difference(){
		basic(0,4,TopSmugeFactor,fingz);														//outside
		translate([wallthickness,wallthickness,wallthickness])basic(2,2,TopSmugeFactor,fingz);	//inside
		translate([length/2,-1,fingz])rotate([-90,0,0])scale([1.5,1,1])cylinder(fingh,fingw,fingw);		//finger holes
	}
}

module bottom(){
	translate([-(length+wallthickness*2)/2,-(width+wallthickness*2)/2,0])difference(){
		basic(0,2);																			//outside
		translate([wallthickness,wallthickness,wallthickness])basic(2);							//inside
	}
}

module basic(plus=0,thick=0,fuge=0,th=height){
	xw1=(length+wallthickness*thick+fuge)/length;
	yw1=(width+wallthickness*thick+fuge)/width;
	zw1=th+wallthickness+plus;
	scale([xw1,yw1,1]){	
		cube([lc,width,zw1]);
		difference(){
			translate([lc,cyl,0])scale([curcyl,1,1])cylinder(zw1,cyl,cyl);
			translate([-curve+10,-1,-1])cube([curve+10,width+2,zw1+2]);
		}
	}
}