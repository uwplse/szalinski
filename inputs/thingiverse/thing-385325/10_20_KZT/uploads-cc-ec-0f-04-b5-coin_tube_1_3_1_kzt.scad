/*
 * PARAMETRIC COIN TUBES + CAP
 * VERSION 1.3.1
 * last update: 02/12/13
 * design by newq 
 * mod kitwallace (thanks!)
 */

// 
// the generated tubes insides are 2 coins higher than the number of coins they fit

coin_type = 0; // [ 0:10 KZT, 1:20 KZT, 2:50 KZT,  3:100 KZT, 4:5 KZT, 5:1 KZT, 6:2 Euro cent, 7: 1 Euro cent, 8: 1 US Dollar, 9: 0.50 US Dollar, 10: 0.25 US Dollar, 11: 0.10 US Dollar, 12: 0.05 US Dollar, 13: 0.01 US Dollar, 14: 2 Canadian Dollar, 15: 1 Canadian Dollar, 16: 0.50 Canadian Dollar, 17: 0.25 Canadian Dollar, 18: 0.10 Canadian Dollar, 19: 0.05 Canadian Dollar, 20: 0.01 Canadian Dollar]

// how many stacked coins should fit in a tube
number_of_coins = 25; 
number_of_tubes = 2; 

// Do you want to print the tubes?
generate_tube = 1; // [1:Yes, 0:No] 
// Do you want a cap to close the tube?
generate_cap = 1; // [1:Yes, 0:No] 
// thickness of wall and bottom (mm)
tube_wall = 2;  
// clearance from coin to wall of tube (mm) 
clearance = 0.4;
// if the cap fits too tight you might decrease slightly
fudge_factor = 0.975; 

// NOTHING TO SEE HERE :)

// coin data - name, diameter, height
coins = [ 
              ["10 KZT", 19.6, 1.35], 
              ["20 KZT", 18.3, 1.5],
              ["50 KZT", 23, 1.6],
              ["100 KZT", 24.5, 1.8],
              ["5 KZT", 17.3, 1.35],
              ["1 KZT", 15, 1.3],
              ["2 Euro cents", 18.75, 1.67],
              ["1 Euro cents", 16.25, 1.67],
              ["1 US Dollar", 26.50, 2.00],
              ["0.50 US Dollar", 30.61, 2.15],
              ["0.25 US Dollar", 24.26, 1.75],
              ["0.10 US Dollar", 17.91, 1.35],
              ["0.05 US Dollar", 21.21, 1.95],
              ["0.01 US Dollar", 19.05, 1.55],
              ["2 Canadian Dollar", 28.00, 1.80],
              ["1 Canadian Dollar", 26.50, 1.75],
              ["0.50 Canadian Dollar", 27.13, 1.95],
              ["0.25 Canadian Dollar", 23.88, 1.58],
              ["0.10 Canadian Dollar", 18.03, 1.22],
              ["0.05 Canadian Dollar", 21.2, 1.76],
              ["0.01 Canadian Dollar", 19.05, 1.45]
            ];

coin_diameter = coins[coin_type][1];
coin_height = coins[coin_type][2];

// generating the tubes
if (generate_tube) {
  assign(cyl_inner_h = (coin_height * number_of_coins) + (4 * tube_wall),
             cyl_inner_r = (coin_diameter / 2) + clearance,

             cyl_outer_h = (coin_height * number_of_coins) + (3 * tube_wall),
             cyl_outer_r = (coin_diameter / 2) + tube_wall + clearance,

             cutout_x = coin_diameter + (4 * tube_wall),
             cutout_y = (coin_diameter / 2),
             cutout_z = (coin_height * number_of_coins) + (3 * tube_wall)
             )


  for (z = [0 : (number_of_tubes-1)]){

	translate (v = [0, z * (cyl_outer_r * 2 - tube_wall), 0]){
		difference(){	
			difference(){
				difference() {
					// outer tube
					cylinder(h = cyl_outer_h, r = cyl_outer_r);
					// inner tube
					translate(v = [0, 0, tube_wall]) {
						cylinder(h = cyl_inner_h, r = cyl_inner_r);
					}
				}
				// round bottom cutout
				translate (v = [0, 0, ((cutout_z / 2) + tube_wall)]){
					cube(size = [cutout_x, cutout_y, cutout_z], center = true);
				}
			}
			// cutout
			translate (v = [0, 0, -tube_wall]){
				cylinder(h = (cyl_inner_h + tube_wall), r = (cyl_inner_r - tube_wall));
			}
		}
   }
}

}

// generating the tube tops

if (generate_cap) {
   assign (cyl_inner_h = 3*tube_wall - clearance,
               cyl_inner_r = ((coin_diameter / 2) + clearance) * fudge_factor,

               cyl_outer_h = tube_wall,
               cyl_outer_r = (coin_diameter / 2) + tube_wall + clearance,

               cutout_x = coin_diameter + (4 * tube_wall),
               cutout_y = (coin_diameter / 2) * fudge_factor,
               cutout_z = 3*tube_wall - clearance
             )
    translate([1.5 * coin_diameter + tube_wall, 0, 0]){
	for (z = [0 : (number_of_tubes-1)]){
		
		translate (v = [0, z * (cyl_outer_r * 2 - tube_wall), 0]){
			difference(){
				union(){		
					cylinder(h = cyl_outer_h, r = cyl_outer_r);
					cylinder(h = cyl_inner_h, r = cyl_inner_r);
				
					intersection(){
						translate([0,0,cutout_z/2]){
							cube(size = [cutout_x, cutout_y, cutout_z], center = true);
						}
						cylinder(h = cyl_outer_h+10, r = cyl_outer_r);
					}
				}
				
				translate([0,0,-(cyl_inner_h /2)]){
					cylinder(h = cyl_inner_h *2, r = cyl_inner_r - tube_wall);
				}			
			}		
		}
	}	
}
}