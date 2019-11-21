//simple pcb standoff library - By the DoomMeister

/*
Types will be through hole, captured nut, split column (with and without base)

v1 - First Release
v1.1 - Tidied Split Base
v1.2 - added support for end nut
v1.3 - Cleaned up a bit, allowing it to be used as both a customizer object and OpenSCAD library without changes (Marius Kintel <marius@kintel.net>)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

include<MCAD/metric_fastners.scad>

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//usage
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
/*
pcb_stand_off(
              type="plain",  THIS IS THE TYPE OF STAND OFF plain, end_nut, split_base 
	      hex=true, 		THIS IS THE OUTSIDE SHAPE IS IT HEXAGONAL OR ROUND,NOT USED ON SPLIT TYPE
	      od = 10, 		OUTSIDE DIAMETER
	      id = 3,        THREAD SIZE FOR INNER DIAMETER, HOLE SIZE FOR SPLIT TYPE
	      len = 12, 		LENGTH, SUPPORT HEIGHT FOR SPLIT TYPE
	      cl=0.3,  		CLEARANCE
	      thk_base,		BASE THICKNESS FOR SPLIT TYPE
	      thk_pcb);		PCB THICKNESS
*/

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//Customiser Stuff
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

//Plain, Retained Nut or Split Pillar With Base
Stand_Off_Type = "plain"; // [plain:Plain, end_nut:Captive Nut, split_base:Screwless]
//Round or Hex Outside
Outside_Shape = 0; // [0:Circular, 1:Hexagonal]
// in mm
Outside_Diameter = 8;
// Thread Size in mm
Inside_Diameter = 3;
// PCB Spacing
Length = 10;
// PCB hole clearance
Clearance = 0.3;
// screwless variant only
Base_Thickness = 1.5;
// screwless variant only
PCB_Thickness = 1.5;

//Thing
pcb_stand_off(type=Stand_Off_Type,
              hex=Outside_Shape,
              od = Outside_Diameter,
              id = Inside_Diameter,
              len = Length,
              cl=Clearance,
              thk_base=Base_Thickness,
              thk_pcb=PCB_Thickness);

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//draw test
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
/*
spaceing = 15*1;
translate([0*spaceing,0*spaceing,0])color("red")pcb_stand_off(type="plain",hex=true, od = 10, id = 3, len = 12, cl=0.3,thk_base=3,thk_pcb=1.5);
translate([1*spaceing,0*spaceing,0])color("green")pcb_stand_off(type="end_nut",hex=false, od = 10, id = 3, len = 12, cl=0.3);
translate([1*spaceing,1*spaceing,0])color("blue")pcb_stand_off(type="split_base", od = 10, id = 3, len = 8, cl=0.3, thk_base=1.5,thk_pcb=1.5);
*/

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//outer module
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

module pcb_stand_off(type="plain",hex=false, od = 8, id = 3, len = 8, cl=0.3,thk_base=3,thk_pcb=1.5)
{
    if (type=="plain") {
	if (hex) stand_off_hex(_od=od, _id = id,_len = len,_cl = cl);
	else stand_off(_od=od, _id = id,_len = len,_cl = cl);
    }
    if (type=="end_nut") {
	if (hex) end_nut_stand_off_hex(_od=od, _id = id,_len = len,_cl = cl);
        else end_nut_stand_off(_od=od, _id = id,_len = len,_cl = cl);
    }
    if (type=="split_base") {
	split_base_stand_off(_od=od, _id = id,_len = len,_cl = cl,_thk_base=thk_base,_thk_pcb=thk_pcb);
    }
}

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//inner modules
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

module end_nut_stand_off(_od=2, _id = 2,_len = 8,_cl = 0.3)
{
    union() {
	difference() {
	    cylinder(r = _od/2, h = _len, $fn=100);
	    translate([0,0,-1])cylinder(r = (_id + _cl)/2, h = _len+2, $fn=100);
	    translate([0,0,0])flat_nut(_id+_cl,apply_chamfer=false);
	    translate([0,0,_len-(0.8*(_id+_cl))+.01])flat_nut(_id+_cl,apply_chamfer=false);
	}
	translate([0,0,(0.8*(_id+_cl))])cylinder(r = _od/2, h = 0.25, $fn=100);
    }
}
module end_nut_stand_off_hex(_od=2, _id = 2,_len = 8,_cl = 0.3)
{
    union() {
	difference() {
	    cylinder(r = _od/2, h = _len, $fn=6);
	    translate([0,0,-1])cylinder(r = (_id + _cl)/2, h = _len+2, $fn=100);
	    translate([0,0,0])flat_nut(_id+_cl,apply_chamfer=false);
	    translate([0,0,_len-(0.8*(_id+_cl))+.01])flat_nut(_id+_cl,apply_chamfer=false);
	}
	translate([0,0,(0.8*(_id+_cl))])cylinder(r = _od/2, h = 0.25, $fn=6);
    }
}
module stand_off(_od=2, _id = 2,_len = 8,_cl = 0.3)
{
    difference() {
	cylinder(r = _od/2, h = _len, $fn=100);
	translate([0,0,-1])cylinder(r = (_id + _cl)/2, h = _len+2, $fn=100);
    }
}

module stand_off_hex(_od=2, _id = 2,_len = 8,_cl = 0.3)
{
    difference() {
	cylinder(r = _od/2, h = _len, $fn=6);
	translate([0,0,-1])cylinder(r = (_id + _cl)/2, h = _len+2, $fn=100);

    }
}

module split_base_stand_off(_od=12, _id = 2,_len = 8,_cl = 0.3,_thk_base=3,_thk_pcb=1.5)
{
    //tunables
    _top_len = 3;
    _sup_d = 2;
    _sup_ang = 30;
    //extra calcs
    _split_w=_id/3;
    _ol_len = _len+_thk_pcb+_top_len+(2*_cl);
    _sup_len = ((_sup_d/2)/tan(_sup_ang));
    _pil_d = (_id-_cl)/2;
    echo(_sup_len);
    difference() {
	union() {
	    cylinder(r = _od/2, h = _thk_base, $fn=100);
	    cylinder(r = _pil_d, h = _ol_len, $fn=100);
	    translate([0,0,_len-_sup_len])cylinder(r1 = _pil_d, r2 = (_id+_sup_d)/2, h = _sup_len, $fn=100);
	    translate([0,0,_len+_thk_pcb+(_cl)])cylinder(r1 = _pil_d, r2 = (_id+(1.1*_cl))/2, h = _cl, $fn=100);
	    translate([0,0,_len+_thk_pcb+(2*_cl)])cylinder(r1 = (_id+(1.1*_cl))/2, r2 = _pil_d, h = _top_len, $fn=100);
	}
	
	translate([-(_id+_sup_d)/2,-_split_w/2,_len-_sup_len+_split_w])
	cube([_id+_sup_d,_split_w,_sup_len+_thk_pcb+_top_len+_cl]);
	translate([-(_id+_sup_d)/2,0,_len-_sup_len+_split_w])
	rotate([0,90,0])
	cylinder(r=_split_w/2, h=_id+_sup_d, $fn=100);		
    }
}
