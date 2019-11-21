targa_Ydir=5;
targa_Xdir=50;
targa_spessore_thickness=2;
word="\u2665MOM\u2665";  //word to spinn
size_font=15;               //size of the font
spacing_text=.8;            //word letter spacing

n_word=len(word);           //calculate length

translate([0, 0, targa_spessore_thickness/2]) {
    cube([targa_Xdir,targa_Ydir,targa_spessore_thickness],true);
}

linear_extrude(height = targa_spessore_thickness+2)
text(word, size=size_font, font="Liberation Sans", halign="center", valign="center",
  spacing=spacing_text, direction="ltr", language="it");
