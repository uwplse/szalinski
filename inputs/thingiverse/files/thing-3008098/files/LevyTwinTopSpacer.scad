ecartement=28; // ecartement fil - wire spacer
epaisseur=1.5; //epaisseur plaque

$fn=50;
rayon=2.54;
largeur=40;
union(){

    difference(){
        union(){
            minkowski(){
                translate([0,0,0])cube([ecartement+21-2*rayon,largeur-2*rayon,epaisseur], center=true);
                cylinder(r=rayon, h=0.1, center=true);
                }
            }
            
            
        // trou fixation haut
        translate([-(ecartement/2)-5,8.4,-epaisseur/2-0.1])cube([12,9,epaisseur+0.2]);
        translate([(ecartement/2)-7,8.4,-epaisseur/2-0.1])cube([12,9,epaisseur+0.2]);
 
        // trou fixation moyen
        translate([-(ecartement/2)-8,-4.4,-epaisseur/2-0.1])cube([12,9,epaisseur+0.2]);
        translate([(ecartement/2)-4,-4.4,-epaisseur/2-0.1])cube([12,9,epaisseur+0.2]);

  
        // trou fixation bas
        translate([0,-15,0])cylinder(d=6, h=epaisseur*2, center=true);
        translate([-(ecartement/2)-5,-18.4,-epaisseur/2-0.1])cube([12,9,epaisseur+0.2]);
        translate([(ecartement/2)-7,-18.4,-epaisseur/2-0.1])cube([12,9,epaisseur+0.2]);

          
        translate([0,15,0])cylinder(d=6, h=epaisseur*2, center=true);
    }
    // fixation haut
    translate([ecartement,13,0])fixation();
    translate([-ecartement,13,0])mirror([1,0,0])fixation();

    // fixation moyen
    fixation();
    mirror([1,0,0])fixation();

    // fixation bas
    translate([ecartement,-14,0])fixation();
    translate([-ecartement,-14,0])mirror([1,0,0])fixation();

    


    }


//***********************************************

module fixation(){
    difference(){
        union(){
        translate([-(ecartement/2)-5.6,-3.40,-epaisseur/2-0.05])cube([3.6,6.75,epaisseur+.1]);
        translate([-(ecartement/2)-3.5,-2.54,-epaisseur/2-0.05])cube([9,5.08,epaisseur+.1]);
        } // piece de maintien
        union(){
            translate([-(ecartement/2)-5.6,-3.40,0])rotate([0,0,45])cube([2,2,epaisseur+2], center=true);
            translate([-(ecartement/2)-5.6,3.40,0])rotate([0,0,45])cube([2,2,epaisseur+2], center=true);
            translate([-ecartement/2,0,epaisseur/2])rotate([90,0,0])cylinder(d=epaisseur-0.5, h=6, center=true);
        }// chanfreins et passe cable
    }
}

module troucable(){
    difference(){
        cylinder(r=rayon, h=epaisseur+1, center=true);
        rotate_extrude () translate([rayon*25,0,0]) circle (rayon*2, $fn=100);
    }
}

