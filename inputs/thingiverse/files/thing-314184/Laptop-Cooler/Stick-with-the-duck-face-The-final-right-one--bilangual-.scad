// bâton avec bec de canard
// Duck bill stick
// Une long prisme rectangulaire avec un long demi cylindre (placer verticalement)
// Long rectangular prisim with half cylinder (vertical)
$fn=30; 
translate([-12,1.30,1.4])	{
rotate(a=120,v=[1,1,1])translate([0.8,1.5,0])cylinder(r=0.16,h=25);	
rotate(a=270,v=[5,0,0])translate([0,-1.5,0.5])cube(size=[25,0.2,0.6]);
								}
union() 					{
// bec du canard 
// Duck bill
translate([0,0.1,1.8])rotate(a=90,v=[1,0,0])	{
difference()		{	
translate([-10.5,4.4,-2.5])cube(size=[5,2.5,1.1]);
translate([-10.5,4.8,-2.5])cube(size=[5,1.6,1.5]);
						}
// tête du canard connecter au bec
//Duck head connected to bill			
difference()		{
translate([-12,5,-2.5])cylinder(r=2.5,h=1.1);
translate([-12,5,-2.5])cylinder(r=2,h=1.1);
translate([-10.5,4.8,-2.6])cube(size=[3,10,1.5]);
						}
//cou du canard
//Duck neck
translate ([-10,11,-4])rotate(a=120,v=[1,1,1])
translate([-10.4,1.5,-2.8])cube(size=[2,1.1,1.5]);
															}
			}	
