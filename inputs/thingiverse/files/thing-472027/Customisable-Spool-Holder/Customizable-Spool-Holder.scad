//Customizable Spool Holder
//Created by planfab
//www.planfab.eu
//Date 21.09.2014


/*[Shape]*/

//This is the total height of the spool holder in mm.
height=190; //[100:250]

//This is the total width of the spool holder in mm.
width=220; //[100:250]

//This is the thickness of each spool holder leg in mm.
thickness=10; //[5:30]

//This represents the width of the walls in mm.
wall_width=50; //[35:80]

//This is the radius of the rod socket in mm.
socket_radius=8; //[1:20]

//This number widens the rod socket for easiest fit. In mm.
tolerance=1; //[0:3]

light_version="true"; //[true:Yes,false:No]


/*[Connecting Rod]*/

//Do you wish to create a connecting rod?
rod="false"; //[true:Yes,false:No]

//This is the length of the rod, aka the distance between the two legs in mm.
rod_length=100; //[65:160]

//Do you wish to export only the rod?
rod_only="false"; //[true:Yes,false:No]


/*[Text]*/

//Do you wish to add text on the spool holder?
add_text="true"; //[true:Yes,false:No]

//What size should the text be?
text_size=12; //[1:20]

//Insert your text.
text="planfab.eu";

//Do you wish to emboss or engrave your text?
embossed_or_engraved="true"; //[true:Embossed,false:Engraved]

//If you wish to emboss, how tall should the letters be? In mm.
emboss_height=5; //[1:20]


/*[Extra Support]*/

//Do you wish to have extra support?
extra_support="true"; //[true:Yes,false:No]

//How tall do you wish the support legs to be? In mm.
support_legs=10; //[1:50]


/*[Hidden]*/
p=100;
use<write.scad>

if(rod=="true" && rod_only=="true"){}else{
	if (extra_support=="true"){
		difference(){
			support();
				translate([0,0,-thickness*0.1])
				union(){
				for (i=[0:p]){
				translate([sin(180*i/p)*(height-(wall_width)),cos(180*i/p)*((width-(wall_width))/2), 0 ])
				linear_extrude((thickness*1.2)+support_legs)
				scale([0.7,0.7,1])
				circle(wall_width/2);
				}		
			}
		}
	}
}

if(rod=="true" && rod_only=="true"){}else{
	if (embossed_or_engraved=="false"){
		if (add_text=="true"){
			difference(){
				if (light_version=="true"){
					difference(){
					spool_holder_side();
					spool_holder_side_mini();
					}
				} else{
					spool_holder_side();
				}
				translate([((height-(wall_width))/4),0,0])
				rotate([0,0,-90])
				write(text,h=text_size,t=thickness*3,bold=1,space=1.2,center=true);
			}
		}else{
			if (light_version=="true"){
					difference(){
					spool_holder_side();
					spool_holder_side_mini();
					}
				} else{
					spool_holder_side();
				}
		}
	}else{
		if (add_text=="true"){
				union(){
					if (light_version=="true"){
						difference(){
						spool_holder_side();
						spool_holder_side_mini();
						}
					} else{
						spool_holder_side();
					}
					translate([((height-(wall_width))/4),0,(thickness/2)+(emboss_height*0.9)])
					rotate([0,0,-90])
					write(text,h=text_size,t=thickness,bold=1,space=1.2,center=true);
				}
			}else{
				if (light_version=="true"){
						difference(){
						spool_holder_side();
						spool_holder_side_mini();
						}
					} else{
						spool_holder_side();
					}
			}
	}
}

if (rod=="true"){
	rod();
	}

module support(){
		translate([sin(0)*(height-(wall_width)),cos(0)*((width-(wall_width))/2),thickness*0.9])
		linear_extrude(support_legs)
		circle(wall_width/2);
		translate([sin(180)*(height-(wall_width)),cos(180)*((width-(wall_width))/2),thickness*0.9])
		linear_extrude(support_legs)
		circle(wall_width/2);
}

module rod(){
	hull(){
			translate([height-(wall_width/2),0,0])
			cylinder(rod_length,socket_radius,socket_radius);
			translate([height-(wall_width),0,0])
			cylinder(rod_length,socket_radius,socket_radius);
		}
}

module spool_holder_side_mini(){
	difference(){
		basic_structure_mini();
		translate([0,0,-thickness*0.1])
		hull(){
			translate([height,0,-thickness*0.1])
			cylinder(thickness*1.5,(socket_radius+tolerance)*1.43,(socket_radius+tolerance)*1.43);
			translate([height-(wall_width*2),0,-thickness*0.1])
			cylinder(thickness*1.5,(socket_radius+tolerance)*1.43,(socket_radius+tolerance)*1.43);
		}
	}
}

module spool_holder_side(){
	difference(){
		basic_structure();
		hull(){
			translate([height,0,-thickness*0.1])
			cylinder(thickness*1.2,socket_radius+tolerance,socket_radius+tolerance);
			translate([height-(wall_width),0,-thickness*0.1])
			cylinder(thickness*1.2,socket_radius+tolerance,socket_radius+tolerance);
		}
	}
}

module basic_structure_mini(){
	translate([0,0,-thickness*0.1])
	union(){
		for (i=[0:p]){
		translate([sin(180*i/p)*(height-(wall_width)),cos(180*i/p)*((width-(wall_width))/2), 0 ])
		linear_extrude(thickness*1.2)
		scale([0.7,0.7,1])
		circle(wall_width/2);
		}		
	}
}

module basic_structure(){
	union(){
		for (i=[0:p]){
		translate([sin(180*i/p)*(height-(wall_width)),cos(180*i/p)*((width-(wall_width))/2), 0 ])
		linear_extrude(thickness)
		circle(wall_width/2);
		}
		for (i=[0:p]){
		translate([sin(180*i/p)*(((height-(wall_width))/4)),cos(180*i/p)*((width-(wall_width))/2), 0 ])
		linear_extrude(thickness)
		circle(wall_width/2);
		}
	}
}