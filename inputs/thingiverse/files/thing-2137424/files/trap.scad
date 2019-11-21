/*
	3D printable small hive beetle trap
	Copyright (C) 2017 Travis John Howse

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

// Gap for beetles
gap = 3.3; // [2:0.1:5]
// Wall thickness
wt = 2; // [1:3]
// How many blades. Controls the length.
blades = 40; //[5:100]
// Blade width
blade_x = 30; // [10:50]
// Oil trap width
box_x = 12; // [5:25]
// Oil trap depth
box_z = 30; // [10:60]

total_y = blades*(gap+wt)+wt;

rotate([0,0,45]) {
translate([0,-wt,0]) for (i=[0:blades]) {
	translate([-blade_x/2,i*(wt+gap),0]) cube([blade_x,wt,wt]);
}

translate([-(box_x-wt*2)/2,0,0]) box();
}

module box() {
	difference() {
		minkowski() {
			inner_box();
			sphere(r=wt);
		}
		inner_box();
		cube([1000,1000,wt*2],center=true);
	}
}

module inner_box() {
	hull() {
		cube([box_x-wt*2,total_y-wt*2,box_z-(box_x-2*wt)]);
		translate([(box_x-wt*2)/2-wt/4,0,box_z]) cube([1,total_y-wt*2,1]);
	}
}
