//Word or Name
the_word = "Jeep";
//Padding Around Word
border = 2;
//Resolution - The higher the number, the smoother the print
$fn = 75;
linear_extrude (height = 4) {
    text (the_word, font = "Archivo Black", valign = "center");
}
linear_extrude (height = 2) {
offset (r= border){
    text (the_word, font = "Archivo Black", valign = "center");
    }
}
difference(){
    hull(){
        translate([-4,0,0]) cylinder (h=2, r=4, center=false);
        translate([-4,-4,0]) cube ([8,8,2], false);
    }
    translate([-4,0,0]) cylinder (h=6, r=2, center=true);
}