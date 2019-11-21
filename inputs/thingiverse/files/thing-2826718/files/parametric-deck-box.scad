//-----------------------------------------
// Customizable deck box by @satanin
//-----------------------------------------
// Card or sleeves data
card_width=59; //[10:200]
card_height=91; //[10:200]
box_depth=70; // [10:200]
//-----------------------------------------
// Which part do you want to print? Lid, box, all?
part="both"; // [both:"both","boxlid":"box lid","box":"box"]
// Gane text, leave empty to disable text
game1="Oh my Goods!";
// Text size
text_size=6; // [1:20]
//-----------------------------------------
// Do not edit beyond this unless you know
// what you do. :D
//-----------------------------------------
/* Hidden */
card_spacer=2;
box_wall=1;
box_separator=3;
width=card_width+card_spacer+(box_wall*2);
depth=box_depth;
height=card_height+card_spacer+box_wall;
box_height=height*75/100;
boxlid_height=height*60/100;
boxlid_width=width+box_separator;
boxlid_depth=depth+box_separator;



module fside(x,y,z,_offset) {
 	translate([0,_offset,0]){cube([x,y,z]);}
}

module lside(x,y,z,_offset) {
 	translate([_offset,0,0]){cube([x,y,z]);}
}

module box(){
	cube([width,depth,box_wall]);
	color("purple"){
		fside(width,box_wall,box_height,0);
		fside(width,box_wall,box_height,depth-box_wall);
	}
	lside(box_wall,depth,box_height,0);
	lside(box_wall,depth,box_height,width-box_wall);
	
}

module boxlid(){
	cube([boxlid_width,boxlid_depth,box_wall]);
	color("purple"){
		fside(boxlid_width,box_wall,boxlid_height,0);
		fside(boxlid_width,box_wall,boxlid_height,boxlid_depth-box_wall);
	}
	lside(box_wall,boxlid_depth,boxlid_height,0);
	lside(box_wall,boxlid_depth,boxlid_height,boxlid_width-box_wall);
	
	color("red"){
		translate([boxlid_width/2,0,boxlid_height/2]){
			rotate([-90,0,180]){
				linear_extrude(0.5){
					text(game1,size=text_size,halign="center");
					//text(game2);
				}
			}
		}
	}
}

if (part=="box"){
	box();
}
else if (part=="boxlid"){
	
		boxlid();
}
else {
	box();
	translate([0,-box_depth*1.5,0]){
		boxlid();
	}
}
