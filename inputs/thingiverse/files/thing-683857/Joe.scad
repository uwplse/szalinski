/********************************
Project:	Reposman HubOut
Date:		01/09/2014
*********************************/

// heigth of the book
H = 210;
// thickness of the book
s = 10;
// width of suport
l = 20; 
// inclination
a = 75; // [70:85]
// thickness of the man
t = 1.5; // [0.5:5]

// scale (don't modify)
w = H/104.1212/2;


inset_shell(t) {

	linear_extrude(l) {

		union() {

			//Piede posteriore
			polygon([[0*w,0*w], [17*w, 0*w], [17.73*w, 2.91*w], [8*w, 8*w], [-0.87*w, 4.92*w]]);

			//Gamba posteriore
			intersection() {
				polygon([[-0.87*w, 4.92*w], [-10*w, 4.92*w], [18*w, 40.50*w], [28*w, 40.50*w], [35.18*w, 31*w], [8*w,8*w]]);	

				difference() {
					translate([65.06*w, -19.07*w, 0])	
					{
						circle(70.16*w, $fn = 200);
					}
		
					translate([46.52*w, -9.96*w, 0])
					{
						circle(42.50*w, $fn = 200);
					}
				}
			}

			//Piede anteriore
			polygon([[75*w, 0*w], [((80*w+s*cos(90-a)+1*cos(180-a)+1*cos(90-a))+((6*w+s*sin(90-a)+1*sin(180-a)+1*sin(90-a))*cos(180-a)/sin(-(180-a)))), 0*w], [(80*w+s*cos(90-a)+1*cos(180-a)+1*cos(90-a)), (6*w+s*sin(90-a)+1*sin(180-a)+1*sin(90-a))], [(80*w+s*cos(90-a)+1*cos(180-a)), (6*w+s*sin(90-a)+1*sin(180-a))] ,[(80*w+s*cos(90-a)), (6*w+s*sin(90-a))], [80*w, 6*w]]); 

			//Gamba anteriore
			intersection() {
				polygon([[75*w, 0*w], [80*w, 6*w], [90*w, 6*w], [50*w, 42*w], [40*w, 42*w], [35.18*w, 31*w]] );	

				difference() {
					translate([17.62*w, -23.09*w, 0])
					{
						circle(68.83*w, $fn = 200);
					}
		
					translate([24.80*w, -23.41*w, 0])
					{
						circle(55.39*w, $fn = 200);
					}
				}
			}	

			//Busto e mano
			polygon([[35.18*w, 31*w], [28*w, 40.50*w], [23*w, 54.50*w], [25*w, 62*w], [25*w, 64*w], [31*w, 66*w], [33*w, 62*w], [56.96*w, 62*w], [(66.15*w+20*w*cos(180-a)), (57.68*w+20*w*sin(180-a))], [66.15*w, 57.68*w], [41*w, 51*w], [40*w, 42*w]]);

			//Spalla	
			difference() {
				translate([25*w, 57.98*w, 0])
				{
					circle(4.02*w, $fn = 200);
				}
			
				polygon([[23*w, 54.50*w], [25*w, 62*w], [40*w, 62*w], [40*w, 40*w], [23*w, 40*w]]);
			}

			//Testa	
			difference() {
				translate([22.72*w, 80.85*w, 0])
				{
					circle(17*w, $fn = 200);
				}
			
				polygon([[25*w, 64*w], [31*w, 66*w], [31*w, 50*w], [25*w, 50*w]]);
			}
		} //union()
	} //linear_extrude()
} //inset_shell()





//Library offset.scad
//Reference https://cubehero.com/physibles/iamwil/offset

/*
 * Inset - returns the shrunken outline shape
 *
 */
module inset(thickness = 0.5, bbox = [5000, 5000, 5000]) {
  module invert() {
    difference() {
      cube(bbox, true);
      child();
    }        
  }

  render() {
    invert(0.9 * bbox)
      minkowski() {
        invert() child();
        cube([2 * thickness, 2 * thickness, 2 * thickness], center=true);
      }
  }
}

/*
 * Inset shell - gives the vertical shell between the original extrusion
 *   and the inset shape
 *
 */
module inset_shell(thickness = 0.5, bbox = [5000, 5000, 5000]) {
  render() {
    difference() {
      child();
      translate([0, 0, -5 * thickness]) scale([1, 1, 100])
        translate([0, 0, -2 * thickness])
          inset(thickness, bbox)
            child();
    }
  }
}


