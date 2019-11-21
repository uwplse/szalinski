// le cadre du milieu avec avec les connecteurs sur les côté (2 sur chaque)
// Middle piece with connectors on the side (2 each)
// côté droite(longeur)avec un connecteur (extrême droite)   
//righ side legth with connector (far right)
union () 					{
rotate(a=120,v=[1,1,1])translate([4,0.1,4])cylinder(r=0.5,h=2.6);
translate([4,0,0]) {
cube(size=[2,13,2],center=true);
		}
// côté gauche (longeur)avec la deuxième connecteur (droite)
//left side legth with seconde connector (right) 
rotate(a=120,v=[1,1,1])translate([-4,0.1,4])cylinder(r=0.5,h=2.6);
translate([-4,0,0]){								
cube(size=[2,13,2], center=true);
		}		
// largeur(vers l'avant)avec la trosième connecteur (gauche)
// Width (front) with third connecteur (left)
rotate(a=120,v=[1,1,1])translate([-4,0.1,-6.6])cylinder(r=0.5,h=2.6);
translate([0,-6.5,0]){
cube(size=[10,2,2],center=true);
		}
// largeur (vers l'arrière) avec quatrième connecteur (extreme gauche) 
// Width (back) with fourth connector (far left)
rotate(a=120,v=[1,1,1])translate([4,0.1,-6.6])cylinder(r=0.5,h=2.6);
translate([0,6.5,0]){
cube(size=[10,2,2],center=true);
		}

								}

// Jambe gauche
// left leg
$fn=30;
translate([-4,-6.5,-4]){
cylinder(h=3,l=10);
		}

// Jambe extrême droite
// far right leg
$fn=30;
translate([4,6.5,-4]){
cylinder(h=3,l=10);
		}

// Jambe droite
//right leg
$fn=30;
translate([4,-6.5,-4]){
cylinder(h=3,l=10);
		}

//Jambe extrême gauche
//far left leg
$fn=30;
translate([-4,6.5,-4]){
cylinder(h=3,l=10);
		}