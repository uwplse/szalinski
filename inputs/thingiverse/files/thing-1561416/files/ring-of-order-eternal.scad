//ring of order eternal
//this is a piece of equipment from the game kingdoms at war
/*[ring details]*/
//this is using american sizes, if you don't want to use american sizes, put the size you want in custom
size = 7;
//set to 0 if you want to use the ring size
custom = 0;
ring_thickness = 4;//[1:25]
/*[rotate view]*/
x_rotation = -30;//[-359:359]
y_rotation = 50;//[-359:359]
z_rotation = -45;//[-359:359]
/*[units]*/
//Basically are you using american units or real units
units_entered = 1;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]

//default is mm for most printers
desired_units_for_output = 1;//[1:mm, .1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]

//END CUSTOMIZER VARIABLES
unit_conversion_factor = units_entered*desired_units_for_output;
//step == len(eq_to_eval) ? sum : evaluate(x_val, eq_to_eval, step+1, sum + pow(eq_to_eval[step][1]*x_val,eq_to_eval[step][2]));
ring_diameter = custom == 0 ? size*.8+11.6:custom*unit_conversion_factor;
module make_ring(){
	difference(){
		union(){
			cylinder(d1=ring_diameter*1.1+ring_thickness*2,d2=ring_diameter*1.1+ring_thickness,h = ring_thickness/2,$fn = 9);
			translate([0,0,ring_thickness/2]){
				cylinder(d1=(ring_diameter*1.1+ring_thickness),d2=(ring_diameter*1.1),h = ring_thickness/2,$fn = 9);
			}
		}
		cylinder(r=ring_diameter/2,h = ring_thickness*2.1,$fn = 81,center = true);
		for(rot = [0:8]){
			rotate([0,0,360*rot/9]){
				translate([-(ring_diameter*1.1+ring_thickness*2)*.95,0,-.1]){
					cylinder(d1 = ring_diameter*1.1+ring_thickness*2,d2 = ring_diameter*1.1+ring_thickness*5.75, h = ring_thickness*2+1,$fn=100);
				}
			}
		}
		translate([0,0,ring_thickness/2]){
			minkowski(){
				sphere(ring_thickness/50,$fn = 20);
				cylinder(r=ring_diameter/2, h = .0000001);
			}
			difference(){
				minkowski(){
					resize([ring_thickness,ring_thickness,ring_thickness/50]){
						sphere(1,$fn = 20);
					}
					cylinder(r=(ring_diameter+ring_thickness)/2, h = .0000001,$fn=50);
				}
				cylinder(r=(ring_diameter+ring_thickness)/2.2, h = ring_thickness*2,$fn=50,center = true);
			}
		}
	}
}

color([.1,.5,.1]){
	rotate([x_rotation,y_rotation,z_rotation]){
		make_ring();
	}
}