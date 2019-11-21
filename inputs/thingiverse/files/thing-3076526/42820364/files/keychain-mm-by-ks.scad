yourname="My Name";
fontsize=12;
textheight=3.2;
frameheight=2.4;
baseheight=0.6;
ringheight=2.4;
//all fonts from front.google.com can be used. If your favorite is not listed, use "not-listed-font" and enter the name in the appropriate field below.
dropdown_fontname="Pacifico"; // [not-listed-font,Arial,Gloria Hallelujah, Pacifico, Courgette, Permanent Marker, Domine:Domine bold, Ultra, Bevan, Corben:Corben bold, Coustard:Coustard bold, ZCOOL QingKe HuangYou]
// has to be the complete name of the font including style
not_listed_font="Sacramento";
$fn=50;
inverse="no";//[yes,no]
//To make a multi-material print, export text and frames individually to a file. For a monochrome print, export both at the same time.
multi_material_print_text="yes";//[yes,no]
multi_material_print_frame="yes";//[yes,no]

/* [Hidden] */

fontname = dropdown_fontname == "not-listed-font" ? not_listed_font : dropdown_fontname ;

if (inverse == "no"){
  if (multi_material_print_frame == "yes"){
    linear_extrude(height = baseheight) {
      offset(r = 5) maketext(yourname,fontsize,0);
      ring();
    }
    translate([0,0,baseheight])linear_extrude(height = frameheight-baseheight) {
      difference(){
        offset(r = 5) maketext(yourname,fontsize,0);
        offset(r = 3)offset(r=-5) offset(delta=+5) maketext(yourname,fontsize,0);
      }
    }
    translate([0,0,baseheight])linear_extrude(height = ringheight-baseheight) {
      difference(){
        ring();
        offset(r = 3)offset(r=-5) offset(delta=+5) maketext(yourname,fontsize,0);
      }
    }
  }
  if (multi_material_print_text == "yes"){
    translate([0,0,baseheight])maketext(yourname,fontsize,textheight-baseheight);
  }
}else{
  if (multi_material_print_frame == "yes"){
    color("blue")linear_extrude(height = baseheight) {
      offset(r = 4) maketext(yourname,fontsize,0);
      ring();
    }
  }
  if (multi_material_print_text == "yes"){
    translate([0,0,baseheight])linear_extrude(height = textheight) {
      difference(){
        offset(r = 4) maketext(yourname,fontsize,0);
        maketext(yourname,fontsize,0);
      }
    }
    translate([0,0,baseheight])linear_extrude(height = ringheight) {
      difference(){
        ring();
        maketext(yourname,fontsize,0);
      }
    }
  }
}

module maketext(zeichen,groesse,textheight){
  if (textheight > 0){
    color("red")linear_extrude(height = textheight) {
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
