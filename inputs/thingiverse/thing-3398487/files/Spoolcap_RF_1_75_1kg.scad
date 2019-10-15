/***********************************************************
* Spoolcap_RF_1_75_1kg.scad
*
* Spoolcap for Renforce Spool 1.75mm 1kg, to reduce the hole for the Spoolholder from Anycubic delivered with I3 Mega
*
* (C) 2019, https://www.thingiverse.com/d3d3d3/about
*
*************************************************************/

// In use of the library below, found at https://www.thingiverse.com/thing:3392835

/***********************************************************
* baConEl.scad
* Library of basic construction elements
* (C) 2019, Hermann Gebhard
*
*************************************************************/

use <baConEl.scad>

module extract_eckig(){
    circleof(r=38/sqrt(2), num=12, startAngle=45) cube(5);
    circleof(r=36/sqrt(2), num=12, startAngle=45) cube(5);
    circleof(r=34/sqrt(2), num=12, startAngle=45) cube(5);
    circleof(r=32/sqrt(2), num=12, startAngle=45) cube(5);
    circleof(r=30/sqrt(2), num=12, startAngle=45) cube(5);
    circleof(r=28/sqrt(2), num=6, startAngle=45) cube(5);
    circleof(r=26/sqrt(2), num=6, startAngle=45) cube(5);
    circleof(r=24/sqrt(2), num=6, startAngle=45) cube(5);
    circleof(r=22/sqrt(2), num=6, startAngle=45) cube(5);
    circleof(r=20/sqrt(2), num=6, startAngle=45) cube(5);
}

module extract_rund(){
    circleof(r=35/sqrt(2), num=5, startAngle=45) cylinder(d=15, h=5);
}

module tubes(){
    // Innen
    tube(di=18.5,do=20.5,length=16);
    // Aussen
    tube(di=46.5,do=50.5,length=16);
    // Grundplatte
    tube(di=18.5,do=80,length=5);
}

module klammer(){
    translate([0,0,14]) circleof(r=35/sqrt(2), num=6, startAngle=45) cylinder(d=2, h=2);//cube(1);
//translate([0,0,14]) circleof(r=35/sqrt(2), num=6, startAngle=45) cube(1);
//translate([0,0,15]) circleof(r=35/sqrt(2), num=6, startAngle=45) cube(1);
}

difference(){
    tubes();
    extract_rund();
}
klammer();