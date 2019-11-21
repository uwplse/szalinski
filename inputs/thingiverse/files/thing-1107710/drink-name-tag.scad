

echo(version=version());

font = "Liberation Sans";


//thickness of the name tag
tt_numerical_slider=2;// [1:4]
tag_thickness=tt_numerical_slider;

//internal diameter of the hook
hd_numerical_slider=10;// [5:15]
hook_diameter=hd_numerical_slider;

//width of the hook material
hw_numerical_slider=4;// [2:6]
hook_width=hw_numerical_slider;

//font size
ls_numerical_slider=10;// [3:20]
letter_size=ls_numerical_slider;

//name to go on the tag
label_text_box="SSaggers";
label=label_text_box;

//length of the tag
l_text_box=70;
tag_length=l_text_box;

//radius of the fillet (rounding of the corners
f_text_box=3;
fillet=f_text_box;

tag_width = hook_diameter+2*hook_width;







difference(){
  union() {
      
      difference(){
                  cube(size = [tag_length+tag_width/2,tag_width,              tag_thickness], center = false);  //main tag
    
                    union(){ //generate geometry for corner fillets
                        difference(){
                            translate([tag_length+tag_width/2-fillet,0,0])cube(size = [fillet,fillet,tag_thickness],center = false);
    
                            translate([tag_length+tag_width/2-fillet,fillet,0])cylinder(h = tag_thickness, d=fillet*2, center = false);
                        }
                        difference(){
                            translate([tag_length+tag_width/2-fillet,tag_width-fillet,0])cube(size = [fillet,fillet,tag_thickness], center = false);
    
                            translate([tag_length+tag_width/2-fillet,tag_width-fillet,0])cylinder(h = tag_thickness, d=fillet*2, center = false);
                        }
                    }
      }
    translate([0,tag_width/2,0])cylinder(h = tag_thickness, d=tag_width, center = false); //main round for hook
      
    
  }
union() { //cut out text
   translate([hook_diameter+hook_width,tag_width/2,0.5])linear_extrude(height = tag_thickness) {
       text(text = label, font = font, size = letter_size, valign = "center");
     }
     
    translate([0,tag_width/2,0])cylinder(h = tag_thickness, d=hook_diameter, center = false);

cube(size = [hook_diameter,hook_diameter+hook_width,tag_thickness], center = false);

}
}

difference(){ //generate internal fillet to smooth hook
    translate([hook_diameter/2,tag_width/2,0])cube(size = [hook_diameter/2,hook_diameter/2,tag_thickness], center = false);
    
    translate([hook_diameter/2,tag_width/2,0])cylinder(h = tag_thickness, d=hook_diameter, center = false);
}
