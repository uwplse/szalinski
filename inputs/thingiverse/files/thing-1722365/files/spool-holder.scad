/* [General] */
render = "arm"; // [first:base,second:arm]
d1 = 35;
d2 = 60;

/* [Arm] */
spool_width = 110;
spool_width = 110;
/*thingiverse
//	text_top = "5lb";
//	font = "ariel:style=Bold"; // style can look like "ariel:style=Bold Italic" to apply styles
//	font_size = 20; // [5:30]
//	font_height = 2; // [.1:5]
*/
/* [Base] */
width = 90; // [30:100]
height = 90; // [30:100]
screw_head = 10; // [4:10]
screw_width = 4; // [2:10]

module added_mount(){
	hull(){
		translate([0,0,-10]) cube([width,height,20+10], center=true);
		cylinder(d=60, h=20);
	}
}
module taken_mount(){
	hull(){
		cylinder(d=60, d2=35, h=30);
		translate([-50,0,0]) cylinder(d=62, d2=36, h=30);
	}
	translate([5,0,-20]) cube([width,height+5,30], center=true);
	//curve edge screws
	translate([-width/2+10,-width/2+10,-width/2]) cylinder(d=screw_width, h=100);
	translate([-width/2+10,-width/2+10,-2]) cylinder(d=screw_head, h=100);
	translate([-width/2+10,width/2-10,-width/2]) cylinder(d=screw_width, h=100);
	translate([-width/2+10,width/2-10,-2]) cylinder(d=screw_head, h=100);

	translate([width/2-10,-width/2+10,-width/2]) cylinder(d=screw_width, h=100);
	translate([width/2-10,-width/2+10,-2]) cylinder(d=screw_head, h=100);
	translate([width/2-10,width/2-10,-width/2]) cylinder(d=screw_width, h=100);
	translate([width/2-10,width/2-10,-2]) cylinder(d=screw_head, h=100);

	translate([width/2,20,-15]) rotate([0,-90,0]) cylinder(d=screw_width, h=100);
	translate([width/2,-20,-15]) rotate([0,-90,0]) cylinder(d=screw_width, h=100);
}

if(render == "base"){
	rotate([0,-90,0]) difference(){
		added_mount();
		taken_mount();
	}
} else if (render == "arm"){
	union(){
		cylinder(d=60, d2=35, h=30, $fn=80);
		cylinder(d=35, h=3+spool_width, $fn=80);
			difference(){
				translate([0,0,spool_width]) cylinder(d=35, d2=45, h=10, $fn=80);
			/*thingiverse
			//	translate([0,0,spool_width+10-font_height]) linear_extrude(height = font_height) {
       		//		text(text = str(text_top), font = font, size = font_size, valign = "center", halign = "center" );
     			//	}
			*/
			}
	}
}