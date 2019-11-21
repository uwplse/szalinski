// Evelyn Boettcher 20160227
// Edit to change flower message.  

thk   = 6;
lgth  = 50;
step  = 5;
$fn   = 40;
font  = "Liberation Sans";
style = ":style=Bold";
fntsz = 12;
wf    = 9;

//Main Program
translate([0,0,1.25]) spike();
 flower();
 
// -----------------------------------
//EDIT the Words Here
module N(){ offset(0.2) text("No", size=fntsz, halign="center", valign="center", font = str(font,style));}
module S(){ offset(0.15) text("Spraying", size=fntsz, halign="center", valign="center", font = str(font,style));}
module F(){ offset(0.15) text("Flowers", size=fntsz, halign="center", valign="center",  font = str(font,style));}
module G(){ offset(0.15) text("Growing", size=fntsz, halign="center", valign="center",  font = str(font,style));}

module flower(){   
    difference(){
       union(){ 
        cylinder(r1=lgth/5,r2=lgth/2, h=thk, center=true);   
        translate([lgth/2*sin(0),lgth/2*cos(0),0]) cylinder(r1=lgth/10,r2=lgth/2, h=thk, center=true);
        translate([lgth/2*sin(72),lgth/2*cos(72),0])cylinder(r1=lgth/10,r2=lgth/2, h=thk, center=true);
        translate([lgth/2*sin(72*2),lgth/2*cos(72*2),0])cylinder(r1=lgth/10,r2=lgth/2, h=thk, center=true);
        translate([lgth/2*sin(72*3),lgth/2*cos(72*3),0])cylinder(r1=lgth/10,r2=lgth/2, h=thk, center=true);
        translate([lgth/2*sin(72*4),lgth/2*cos(72*4),0]) cylinder(r1=lgth/10,r2=lgth/2, h=thk, center=true);
       }
     translate([0,lgth/2+wf,thk/2]) linear_extrude(height = 2.5, convexity = 3, center=true) N();
     translate([0,lgth/2-15+wf,thk/2]) linear_extrude(height = 2.5, convexity = 3, center=true) S();
     translate([0,-lgth/2+7.5,thk/2]) linear_extrude(height = 2.5, convexity = 3, center=true)G();
     translate([0,-lgth/2-wf+4.5,thk/2]) linear_extrude(height = 2.5, convexity = 3, center=true)F();
   scale([.5,.5,1]) center(); }
}

module spike(){
    rotate([190,0,180]) union(){
    scale([2,.5,1]) cylinder(h=110,r1=5,r2=1);
    scale([.5,2,1]) cylinder(h=110,r1=5,r2=1);
    }
}
//Flower Center
module center(){
    difference(){
        cylinder(r=lgth/2, h=thk, center=true);
        union(){
          grill();
          rotate([0,0,90])grill();
    }   }}
   
// Grill pattern on the center flower  
module grill(){      
        cube([lgth, step, thk],center=true);
        translate([0,2*step,0]) cube([lgth, step, thk],center=true);
        translate([0,4*step,0])cube([lgth, step, thk],center=true);
        translate([0,-2*step,0])cube([lgth, step, thk],center=true); 
        translate([0,-4*step,0])cube([lgth, step, thk],center=true); 
        }

    
    
//}