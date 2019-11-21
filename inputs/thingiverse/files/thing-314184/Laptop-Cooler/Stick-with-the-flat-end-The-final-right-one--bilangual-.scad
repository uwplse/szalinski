//bâton à bout plat
//Flat end stick
//Une long prisme rectangulaire avec un long demi cylindre (placer verticalement)
// Long rectangular prisim with long half-cylinder (vertical)
$fn=30; 
union()	{
translate([0,0,0])				{
rotate(a=120,v=[1,1,1])translate([1,0.1,-0.9])cylinder(r=0.16,h=25);
rotate(a=270,v=[5,0,0])translate([-0.9,-0.1,0.7])cube(size=[25,0.2,0.6]);

// bout plat à la fin du bâton
// Flat end at the end of stick
rotate(a=270,v=[1,0,0]) {
translate([-0.99,-2,1.045]){
translate([0.03,-0.2,-0.05])rotate(a=120,v=[1,1,1])cylinder(r=0.45,h=0.2);
translate([0,-0.25,-0.5])cube(size=[0.25,2.4,0.9]);
					         }

				                  }
			
											}

			}