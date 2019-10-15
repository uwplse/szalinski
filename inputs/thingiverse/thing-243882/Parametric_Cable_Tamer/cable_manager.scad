//Cable organizer
//John Finch 2-6-14

inner_dia=40; 		//large inner hole
wall=3;  			//wall thickness of loop
tab_length=10; 		//mounting tab length
tab_thickness=5;		//mounting tab thickness
clip_width=10; 		//height of loop along Z axis
mount_hole_dia=4.5;	//screw hole diameter
opening=1;			//1 for a gap in loop, 0 for a solid loop
opening_width=.5;	//opening width if enabled


fn=100;


difference(){

	union(){
  	//place outer ring
	cylinder(h=clip_width,r1=inner_dia/2+wall,r2=inner_dia/2+wall,$fn=fn);

	//place mounting tabs
	translate([inner_dia/2+wall-tab_thickness,-(inner_dia+2*wall+2*tab_length)/2,0])
	cube([tab_thickness,inner_dia+2*wall+2*tab_length,clip_width]);

	//place lower cube
	translate([0,-inner_dia/2-wall,0])
	cube([inner_dia/2+wall,inner_dia+2*wall,clip_width]);
	}

//cut inner hole
cylinder(h=clip_width,r1=inner_dia/2,r2=inner_dia/2,$fn=fn);

//cut hole in mounting tab 1
translate([inner_dia/2+wall-tab_thickness*1.01,-(inner_dia/2+wall+tab_length/2),clip_width/2])
rotate([0,90,0])
cylinder(h=tab_thickness*1.05,r1=mount_hole_dia/2,r2=mount_hole_dia/2,$fn=fn);

//cut hole in mounting tab 2
translate([inner_dia/2+wall-tab_thickness*1.01,(inner_dia/2+wall+tab_length/2),clip_width/2])
rotate([0,90,0])
cylinder(h=tab_thickness*1.05,r1=mount_hole_dia/2,r2=mount_hole_dia/2,$fn=fn);

//slice ring
if (opening == 1)
	{
	translate([-(inner_dia/2+wall),-opening_width/2,0])
	cube([inner_dia/2,opening_width,clip_width]);
	}
}
