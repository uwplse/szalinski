use<write/Write.scad>;

// preview[view:southwest, tilt:top]

/* [Text] */

// Which one would you like to see?
part = "first"; // [first:Full Plaque,second:Letters Only,third:Base Only]

//(Select a font)
typeface = "orbitron"; // [orbitron, Letters, braille, knewave]

top_line_text = "Best Overall";
top_font_size=7; //[1:10]
//(letter spacing)
top_font_space=1;

bot_line_text = "Portland Startup Weekend";
bot_font_size=5; //[1:10]
//(letter spacing)
bot_font_space=1;



/* [Hidden] */
$fn=100;
//Top trapezoid width to fit inside of beaker
p_top=76;
//Overall plaque height
height=20;
//Overall plaque width
width=96;
// plaque thickness
depth=2;
//Cube dimensions
dim=[width, height, depth];


print_part();
module print_part() {
	if (part == "second") {
		gen_text(dim);
	} else if (part == "third") {
		gen_base(dim);
	} else {
		gen_base(dim);
		gen_text(dim);
	}
}


module gen_base(p=[0,0,0]) {
	difference() {
		cube(p, center=true);
		translate([width/2,-height/2,-depth*2]) {rotate([0,0,25]) {cube(height+10);}}
		translate([-width/2,-height/2,-depth*2]) {rotate([0,0,65]) {cube(height+10);}}
	}
}

module gen_text(p=[0,0,0]){
	dafont=str("write/", typeface, ".dxf");
	echo(dafont);
	color("blue") {writecube(top_line_text,[0,0,0],p,face="top", t=3, up=5, font=dafont, h=top_font_size, space=top_font_space);}
	color("red") {writecube(bot_line_text,[0,0,0],p,face="top", t=4, down=5, font=dafont, h=bot_font_size, space=bot_font_space);}
}


