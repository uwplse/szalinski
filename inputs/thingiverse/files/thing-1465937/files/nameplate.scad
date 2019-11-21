/* [Text] */

//	the words you want shown
name = "Name/Title";

//	how large do you want the text?
font_size = 11;	//	[1:11]

/*[advanced options]*/
//no negative numbers, just don't touch unless you know you know what your doing.
text_spacing = 1;

//set higer if you want higer res, lower if you want lower res.
fn = 200;
//CUSTOMIZER VARIABLES END

translate([0,0,-.8]) {
	cube([95.9, 11.9, .8],center=true);
}
linear_extrude(.8){
	text(name, size=font_size, halign ="center", valign = "center", spacing=text_spacing,$fn=fn);
}