//list of lines, separated by "," each line has to be double quoted
yourname=["this is my","name tag"];
// as many sizes as lines are in yourname
fontsize=[6,10,8,8];
//height is the same for all lines
textheight=2;
//horizontal align of the lines
horizontalalign="center"; //[left, center]
frameheight=3;
framethicknes=2;
baseheight=0.6;
//as many fonts as lines are in "yourname". You can use (nearly) all fonts of fonts.google.com for example Arial,Gloria Hallelujah, Pacifico, Courgette, Permanent Marker, Domine:Domine bold, Ultra, Bevan, Corben:Corben bold, Coustard:Coustard bold, ZCOOL QingKe HuangYou
fontname=["Courgette","Pacifico"];
//space between the lines depends on the fontsize and this factor
linespacingfactor=1.5;
//space between the characters depends on the fontsize and this factor
characterspacingfactor=1.0;
//ring on the right side, too
right_ring = "yes"; //[no, yes]
//correction factor for both rings, if not the right distance to the text
lencorrect=0.65;
$fn=50;
//the frame arround the single characters
offsetr = 6;
inverse="no";//[yes,no]
multi_material_print_text="yes";//[yes,no]
multi_material_print_frame="yes";//[yes,no]

/* [Hidden] */

ringlength = (len(yourname[0])*fontsize[0]*lencorrect)/2;
ringmove = horizontalalign == "center" ? 0 : ringlength;

function add(v, i = 0, r = 0) = i < len(v) ? add(v, i + 1, r + v[i]) : r;
function sublist(list, from=0, to) =
    let( end = (to==undef ? len(list)-1 : to) )
    [ for(i=[from:end]) list[i] ];

if (inverse == "no"){
  if (multi_material_print_frame == "yes"){
    linear_extrude(height = baseheight) {
      offset(r = offsetr) maketext(yourname,fontsize,0);
      translate([ringmove,0,0])ring(ringlength);
      if (right_ring == "yes"){
        translate([ringmove,0,0])mirror([1,0,0])ring(ringlength);
      }
    }
    translate([0,0,baseheight])linear_extrude(height = frameheight-baseheight) {
      difference(){
        union(){
          offset(r = offsetr*characterspacingfactor) maketext(yourname,fontsize,0);
          translate([ringmove,0,0])ring(ringlength);
          if (right_ring == "yes"){
            translate([ringmove,0,0])mirror([1,0,0])ring(ringlength);
          }
        }
      offset(r = (offsetr-framethicknes)*characterspacingfactor)offset(r=-offsetr*characterspacingfactor) offset(r=+offsetr*characterspacingfactor) maketext(yourname,fontsize,0);
      }
    }
  }
  if (multi_material_print_text == "yes"){
    translate([0,0,baseheight])maketext(yourname,fontsize,textheight-baseheight);
  }
}else{
  if (multi_material_print_frame == "yes"){
    color("blue")linear_extrude(height = frameheight-textheight) {
      offset(r = offsetr-1*characterspacingfactor) maketext(yourname,fontsize,0);
      translate([ringmove,0,0])ring(ringlength);
      if (right_ring == "yes"){
        translate([ringmove,0,0])mirror([1,0,0])ring(ringlength);
      }
    }
  }
  if (multi_material_print_text == "yes"){
    translate([0,0,frameheight-textheight])linear_extrude(height = textheight) {
      difference(){
        union(){
          offset(r = offsetr-1*characterspacingfactor) maketext(yourname,fontsize,0);
          translate([ringmove,0,0])ring(ringlength);
          if (right_ring == "yes"){
            translate([ringmove,0,0])mirror([1,0,0])ring(ringlength);
          }
        }
        maketext(yourname,fontsize,0);
      }
    }
  }
}

module maketext(alltext,textsize,textheight){
  if (textheight > 0){
    color("red")linear_extrude(height = textheight) {
      //text(zeichen, font = fontname, size = groesse, direction = "ltr",  spacing = 1 );
      translate([0,0,0])multiLine(alltext, textsize, fontname);
    }
  }else{
    //text(zeichen, font = fontname, size = groesse, direction = "ltr",  spacing = 1 );
    translate([0,0,0])multiLine(alltext, textsize, fontname);
  }
}

module ring(rlength){
  difference(){
    hull(){
      //translate([-2-offsetr,-fontsize[0]/2])circle(r=4);
      translate([-rlength-offsetr-2,-fontsize[0]*linespacingfactor*0.7])circle(r=4);
      translate([0,-fontsize[0]*linespacingfactor*0.7])circle(r=4);
    }
    translate([-rlength-offsetr-2,-fontsize[0]*linespacingfactor*0.7])circle(r=2);
  }
}

module multiLine(lines, tsize, fonttitel){
  union(){
    for (i = [0 : len(lines)-1]){
      translate([0 , -1 * (add(sublist(tsize,0,i))) * linespacingfactor, 0 ]) text(lines[i], font = fonttitel[i], size = tsize[i], direction = "ltr",  spacing = characterspacingfactor, valign = "center", halign = horizontalalign);
    }
  }
}
