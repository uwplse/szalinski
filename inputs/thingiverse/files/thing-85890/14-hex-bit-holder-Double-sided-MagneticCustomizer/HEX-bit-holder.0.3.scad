/*
 *      Customazable 1/4" hex bit holder.
 *	
 * Copyright (C) 2013 Mikhail Basov <RepRap[at]Basov[dot]net>
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
 *		2013. License, GPL v2 or later
 */

use <write/Write.scad>

/* Start of customizer header */

/* [Model parameters] */

// (show model to print or assembled model)
Print=0;//[1:Print,0:Show]

// of bits on each side
Number=6;

// on sides or leave blank for no inscription
inscription="1/4' bits";

// (rotate inscription on opposite side)
Back_inscription_rotate=180;//[0:Rotate,180:No_Rotate]

inscription_font="write/orbitron.dxf";//["write/orbitron.dxf":Orbitron,"write/Letters.dxf":Letters,]

Font_size=10;//[8:16]

// preview[view:north west, tilt:top diagonal]

/* [Hidden] */
// End of Customizer header

shift=9.5;
height=10;
pad_height=1;
text_deep=0.6;

module magnet(){cylinder(r=8/2,h=1.02,$fn=120);}
module bit(){rotate([0,0,90])cylinder(r=7.75/2,h=15,$fn=6);}

module r_corner_cut(r=20,h=10){
  difference(){
    translate([-0.1,-0.1,-1])
      cube([r+0.2,r+0.2,h+2]);
    translate([r,r,-2])
      cylinder(r=r,h=h+4,$fn=120);
  }
}

module ISO_bolt_panhead(M=3,h=10){
  had_h=0.6*M;
  had_d=2*M;
  translate([0,0,-had_h])
  union(){
    cylinder(r=M/2,h=h+had_h,$fn=60);
    cylinder(r=had_d/2,h=had_h,$fn=60);
  }
}

module M3_nut(nut_od=6.3,nut_h=2.5){
  cylinder(r=nut_od/2,h=nut_h,$fn=6);
}

module body(h=10){
  difference(){
    translate([-shift*1.1/2,-((Number+1.6)*shift)/2,0])
      cube([shift*1.1,(Number+1.6)*shift,h]);
    translate([-shift*1.1/2,-(Number+1.6)*shift/2,0])
      rotate([0,0,0])
        r_corner_cut(r=3,h=10);
    translate([shift*1.1/2,-(Number+1.6)*shift/2,0])
      rotate([0,0,90])
        r_corner_cut(r=3,h=10);
    translate([shift*1.1/2,(Number+01.6)*shift/2,0])
      rotate([0,0,180])
        r_corner_cut(r=3,h=10);
    translate([-shift*1.1/2,(Number+01.6)*shift/2,0])
      rotate([0,0,-90])
        r_corner_cut(r=3,h=10);
  }
}

module half(){
  difference(){
    body(h=height);
    translate([0,-((Number-1)*shift)/2,0.7])
      for(n=[1:Number]){
        translate([0,(n-1)*shift,0])
          bit();
      }


    #translate([0,(Number+0.7)*shift/2,height-0.6*3+0.01])
      rotate([0,180,0])
        ISO_bolt_panhead();

    #translate([0,-(Number+0.7)*shift/2,0]){
       ISO_bolt_panhead();
       translate([0,0,height-2.5+0.01])
         M3_nut();
    }
  }
}

module pad(){
  difference(){
    body(h=pad_height);

    #translate([0,-((Number-1)*shift)/2,0])
      for(n=[1:Number]){
        translate([0,(n-1)*shift,-0.01])
          #magnet();
      }

    #translate([0,(Number+0.7)*shift/2,height-0.6*3+0.01])
      rotate([0,180,0])
        ISO_bolt_panhead();


    #translate([0,-(Number+0.7)*shift/2,0]){
       ISO_bolt_panhead();
       translate([0,0,height-2.5+0.01])
         M3_nut();
    }

  }
}  

module holder(what=3){
if(what==0 || what==1){ 
  translate([-pad_height/2,0,shift*1.1/2])
    rotate([0,-90,0])
      half();}
if(what==0 || what==2){ 
  translate([pad_height/2,0,shift*1.1/2])
    rotate([0,-90,180])
      half();}
if(what==0 || what==3){ 
  translate([-pad_height/2,0,shift*1.1/2])
    rotate([0,90,0])
      pad();}
}

module holder_inscriptioned(what=0){
  difference(){
    holder(what=what);
    translate([0,0,shift*1.1-text_deep/2+0.01])
      write(inscription,font=inscription_font,center=true,rotate=90,h=Font_size,t=text_deep);
    mirror()
      translate([0,0,text_deep/2-0.01])
        rotate([0,0,Back_inscription_rotate])
          write(inscription,font=inscription_font,center=true,rotate=90,h=Font_size,t=text_deep);
  }
}

module show_or_print(show=true){
  if(show){
    rotate([0,0,0])
      holder_inscriptioned(what=0);
    translate([-20,0,0])
      write("Assembled holder.",h=7,t=0.5,rotate=90,font=inscription_font,center=true);
    translate([-32,0,0])
      write("Don't print it.",h=7,t=0.5,rotate=90,font=inscription_font,center=true);
  } else {
    translate([shift*0.8,0,-pad_height/2])
      rotate([0,90,0])
        holder_inscriptioned(what=1);
    translate([shift*1.1/2,0,-pad_height/2])
      rotate([0,-90,0])
        holder_inscriptioned(what=2);
    translate([-shift*0.8,0,pad_height/2])
      rotate([0,-90,0])
        holder_inscriptioned(what=3);
  }
}

show_or_print(show=!Print);
