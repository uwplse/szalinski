// preview[view:east, tilt:top]

/* [Global] */
//how many raspis to stack on each other
rack_height=4; //[1:10]


/* [Hidden] */
rpi_width=57.5;
rpi_length=87;
u_height=23;
wall=2;
ledge=2;
port_height=11;
port_len=61;

module rack_floor(){
cube([rpi_width+2*wall,rpi_length+wall,wall]);
}

module one_u(){
 difference(){
	cube([rpi_width+2*wall,rpi_length+wall,u_height]);
 // cut out main area
	translate([wall,-wall,wall])cube([rpi_width,rpi_length,u_height]);
  //cut floor
  translate([wall+ledge,-wall,-wall])cube([rpi_width-2*ledge,rpi_length,3*wall]);

  //back
	translate([wall+1,rpi_length-2*wall,ledge+1])cube([rpi_width-2,5*wall,u_height-1-2*wall]);
  //side ports
  translate([rpi_width,-wall,wall+1])cube([5*wall,port_len,port_height]);
 }
}

module raspi_rack(){
	rack_floor();
	for(i=[1:rack_height]){
		translate([0,0,(i-1)*u_height])one_u();
	}
	//roof
	translate([0,0,rack_height*u_height])rack_floor();
}

//rotate & center
translate([(rack_height*u_height)/2,-(rpi_width+2*wall)/2,rpi_length+wall])rotate([-90,0,90])raspi_rack();


