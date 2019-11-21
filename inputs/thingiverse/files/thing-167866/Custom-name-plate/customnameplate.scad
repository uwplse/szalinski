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
line_1 = "Name";
line_2 = "Profession";
line_3 = "Company";
plate_height = 40;
plate_width = 100;
plate_depth  = 3;
text_size = 6;
intend = 4;

rad1 = plate_height/4*3-(plate_height/12) ;
rad2 = plate_height/4*2-(plate_height/12) ;
rad3 = plate_height/4*1-(plate_height/12) ;
//CUSTOMIZER VARIABLES END


difference() {
				cube([plate_width,plate_height,plate_depth],center=false);
					# translate ([1,1,plate_depth]) {
										cube([plate_width-2,plate_height-2,1],center=false);
					}
}

translate([intend,rad1,plate_depth])
write(line_1 ,h=text_size,t=2,center=false);

translate([intend,rad2,plate_depth])
write(line_2,h=text_size ,t=2,center=false);

translate([intend,rad3,plate_depth])
write(line_3,h=text_size ,t=2,center=false);


