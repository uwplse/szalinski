////////////glasses/////////////
ear_difference		= 0;
bridge_width			= 20;
bridge_position		= 0;
thickness				= 4;
frame_thickness		= 10;
frame_depth			= thickness+3;
groove_depth			= 1;
name					= "Ben Engel";
lense_thickness		= 3;
lense_height			= 20;
lense_width			= 45;
a =[8,8,8,5];	// these are the radius of the lenses starting
						// upper right, upper, left lower left, lower right
/*

optons for make are
"frame" will make just the face part that holds the lenses
"stems" this will make only the parts that go over your ears
"all" and this will make everything all in one file

*/
rotate =[0,0,0];
make	= "frame";

///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
//						EVERYTHING PAST HERE IS CODE						     //
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////










module lense(){
	hull(){
			translate([lense_width/2-(a[0]/2),lense_height-(a[0]/2),0]) cylinder(d=a[0], h=.1, center=true);
			translate([-lense_width/2+(a[1]/2),lense_height-(a[1]/2),0]) cylinder(d=a[1], h=.1, center=true);
			translate([-lense_width/2+(a[2]/2),-lense_height+(a[2]/2),0]) cylinder(d=a[2], h=.1, center=true);
			translate([lense_width/2-(a[3]/2),-lense_height+(a[3]/2),0]) cylinder(d=a[3], h=.1, center=true);

			translate([lense_width/2-(a[0]/2)-groove_depth,lense_height-(a[0]/2+groove_depth),0]) cylinder(d=a[0], h=lense_thickness, center=true);
			translate([-lense_width/2+(a[1]/2)+groove_depth,lense_height-(a[1]/2)-groove_depth,0]) cylinder(d=a[1], h=lense_thickness, center=true);
			translate([-lense_width/2+(a[2]/2)+groove_depth,-lense_height+(a[2]/2)+groove_depth,0]) cylinder(d=a[2], h=lense_thickness, center=true);
			translate([lense_width/2-(a[3]/2)-groove_depth,-lense_height+(a[3]/2)+groove_depth,0]) cylinder(d=a[3], h=lense_thickness, center=true);
	}
}
module lense_frame(){
	difference(){
		scale([(1/lense_width)*(lense_width+frame_thickness),(1/lense_width)*(lense_width+frame_thickness),1]) lense(lense_thickness=frame_depth);
		scale([(1/lense_width)*(lense_width+groove_depth),(1/lense_width)*(lense_width+groove_depth),1]) lense();
		lense(lense_thickness=frame_depth+2);
	}
}
module ear_stem_mount(){
	difference(){
		translate([lense_width+bridge_width+frame_thickness/2,lense_height-a[0],0]) cube([15,25,frame_depth], center=true);
		translate([lense_width+bridge_width+frame_thickness/2,lense_height-a[0],0]) cube([15,20-8,frame_depth+1], center=true);
	}
		translate([lense_width+bridge_width+frame_thickness/2+1,lense_height-a[0],0]) rotate([90,0,0]) cylinder(d=frame_depth, h=20-8, center=true);
}
module face(){
	translate([(lense_width+frame_thickness)/2+bridge_width/2,0,0]) lense_frame();
	translate([-(lense_width+frame_thickness)/2-bridge_width/2,0,0]) mirror() lense_frame();
	translate([0,bridge_position,0]) difference(){
		cylinder(d=bridge_width+(frame_thickness-groove_depth*2)*2,h=frame_depth, center=true);
		translate([0,-frame_thickness/2,0]) cylinder(d=bridge_width+(frame_thickness-groove_depth*2)*2,h=frame_depth+2, center=true);
		translate([(lense_width+frame_thickness)/2+bridge_width/2,0,0]) {
			scale([(1/lense_width)*(lense_width+groove_depth),(1/lense_width)*(lense_width+groove_depth),1]) lense();
			lense(lense_thickness=frame_depth+2);
		}
		translate([-((lense_width+frame_thickness)/2+bridge_width/2),0,0]) {
			scale([(1/lense_width)*(lense_width+groove_depth),(1/lense_width)*(lense_width+groove_depth),1]) lense();
			lense(lense_thickness=frame_depth+2);
		}

	}
	translate([0,ear_difference/2,0]) ear_stem_mount();
	translate([0,-ear_difference/2,0]) mirror(1,0,0) ear_stem_mount();
}
module ear_stem(){
	cube([150,10,frame_thickness], center=true);
	intersection(){
		difference(){
			translate([150/2,-(80/2)+5,0]) cylinder(d=80, h=frame_thickness, center=true);
			translate([150/2-frame_thickness,-(80/2)-frame_thickness/2,0]) cylinder(d=80, h=frame_thickness+1, center=true);

		}
		translate([150/2,-45,-25]) cube([150,150,50]);
	}
}
module finished_stem(){
	difference(){
		ear_stem();
		#translate([-150/2+7,0,0]) rotate([90,0,0]) {
		cylinder(d=frame_depth, h=20-8, center=true);
		translate([0,frame_depth,0]) cube([frame_depth-2,20-8,10],center=true);
		}
	}
}

module full_print_set(){
if(make=="frame" || make=="all")   {
	face();
}else if(make=="stems" || make=="all"){
	translate([0,lense_height+15,0]) finished_stem();
	translate([15,12,0]) mirror([0,0,1]) mirror([1,0,0]) mirror([0,1,0]) translate([0,lense_height+30,0]) finished_stem();
}
}

rotate(rotate) full_print_set();
