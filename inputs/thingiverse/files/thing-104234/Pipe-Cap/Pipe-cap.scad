higth=10; //[5:100]
top_with=16; //[5:100]
bottum_with=17; //[5:100]
wall_thikness=1.5; //[0.5:10]
pipe_thikness=1.5; //[0.5:10]

/* [Hidden] */
$fn = 150;
cap();

module cap(){
	cylinder(wall_thikness,((bottum_with/2)+pipe_thikness),((bottum_with/2)+pipe_thikness));
	difference(){	
		cylinder(higth,(bottum_with/2),(top_with/2));
		translate([0,0,wall_thikness])cylinder(h=higth,r=((min(bottum_with,top_with)/2)-wall_thikness));
	}
}