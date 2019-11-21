yourname="Name";
fontsize=12;
texthight=0.4;
framehight=3;
minkowski_radius=0.5;
minkowski_fn=7;
fontname="Pacifico"; // [Arial,Gloria Hallelujah, Pacifico, Courgette, Permanent Marker, Domine:Domine bold, Ultra, Bevan, Corben:Corben bold, Coustard:Coustard bold]
what_to_print="text";//[text,frame]



if (what_to_print == "frame"){
  union(){
    difference(){
      translate([0,0,minkowski_radius])minkowski($fn=minkowski_fn){
        union(){
          $fn=24;
          linear_extrude(height = framehight-minkowski_radius*2)rotate([180,0,0])offset(r = 4-minkowski_radius) maketext(yourname,fontsize,0);
          linear_extrude(height = framehight-minkowski_radius*2)rotate([180,0,0])offset(r = 4-minkowski_radius) rotate([180,0,0])maketext(yourname,fontsize,0);
          linear_extrude(height = framehight-minkowski_radius*2)ring();
        }
        sphere(r=minkowski_radius,$fn=minkowski_fn);
      }
      translate([0,0,-0.01])linear_extrude(height = texthight) rotate([180,0,0]) maketext(yourname,fontsize,0);
      translate([0,0,framehight-texthight])linear_extrude(height = texthight+0.01) maketext(yourname,fontsize,0);
    }
  }
}
      
if (what_to_print == "text"){
  union(){
    color("red")translate([0,0,-0.01])linear_extrude(height = texthight) rotate([180,0,0]) maketext(yourname,fontsize,0);
    color("red")translate([0,0,framehight-texthight])linear_extrude(height = texthight+0.01) maketext(yourname,fontsize,0);
  }
}



module maketext(zeichen,groesse,texthight){
  if (texthight > 0){
    color("red")linear_extrude(height = texthight) {
      text(zeichen, font = fontname, size = groesse, direction = "ltr",  spacing = 1, valign = "center");
    }
  }else{
    text(zeichen, font = fontname, size = groesse, direction = "ltr",  spacing = 1, valign = "center" );
  }
}
module ring(){
  difference(){
    hull(){
      translate([-8,0])circle(r=4);
      translate([0,0])circle(r=4);
    }
    translate([-8,0])circle(r=2+minkowski_radius);
  }
}
