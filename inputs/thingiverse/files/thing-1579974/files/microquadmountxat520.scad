// customizer

//CUSTOMIZER VARIABLES

// The width of the mount - recommend 16.5
mount_width=16.5; // [15,15.5,16,16.5,17,17.5]

// longitudinal length of the mount - recommend 13
mount_length=13; // [12,13,14,15,16]

// height of the mount - recommend 9
mount_height=9; // [8,9,10,11,12,13]

// angle of the camera - recommend 10-35
angle_mount=35;  // [0:60]

// measured width of your camera's body - for example: 11.3 for XAT520
camera_width=11.3; // [11,11.1,11.2,11.3,11.4,11.5,11.6,11.7,11.8,11.9,12]

// height of angle numbers on front - recommend .25
letter_height=.25;  // [.15,.25,.35,.45]

// size of angle numbers - recommend 1.5
letter_size=mount_height/1.5;  // [1,1.25,1.5,1.75,2]


//font = "Liberation Sans";

//if must fit between posts, recommend 2.5.  0 will eliminate the cutout
post_radius=2.5;  // [0,1,1.5,2,2.5,3,3.5]

// adjustment to height of camera setting - recommend 8
height_adjustment=8;  // [7,7.5,8,8.5,9,9.5]

/*hidden*/

camera_length=40*1;

wall_thickness=(mount_width-camera_width)/2; 

module letter(msg){
	linear_extrude(height = letter_height) {
	text(str(angle_mount), size = letter_size, halign = "center", valign = "center", $fn = 32);
	}
} 

module mount(){// basic mount cube and the letters, from which "cutouts" will be made
cube ([mount_width, mount_length, mount_height]);
    color("black")
    translate([mount_width/2, 0, mount_height/2]) rotate([90, 0, 0]) letter(str(angle_mount));
}

module tube(){  //this is the camera body to cut out from mount
cube ([camera_width+.4, 11.3, camera_length]); //accounts for extruder width of.4mm to size actual measurement for fit

}
module hole(){  // mounting hole... you may change the diameter/radius to fit your bolt/screw
    cylinder($fa=5, $fn=60, $fs=1, r1=1.3,r2=1.3,45);
}

module post(){  // some micros have posts between horizontal bodies which may interfere with mounting, if so this "notches" the mount to allow it to slide forward for mounting between the posts.
    cylinder($fn=60,r1=post_radius,r2=post_radius,45);
}

difference(){
mount();
rotate([90-angle_mount,0,0])
translate([wall_thickness,height_adjustment,-(camera_length/2)-mount_height]){tube();}
translate([mount_width/2,mount_length/2,-15]){hole();}
translate([mount_width,0,-15]){post();}
translate([0,0,-15]){post();}
}


