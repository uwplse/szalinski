//Paramètres commun d'un flocon de neige

Nombre_de_bras = 6;
Longueur_de_la_branche =30;
Angle_des_branches = 24;
Epaisseur_des_branches = 2;
Epaisseur = 2;
Nombre_de_branches = 5; //inférieur à 40
germe =7; //un nombre entre 1 et 7

module tree(Longueur_de_la_branche,Angle_des_branches, Epaisseur_des_branches, Epaisseur,Nombre_de_branches,germe){
	module half_tree(){
		cube([Epaisseur_des_branches/2,Longueur_de_la_branche,Epaisseur]);

		for ( i = [1:Nombre_de_branches]){
			translate([0, (Longueur_de_la_branche-1.3)*cos(i*13), 0]) 
			rotate(Angle_des_branches*(germe+sin(i*15))) 
			cube([Longueur_de_la_branche*sin(i*(2+germe))+0.5, Epaisseur_des_branches, Epaisseur]);
		}
	}

	half_tree(Longueur_de_la_branche, Angle_des_branches,Epaisseur_des_branches, Epaisseur,Nombre_de_branches, germe);
	mirror()half_tree(Longueur_de_la_branche, Angle_des_branches, Epaisseur, Nombre_de_branches, germe);
}

module snowflake(Nombre_de_bras, Longueur_de_la_branche, Angle_des_branches, Epaisseur_des_branches, Epaisseur, Nombre_de_branches, germe){
	hole_dist = Longueur_de_la_branche;
	translate([0,Longueur_de_la_branche,0])cylinder(h=Epaisseur, r=Longueur_de_la_branche*sin(1*(2+germe))+Epaisseur_des_branches, $fn=10);
		for ( i = [0:Nombre_de_bras-1]){
			rotate( i*360/Nombre_de_bras, [0,0,1])
			tree(Longueur_de_la_branche,Angle_des_branches, Epaisseur_des_branches, Epaisseur,Nombre_de_branches,germe);
		}
}

translate([Longueur_de_la_branche,Longueur_de_la_branche,0]){
difference(){

snowflake(
	Nombre_de_bras, 
	Longueur_de_la_branche, 
	Angle_des_branches,
	Epaisseur_des_branches,
	Epaisseur,
	Nombre_de_branches,
	germe
);
translate([0,Longueur_de_la_branche,-2])cylinder(h=Epaisseur*2, r=Longueur_de_la_branche*sin(3), $fn=10);
}
}
