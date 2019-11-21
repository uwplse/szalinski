// Length 
distance=40;
		
// Number of sabilizers
num=5;		
		
// Thickness of the middle part
ralt=4;		
	
// Servos plateau diameter 	
plateau =11.5;   
	
// Bottom wall height
wall=1.5;	
		
// Bridge sabiziber width
stab=1.1;			

// Thickness of screw retention
height=1.5;	

// Height of gear connector		
zdim=3.5;		
// Diameter of gear connector	
rdim=4.7;	

// Gear connector's screw bolt diameter		
screw=1.5;			

//////////////////////////////////////////////////////////////////////////////////////////////
// Servo double horn (press fit)
//
// Copyright (C) 2013  Lochner, Jürgen
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

nustart=(distance-plateau/2)/(num+1)+plateau/4;										// calculate start position for sabilizers
nudist=(distance-plateau/2)/(num+1);												// calculate distance of stabilizers

rcut = ( distance/2*distance/2 +ralt*ralt/4 - plateau*plateau/4)/2/(plateau/2-ralt/2);		// calculate cutting radius
bwidth = plateau/2* sin(atan((ralt/2+rcut)/ralt*2) )*2;									// calculate bridge width

difference(){
	union(){	
		translate([0,0,(zdim+height)/2]) cylinder (h=zdim+height,r=plateau/2, center=true,$fn=36);								// right plateau
		translate([distance,0,(zdim+height)/2]) cylinder (h=zdim+height,r=plateau/2, center=true,$fn=36);							// left plateau

		translate([distance/2,0,wall/2]) cube([distance,bwidth,wall],center=true);													// bridge bottom wall

		intersection(){																											// upper side wall
			translate([distance/2,rcut+ralt/2,(zdim+height)/2]) cylinder (h=zdim+height+1,r=rcut+stab, center=true,$fn=80);	
			translate([distance/2,0,(zdim+height)/2]) cube([distance,bwidth,zdim+height],center=true);		
		}
		intersection(){																											// lower side wall
			translate([distance/2,-(rcut+ralt/2),(zdim+height)/2]) cylinder (h=zdim+height+1,r=rcut+stab, center=true,$fn=80);	
			translate([distance/2,0,(zdim+height)/2]) cube([distance,bwidth,zdim+height],center=true);		
		}
		for (i = [0:1:num-1]) {translate([nustart+i*nudist,0,(zdim+height)/2]) cube([stab,bwidth,zdim+height],center=true);	}		// stabilizers
	}

	translate([0,0,(zdim+height)/2+height]) cylinder (h=zdim+height,r=rdim/2, center=true,$fn=24);				// cut right gear connector	
	translate([0,0,(zdim+height)/2-0.1]) cylinder (h=zdim+height+1,r=screw/2, center=true,$fn=12);				// cut right screw hole

	translate([distance,0,(zdim+height)/2+height]) cylinder (h=zdim+height,r=rdim/2, center=true,$fn=24);			// cut left gear connector	
	translate([distance,0,(zdim+height)/2-0.1]) cylinder (h=zdim+height+1,r=screw/2, center=true,$fn=12);		// cut left screw hole

	translate([distance/2,rcut+ralt/2,(zdim+height)/2]) cylinder (h=zdim+height+1,r=rcut, center=true,$fn=80);			// cut round shape
	translate([distance/2,-(rcut+ralt/2),(zdim+height)/2]) cylinder (h=zdim+height+1,r=rcut, center=true,$fn=80);		// cut round shape
}
