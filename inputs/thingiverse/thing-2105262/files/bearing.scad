/* toothedLinearBearing
 * based on  Krallinger Sebastian's 2012 model:
 * http://www.thingiverse.com/thing:18219
 * Dual-licensed under 
 * Creative Commons Attribution-ShareAlike 3.0 (CC BY-SA) [http://creativecommons.org/licenses/by-sa/3.0/]
 * and
 * GPL v2 or later [http://www.gnu.org/licenses/].
 */

//Inner Diamiter of the baring. This is the size of the rod it's to be run on, in mm
int_Inner = 10; //[8:100]
//Outer Diamiter of the baring. diffrent shapes may need bigger/smaller outer diamiters
int_Outer = 15; //[15:115]
//Length of the baring
int_Length = 24;//[100]
//printer head diamiter
dec_Dia = 0.2;
//minimum thickness of the outer wall. 
dec_wallThick = 0.85;
//number of teeth, more the better, but dont be silly
int_teeth = 25; //[100]
//coverd length of the inner ring (Im not sure exactly what this does, but it doesnt work right without it)
dec_toothRatio = 0.25;
//number of sides for the outside of the baring (3 = triange, 4 = square ect)
int_sides = 16; //[3:360]

// ************* units.scad ************* //
//thise units are used to keep everything clean
mm = 1;
cm = 10 * mm;
dm = 100 * mm;
m = 1000 * mm;

inch = 25.4 * mm;

X = [1, 0, 0];
Y = [0, 1, 0];
Z = [0, 0, 1];

M3 = 3*mm;
M4 = 4*mm;
M5 = 5*mm;
M6 = 6*mm;
M8 = 8*mm;

epsilon = 0.01*mm;
OS = epsilon;

TLB_linearBearing(int_Inner, int_Outer, int_Length, dec_Dia, dec_wallThick, int_teeth, dec_toothRatio);

module TLB_linearBearing(inner_d, outer_d, h, stringWidth, minWallThickness,	tooths, toothRatio) {
	
	stringWidth          = stringWidth; //!< the layer width of one string
	
	TLB_innerD           = inner_d;
	TLB_outerD           = outer_d;
	TLB_minWallThickness = minWallThickness;
	TLB_h                = h;
	TLB_tooths           = tooths;
	
	TLB_toothRate        = toothRatio;
	
	
	gapWidth             = (TLB_innerD*PI)/TLB_tooths *TLB_toothRate;
	//echo(str("gap Width: ", gapWidth));
	middR                = TLB_outerD/2- TLB_minWallThickness;
	
	//outer ring
	difference() {
		cylinder(r=TLB_outerD/2, h=TLB_h, center=true,$fn=int_sides);
		cylinder(r=middR, h=TLB_h+2*OS, center=true);
	}
	

	difference() {
		union(){
			cylinder(r=TLB_innerD/2 + stringWidth, h=TLB_h, center=true);

			for (i=[0:360 / TLB_tooths : 360]) {
				rotate(a=i,v=Z) translate([-(gapWidth+2*stringWidth)/2, 0, -TLB_h/2])
					cube(size=[gapWidth+2*stringWidth, middR+OS, TLB_h], center=false);
			}
		}
		union(){
			cylinder(r=TLB_innerD/2, h=TLB_h+2*OS, center=true);
			
			for (i=[0:360 / TLB_tooths : 360]) {
				rotate(a=i,v=Z) translate([-gapWidth/2, 0, -TLB_h/2-OS]) 
					cube(size=[gapWidth, middR, TLB_h+2*OS], center=false);
			}
		}
	}
}
