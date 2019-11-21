     ///////////////////////////////////////////////////////////
    //////// This project was done by Benjamin Engel  ///////////
   //////// Twitter @ben_bionic ///////////////////////////////
  //////// Google benengel94  ///////////////////////////////
 //////// github benbeezy //////////////////////////////////
///////////////////////////////////////////////////////////


  ////////////////////////////////////////////////////////
 ///////////////// EVERYTHING IS IN MM /////////////////
////////////////////////////////////////////////////////

/* [General] */
make_this = "face";	// [first:face,second:front,third:both,forth:strap]
make_printable = true; // [true,false]

/* [Phone Settings] */
phone_height = 126;
phone_width = 71;
phone_thickness = 8.636;

/* [Face Settings] */
face_curve = phone_height/2;
//IPD
eye_gap = 70;
nose_width = 33;
nose_depth = 20;
nose_height = phone_width/2;

/* [Print Settings] */
wall_thickness = 2; // [1:8]
layer_height=.5;

/* [Strap Settings] */
stretch_strength = 3;

/* [Lense Settings] */
lense_diamiter = 50;
lense_thickness = 10;
outer_thickness= 2;
focal_length= 50;
face_plate_thickness = 5;

/* [Label It] */
your_name = "Ben_bionic";
phone_name = "Nexus";

/* head strap */
head_strap_mount = true; // [true,false] 
head_strap_width = 40;
head_strap_mount_thickness = 5;
head_strap_thickness = 2.5;


/* [magnet] */
add_magnet = true; // [true,false] 
magnet_gap = 2;
innder_magnet_diamiter = 20;
outer_magnet_diamiter = 19; 
outer_magnet_thickness = 6;
magnet_position = 10;








//oporations

module front() {
	intersection(){
		translate([-phone_height,0,-phone_width]) cube([phone_height*2,focal_length,phone_width*2]);
		difference(){
			front_added();
			front_taken();
		}
	}
}

module face() {
		difference(){
			face_added();
			face_taken();
		}

}

//functions

if (make_this=="front" || make_this=="both") {
	if (make_printable == true){
		rotate([90,0,0]) front();
	}
	else{
		front();
	}
}

	if (make_this=="face" || make_this=="both") {
		if (make_printable == true){
			rotate([-90,0,0]) face();
		}
		else{
			face();
		}
	}

if (make_this=="strap"){
			strap();
}


//modules
		module head_strap_mount(){
			module taken(){
				translate([(phone_height/2)+wall_thickness+head_strap_thickness,head_strap_mount_thickness/2,0]) cube([head_strap_thickness,50,head_strap_width], center=true);
				translate([(phone_height/2)+wall_thickness+head_strap_thickness*3,head_strap_mount_thickness/2,0]) cube([head_strap_thickness,50,head_strap_width], center=true);
			}
			module added(){
				translate([(phone_height/2)+wall_thickness+head_strap_thickness*2.5,head_strap_mount_thickness/2,0]) cube([head_strap_thickness*5,head_strap_mount_thickness,head_strap_width+head_strap_mount_thickness], center=true);
			}
			module head_strap_fin(){
				difference(){
					added();
					taken();
				}
			}
			head_strap_fin();
			mirror([1,0,0]) head_strap_fin();
		}
		
		module nose(){
				translate([0,0,-phone_width/2]) scale([nose_width,nose_depth*2,nose_height*2]) sphere(d=1, $fn=50);;
		}
		module outside_magnet(){
			translate([phone_height/2,focal_length/2,outer_magnet_diamiter/2])difference(){
				hull(){
					sphere(d=outer_magnet_diamiter+4);
					translate([0,0,-outer_magnet_diamiter]) sphere(d=outer_magnet_diamiter+4);
				}
				translate([outer_magnet_diamiter/2-outer_magnet_thickness,0,0]) hull(){
					rotate([0,90,0]) cylinder(d=outer_magnet_diamiter, h=50);
					translate([0,0,-outer_magnet_diamiter]) rotate([0,90,0]) cylinder(d=outer_magnet_diamiter, h=50);
				}
				translate([-100,-50,-50]) cube([100,100,100]);
				translate([-50+outer_magnet_diamiter/2-outer_magnet_thickness-magnet_gap,0,0]) rotate([0,90,0]) cylinder(d=outer_magnet_diamiter, h=50);
			}
		}
		
		module inner_magnet(){
			translate([phone_height/2,focal_length/2,outer_magnet_diamiter/2])
				translate([-50+outer_magnet_diamiter/2-outer_magnet_thickness-magnet_gap,0,0]) rotate([0,90,0]) cylinder(d=outer_magnet_diamiter, h=50);
		}
		
		module clip(){
			rotate([-90,0,0]) translate([0,-5,0]) difference(){
				rotate([45,0,0]) translate([0,0,1]) cube([10,50,5], center=true);
				translate([-25,-25,-50]) cube([50,50,50]);
				translate([-25,-50,-5]) cube([50,50,50]);
				translate([-25,5,0]) cube([50,50,50]);
			}
		}
		module strap(){
			difference(){
				cube([15,phone_width+focal_length*2+phone_thickness,layer_height*stretch_strength]);
				translate([2.5,2.5,-5])cube([10,10,10]);
				translate([2.5,(phone_width+focal_length*2)-7.5,-5]) cube([10,10,10]);
			}
		}
		module front_added(){
			translate([phone_height/3,0,phone_width/2+wall_thickness]) clip();
			mirror([1,0,0]) translate([phone_height/3,0,phone_width/2+wall_thickness]) clip();
			mirror([0,0,1]) mirror([1,0,0]) translate([phone_height/3,0,phone_width/2+wall_thickness]) clip();
			mirror([0,0,1]) translate([phone_height/3,0,phone_width/2+wall_thickness]) clip();
			
			translate([0,focal_length/2-(lense_thickness/4),0]){
				cube([phone_height+wall_thickness*2,focal_length+(lense_thickness/4),phone_width+wall_thickness*2], center=true);
			}
			if (add_magnet == true){
				translate([0,0,magnet_position]) outside_magnet();
			}
			if (head_strap_mount == true){
				head_strap_mount();
			}
					
		}
		module front_taken(){
					nose();
			translate([0,(focal_length/2)+3,0]){
				translate([phone_height/4,0,0]) cube([phone_height/2-wall_thickness/2,focal_length,phone_width], center=true);
				mirror([1,0,0]) translate([phone_height/4,0,0]) cube([phone_height/2-wall_thickness/2,focal_length,phone_width], center=true);
				
				
				translate([phone_height/4,-15,0]) rotate([90,0,0]) cylinder(h=focal_length, d=phone_width-10);
				translate([-phone_height/4,-15,0]) rotate([90,0,0]) cylinder(h=focal_length, d=phone_width-10);
				translate([-phone_height/2,-5,phone_width/2+wall_thickness/2]) linear_extrude(height=wall_thickness) {
					text(phone_name);
				}
			}
			if (add_magnet == true){
				translate([0,0,magnet_position]) inner_magnet();
			}
		}
		
		//face
		module face_added(){
			translate([0,-focal_length/2,0]){
				cube([phone_height+wall_thickness*2,focal_length,phone_width+wall_thickness*2], center=true);
			}
		}
		module face_taken(){
					nose();
			translate([0,(-focal_length/2)-face_plate_thickness,0]) cube([phone_height,focal_length,phone_width], center=true);
			translate([0,-face_curve-face_plate_thickness,-phone_width/2-wall_thickness-1]) cylinder(h=phone_width*2, r=face_curve);
			translate([eye_gap/2,(-lense_thickness/2)-(face_plate_thickness/2),0]) lense();
			mirror([1,0,0]) translate([eye_gap/2,(-lense_thickness/2)-(face_plate_thickness/2),0]) lense();
			translate([-phone_height/2,-10,phone_width/2+wall_thickness-2]) linear_extrude(height=3) {
					text(your_name);
				}
		}
		
		//lenses
		module lense(){
			hull(){
				translate([0,lense_thickness/2,0]) scale([lense_diamiter-3,lense_thickness,lense_diamiter-3]) sphere(d=1, $fn=50);
				translate([0,(lense_thickness/2)-outer_thickness/2,0]) rotate([-90,0,0]) cylinder(d=lense_diamiter, h=outer_thickness, $fn=50);
			}
		}