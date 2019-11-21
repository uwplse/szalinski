/*			CHANGELOG

	V1.1 fixes the stopers at the end, and makes it better for customizer on thingiverse.
	
	V1,5 has some tweaks for the size so you don't have to scale it, and i added in a color command because i NEED all my designs to be blue.


			INTRODUCTION
This is my first scad file, but i think i did a decent job, although i still have alot to learn. Please excuse all, if any, typoes, and feel free to share with me all the ways i messed this up, if any. and if you have any problems, please leave a comment with what scad editor your using, and what exactly went wrong (screen shots are helpfull too) and i'll do my best to help you... or look up stuff on google till i can:)


Among other things, i plan on updating this file with options to customize the grip, the disks (ammo) , and maybe the ammo holder. i don't think there is anything to do with the barrel.

			INSTRUCTIONS
This should be fairly straight foward for those of you who are familiar with these types of files. All instructions given are with openscad's default editor in mind. when i say left and right, thats with the finger ring as the closest part, and your looking down the lentgh of it. If you still not sure of orientation, just play with a variable to see which piece moves or changes.


For those who aren't familiar, while i do encourage you to read through my code and try to understand what i did, that's not actually needed to tweak this file. All you need to do is measure the diameter of your finger, and input the measurements in milimeters, and end the line with a semi colon ( ; ). You can round a bit, so 25 mm can be called a inch, if you only have imperial measuring devices.


You can also adjust the quality of the finger ring and cut outs. the latter may be slightly pointless, but why not?


After you change the values and end the line with a semicolon ( ; ), you can press F5 to to preview it, this is quick. when your ready to save it as a stl file, press F6 to render the file, this can take a while depending on what you told it for the various quality settings, and than save as stl. Easy peasy.

Please note that i'm not responsible if your computer explodes, or becomes a giant fire breathing duck that yodels.
*/


/*           CUSTOMIZABLES               */


finger_size = 25;

finger_ring_face_count = 50;

center_cut_out_quality = 50;

end_cut_out_quality = 50;


/*						CODE					 feel free to play with and modify it
*/

/* i redifned these to make it easier for me*/
r = finger_size;
frq = finger_ring_face_count;
ccq = center_cut_out_quality;
ecq = end_cut_out_quality;

module slide() {
	union() {
		
//finger ring
		translate([116/2+r/2,0,2.5]) {
			difference() {
				cylinder(r=r/2+2, h = 8, center = true,$fn = frq);
				cylinder(r=r/2, h = 9, center = true,$fn = frq);
			}
		}
//circular cutout at the end of the slide and in the center of the slide, and the stoppers.
		
//this is the circular cut out at the end
		difference() {
			translate([-5,0,0]) {
			cube([92,28,3], center = true);
			}
			translate([-56.6,0,0]) {
				cylinder(r=33.5/2, h=4, center = true, $fn = ecq);
			}
//this is the oval cut out in the center.
			translate([0,0,0]) {
				scale([5,1,1]) cylinder (r = 7, h = 5, center = true, $fn = ccq);
			}
		}
		
//these are the stoppers at the end on either side of the cutout
		
		//right side
		scale([1,0.8,1]) {
			rotate([0,0,-90]) {
				translate([-17.5,-42.944,-1.5]) {
					difference() {
						linear_extrude(3) {
							hull() {
						translate([0,3.5,0]) square (9, center = true);
				circle (r=4.5, $fn = 4 );
								}
							}
							translate([5,2,0]) cube([10,20,10],center = true);
						}
					}
				}
			}
	
		//left side
		scale([1,0.8,1]) {
			rotate([0,180,-90]) {
				translate([-17.5,-42.9,-1.5]) {
					difference() {
						linear_extrude(3) {
							hull() {
								translate([0,3.5,0]) square (9, center = true);
				circle (r=4.5, $fn = 4 );
								}
							}
							translate([5,2,0]) cube([10,20,10],center = true);
						}
					}
				}
			}
		
//stablizers for the top sides
		
		//right side
		translate([2,12,3]) {
			cube([74,2,4], center = true);
		}
		translate([-43,13,1]) {
			rotate ([90,0,0]) {
				scale ([4,2,1]) {
					difference() {
						cube (2);
						rotate([0,0,45]) cube(10);
					}
				}
			}
		}
		
		//left side
		translate([2,-12,3]) {
			cube([74,2,4], center = true);
		}
		translate([-43,-11,1]) {
			rotate ([90,0,0]) {
				scale ([4,2,1]) {
					difference() {
						cube (2);
						rotate([0,0,45]) cube(10);
					}
				}
			}
		}

//conection for the finger ring
		translate([51,0,0]) {
			cube([14,13,3], center = true);
		}
		translate([53.5,0,4]) {
			cube([9,13,5], center = true);
		}
		translate([48,10,0]) {
			rotate([0,0,-45]) cube([12,2,3], center = true);
		}
			translate([48,-10,0]) {
				rotate([0,0,45]) cube([12,2,3], center = true);
		}
			translate([47.5,11.915,1.45]) {
				rotate ([90,0,-45]) {
					scale ([4,2.4,1]) {
					difference() {
						cube (2);
						rotate([0,0,45]) cube(10);
					}
				}
			}
		}
		translate([46.2,-10.385,1.45]) {
			rotate ([90,0,45]) {
				scale ([4,2.4,1]) {
					difference() {
						cube (2);
						rotate([0,0,45]) cube(10);
					}
				}
			}
		}
		
//rubberband retainer, has a large ring for the indent the rubber band goes into, and little triangle ears.
		difference() {
		translate([41,0,2.75]) {
			cube([8.5,34,8.5], center = true);
			}
			//this is the ring indent
			translate([-21,0,3.51]) {
				difference() {
					cylinder(r=70, h = 4, $fn = 90, center = true);
					cylinder(r= 65.5, h = 5, $fn = 250, center = true);
				}
			}
		}
		//left triangle stop ear
		translate([36.75,20,7]) {
				rotate ([-90,0,-90]) {
					scale ([1,1.5,1]) {
					difference() {
						cube (3);
						rotate([0,0,45]) cube(10);
					}
				}
			}
		}
		//right triangle stop ear
		translate([39.75,-20,7]) {
			rotate ([-90,0,90]) {
				scale ([1,1.5,1]) {
					difference() {
						cube (3);
						rotate([0,0,45]) cube(10);
					}
				}
			}
		}
	}
}

color("cyan") {
	slide();
}

//still no firebreathing duck? i must've done somthing wrong...