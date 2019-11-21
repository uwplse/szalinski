//Longueur de tasseau (mm)
H1=2400;
//Eppaisseur du Tasseau(mm)
LTasseau=32;
//arete du socle carré (mm)
LSocle=1000;
//eppaisseur du socle (mm)
ESocle=30;

HSolide=H1/8;
H2=H1-HSolide;

echo("HAUTEUR TOTALE :",(H1-HSolide)*2,"mm");
echo("liste de courses : ");
echo("   Seau de ",H1/8/10,"cm de hauteur, par ",H1/8/3*2/10,"x",H1/8/10,"cm de diametre");
echo("   Tasseaux de ",H1/1000,"m : 5");
echo("   Tasseaux de ",H2/1000,"m : 1");
echo("   Tasseaux de ",HSolide/10,"cm : 1");
echo("   Tasseaux de ",H1/3/1000,"m : 1");
echo("   Tasseaux de ",H1/5*4/1000,"m : 1");
echo("   Tasseaux de ",H1/5*2.5/1000,"m : 1");
echo("   Tasseaux de ",H1/5/1000,"m : 1");
echo("   4 equerres metalliques");
echo("   16 vis,boulons, rondelles x2 superieur à ",3*LTasseau,"mm (Fixation du mat)");
echo("   8 vis,boulons, rondelles x2 superieur à ",ESocle+10,"mm  (fixation du mat au socle)");
echo("   2 vis,boulons, rondelles x2 superieur à ",4*LTasseau,"mm  (fixation des voiles basses)");
echo("   1 vis,boulons, rondelles x2 superieur à ",2*LTasseau,"mm  (fixation des voiles Hautes)");
echo("Voile N°1 :",H1/3*2/1000,"m en haut, ",H1/1000,"m en bas, sur ",(((H1+H2)/5*2.5-(H1+H2)/5)-3*LTasseau)/1000,"m de haut");
echo("Voile N°2 :",H1/3/1000,"m en haut, ",H1/3*2/1000,"m en bas, sur ",(((H1+H2)/5*2.5-(H1+H2)/5)-3*LTasseau)/1000,"m de haut");
echo("la Vigie sera agrafée...");

module Voile(LongHaut,LongBas,Hauteur){
    lh=LongHaut/2;
    lb=LongBas/2;
    h=Hauteur;
    rotate([90,0,0]) linear_extrude(height=10,center=true,convexity=10,twist=0) polygon([[-lb,0],[lb,0],[lh,h],[-lh,h]],center=true);
}

module Tasseau(x) 
{
    cube([LTasseau,LTasseau,x]);
};

module Vigie(h){
    cylinder(h,h/3,h/2,center=true);
}

color("Red") {
    Tasseau(200);
    translate([0,0,H2]) Tasseau(H2);
}

color("Orange") translate([LTasseau,0,0]) Tasseau(H1);
color("Orange") translate([-LTasseau,0,0]) Tasseau(H1);
color("Orange") translate([0,LTasseau,0]) Tasseau(H1);
color("Orange") translate([0,-LTasseau,0]) Tasseau(H1);

color("cyan") translate([-H1/6,LTasseau,(H1+H2)/5*4]) rotate([0,90,0]) Tasseau(H1/3);

color("blue") translate([-H1/3,LTasseau*2,(H1+H2)/5*2.5]) rotate([0,90,0]) Tasseau(H1/3*2);


color("green") translate([-H1/2,LTasseau*2,(H1+H2)/5]) rotate([0,90,0]) Tasseau(H1);

color("pink") translate([-LSocle/2,-LSocle/2,-LTasseau]) cube([LSocle,LSocle,ESocle]);

color("White") translate ([0,LTasseau*4,(H1+H2)/5+1.5*LTasseau]) Voile(H1/3*2,H1,((H1+H2)/5*2.5-(H1+H2)/5)-3*LTasseau);

color("White") translate ([0,LTasseau*4,(H1+H2)/5*2.5+1.5*LTasseau]) Voile(H1/3,H1/3*2,((H1+H2)/5*2.5-(H1+H2)/5)-3*LTasseau);

color("Red") translate([0,0,2*H1/8*7]) Vigie(H1/8);

