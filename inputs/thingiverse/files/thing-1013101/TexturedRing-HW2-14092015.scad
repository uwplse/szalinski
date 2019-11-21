// By 20156444 EK
// Reference : https://github.com/openscad/openscad/issues/512
//             http://customizer.makerbot.com/docs
// The size is not respected (finger size for eg)

/* [Global] */
use <write/Write.scad>
//text to be printed around the ring
text = "Je t'aime";
// radius of ring
r1 = 30; // [20:100]
// embosed height of letters
h2 =1; // [1:5]
// text size 
size = 10; // [1:12]
//height of the ring
d = 20; // [15:25]
//convexity
c = 10; // [5:30]
//color of letter RGB
x=0;
y=0;
z=0;
//color of ring RGB
//a=240;b=215;c=52;
module text_around_ring(
						,r=r1           // r is the radius of the ring
						,h=h2		// h is embosed height of letters
						,size = size		// text size
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
	_r=(r1+h2)*l;
	//echo(r=r,h=h,text=text,size=size,rotate=rotate);
	//echo(l=l,tall=tall,_h=_h,_r=_r);

color([x,y,z])
 // choose the color of the text
              translate([ 0, 0, -d/4 ])/*d/4 so that letters to be in the middle of the ring*/      difference() {
		rotate([90,rotate[1],rotate[2]])
			linear_extrude(height=r1+h2,convexity=c)
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
			cylinder(r=r1-0.1,h=_h,center=true);
			difference() {
				cylinder(r=_r,h=_h+s,center=true);
				// -
				cylinder(r=r1+h2,h=_h+s2,center=true);
			} //d
		} // t
	} // d
} // text_around_ring

module _ring() {
	color("gold") // color of the ring
    difference() {
            cylinder(r=r1,h=d,center=true);
        translate([ 0, 0, 0 ]) cylinder(r=r1-5, h=d+1, center = true);
    }
	text_around_ring();			// test defaults
} 

_runring=1;
if (_runring)
_ring();