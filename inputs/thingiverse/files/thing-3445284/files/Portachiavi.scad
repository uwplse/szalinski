yourname="EMANS 1970";
fontsize=12;
texthight=2;
framehight=3;
basehight=0.6;
fontname="BurbankBigCondensed-Bold"; // [Arial, BurbankBigCondensed-Bold,Gloria Hallelujah, Pacifico, Courgette, Permanent Marker, Domine:Domine bold, Ultra, Bevan, Corben:Corben bold, Coustard:Coustard bold]
$fn=50;
inverse="no";//[yes,no]
multi_material_print_text="yes";//[yes,no]
multi_material_print_frame="yes";//[yes,no]

if (inverse == "no"){
  if (multi_material_print_frame == "yes"){
    linear_extrude(height = basehight) {
      offset(r = 5) maketext(yourname,fontsize,0);
      ring();
    }
    translate([0,0,basehight])linear_extrude(height = framehight-basehight) {
      difference(){
        union(){
          offset(r = 5) maketext(yourname,fontsize,0);
          ring();
        }
      offset(r = 3)offset(r=-5) offset(delta=+5) maketext(yourname,fontsize,0);
      }
    }
  }
  if (multi_material_print_text == "yes"){
    translate([0,0,basehight])maketext(yourname,fontsize,texthight-basehight);
  }
}else{
  if (multi_material_print_frame == "yes"){
    color("blue")linear_extrude(height = framehight-texthight) {
      offset(r = 4) maketext(yourname,fontsize,0);
      ring();
    }
  }
  if (multi_material_print_text == "yes"){
    translate([0,0,framehight-texthight])linear_extrude(height = texthight) {
      difference(){
        union(){
          offset(r = 4) maketext(yourname,fontsize,0);
          ring();
        }
        maketext(yourname,fontsize,0);
      }
    }
  }
}

module maketext(zeichen,groesse,texthight){
  if (texthight > 0){
    color("red")linear_extrude(height = texthight) {
      text(zeichen, font = fontname, size = groesse, direction = "ltr",  spacing = 1 );
    }
  }else{
    text(zeichen, font = fontname, size = groesse, direction = "ltr",  spacing = 1 );
  }
}
module ring(){
  difference(){
    hull(){
      translate([-8,fontsize/2])circle(r=4);
      translate([0,fontsize/2])circle(r=4);
    }
    translate([-8,fontsize/2])circle(r=2);
  }
}

