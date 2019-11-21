use <utils/build_plate.scad>
use <write/Write.scad>

// preview[view:south, tilt:top]

/* [Image] */
format = "standard"; // [square:Carré, standard:Photo_4x3, hd:16x9]
orientation = "paysage"; // [paysage, portrait]
Dimensions_de_la_plaque = "grande"; // [grande, petite]
fichier_image = "image-surface.dat"; // [image_surface:100x100]

/* [Plaque] */
avec_un_anneau = "oui"; // [oui, non]
diametre_du_trou = 10;
epaisseur_des_couches = 0.2;
nombre_de_couches = 12; // [8:20]

/* [Texte] */
Ligne_de_texte_1 = "";
Ligne_de_texte_2 = "";
Ligne_de_texte_3 = "";
Ligne_de_texte_4 = "";
Ligne_de_texte_5 = "";
Grandeur_des_lettres = 10;
position_verticale = 0; // [-80:80]
texte_en_miroir = "non"; // [non, oui]

/* [Hidden] */

// base (white) will always be 2 layers thick
min_epaisseur_des_couches = epaisseur_des_couches*2;
hole_radius = diametre_du_trou/2;
height = epaisseur_des_couches*nombre_de_couches;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2, 1:Replicator, 2:Thingomatic, 3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

preview_tab = "";

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

if (format == "square") {
  if (Dimensions_de_la_plaque == "grande") {
    lithopane(100, 100, 1, 1);
  } else {
    lithopane(50, 50, 0.5, 0.5);
  }
} else if (format == "standard") {
  if (orientation == "paysage") {
    if (Dimensions_de_la_plaque == "grande") {
      lithopane(133, 100, 4/3, 1);
    } else {
      lithopane(133/2, 100/2, (4/3)/2, 1/2);
    }
  } else {
    if (Dimensions_de_la_plaque == "grande") {
      rotate([0,0,90]) lithopane(100, 133, 1, 4/3);
    } else {
      rotate([0,0,90]) lithopane(100/2, 133/2, 1/2, (4/3)/2);
    }
  }
} else if (format == "hd") {
  if (orientation == "paysage") {
    if (Dimensions_de_la_plaque == "grande") {
      lithopane(177, 100, 16/9, 1);
    } else {
      lithopane(177/2, 100/2, (16/9)/2, 1/2);
    }
  } else {
    if (Dimensions_de_la_plaque == "grande") {
      rotate([0,0,90]) lithopane(100, 177, 1, 16/9);
    } else {
      rotate([0,0,90]) lithopane(100/2, 177/2, 1/2, (16/9)/2);
    }
  }
}

module lithopane(length, width, x_scale, y_scale) {
  union() {
    // take just the part of surface we want
    difference() {
      translate([0, 0, min_epaisseur_des_couches]) scale([x_scale,y_scale,height]) surface(file=fichier_image, center=true, convexity=5);
      translate([0,0,-(height+min_epaisseur_des_couches)]) linear_extrude(height=height+min_epaisseur_des_couches) square([length, width], center=true);
    }
    linear_extrude(height=epaisseur_des_couches*2) square([length+4, width+4], center=true);

    linear_extrude(height=height+min_epaisseur_des_couches) {
  	  difference() {
  		  union() {
  	      square([length+4, width+4], center=true);
  	      if (avec_un_anneau == "oui") {
            translate([0, width/2+hole_radius+2, 0]) circle(r=hole_radius+5);
          }
  		  }
        union() {
          square([length, width], center=true);
  	      if (avec_un_anneau == "oui") {
            translate([0, width/2+hole_radius+2, 0]) circle(r=hole_radius);
          }
        }
  	  }
    }
    
    // add optional text
    rotate_text() translate([0, position_verticale, height/2]) union() {
      translate([0, 30, 0])  write(Ligne_de_texte_1, t=height, h=Grandeur_des_lettres, center=true);
      translate([0, 15, 0])  write(Ligne_de_texte_2, t=height, h=Grandeur_des_lettres, center=true);
      translate([0, 0, 0])   write(Ligne_de_texte_3, t=height, h=Grandeur_des_lettres, center=true);
      translate([0, -15, 0]) write(Ligne_de_texte_4, t=height, h=Grandeur_des_lettres, center=true);
      translate([0, -30, 0]) write(Ligne_de_texte_5, t=height, h=Grandeur_des_lettres, center=true);
    }
  }
}

module rotate_text() {
  if (texte_en_miroir == "oui") {
    translate([0, 0, height]) rotate([0, 180, 0]) child(0);
  } else {
    translate([0, 0, 0]) rotate([0, 0, 0]) child(0);
  }
}


