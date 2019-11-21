// By 20156444 EK
// Reference : https://github.com/openscad/openscad/issues/512


//text to be printed (round the ring
text = "HELLO WORLD";
// radius of ring
r = 30; // [10:100]



module text_around_ring(text="Je t'aime" //text to write around the ring
						,r=30           // r is the radius of the ring
						,h=1			// h is embosed height of letters
						,size=5		// text size
						,rotate=[0,0,0]		// | y= rotate face of text
											// | z= rotate around the circumference
											// | x is ignored
						,font=undef		// : these allow default value in text()
						,spacing=undef	// : undef gets rid of WARNING unknown variable
						,language=undef
						,valign=undef
                        ,script=undef					
						,halign="center" // is centered due to the technique used here
										// 
						,direction=undef
						) { 
	s=0.1; s2=s*2;	// small, for difference etc.
	l=3;			// large (as a multiplyer) to allow for text size irregularity
	tall=( rotate!=[0,0,0] || direction=="btt" || direction=="ttb" );
	_h= (	tall 					// keep cut cylinders to reasonable size
			? (size*len(text)*l) 
			: size*l ); 
	_r=(r+h)*l;
	//echo(r=r,h=h,text=text,size=size,rotate=rotate);
	//echo(l=l,tall=tall,_h=_h,_r=_r);


color("gold") // choose the color of the text
                          difference() {
		rotate([90,rotate[1],rotate[2]])
			linear_extrude(height=r+h,convexity=5)
				text(text,size,halign="center"
						,font=font
						,spacing=spacing
						,language=language
						,script=script
						,valign=valign
						,direction=direction
				);
		// -
		translate([0,0,size/2]) {
			cylinder(r=r,h=_h,center=true);
			difference() {
				cylinder(r=_r,h=_h+s,center=true);
				// -
				cylinder(r=r+h,h=_h+s2,center=true);
			} //d
		} // t
	} // d
} // text_around_ring

module _ring() {
	color("gold") // color of the ring
    difference() {
            cylinder(r=30,h=15,center=true);
        translate([ 0, 0, -10 ]) cylinder(r=27, h= 25);
    }
	text_around_ring();			// test defaults
} 

_runring=1;
if (_runring)
_ring();