include <write/Write.scad>

/* [Global] */
part = "both"; // [coin:Coin with the text carved out,text:Text only,both:Coin with text]

coin_diameter=27;
coin_thickness=2;
hole_radius=3;
text="TO BE OR NOT TO BE";
font_size=3;
font_spacing=1.3;

/* [Hidden] */
radius=coin_diameter/2;
fn=300;

module txt(){
 writecylinder(text,[0,0,0],radius,coin_thickness*2-0.5,face="top",center=true,h=font_size,space=font_spacing); 
}

if(part=="coin" || part=="both"){

	difference(){
	 color("yellow")cylinder(h=coin_thickness, r=radius, $fn=fn);
	  translate([0,-radius+hole_radius+3,-1]){
	   cylinder(h=coin_thickness+2, r=hole_radius, $fn=fn);
	  } 
	 txt();
	}

}

if (part=="text" || part=="both"){
	color("black")txt();
}
