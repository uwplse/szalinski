//Customizable Filament Holder
//Created by planfab
//www.planfab.eu
//Date 29.09.2014

/*[Global]*/

//This is the total radius of the Filament Holder (from center to edge) in mm. The true radius might be a bit shorter.
radius=120; //[50:300]

//This is the radius of the center hole of the Filament Holder in mm.
center_hole=26.5; //[10:40]

//This is the depth of the Filament Holder (top to bottom) in mm.
depth=30; //[10:100]

//Please choose the radius of your filament. In mm.
filament_radius=1.75; //[1.75:1.75,3.00:3.00]

/*[Hidden]*/
$fn=100;

difference(){
	filament_holder();
	for(i=[1:4]){
	rotate([0,0,i*360/4])
		filament_radius();
	}
}	

module filament_radius(){
	translate([0,0,depth/2])
		rotate([-90,0,0])
			cylinder(center_hole*1.5,filament_radius,filament_radius);
}

module filament_holder(){
	difference(){
		union(){
			center();
			difference(){
				for(i=[1:3]){
					rotate(i*360/3,0,0)
						arm();
				}
				difference(){
					cylinder(depth,radius,radius);
					translate([0,0,-depth*0.1])
						cylinder(depth*1.2,radius*0.9,radius*0.9);
				}
			}
		}
		translate([0,0,-depth*0.1])
			cylinder(depth*1.2,center_hole,center_hole);
	}
}


module arm(){
	difference(){
		armpiece();
		translate([-((depth/8)*1.5),radius/2,depth/2])
			rotate([0,90,0])
				armcut();
	}
}

module armcut(){
	hull(){
		translate([0,radius/2,0])
			cylinder(((depth/8)*2)*1.5,depth/2,depth/2);
		translate([(depth/2)/3,0,0])
			cylinder(((depth/8)*2)*1.5,(depth/2)/3,(depth/2)/3);
	}
}

module armpiece(){
	union(){
		translate([0,0,depth-(depth/8)])
			rotate([-90,0,0])
				cylinder(radius,depth/8,depth/8);
		translate([-((depth/8)*2)/2,0,depth/8])
			cube([((depth/8)*2),radius,depth-((depth/8)*2)]);
		translate([0,0,depth/8])
			rotate([-90,0,0])
				cylinder(radius,depth/8,depth/8);
	}
}

module center(){
	difference(){
		translate([0,0,depth/2])
			sphere(center_hole*1.5);	
		translate([-(center_hole*1.5)*2/2,-(center_hole*1.5)*2/2,-(center_hole*1.5)*2])
			cube((center_hole*1.5)*2);
		translate([-(center_hole*1.5)*2/2,-(center_hole*1.5)*2/2,depth])
			cube((center_hole*1.5)*2);
	}
}