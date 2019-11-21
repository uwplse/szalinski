marcoSup=6.3;
marcoLat=3.7;

difference(){
union(){
translate([-141.69,-54.76,-10.6-3.4+0.01]) scale(v=[1,1,1.13]) import("lcdFront.stl");
// Volumen añadido
translate([18.55-marcoLat,35.7-marcoSup,-2])  cube([71.5+2*marcoLat,39.5+2*marcoSup,2]);

}

// hueco LCD
translate([18.55,35.7,-4])  cube([71.5,39.5,10]);

}