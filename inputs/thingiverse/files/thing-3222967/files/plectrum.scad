//length of plectrum
length = 30;
//main thickness of plectrum
thickness = 0.75; //[0.3:0.1:2]
//Text to emboss on the pick - 3-6 characters is good
my_text = "guitar";
//how much the text should stick out from the surface
text_thickness = 0.25;

linear_extrude(thickness) scale( length/40 ){
    hull() {
        translate ([-10,16]) rotate(30) scale([0.2,1]) circle (r=20,  $fn=72);
        translate ([10,16]) rotate(-30) scale([0.2,1]) circle (r=20,  $fn=72);
        translate ([0,33]) rotate(90) scale([0.4,1]) circle (r=20.5,  $fn=72);
    }
}   
    linear_extrude(thickness +text_thickness) scale( length/40 ){
        translate([0,25]) text(my_text, halign="center");
    }