$fn=50+4;

//camera mount pole mounting legnth
camera_mount_lenght = 100 ;

//camera mount pole mount width
camera_mount_width = 40 ;

//camera leg pole diameter
pole_diameter = 22.5 ;

//ziptie width for atatchment add a bit for clearance
ziptie_width = 4 ;

//ziptie height for atatchment
ziptie_height = 2 ;

pole_diameter2 = pole_diameter/2;

centre_point = pole_diameter2+5+ziptie_height ;

rotate([0,0,90])difference(){
	hull(){
		translate([0,0,1])cube([camera_mount_lenght,camera_mount_width,2],true);
		difference(){
			translate([0,0,centre_point])rotate([0,90,0])cylinder(camera_mount_lenght,pole_diameter2-0.1,pole_diameter2-0.1,true);
			translate([0,0,centre_point+pole_diameter2])cube([camera_mount_lenght+2,pole_diameter+2,pole_diameter],true);
			}
		}
	translate([0,0,centre_point])rotate([0,90,0])cylinder(camera_mount_lenght+0.2,pole_diameter2,pole_diameter2,true);
//	translate([0,0,centre_point])cube([camera_mount_lenght+pole_diameter2,camera_mount_width+pole_diameter2,10],true);
	translate([camera_mount_lenght/2-10,0,0])zip();
	zip();
	translate([-camera_mount_lenght/2+10,0,0])zip();
	}

module zip(){
	translate([0,0,centre_point])rotate([0,90,0]){
		difference(){
			cylinder(ziptie_width,pole_diameter2+2.5+ziptie_height,pole_diameter2+2.5+ziptie_height,true);
			cylinder(ziptie_width+0.2,pole_diameter2+2.5,pole_diameter2+2.5,true);
			}
		}
	}