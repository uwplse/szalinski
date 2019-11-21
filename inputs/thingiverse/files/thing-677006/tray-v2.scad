
//Length of the tray
length=250; //[10:300]

//Width of the tray
width=150; //[10:300] 

//Height of the wall
wall_height=10; //[2:20]

//Thickness of the wall
wall_thick=2;//[1:5]

//Thickness of the base
base_thick=2;//[1:10] 

//Width of the strips
strip_width=3; //[1:10]

//Width of the gaps
gap_width=10;//[1:10]

//Height of foot
foot_height=5; //[2:10]

//Width of foot
foot_width=10; //[2:20]

//Number of feet in x direction
x_feet_count=5; //[2:20]

//Number of feet in y direction
y_feet_count=3; //[2:20]




union(){
	feet(length,width,-foot_height-base_thick/2, foot_width,foot_height,x_feet_count,y_feet_count);	
	
	//wall
	translate([0,width/2,-base_thick/2]) 
		rotate(a=[90,-90,90]) linear_extrude(height = length, center = true)
			polygon(points=[[0,0],[wall_height,0],[wall_height,wall_thick],[0,wall_height+wall_thick]], paths=[[0,1,2,3]]);
	translate([0,-width/2,-base_thick/2])
		rotate(a=[90,-90,-90]) linear_extrude(height = length, center = true)
			polygon(points=[[0,0],[wall_height,0],[wall_height,wall_thick],[0,wall_height+wall_thick]], paths=[[0,1,2,3]]);
	translate([-length/2,0,-base_thick/2])
		rotate(a=[90,-90,180]) linear_extrude(height = width, center = true)
			polygon(points=[[0,0],[wall_height,0],[wall_height,wall_thick],[0,wall_height+wall_thick]], paths=[[0,1,2,3]]);
	translate([length/2,0,-base_thick/2])
		rotate(a=[-90,-90,180]) linear_extrude(height = width, center = true)
			polygon(points=[[0,0],[wall_height,0],[wall_height,wall_thick],[0,wall_height+wall_thick]], paths=[[0,1,2,3]]);

	//base
	intersection(){
		cube([length,width,base_thick],center=true);
		for(i=[-length/2-width/2:1.414*gap_width+1.414*strip_width:length/2+width/2]){
			translate([i,0,0]) rotate([0,0,-45]) cube([strip_width,length,base_thick], center=true);
			translate([i,0,0]) rotate([0,0,45]) cube([strip_width,length,base_thick], center=true);
		}
	}
	
}

module feet(l,w,z,fw,fh,xfc,yfc){
	x_gap = (l-fw)/(xfc-1)-0.01;
	y_gap = (w-fw)/(yfc-1)-0.01; 
	for ( i = [-w/2+fw/2 : y_gap : w/2-fw/2] ){
		for ( j = [-l/2+fw/2 : x_gap : l/2-fw/2] ){
			foot(j,i,z,fw,fh);
		}
	}
}


module foot(x,y,z,w,h)
{	
	polyhedron(
		points=[[x,y,z],
				[x+w/2,y+w/2,z+h],
				[x+w/2,y-w/2,z+h],
				[x-w/2,y-w/2,z+h],
				[x-w/2,y+w/2,z+h]],
  		faces=[[0,1,2],[0,2,3],[0,3,4],[0,4,1],[4,3,2,1]]
		
	 );

}


