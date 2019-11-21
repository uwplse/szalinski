use <MCAD/fonts.scad>

// Word to display on the pen
word = "BrandonW6";

// Scale multipler for font size
font_scale = 2.1	;

// Character Spacing (for some reason this value is buggy using the customizer)
font_spacing = 0.81; 

// The diameter of end hole
pen_inner_diameter = 4.3 *1;
pen_inner_radius = pen_inner_diameter / 2;

// length of the entire pen
pen_length = 130; //

// Overal thickness of the pen
pen_thickness = 8*1;


/////////////////////////////////////////
//////////////////////////////////



module penword()
{

thisFont=8bit_polyfont();
x_shift=thisFont[0][0] * font_spacing;
y_shift=thisFont[0][1];

	theseIndicies=search(word,thisFont[2],1,1);
	wordlength = (len(theseIndicies))* x_shift;
	
	difference() {

		union() {

// Create the Text //
			scale([font_scale,font_scale,1]){
			for( j=[0:(len(theseIndicies)-1)] ) 
				translate([ j*x_shift + 1, -y_shift/2 ,-pen_thickness/2]) 
				{
					linear_extrude(height=pen_thickness) polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);
				}
			}
			
// Main body
			translate([1*font_scale+3	,-y_shift*.45,-pen_thickness/2]) cube([pen_length - 3,y_shift * 0.9,pen_thickness * 0.8]);

// Pen Tip
			rotate(a=[0,90,0]) 
				{
					translate([pen_thickness*0.1,0,0	])	cylinder(h = 5, r = pen_thickness*.4, $fn=50);
					translate([pen_thickness*0.1,0,-5	])	cylinder(h = 5, r1 = 1, r2 = pen_thickness*.4, $fn=50);
				}			
		}
// Cut outs
			translate([0,-pen_inner_diameter/2,-pen_thickness/2+pen_thickness*.15]) cube([pen_length + 20,pen_inner_diameter,pen_inner_diameter]);
			rotate(a=[0,90,0])translate([pen_thickness*.1,0,-15])	cylinder(h = 30, r = pen_inner_radius, $fn=100);
	}
}




penword();