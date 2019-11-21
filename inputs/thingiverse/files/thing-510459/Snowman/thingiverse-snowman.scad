//Sarah Bramley
//BEGIN CUSTOMIZER

//Scale Factor
scale_factor= 1; //[.8:2]
$fn=Render_Detail;

//Render Detail
Render_Detail=40; // [25:LOW, 40:MED, 100:HIGH]

//Ornament Hook
ornament_hook= 0; // [0:NO HOOK, 1:HOOK]


//body
scale([scale_factor, scale_factor, scale_factor]) {
difference() {
	union() {
	   translate([0,0,-25])sphere(r=22, center=true, $fn=Render_Detail);
		translate([0,0,6]) sphere(r=15, center=true, $fn=Render_Detail);
		translate([0,0,28]) sphere(r=10, center=true, $fn=Render_Detail);
	}
//cut bottom off of snowman
	translate([0,0,-66]) cube ([50,50,50], center = true, $fn=Render_Detail);
//smile
	rotate ([90,0,0]) translate([5,25,-1]) cylinder (h = 15, r=1.2, center = true, $fn= Render_Detail);
	rotate ([90,0,0]) translate([3,23,-1]) cylinder (h = 15, r=1.2, center = true, $fn= Render_Detail);
	rotate ([90,0,0]) translate([0,22,-1]) cylinder (h = 15, r=1.2, center = true, $fn= Render_Detail);
	rotate ([90,0,0]) translate([-5,25,-1]) cylinder (h = 15, r=1.2, center = true, $fn= Render_Detail);
	rotate ([90,0,0]) translate([-3,23,-1]) cylinder (h = 15, r=1.2, center = true, $fn= Render_Detail);

//nose
	rotate ([90,0,0]) translate([0,28.5,-5]) cylinder (h = 10, r1=2, r2=1.75, center = true, $fn= Render_Detail);

//eyes
rotate ([90,0,0]) translate([4,32,-5]) cube ([2.2,2.2,10], center = true, $fn=Render_Detail);
rotate ([90,0,0]) translate([-4,32,-5]) cube ([2.2,2.2,10], center = true, $fn=Render_Detail);


//arms
	rotate ([0,90,0]) translate([-5,0,0]) cylinder (h = 70, r=1.2, center = true, $fn=Render_Detail);

//hat
	union() {
		translate([0,0,36]) cube ([20.02,20.02,3], center = true, $fn=Render_Detail);
		translate([0,0,40]) cube ([10.02,10.02,8], center = true, $fn=Render_Detail);
	}
}

//smile pieces
rotate ([0,0,0])translate([24,0,-35]) cylinder (h = 13, r=.9, center = true, $fn=Render_Detail);
rotate ([0,0,0])translate([27,0,-35]) cylinder (h = 13, r=.9, center = true, $fn=Render_Detail);
rotate ([0,0,0])translate([30,0,-35]) cylinder (h = 13, r=.9, center = true, $fn=Render_Detail);
rotate ([0,0,0])translate([33,0,-35]) cylinder (h = 13, r=.9, center = true, $fn=Render_Detail);
rotate ([0,0,0])translate([36,0,-35]) cylinder (h = 13, r=.9, center = true, $fn=Render_Detail);

//nose piece
rotate ([180,0,0]) translate([40,0,34]) cylinder (h = 15, r1=0, r2=1.9, center = true, $fn=Render_Detail);


//eyes pieces
rotate ([90,0,0]) translate([45,-40.5,-4]) cube ([1.9,1.9,8], center = true, $fn=Render_Detail);
rotate ([90,0,0]) translate([49,-40.5,-4]) cube ([1.9,1.9,8], center = true, $fn=Render_Detail);

//arms piece
rotate ([0,90,0]) translate([40,0,-57]) cylinder (h = 70, r=.9, center = true, $fn=Render_Detail);

union(){
//hat pieces
translate([62,0,-40]) cube ([20,20,3], center = true, $fn=Render_Detail);
translate([62,0,-34]) cube ([10,10,12], center = true, $fn=Render_Detail);
}

difference() {
	union() {
	   
	translate([62,0,-26.5]) sphere(r=3*ornament_hook, center=true, $fn=Render_Detail);
	}
   rotate ([90,0,0])translate([62,-26,-4]) cylinder (h = 20*ornament_hook, r=1*ornament_hook, center=true, $fn=Render_Detail);
}

} //end scale
//END CUSTOMIZER
