use <write/Write.scad>

// How Many Colors?
part = "single"; // [single:Single,dual:dual]

CasinoName="Sky Trail Poker ";
CasinoNameHeight=7.1;
CasinofontName="write/Letters.dxf"; //["write/Letters.dxf":Letters, "write/BlackRose.dxf":BlackRose, "write/orbitron.dxf":orbitron, "write/knewave.dxf":knewave, "write/braille.dxf":braille]
ChipValue=100;
ValueHeight=12;
ValuefontName="write/Letters.dxf"; //["write/Letters.dxf":Letters, "write/BlackRose.dxf":BlackRose, "write/orbitron.dxf":orbitron, "write/knewave.dxf":knewave, "write/braille.dxf":braille]
Diameter=40;
Thickness=3.5;
width=175;


	if (part == "dual") {
		fillcolor();
		//maincolor();
	} else if (part == "single") {
		maincolor();
	} else  {
		maincolor();
	} 




module maincolor(){
difference(){
    chip();
    translate([0,0,Thickness-1.0])valueletters();
	ringletters();
	}
}

module fillcolor(){
    translate([0,0,Thickness-1.0])valueletters();
	ringletters();
}


module ringletters(){
 color("blue")translate([0,0,.5])writecylinder(CasinoName,[0,0,0],(Diameter)/2+1,height=CasinoNameHeight,face="bottom",h=CasinoNameHeight,t=1.25,space=1.15,font=CasinofontName);
}


module valueletters(){
 color("blue")write(str(ChipValue), t=Thickness-1.25, h=ValueHeight,font=ValuefontName, center=true);
}

module chip(){
	translate([0,0,1])cylinder(r=Diameter/2,h=Thickness-2,$fn=60);
	translate([0,0,0])cylinder(r1=Diameter/2-.25,r2=Diameter/2,h=1,$fn=60);
	translate([0,0,Thickness-1])cylinder(r1=Diameter/2,r2=Diameter/2-.25,h=1,$fn=60);
	
}



