/*
 * Mount plate for NMEA14 version of extruder.
 *      Version 2015-05-11
 *
 * Copyright (C) 2015 Mikhail Basov <RepRap[at]Basov[dot]net>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License,
 * LGPL version 2.1, or (at your option) any later version of the GPL.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 *              2015. License, GPL v2 or later
 */
/* Start of customizer header */

/* [Model parameters] */

Print_dual=1;//[1:true,0:false]

// [mm]
Rods_diameter=6;

// [mm]
Top_rods_distance=39;

// [mm]
Wide=20;

// [mm]
Thicknes=6;

// [mm] (Ususaly, Wide/2+19.5+50+Top_road_distance+Wide)
Length=138.5;

/* [Print parameters] */

// [mm]
Tolerance=0.25;

/* [Hidden] */

r=Rods_diameter; // rod diameter
rd=Top_rods_distance; // top rod distance
w=Wide;  // mount plate wide
l=Length; //mount plate length
t=Thicknes; // mount plate thicknes
tol=Tolerance; //assemble tollerance
M3=3.4;

dual=Print_dual; // false - mount for only one extruder

k8=1+sqrt(2);
ro8=sqrt(k8/(k8-1))/k8;

module ext_edge_cuter(){
    difference(){
        translate([0,-w/2-0.1,0])
            cube([w+0.1,w+0.2,t+0.2]);
        translate([0,0,-0.2])
            rotate([0,0,22.5])
                cylinder(r=w*ro8,h=t+0.6,$fn=8);
    }
}

module int_edge_cuter(){
    rotate([0,0,180])
    difference(){
        translate([rd/2,-w/2-0.1,0])
            cube([w+0.1,w+0.2,t+0.2]);
        translate([0,0,0.1])
            cylinder(r=(rd+r+w)/2,h=t+0.2,$fn=50);
    }
}

module assemble_halfs(){
        translate(t/2)
            cylinder(r=(rd+r+w+tol)/2,h=t/2+0.1,$fn=50);
}

module extruder_mount_cuter(){
    $fn=12;
    cylinder(r=6/2,h=t+0.2);
    for(i=[0,180]){
        rotate([0,0,i]){
            translate([12,0,0])
                cylinder(r=M3/2,h=t+0.2);
            translate([19.5,0,0])
                cylinder(r=M3/2,h=t+0.2);
        }
    }
}

module rods_mount_cuter(atol=0){
    // atol - tolerance
    for(i=[0,180]){
        rotate([0,0,i]){
            translate([rd/2,0,-0.1])
                cylinder(r=(r+atol)/2, h=t+0.2, $fn=50);
            intersection(){
                translate([0,-(w/2+0.2),-0.2])
                    cube([rd/2+r/2+0.2,w/2+0.2,t+0.4]);
                difference(){
                    translate([0,0,-0.2])
                        cylinder(r=rd/2+r/2+atol/2,h=t+0.4,$fn=50);
                    translate([0,0,-0.4])
                        cylinder(r=rd/2-r/2-atol/2,h=t+0.8,$fn=50);
                }
            }
        }
    }
}

difference(){
    // main plate body
    translate([-1*(w+rd/2),-1*w/2,0])
        cube([l,w,t]);
    
    // rods mount holes
    rods_mount_cuter();
    
    // extruder mount holes
    translate([rd/2+50,0,-0.1])
        extruder_mount_cuter();
    
    // external edge cuter
    translate([rd/2+50+19.5,0,-0.1])
        ext_edge_cuter();

    // internal edge cuter
    translate([0,0,-0.1])
        int_edge_cuter();
    
    if(dual){
        translate([0,0,t/2])
            difference(){
                assemble_halfs();
                rotate([180,0,0])
                    translate([0,0,-t])
                        rods_mount_cuter(atol=-1*tol);
            }
        
        // remove sharp edges
        for(i=[0,180]){
            rotate([0,0,i]){
                translate([rd/2-r/2,-r/2-r/6,t/2])
                    cube([r,r,t]);
            }
        }
    }
}
