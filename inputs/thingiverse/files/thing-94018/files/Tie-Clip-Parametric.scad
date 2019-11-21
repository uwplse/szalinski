include <write/Write.scad>

/* [Basic] */

//Input Text
text="Your Name";

//Tie Clip Height scale factor
height=1;

//Text Horizontal offset on clip (Default 0 is approx centered.)
offset=0;

//Text Vertical Offset on clip
vOff=0;

//Font
font="write/Orbitron.dxf"; //["write/BlackRose.dxf":BlackRose,"write/braille.dxf":Braille,"write/knewave.dxf":knewave,"write/Letters.dxf":Default,"write/orbitron.dxf":Orbitron]

/* [Advanced] */

clip_height=8;
clip_width=9;
clip_thick=3;
clip_front_length=60;
clip_back_length=45;
clip_tooth_spacing=6;
clip_tooth_size=1;
clip_gap=(clip_width-2*clip_thick);



scale([1,1,height])
tie_clip();


	translate([offset+clip_front_length/2,-clip_width/2,height*clip_height/2+vOff])
rotate([90,0,0])
		write(text,t=2,h=height*5,center=true, font=font);



module tie_clip(){

union(){
	difference(){
		union(){
			cylinder(r=clip_width/2, h=clip_height, $fn=40);
			translate([0,-clip_width/2,0])
				cube([clip_front_length,clip_width,clip_height]);
		}
		cylinder(r=clip_gap/2, h=clip_height, $fn=40);
		translate([0,-(clip_width-2*clip_thick)/2,0])
			cube([clip_front_length,clip_gap,clip_height]);
		translate([clip_back_length,0,0])
			cube([100,100,100]);
	}
	translate([clip_back_length,clip_gap/2+clip_thick/2,0])
		cylinder(r=clip_thick/2,h=clip_height,$fn=40);
	translate([clip_front_length,-clip_gap/2-clip_thick/2,0])
		cylinder(r=clip_thick/2,h=clip_height,$fn=40);
	for(i=[clip_tooth_spacing:clip_tooth_spacing:clip_back_length]){
		translate([i,clip_gap/2,clip_height/2])
			cube([clip_tooth_size,clip_tooth_size,clip_height],center=true);
	}
	for(i=[clip_tooth_spacing/2:clip_tooth_spacing:clip_back_length]){
		translate([i,-clip_gap/2,clip_height/2])
			cube([clip_tooth_size,clip_tooth_size,clip_height],center=true);
	}
}
}
