	/*
*****************************************************
By Daniel Lindahl
i@d9l.se
2013
*****************************************************
*/
use <write/Write.scad>
//CUSTOMIZER VARIABLES
build_plate_selector = 1; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]
line_1 = "John Doe";
line_2 = "2005-2006";
line_3 = "2005-2006";
plate_height = 32;
plate_width = 89;
plate_depth  = 2;
text_size1 = 8;
text_size2 = 8;
text_size3 = 6;
intend = plate_width/2;

rad1 = plate_height-(plate_height/3.45) ;
rad2 = plate_height/2;
rad3 = plate_height-(plate_height/1.45) ;
screw = plate_width-5;
//CUSTOMIZER VARIABLES END


difference() {
				cube([plate_width,plate_height,plate_depth],center=false);
					# translate ([1,1,plate_depth]) {
										cube([plate_width-2,plate_height-2,1],center=false);
					}
																
						translate([5,rad2,0]) {
										cylinder(h=plate_depth,r=2);
					}
						translate([screw,rad2,0]) {
										cylinder(h=plate_depth,r=2);
					}
}



translate([intend,rad1,plate_depth])
write(line_1 ,h=text_size1,t=2,center=true);

translate([intend,rad2,plate_depth])
write(line_2 ,h=text_size2,t=2,center=true);

translate([intend,rad3,plate_depth])
write(line_3,h=text_size3 ,t=2,center=true);


