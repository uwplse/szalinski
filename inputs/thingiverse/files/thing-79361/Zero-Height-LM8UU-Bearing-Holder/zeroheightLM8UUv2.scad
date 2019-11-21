//////////////////////////////////////////////////////////////////////////////////////////////
// Zero height LM8UU bearing holder
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

// bearing's length
b_length=24.2 ;		
// bearing's diameter
b_dia= 15.3;		

// x distance of holes
dx=28;			
// y distance of holes	
dy=21;				

angle=60;			// holder cut off angle
b_angle=30;		// bearing cut off angle

bolt=4.9+0.4;		// M5 bolt diameter
nut=9.8+0.4; 		// washer's size 

rod=8+2;			// round cut at center rod
zcutoff=0;		// 0= cut height at bearing's height

boltlength=20-6-4-1-1;   // 20 mm bolt, 6 mm aluplate, 4mm nut, 1mm washer

module holder(){
intersection(){
	difference(){

		translate([b_dia/2+3,0,0.5]) rotate([90,0,0])cube ([b_dia,b_dia+1,b_length+8-1],center=true);
		#rotate([90,0,0]) cylinder(h=b_length,r=b_dia/2,center=true,$fn=46);								// cut bearing
		translate([0 ,0,-b_dia/2]) rotate([90,0,0])cube ([b_dia,b_dia,b_length],center=true);			// cut below bearing

		#rotate([90,0,0]) cylinder(h=b_length+15,r=rod/2,center=true,$fn=24);								// cut center rod
 
		#translate([dx/2,dy/2,0])cylinder(h=b_dia*3,r=bolt/2, center=true,$fn=12);						// cut bolt 1
		translate([dx/2,dy/2,0.5+boltlength])
			union(){
				cylinder(h=b_dia+1,r=nut/2, center=true,$fn=44);
				translate([nut/2,0,0])cube ([nut,nut,b_dia+1],center=true);
				translate([0,nut/2,0])cube ([nut,nut,b_dia+1],center=true);
			}
	
		#translate([dx/2,-dy/2,0])cylinder(h=b_dia*3,r=bolt/2, center=true,$fn=12);						// cut bolt 2
		translate([dx/2,-dy/2,0.5+boltlength])
			union(){
				cylinder(h=b_dia+1,r=nut/2, center=true,$fn=44);
				translate([ nut/2,0,0])cube ([nut,nut,b_dia+1],center=true);
				translate([0,-nut/2,0])cube ([nut,nut,b_dia+1],center=true);
			}

		translate([b_dia+3,0,0]) cylinder(h=b_length+15,r=9.5/2,center=true,$fn=24);						// slim cut

		translate([b_dia+3,0,0.4])rotate([0,-angle,0])translate([b_dia*1.5,0,b_dia*1.5])cube([b_dia*3,b_length+8+1,b_dia*3],center=true); // cut holder angle
		rotate([0,b_angle,0])translate([-b_dia*1.5,0,b_dia*1.5])cube([b_dia*3,b_length+8+1,b_dia*3],center=true);		// cut bearing angle
		translate([0,0,b_dia*1.5-b_dia/2+b_dia+zcutoff])cube([b_dia*3,b_length+8+1,b_dia*3],center=true);		// cut top

	}

	cylinder(h=b_dia*4,r=b_length-0.3,center=true,$fn=12);
}
}

module spacer(){
	difference(){
		cylinder(h=6,r=10/2-0.1,center=true,$fn=44);
		cylinder(h=7,r=8/2,center=true,$fn=44);
	}
}

module plate(){
	translate([-2,0,0])holder();
	translate([2,0,0])rotate([0,0,180]) holder();
}

//plate();
holder();