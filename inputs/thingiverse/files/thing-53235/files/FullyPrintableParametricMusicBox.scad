/*
 * Fully Printed Parametric Music Box With Exchangeable Song-Cylinders
 * Copyright (C) 2013  Philipp Tiefenbacher <wizards23@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * The latest version can be found here:
 * https://github.com/wizard23/ParametrizedMusicBox 
 *
 * contibutions welcome! please send me pull requests!
 *
 * This project was started for the Thingiverse Customizer challenge
 * and is online customizable here:
 * http://www.thingiverse.com/thing:53235/ 
 *
 *
 * Changelog:
 *
 * 2013-03-09, wizard23
 * added name of song using write.scad
 * fixed pulley position on print plate
 *
 */

use <MCAD/involute_gears.scad>
use <write/Write.scad>

// Is this to generate models for 3D printing or for the assembled view?
FOR_PRINT=1; // [0:Assembled, 1:PrintPlate]

// Should the MusicCylinder be generated? 
GENERATE_MUSIC_CYLINDER=1; // [1:yes, 0:no]
// Should the Transmission Gear be generated?
GENERATE_MID_GEAR=1; // [1:yes, 0:no]
// Should the CrankGear be generated?
GENERATE_CRANK_GEAR=1; // [1:yes, 0:no]
// Should the Case (including the vibrating teeth) be generated?
GENERATE_CASE=1; // [1:yes, 0:no]
// Should the Crank be generated?
GENERATE_CRANK=1; // [1:yes, 0:no]
// Should the Pulley for the Crank be generated?
GENERATE_PULLEY=1; // [1:yes, 0:no]

// this text will be put on top of the music cylinder
MusicCylinderName="test song";
// What font do you want to use for the text?
MusicCylinderNameFont="write/Letters.dxf"; //["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]
// how large should the font be
MusicCylinderNameFontSize = 8;
// how deep should the name be carved in?
MusicCylinderNameDepth=0.6;
// should the text be on the top or on the bottom of the music cylinder?
MusicCylinderNamePosition=0; // [0:top, 1:bottom]

// the width of all the walls in the design.
wall=2;

// how many vibrating teeth should there be? (also number of available notes) You can use the output of the generator for this field: http://www.wizards23.net/projects/musicbox/musicbox.html
pinNrX = 13;

// what should the notes on the teeth be? Each note is encoded by 3 characters: note (C,D,E,F,G,A,B), then the accidental (#, b or blank), and then the a one digit octave. You can use the output of the generator for this field: http://www.wizards23.net/projects/musicbox/musicbox.html
teethNotes="C 0C#0D 0D#0E 0F 0F#0G 0G#0A 0A#0B 0C 1C#1D 1D#1E 1F 1";

// how many time slots should there be? (If you make this much higher you should also increase musicCylinderTeeth) You can use the output of the generator for this field: http://www.wizards23.net/projects/musicbox/musicbox.html
pinNrY = 35;

// the actual song. each time slot has pinNrX characters. X marks a pin everything else means no pin. You can use the output of the generator for this field: http://www.wizards23.net/projects/musicbox/musicbox.html
pins="XoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooooooooooooXoooXooXoooooooooooooooooooXoooXooXoooooooooooooooooooXoooXooXoooooooooooooooooooXoooXooXoooooooooooooooooooXoooXooXoooooooooooooooooooXoooXooXoooooooooooooXooXoooXoooooooooooooooooooXooXoooXoooooooooooooooooooXooXoooXoooooooooooooooooooXooXoooXoooooooooooooooooooXooXoooXoooooooooooooooooooXooXoooX";

// the number of teeth on the music cylinder
musicCylinderTeeth = 24;

// nr of teeth on small transmission gear
midSmallTeeth = 8;
// nr of teeth on big transmission gear (for highest gear ratio this should be comparable but slightly smaller than musicCylinderTeeth)
midBigTeeth = 20;
// nr of teeth on crank gear
crankTeeth = 8;

//// Constants 

// the density of PLA (or whatever plastic you are using) in kg/m3 ((( scientiffically derived by me by taking the average of the density values I could find onthe net scaled a little bit to take into account that the print is not super dense (0.7 * (1210 + 1430)/2) )))
ro_PLA = 924; 
// elasticity module of the plastic you are using in N/m2 ((( derived by this formula I hope I got the unit conversion right 1.6*   1000000 *(2.5+7.8)/2 )))
E_PLA = 8240000; 
// the gamma factor for the geometry of the teeth (extruded rectangle), use this to tune it if you have a finite state modell of the printed teeth :) taken from http://de.wikipedia.org/wiki/Durchschlagende_Zunge#Berechnung_der_Tonh.C3.B6he
gammaTooth = 1.875; 
// the frequency of C0 (can be used for tuning if you dont have a clue about the material properties of you printing material :)
baseFrequC0 = 16.3516;


// the angle of the teeth relative to the cylinder (0 would be normal to cylinder, should be some small (<10) positive angle)
noteAlpha = 5;
// the transmission gears angle (to help get the music cylinder out easily this should be negative)
midGearAngle=-5;
// should be positive but the gear must still be held by the case...TODO: calculate this automagically from heigth and angle...
crankGearAngle=15;

// diametral pitch of the gear (if you make it smaller the teeth become bigger (the addendum becomes bigger) I tink of it as teeth per unit :)
diametral_pitch = 0.6;
// the height of all the gears
gearH=3;

// direction that crank hast to be turned it to play the song (has a bug: music is played backwards in clockwise mode so better leave it counter clockwise)
crankDirection = 0; // [1:Clockwise, 0:CounterClockwise]


// HoldderH is the height of the axis kegel

// how far should the snapping axis that holds the crank gear be? (should smaller than the other two because its closer to the corner of the case)
crankAxisHolderH = 1.55;
// how far should the snapping axis that holds the transmission gear be?
midAxisHolderH=3.3;
// how far should the snapping axis that holds the music cylinder be?
musicAxisHolderH=3.4;

pulleySlack=0.4;
crankSlack=0.2;
// for extra distance from axis to gears
snapAxisSlack=0.35; 
// for crank gear axis to case
axisSlack=0.3; 

// cutout to get Pulley in
pulleySnapL=1.2; 
// higher tolerance makes the teeth thinner and they slip, too low tolerance jams the gears
gear_tolerance = 0.1;
// used for the distance between paralell gears that should not touch (should be slightly larger than your layer with) 
gear_gap = 1;
gear_min_gap = 0.1;
gear_hold_R = 4;

// used for clean CSG operations
epsilonCSG = 0.1;
// reduce this for faster previews
$fn=32;
// Replace Gears with Cylinders to verify gear alignment
DEBUG_GEARS=0; // [1:yes, 0:no]


crankAxisR = 3;
crankAxisCutAway = crankAxisR*0.8;
crankLength = 18;
crankAxisCutAwayH = 4;

crankExtraH=4;
crankH=crankExtraH+2*crankAxisCutAwayH;


pulleyH=10;
pulleyR=crankAxisR+wall;






/// music section

// also nr of notes

     

teethH = 3*0.3;

pinH= 3;
pteethMinD = 1.5;

teethGap = pinH;

pinD=1.5;

teethHolderW=5;
teethHolderH=5;





circular_pitch = 180/diametral_pitch;

addendum = 1/diametral_pitch;


musicH=pinNrX*(wall+teethGap);

echo("height of song cylinder");
echo(musicH);

//// Derived Music stuff


pinStepX = musicH/pinNrX;
pinStepY = 360/pinNrY;

teethW = pinStepX-teethGap;
maxTeethL=TeethLen(0); // convention index 0 is lowest note
///////////////////////



musicCylinderR = (musicCylinderTeeth/diametral_pitch)/2;
midSmallR = (midSmallTeeth/diametral_pitch)/2;
midBigR = (midBigTeeth/diametral_pitch)/2;
crankR = (crankTeeth/diametral_pitch)/2;

centerForCrankGearInsertion=(midBigR+crankR)/2;





//noteExtend = wall+20;
noteExtend = teethHolderW+maxTeethL + pteethMinD; 

midGearDist = musicCylinderR+midSmallR;
crankDist = midBigR+crankR;

midGearXPos = cos(midGearAngle)*midGearDist;
midGearZPos = sin(midGearAngle)*midGearDist;

crankGearXPos = midGearXPos + cos(crankGearAngle)*crankDist;
crankGearZPos = midGearZPos + sin(crankGearAngle)*crankDist;

echo("R of song cylinder");
echo(musicCylinderR);
maxMusicAddendum = 1.5*max(addendum, pinH);
frameH = max(musicCylinderR, -midGearZPos+midBigR) + maxMusicAddendum;

gearBoxW = 2 * (gearH+gear_gap+wall) + gear_gap;


songH = musicH+teethGap+teethGap;
frameW = gearBoxW + songH;



// noteExtend in alpha angle projected to y and x-axis
noteExtendY = sin(noteAlpha)*noteExtend;
noteExtendX = cos(noteAlpha)*noteExtend;
echo(noteExtendY/musicCylinderR);
noteBeta = asin(noteExtendY/musicCylinderR);

echo("Note Extend");
echo(noteExtendX);

// musicCylinderR to intersection with noteExtend
musicCylinderRX = cos(noteBeta)*musicCylinderR;




negXEnd = -(noteExtendX+musicCylinderRX);
posXEnd = crankGearXPos + crankR + 1.5*addendum + wall;

posYEnd = tan(noteAlpha)*(noteExtendX + musicCylinderRX+posXEnd);


module MyAxisSnapCutout(h, z=0, mirr=0,extra=epsilonCSG)
{
	translate([0,0,z])
	mirror([0,0,mirr])
	translate([0,0,-extra]) 
	{	
		cylinder(h=h+extra+snapAxisSlack, r1=h+extra+snapAxisSlack, r2=0, center=false);
	}
}


module MyAxisSnapHolder(h, x=0, y=0, z=0, mirr=0,extra=wall, h2=0)
{
	rotate([-90,0,0])
	mirror([0,0,mirr])
	translate([x,-z,-extra-y]) 
	{
		cylinder(h=h+extra, r1=h+extra, r2=0, center=false);
		intersection()
		{
			cylinder(h=h+extra+gear_hold_R, r1=h+extra+gear_hold_R, r2=0, center=false);
			translate([0, 0, -50 + extra -gear_min_gap])
				cube([100, 100, 100], center=true);
		}
	}
}

module MyGear(n, hPos, hNeg, mirr=0)
{
	if (DEBUG_GEARS)
	{
		translate([0,0,-hNeg]) cylinder(r=(n/diametral_pitch)/2, h=hPos+hNeg, center = false);
	}
	if (!DEBUG_GEARS)
	{
		HBgearWithDifferentLen(n=n, mirr=mirr, hPos=hPos, hNeg=hNeg, tol=gear_tolerance);
	}
}


/* based on Emmet's herringbone gear taken from thing: http://www.thingiverse.com/thing:34778 */

module HBgearWithDifferentLen(n,hPos,hNeg,mirr=0, tol=0.25)
{
twistScale=50;
mirror([mirr,0,0])
translate([0,0,0])
union(){
	mirror([0,0,1])
	gear(number_of_teeth=n,
		diametral_pitch=diametral_pitch,
		gear_thickness=hNeg,
		rim_thickness=hNeg,
		hub_thickness=hNeg,
		bore_diameter=0,
		backlash=2*tol,
		clearance=2*tol,
		pressure_angle=20,
		twist=hNeg*twistScale/n,
		slices=10);
	
	gear(number_of_teeth=n,
		diametral_pitch=diametral_pitch,
		gear_thickness=hPos,
		rim_thickness=hPos,
		hub_thickness=hPos,
		bore_diameter=0,
		backlash=2*tol,
		clearance=2*tol,
		pressure_angle=20,
		twist=hPos*twistScale/n,
		slices=10);
}
}


echo("Testing NoteToFrequ, expected freq is 440");
echo(NoteToFrequ(9, 4, 0));


//// SPECFIC functions
function TeethLen(x) = 
	1000*LengthOfTooth(NoteToFrequ(LetterToNoteIndex(teethNotes[x*3]), 
			LetterToDigit(teethNotes[x*3+2]),
			AccidentalToNoteShift(teethNotes[x*3+1])),
			teethH/1000, E_PLA, ro_PLA);



//// PLATONIC functions
// http://de.wikipedia.org/wiki/Durchschlagende_Zunge#Berechnung_der_Tonh.C3.B6he
// f [Hz]
// h m
// E N/m2
// ro kg/m3
function LengthOfTooth(f, h, E, ro) = sqrt((gammaTooth*gammaTooth*h/(4*PI*f))*sqrt(E/(3*ro)));

function NoteToFrequ(note, octave, modification) = baseFrequC0*pow(2, octave)*pow(2, (note+modification)/12);

function AccidentalToNoteShift(l) =
l=="#"?1:
l=="b"?-1:
l==" "?0:
INVALID_ACCIDENTAL_CHECK_teethNotes();

// allow B and H
// todo allow big and small letters
function LetterToNoteIndex(l) =
l=="C"?0:
l=="D"?2:
l=="E"?4:
l=="F"?5:
l=="G"?7:
l=="A"?9:
l=="H"?11:
l=="B"?11: 
INVALID_NOTE_CHECK_teethNotes();

function LetterToDigit(l) = 
l=="0"?0:
l=="1"?1:
l=="2"?2:
l=="3"?3:
l=="4"?4:
l=="5"?5:
l=="6"?6:
l=="7"?7:
l=="8"?8:
l=="9"?9:
INVALID_DIGIT_IN_OCTAVE_CHECK_teethNotes();





module Pin()
{
	difference()
	{
		translate([-pinStepX/2,-pinD/2,-pinH])
		cube([pinStepX+4*teethGap, pinD, 2*(pinH+0.15)],center=false);

translate([pinStepX/2,0,0])
		rotate([0,-35,0]) translate([4.0*pinStepX,0,0]) cube([8*pinStepX,8*pinStepX,8*pinStepX],center=true);
	}
}



module MusicCylinder(extra=0)
{
	translate([0,0,-extra]) cylinder(r = musicCylinderR, h = teethGap+musicH+extra, center=false, $fn=128);
	translate([0,0,teethGap])
	for (x = [0:pinNrX-1], y = [0:pinNrY-1])
	{
		assign(index = y*pinNrX + x)
		{
			if (pins[index] == "X")
			{
				
				rotate([0,0, y * pinStepY])
					translate([musicCylinderR, 0, (0.5+x)*pinStepX]) rotate([0,90,0])
							Pin();
			}
		}
	}
}



module MusicBox()
{
	//mirror([0,0,1])
	translate([teethHolderW+maxTeethL,0,0])

	rotate([180,0,0])
	for (x = [0:pinNrX-1])
	{
		assign(ll = TeethLen(x))
		{
			translate([-maxTeethL, x *pinStepX + teethGap, 0]) 
			{
				// teeth holder
				assign (leftAdd = (x == 0) ? gearBoxW : 0, rightAdd = (x == pinNrX-1) ? wall/2+gear_gap : 0)
				{
				translate([-(teethHolderW), epsilonCSG-leftAdd, 0]) 
					cube([teethHolderW+maxTeethL-ll, pinStepX+2*epsilonCSG+leftAdd+rightAdd, teethHolderH]);
				}
				

				// teeth
				translate([-teethHolderW/2, teethGap,0])
				color([0,1,0])cube([maxTeethL+teethHolderW/2, teethW, teethH]);
			}
		}
	}
	
}




///// CODE





mirror ([0, FOR_PRINT?crankDirection:0,0])
{
// case shape

if (GENERATE_CASE)
{	
	translate([0,0,FOR_PRINT?-negXEnd*sin(noteAlpha):0])
	intersection()
	{
		if (FOR_PRINT)
		{
			//translate([0,0, 500+negXEnd*sin(noteAlpha)]) cube([1000, 1000, 1000], center=true);

			assign(maxX = max(posXEnd, -negXEnd))
			translate([0,0, 2*frameH+negXEnd*sin(noteAlpha)]) cube([3*maxX, 2*frameW, 4*frameH], center=true);
		}
	rotate([FOR_PRINT?180:0, FOR_PRINT?-noteAlpha:0,0])
	{

	difference()
	{
		union()
		{

		// PIANO :)
		
		translate([-(noteExtendX+musicCylinderRX),-(gearH/2+gear_gap+teethGap),0]) 
			rotate([0,-noteAlpha*1,0]){
			
				MusicBox();
				translate([0,2*gearH+wall,-teethHolderW]) cube([-negXEnd,teethHolderW,teethHolderW]);
			}
	
		// snapaxis for crank
		MyAxisSnapHolder(h=crankAxisHolderH, x=crankGearXPos, y =gearH/2+gear_gap, z=crankGearZPos, mirr=0, extra=gear_gap+epsilonCSG);
	
	
	
		// snapaxis for music cylinder
		MyAxisSnapHolder(h=musicAxisHolderH, y =gearH/2-gear_gap, mirr=1, extra=gearH+2*gear_gap+wall/2);
		MyAxisSnapHolder(h=musicAxisHolderH, y =gearH/2 +1*gear_gap +songH, extra=gear_gap+epsilonCSG, mirr=0);
	
		// snapaxis for mid gear
		MyAxisSnapHolder(h=midAxisHolderH, y =1.5*gearH, x=midGearXPos, z=midGearZPos, mirr=1);
		MyAxisSnapHolder(h=midAxisHolderH, y =gearH/2+gear_gap, x=midGearXPos, z=midGearZPos, mirr=0);
	
		difference()
		{
			// side poly extruded and rotated to be side
			rotate([-90,0,0]){
				translate([0,0,-frameW+1.5*gearH + gear_gap+wall])
					linear_extrude(height=frameW) 
						polygon(points=
[[negXEnd,0],[posXEnd,-posYEnd],[posXEnd,frameH], [negXEnd,frameH]], paths=[[0,1,2,3]]);
	
			
			}

// cutout, wall then remain
		linear_extrude(height=4*frameH, center=true) 
					polygon(points=[
[negXEnd+wall,-(0.5*gearH+2*gear_gap+songH)],
[musicCylinderR+maxMusicAddendum,-(0.5*gearH+songH+2*gear_gap)],
[musicCylinderR+maxMusicAddendum,-(0.5*gearH+2*gear_gap)],
[posXEnd-wall,-(0.5*gearH+2*gear_gap)],
[posXEnd-wall,(1.5*gearH+gear_gap)],
 [negXEnd+wall,(1.5*gearH+gear_gap)]
], paths=[[0,1,2,3,4,5,6]]);
	

		}
	}

		// cutout, make sure gears can rotate
		linear_extrude(height=4*frameH, center=true) 
					polygon(points=[
[0+1*crankAxisR,(1.5*gearH+gear_gap)],
[0+1*crankAxisR,-(songH/2)],
[musicCylinderR+maxMusicAddendum,-(songH/2)],
[musicCylinderR+maxMusicAddendum,(1.5*gearH+gear_gap)]], paths=[[0,1,2,3]]);


// cutout because of narrow smallgear
			linear_extrude(height=4*frameH, center=true) 
					polygon(points=[
[musicCylinderR+maxMusicAddendum+wall,-(0.5*gearH+2*gear_gap+wall)],
[musicCylinderR+maxMusicAddendum+wall,-frameW],
[posXEnd+1,-frameW],
[posXEnd+1,-(0.5*gearH+2*gear_gap+wall)]], paths=[[0,1,2,3]]);


			// Crank Gear Cutouts
			translate([crankGearXPos,0,crankGearZPos])
			{
				rotate([-90,0,0])
					cylinder(h=100, r=crankAxisR+axisSlack, center=false);


				rotate([0,-90-max(crankGearAngle,45+noteAlpha),0]) 
				{

					*translate([-(crankAxisR-axisSlack),0,0]) cube([2*(crankAxisR),100, centerForCrankGearInsertion]);

					
rotate([-90,0,0])
linear_extrude(height=musicH/2, center=false) 
					polygon(points=[
[-(crankAxisR+axisSlack),-centerForCrankGearInsertion],
[(crankAxisR+axisSlack),-centerForCrankGearInsertion],
[(crankAxisR),0],
[-(crankAxisR),0]],
paths=[[0,1,2,3]]);


					translate([0*(crankR+addendum*1.5),0,centerForCrankGearInsertion])
					rotate([90,0,0])
					cylinder(h=100, r=(crankR+addendum*1.5), center=false);

					translate([0*(crankR+addendum*1.5),0,centerForCrankGearInsertion])
					mirror([0,1,0])
					rotate([90,0,0])
					cylinder(h=100, r=crankAxisR+axisSlack, center=false);

				}	
			}

	}
	
	}
}
}
}


// music cylinder and gear
if (GENERATE_MUSIC_CYLINDER)
{
	translate([FOR_PRINT?-1.5*(musicCylinderR+addendum):0,FOR_PRINT?(crankDirection ? -1 : 1)*-((musicCylinderR+addendum)+gearBoxW):0, FOR_PRINT?gearH/2-gear_gap:0])
	rotate([FOR_PRINT?180:-90,0,0])
		translate([0,0,-(gear_gap)])
		difference()
		{
			union()
			{
				MyGear(n=musicCylinderTeeth, hPos = gearH/2, hNeg=gearH/2+gear_gap);
				translate([0,0,-gearH/2-gear_gap/2]) cylinder(h=gear_gap+epsilonCSG, r2=musicCylinderR-addendum, r1=musicCylinderR-addendum+gear_gap);
				rotate([0, 180,0]) 
translate([0,0,teethGap+gearH/2]) 
{
rotate([0,0,27]) MusicCylinder(extra=teethGap+epsilonCSG);
}
				// PINS :)
			}
			union()
			{
				MyAxisSnapCutout(h=musicAxisHolderH, z=-(gearH/2)-songH, mirr=0);
				MyAxisSnapCutout(h=musicAxisHolderH, z=gearH/2, mirr=1);
	
				// text
				translate([0,0,MusicCylinderNamePosition == 1 ? gearH/2+1: -(songH+gearH/2-MusicCylinderNameDepth)]) 
					scale([1,1,MusicCylinderNameDepth+1])
						writecylinder(text=MusicCylinderName, where=[0,0,0], radius=musicCylinderR, height=1, face="bottom", space=1.3, center=true, h=MusicCylinderNameFontSize, font=MusicCylinderNameFont);
			}
		}
}

// midGear
color([1,0,0])
if (GENERATE_MID_GEAR)
{
	translate([FOR_PRINT?1.5*(musicCylinderR+addendum):0,FOR_PRINT?(crankDirection ? -1 : 1)*-((musicCylinderR+addendum)+gearBoxW):0, FOR_PRINT?1.5*gearH:0])

	translate([FOR_PRINT?0:midGearXPos,0,FOR_PRINT?0:midGearZPos])
		rotate([FOR_PRINT?180:-90,0,0])
			difference()
			{
			union() {
				translate([0,0,gearH]) 
				{
					difference(){
						MyGear(n=midBigTeeth, hPos = gearH/2, hNeg=gearH/2,mirr=1);
						
					}
				}
				translate([0,0,-gear_gap])
				difference()
				{
					MyGear(n=midSmallTeeth, hPos = gearH/2+gear_gap+epsilonCSG, hNeg=gearH/2, mirr=1);
				}
				
			}
			translate([0,0,-gear_gap])			
					MyAxisSnapCutout(h=midAxisHolderH, z=-(gearH/2), mirr=0);
			translate([0,0,gearH]) MyAxisSnapCutout(h=midAxisHolderH, z=(gearH/2), mirr=1);
			}
}



if (GENERATE_CRANK_GEAR)
{
	// crank gear
	translate([FOR_PRINT?0:crankGearXPos, FOR_PRINT?(crankDirection ? -1 : 1)*-(gearBoxW/2+wall/2+gearH+crankR+addendum):0, FOR_PRINT?(0.5*gearH+gear_gap):crankGearZPos])


	//translate([crankGearXPos,0,crankGearZPos])
		rotate([FOR_PRINT?0:-90,0,0])
		union() {
			translate([0,0,gearH]) 
			difference()
			{
				union() {
					difference() {
						cylinder(h=gearH/2+wall+2*gear_gap+2*crankAxisCutAwayH, r=crankAxisR, center=false);
						translate([0,50+crankAxisR-crankAxisCutAway,gearH/2+wall+gear_gap+2*crankAxisCutAwayH])cube([100,100,crankAxisCutAwayH*2], center=true);
					}
					cylinder(h=gearH/2+gear_gap-gear_min_gap, r=crankR-addendum, center=false);
					MyGear(n=crankTeeth, hPos = gearH/2, hNeg=1.5*gearH+gear_gap, mirr=0);	
				}
				MyAxisSnapCutout(h=crankAxisHolderH, z=-1.5*gearH-gear_gap);
			}
		}
}

// crank
color([0,1,0])
if (GENERATE_CRANK)
{
	translate([FOR_PRINT?-2*wall:crankGearXPos, FOR_PRINT?(crankDirection ? -1 : 1)*musicH/2+gearH:1.5*gearH+2*gear_gap+wall+crankH, FOR_PRINT?0:crankGearZPos])

	rotate([FOR_PRINT?0:-90,0,0])
	mirror([0,0,FOR_PRINT?0:1])
	{
		// to gear snapping
		difference() {
			cylinder(h=crankH, r=crankAxisR+crankSlack+wall,center=false);
			translate([0,0,crankH-gear_gap])  difference() {
				cylinder(h=4*crankAxisCutAwayH, r=crankAxisR+crankSlack,center=true);
				translate([0,50+crankAxisR+crankSlack-crankAxisCutAway,-2*crankAxisCutAwayH])cube([100,100,crankAxisCutAwayH*2], center=true);
			}
		}
		
		translate([crankLength,0,0]) 
			difference() {
				union() {
					// crank long piece
					translate([-crankLength/2,0,wall/2])
						cube([crankLength,2*(crankAxisR),wall],center=true);
					translate([-crankLength/2,0,crankExtraH/2])
							cube([crankLength,wall,crankExtraH],center=true);
					// where puley snaps/axis
					cylinder(h=crankExtraH, r=crankAxisR+pulleySlack+wall,center=false);
				}
				cylinder(h=3*crankExtraH, r=crankAxisR+pulleySlack,center=true);
				translate([50,0,0]) cube([100, 2*crankAxisR-2*pulleySnapL, 100], center=true);
			}
				
	}
}

if (GENERATE_PULLEY)
{
	translate([FOR_PRINT?(musicCylinderR+maxMusicAddendum):crankGearXPos, FOR_PRINT?(crankDirection ? -1 : 1)*gearBoxW+pulleyR:1.5*gearH+2*gear_gap+wall+crankH-crankExtraH, FOR_PRINT?crankExtraH+pulleyH+2*gear_gap:crankGearZPos])	
	rotate([FOR_PRINT?180:-90,0,0])
	translate([crankLength,0,0]) 
	{
		// delta shaped end
		translate([0,0,-wall-gear_gap]) cylinder(h=crankAxisR+wall+gear_gap, r2=0, r1=crankAxisR+wall,center=false);
		// axis
		translate([0,0,-wall/2]) cylinder(h=crankExtraH+pulleyH+wall/2, r=crankAxisR,center=false);
		// handle
		translate([0,0,crankExtraH+gear_gap]) cylinder(h=pulleyH+gear_gap, r=pulleyR,center=false);
	}
}









