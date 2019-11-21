/* [Instrument] */
//Scale Length in mm
Scale_length = 280; //[200:0.1:400]
//Number of Frets
Num_Frets = 12; //[8:40]

/* [Fretboard] */
//Length in mm
FB_length = 142; //[80:0.1:300]
//Width in mm
FB_width = 40; //[10:0.1:100] 
//Base thickness in mm
FB_thickness = 3; //[2.6:0.1:20]

/* [Frets] */
//Fret width in mm
Fret_thickness = 1.25; //[0.1:0.01:5]
//Fret height in mm
Fret_height = 1.05; //[0.1:0.01:3]

/* [Nut] */
//Nut thickness in mm
Nut_size = 5; //[1:0.1:8]
//Nut height in mm
Nut_height = 2.4; //[1:0.1:8]
//Depth of grooves in mm
Groove_depth = .5; //[0.1:0.1:1.5]
//Groove thickness in mm
Groove_thickness = 1; //[0.1:0.1:1.5]



//Fretboard
color("yellow")cube([FB_length, FB_width, FB_thickness], center=true);

//Nut
translate([FB_length/2-((Nut_size/2)*.785),0,-(Nut_size/2-FB_thickness/2)+Nut_height])	
fret_shape(FB_width, Nut_size, Nut_size, 4, "Y");

//Frets
color("red") frets(Num_Frets,(Nut_size/2)*.785,Scale_length);


module frets(NumFrets, Offset, Scale) {

	offs = Offset + ((Scale-Offset)/17.817);
	translate([(FB_length/2)-offs,0,(FB_thickness/2-Fret_thickness)+Fret_height])	
	fret_shape(FB_width, Fret_thickness*2, Fret_thickness*2, 4, "N");	
//	echo(NumFrets,offs);
		
	if(NumFrets > 1){frets(NumFrets-1,offs,Scale);}
}

module fret_shape(Length, Width, Height, NumStrings, Grooves){

intersection() {		
	rotate([90,0,90])
	color("blue")cube([Length*2, Height*4, Width*.785], center=true);

	difference(){
		translate([0,FB_width/2,0])
		rotate([90,0,0])
		color("blue")
		cylinder(r=Width/2,h=FB_width,$fn = 300);
		
		//string grooves
		if (Grooves == "Y") {
			translate([-FB_width/4,-(FB_width/3),( Nut_size/2)+1-Groove_depth])
			rotate([0,90,0])
			cylinder(r=Groove_thickness,h=FB_width/2,$fn = 300);
			translate([-FB_width/4,(FB_width/3),( Nut_size/2)+1-Groove_depth])
			rotate([0,90,0])
			cylinder(r=Groove_thickness,h=FB_width/2,$fn = 300);
			translate([-FB_width/4,-(FB_width/8.5),( Nut_size/2)+1-Groove_depth])
			rotate([0,90,0])
			cylinder(r=Groove_thickness,h=FB_width/2,$fn = 300);
			translate([-FB_width/4,(FB_width/8.5),( Nut_size/2)+1-Groove_depth])
			rotate([0,90,0])
			cylinder(r=Groove_thickness,h=FB_width/2,$fn = 300);
			}
		}
	}
}
