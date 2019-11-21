//embout pour connecter au cadre du milieu(sur le côté droite) avec trois cube(sur le côté gauche) 
//End piece to connect the middle (right side) 3 cubes (left side)
//côté droite longeur avec deux trou extrême droite et droite
//right side with 2 holes far right and right
union () 					{
difference()	{
translate([4,0,0]) {
cube(size=[2,13,2],center=true);
						 }
rotate(a=120,v=[1,1,1])translate([4,0.1,3])cylinder(r=0.5,h=3);
				
rotate(a=120,v=[1,1,1])translate([-4,0.1,3])cylinder(r=0.5,h=3);			
	}
//côté gauche longeur
//left side length 
translate([-4,0,0]){								
cube(size=[2,13,2], center=true);
		}		

//largeur (vers l'avant)
//widht (towards the front)
translate([0,-6.5,0]){
cube(size=[10,2,2],center=true);
		}

// largeur (vers l'arrière)
//widht (back)
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

//Jambe extrême droite
// far right leg
$fn=30;
translate([4,6.5,-4]){
cylinder(h=3,l=10);
		}

//Jambe droite
//right leg
$fn=30;
translate([4,-6.5,-4]){
cylinder(h=3,l=10);
		}

// Jambe extrême gauche
//far left leg 
$fn=30;
translate([-4,6.5,-4]){
cylinder(h=3,l=10);
		}

// Cube (gauche) avec trou(en haut et en bas) pour faire entre les clés 
// left cube with hole (top and bottom) to fit in sticks
union()											{
rotate (a=450,v=[0,0,1])translate([2.5,20,0])					{
translate([-10,-15,-1]){
difference () 					{
cube(size=[2,2,2]);
rotate(a=120,v=[1,1,1])translate([1,1.5,-0.5])cylinder(r=0.3,h=3);	
rotate(a=120,v=[1,1,1])translate([1,0.5,-0.5])cylinder(r=0.3,h=3);
rotate(a=270,v=[5,0,0])translate([-1.5,-1.5,0.5])cube(size=[3.5,0.3,1.0]);
rotate(a=270,v=[5,0,0])translate([-1,-0.5,0.5])cube(size=[3.1,0.3,1.0]);
						}
				
									}


															       }	

// Cube (gauche milieu) avec trou (en haut et en bas) pour faire entre les clés
// left middle cube with hole (top and bottom) to fit in sticks
rotate (a=450,v=[0,0,1])translate([-9,22,0])					{	
translate([8,-17,-1]){
difference () 					   {
cube(size=[2,2,2]);
rotate(a=120,v=[1,1,1])translate([1,1.5,-0.5])cylinder(r=0.3,h=3);	
rotate(a=120,v=[1,1,1])translate([1,0.5,-0.5])cylinder(r=0.3,h=3);
rotate(a=270,v=[5,0,0])translate([-1.5,-1.5,0.5])cube(size=[3.5,0.3,1.0]);
rotate(a=270,v=[5,0,0])translate([-1,-0.5,0.5])cube(size=[3.1,0.3,1.0]);
						}
				
									}					
																}


//Cube (gauche extrême) avec un trou (en haut et en bas) pour faire entre les clés 
//Cube far left with hole (top and bottom) to fit in sticks
rotate (a=450,v=[0,0,1])translate([-2.5,-10,0])			{	
translate([8,15,-1]){
difference () 				       {
cube(size=[2,2,2]);
rotate(a=120,v=[1,1,1])translate([1,1.5,-0.5])cylinder(r=0.3,h=3);	
rotate(a=120,v=[1,1,1])translate([1,0.5,-0.5])cylinder(r=0.3,h=3);
rotate(a=270,v=[5,0,0])translate([-1.5,-1.5,0.5])cube(size=[3.5,0.3,1.0]);
rotate(a=270,v=[5,0,0])translate([-1,-0.5,0.5])cube(size=[3.1,0.3,1.0]);
					}
				
									}	 					 }

						
				
									
						
												}
									


															       
						

														



