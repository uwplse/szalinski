// leg length and servo center position  
servoposition=48;

// constrinction's position (middle part)
cons = 17;

// Thickness of the middle part
ralt=4;	

// Servo boarder thickness
svbt=1.5;

// Number of sabilizers
num=5;		
		
// Rubber clamp diameter 	
plateau =11.5;   
	
// Bottom wall height
wall=1.5;	
		
// Bridge sabiziber width
stab=1.1;			

// Overall thickness of the leg		
zdim=5;		

// Servo length
sl = 23;

// Servo width
sw = 12.5;	

// Servo mounting holes radius
smhr = 1;

// Servo mounting holes distance
smhd = 26.5;

// rubber diameter
rubd = 6.7;

// rubber retension height
rubh = 6;

// Do you need two servo mounting holes?
two_se = false;


//////////////////////////////////////////////////////////////////////////////////////////////
// Servo rubber leg
//
// Copyright (C) 2013  Lochner, Juergen
// http://www.thingiverse.com/Ablapo/designs
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
/////////////////////////////////////////////////////////////////////////////////////////////////


module servo(){
	cube([sl,sw,40],center=true);
	translate([-smhd/2,0,0]) cylinder(r=smhr, h=40,center=true,$fn=10);
	if (two_se==true) {translate([smhd/2,0,0]) cylinder(r=smhr, h=40,center=true,$fn=10);}
}



nustart=(servoposition-sl/2-svbt-plateau/4)/(num+1);										// calculate start position for sabilizers
nudist=(servoposition-sl/2-svbt-plateau/8)/(num+1);										// calculate distance of stabilizers

rcut = ( cons*cons +ralt*ralt/4 - plateau*plateau/4)/2/(plateau/2-ralt/2);				// rubber, calculate cutting radius
bwidth = plateau/2* sin(atan((ralt/2+rcut)/ralt*2) )*2;									// rubber, calculate bridge width

bwidth_sv=sw+svbt*2;																// servo, calculate bridge width

svalpha=60;
svplat=(sw/2+svbt)/sin(svalpha)*2 ;
svcons=servoposition-cons-sl/2-svbt+cos(svalpha)*svplat/2;

//#translate([cons+svcons,0,0])cylinder(h=zdim,r=svplat/2);

svrcut = ( svcons*svcons +ralt*ralt/4 - svplat*svplat/4)/2/(svplat/2-ralt/2);				// servo, calculate cutting radius



rubcut=1.5+rubh-plateau/2;															// rubber clamp cut position

difference(){
	union(){	
		difference(){																									// rubber clamp
			translate([0,0,(zdim)/2]) cylinder (h=zdim,r=plateau/2, center=true,$fn=36);								
			if (rubcut>1.5) {translate([(plateau+1)/2+rubcut,0,(zdim+2)/2-1]) cube ([plateau+1,plateau+1,zdim+2], center=true);}
			else {translate([(plateau+1)/2+1.5,0,(zdim+2)/2-1]) cube ([plateau+1,plateau+1,zdim+2], center=true);}		
		}

		translate([cons/2,0,wall/2]) cube([cons,bwidth,wall],center=true);											// bridge bottom wall rubber part
		translate([(servoposition-cons)/2+cons,0,wall/2]) cube([servoposition-cons,bwidth_sv,wall],center=true);		// bridge bottom wall servo part



		intersection(){																									// upper side wall rubber part
			translate([cons,rcut+ralt/2,zdim/2]) cylinder (h=zdim+1,r=rcut+stab, center=true,$fn=80);	
			translate([cons/2,0,zdim/2]) cube([cons,bwidth,zdim],center=true);		
		}
		intersection(){																									// lower side wall rubber part
			translate([cons,-(rcut+ralt/2),zdim/2]) cylinder (h=zdim+1,r=rcut+stab, center=true,$fn=80);	
			translate([cons/2,0,zdim/2]) cube([cons,bwidth,zdim],center=true);		
		}


		intersection(){																									// upper side wall servo part
			translate([cons-0.01,svrcut+ralt/2,zdim/2]) cylinder (h=zdim+1,r=svrcut+stab, center=true,$fn=80);	
			translate([svcons/2+cons-0.01,0,zdim/2]) cube([svcons,bwidth_sv,zdim],center=true);		
		}
		intersection(){																									// lower side wall servo part
			translate([cons-0.01,-(svrcut+ralt/2),zdim/2]) cylinder (h=zdim+1,r=svrcut+stab, center=true,$fn=80);	
			translate([svcons/2+cons-0.01,0,zdim/2]) cube([svcons,bwidth_sv,zdim],center=true);		
		}


		for (i = [0:1:num-1]) {translate([nustart+i*nudist,0,zdim/2]) cube([stab,bwidth,zdim],center=true);	}		// stabilizers

		if (two_se!=true) {translate ([servoposition-(smhd-sl)/2*1.5/2,0,zdim/2]) cube([sl+2*svbt+(smhd-sl)/2*1.5,sw+2*svbt,zdim], center=true);}			// servo frame 1 mounting hole
		else  {translate ([servoposition,0,zdim/2]) cube([sl+(smhd-sl)/2*2.2*2,sw+2*svbt,zdim], center=true);}	// servo frame with 2 mounting holes	
	
		
	}

	
	translate([cons,rcut+ralt/2,zdim/2]) difference(){ 								// cut round shape upper rubber part
			cylinder (h=zdim+1,r=rcut, center=true,$fn=80);										
			translate([rcut/2,-(rcut+1)/2,0]) cube ([rcut,rcut+1,zdim+2],center=true);
			}

	translate([cons,-(rcut+ralt/2),zdim/2]) difference(){ 							// cut round shape lower rubber part
			cylinder (h=zdim+1,r=rcut, center=true,$fn=80);		
			translate([rcut/2, (rcut+1)/2,0]) cube ([rcut,rcut+1,zdim+2],center=true);
			}

	translate([cons-0.01,svrcut+ralt/2,zdim/2]) difference(){ 								// cut round shape upper servo part
			cylinder (h=zdim+1,r=svrcut, center=true,$fn=80);										
			translate([-svrcut/2,-(svrcut+1)/2,0]) cube ([svrcut,svrcut+1,zdim+2],center=true);
			}

	translate([cons-0.01,-(svrcut+ralt/2),zdim/2]) difference(){ 							// cut round shape lower servo part
			cylinder (h=zdim+1,r=svrcut, center=true,$fn=80);		
			translate([-svrcut/2, (svrcut+1)/2,0]) cube ([svrcut,svrcut+1,zdim+2],center=true);
			}


#	translate([servoposition,0,0]) servo();		// servo mount cut
	translate([-plateau/2+rubh/2-0.1,0,+rubd/2-(rubd-zdim)/2]) rotate([ 0,90,0])rotate([0,0,360/2/8]) cylinder(r=rubd/2,h=rubh,center=true,$fn=8);  // cut rubber
}
