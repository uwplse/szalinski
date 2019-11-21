//BEGIN CUSTOMIZER VARIABLES
/* [Slot] */

//thickness
thickness = .0625;

//strip_height
strip_height = .4;

//length
length = 3;

/* [Push Pin] */

//pin_width, the pointy end
pin_width = .0625;

//pin_outer_width, need to name better
pin_outer_width = .375;

//num_of_pins
num_of_pins = 2;//[1:3]

/* [Advanced] */
//if you don't want fillets turn this off
fillets = true;

/* [Unit adjustment] */
//Basically are you using american units or real units
units_entered = 25.4;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]

//default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]

//END CUSTOMIZER VARIABLES

unit_conversion_factor = units_entered*desired_units_for_output;

module rail(){
	difference(){
		cube([thickness*3,length,strip_height+thickness*2]);
		translate([thickness*1.5,-.005,thickness*1.5]){
			rotate([-90,0,0]){
				linear_extrude(length+.01)
				{
					hull(){
						circle(thickness/2,$fn=42);
						translate([0,-strip_height+thickness]){
							circle(thickness/2,$fn=42);
						}
					}
					translate([thickness*.5,thickness*1.5-strip_height]){
						square([thickness+.01,strip_height-thickness*2]);
					}
				}
			}
		}
	}
}

module push_pin_spot(){
	translate([0,0,(pin_outer_width+thickness*2)/2]){
		rotate([0,90,0]){
			difference(){
				linear_extrude(thickness*2){
					translate([(pin_outer_width+thickness*2)/4,0]){
						square([(pin_outer_width+thickness*2)/2,pin_outer_width+thickness*2],center=true);
					}
					circle((pin_outer_width+thickness*2)/2,$fn=42);
				}
				translate([0,0,thickness+0.005]){
					linear_extrude(thickness+.01){
						circle(pin_outer_width/2,$fn=42);
					}
				}
				translate([0,0,-0.005]){
					linear_extrude(thickness*2+.01){
						circle(pin_width/2,$fn=42);
					}
				}
			}
		}
	}
}

scale(unit_conversion_factor){
	rotate([90,-90,0]){//for display purposes
		translate([0,-length/2,0]){
			rail();
		}
		if(num_of_pins%2==1){
			translate([0,0,strip_height+thickness*2]){
				push_pin_spot();
			}
			if(num_of_pins==3){
				translate([0,-length/2+pin_outer_width-thickness*2,strip_height+thickness*2]){
					push_pin_spot();
				}
				translate([0,length/2-pin_outer_width+thickness*2,strip_height+thickness*2]){
					push_pin_spot();
				}
			}
		}
		else{
			translate([0,-length/4,strip_height+thickness*2]){
				push_pin_spot();
			}
			translate([0,length/4,strip_height+thickness*2]){
				push_pin_spot();
			}
		}
	}
}
