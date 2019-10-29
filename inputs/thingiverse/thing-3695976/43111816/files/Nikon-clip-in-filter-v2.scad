// Nikon Clip in filter
nikon_D5300_width=37.5;
nikon_D5300_height=32;
nikon_D5300_depth=3; //Actual is about 3.5

nikon_D5300_ring_diameter=40;

nikon_D5300_corner_clip_ring_diameter=44;




filter_lip_width=1.5;
filter_lip_height=1;
filter_diameter=1.25*25.4;

$fn=50;



difference(){
	//This intersection is to clip the corners so it will go down in. 
	intersection() {
		translate([nikon_D5300_width/2, nikon_D5300_height/2, -0.1]) {
		cylinder(h=nikon_D5300_depth+1,r=nikon_D5300_corner_clip_ring_diameter/2);
	}
	//Main form
		union() {
			cube([nikon_D5300_width, nikon_D5300_height, nikon_D5300_depth]);
			translate([nikon_D5300_width/2, nikon_D5300_height/2, 0])
			//Circular bottom tab, other 3 sides get clipped at the end
			cylinder(h=nikon_D5300_depth, r=nikon_D5300_ring_diameter/2);
		}
	}
	translate([nikon_D5300_width/2, nikon_D5300_height/2, -0.1]) {
		translate([0,0,filter_lip_height+0.1]) {
		cylinder(h=nikon_D5300_depth+1,r=filter_diameter/2);
		}
		cylinder(h=nikon_D5300_depth+1,r=(filter_diameter)/2-filter_lip_width);
	}
	
	
	//Clip to allow circular bottom part. 
	translate([0, nikon_D5300_height, -0.1]){
		cube([nikon_D5300_width, nikon_D5300_height, nikon_D5300_depth+1]);
	}
	translate([nikon_D5300_width, 0, -0.1]){
		cube([nikon_D5300_width, nikon_D5300_height, nikon_D5300_depth+1]);
	}
		translate([-nikon_D5300_width, 0, -0.1]){
		cube([nikon_D5300_width, nikon_D5300_height, nikon_D5300_depth+1]);
	}
	
}