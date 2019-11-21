
/*[Parameters]*/

//diameter cable (default: 7)
diameter = 7; //[2:30]

//height table (default: 22.5)
height_table = 22.5;

//width holder (default: 10)
width = 10;

//Thickness holder (default: 2.5)
thickness = 2.5; //[2.5:5]

//Use Lock for cable? (default: No)
lock = "no"; //[no: No, yes: Yes]



/*[hidden]*/
module output(){
	if (lock == "yes"){
		lock();
	}
}



module lock(){
	translate([-(width/2)-(diameter)-(thickness/2),0,0]){
		translate([(diameter/14),(diameter/1.9),0]){
			sphere(r = diameter/12, $fn=32, center=true);
		}
		translate([(diameter/14),-(diameter/1.9),0]){
			sphere(r = diameter/12, $fn=32, center=true);
		}
	}
}


rotate ([0,-90,0])
part1();
module part1(){
	difference(){
		translate([0 ,0,0]){
		cube([width+(thickness),  diameter + (thickness*2) ,height_table+(thickness*2)], center = true); 
	}
		translate([thickness,0,0]){
			cube([width+(thickness), diameter + (thickness*4), height_table], center = true);
		}
	}
	difference(){
		union(){
			difference(){
				translate([(-width/2)-(diameter/2)- (thickness/2),0,0]){
					cube	([diameter+thickness, diameter + (thickness*2) , height_table + (thickness*2)], center = true);
				}
				translate([(-width/2)-(diameter/2)-(thickness/2),0,0]){
					union(){
						#cylinder(h = height_table+(thickness*4), r = diameter/2, $fn=100, center=true);
						translate([-(diameter/2)-1,0, 0]){
							cube([diameter+2, diameter, height_table+(thickness*4)], center = true);
						}
					}
				}
			}

			//lock
			output();
		}
		
	}
}

