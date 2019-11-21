// Llavero a partir de logo. Requiere fichero text.scad (ver https://github.com/brodykenrick/text_on_OpenSCAD)
use <text.scad>

// Parametros texto
use <play.ttf>;
text_font="Play:style=Bold";
text_font_size = 16; 

// Espaciado entre letras (segun fuente... deben estar tocandose todas ellas o se desmontara en cachos
text_font_spacing = 0.78;

//text="MARTINA"; // font-spacing 0.71, font size 16, pencil_length 66.0
text="BRUNO"; // font-spacing 0.78, font size 16, pencil_length = 53.0;

// Pencil cap length (play with this parameter depending on text lenght)
pencil_length = 53.0;
// how big the hole for the pencil should be. BIC: 8.1 
pencil_diameter=8.1;
// how many sides the pencil has (use 20 or more for a circle)
pencil_sides=6;

// Diametro hexagono = 2 * altura_lado_a_lado * raiz_cubica(3)
pencil_hexagon_diameter = pencil_diameter * 1.1547;

text_height = pencil_diameter * 1.8;

module pencil( pencil_length, pencil_diameter, pencil_sides ) {
	difference() {
		// pencil body
        rotate(a=[0,90,0]) cylinder(h = pencil_length, r=pencil_diameter/2, $fn=pencil_sides);
        
		// let's sharpen the pencil
		difference() {
			translate([ -1 ,-25,-pencil_diameter/2]) cube(40,40,40);
			rotate(a=[0,90,0]) cylinder(h = 40,  r1=0.5, r2=(pencil_diameter/2)+2, $fn=50);
		}
	}
	
}

// Pencil hole in text
difference() {
        union(){
            translate( [ pencil_length  / 2 ,  0, 0] ) text_extrude( text , extrusion_height = text_height, center = true, font = text_font, size = text_font_size, spacing = text_font_spacing, convexity = 10, scale=[0.9,0.9]  ); 
            translate([ 3,0,0]) 
                pencil( pencil_length, pencil_hexagon_diameter + 1, pencil_sides);
        }
    translate([ 3,0,0]) pencil( pencil_length+10, pencil_hexagon_diameter, pencil_sides);
}

