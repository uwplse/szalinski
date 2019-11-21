


difference() {	
	difference() {
		
		difference(){
			union(){
				cube([70,55,2]);
				translate([22.5,55,0])
				cube([25,42,2]);
			}
			translate([29,5,0])
			cube([12,88,4]);
		}
		
		translate([35,15,0])
		cylinder(r=7.5, h=2,center=false);
	}
		translate([35,35,0])
		cylinder(r=10, h=2,center=false);
	}



	 text = "MJKOUT";
 font = "Liberation Sans";
 
 
translate([15,50,0])
     linear_extrude(height =4) {
       text(text = str(text), font = font, size = 6, direction="ttb");
     }
   
 

/* text2 = "PokiGo";
translate([55,50,0])
     linear_extrude(height =4) {
       text(text = str(text2), font = font, size = 6, direction="ttb");
     }
   */