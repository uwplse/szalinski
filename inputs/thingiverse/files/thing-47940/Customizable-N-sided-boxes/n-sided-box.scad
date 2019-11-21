show_options = "both";//[both,box,cap]

//in mm
height = 30;//[1:200]
//in mm
radius = 50;//[1:200]
sided = 6;//[3:100]
//in mm
wallthickness = 4;//[1:20]


if(show_options == "both" || show_options == "box")
translate([show_options == "both" ? -radius - 1 : 0,0,0])
difference(){
	cylinder(h = height, r = radius, $fn = sided);
	translate([0,0,wallthickness])
	cylinder(h = height, r = radius-wallthickness, $fn = sided);
}


if(show_options == "both" || show_options == "cap")
translate([show_options == "both" ? radius + 1 : 0,0,0])
union(){
	cylinder(h = wallthickness, r = radius, $fn = sided);
	difference(){
		cylinder(h = (wallthickness*2), r = radius-wallthickness, $fn = sided);
		translate([0,0,wallthickness-0.1])
			cylinder(h = height, r = radius-(wallthickness*2), $fn = sided);
	}

}