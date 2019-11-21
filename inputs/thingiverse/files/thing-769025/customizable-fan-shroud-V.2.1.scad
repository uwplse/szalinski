/*customizable_fan_shroud.scad 
Copyright (C) 2015 Andrés Cabrera
Águilas (Spain),(local city info in: http://www.spain.info/en/que-quieres/ciudades-pueblos/otros-destinos/aguilas.html)

ORIGINAL THINGS:
http://www.thingiverse.com/thing:94086
and a lot of more designs this thing you can find on Thingiverse
http://www.thingiverse.com/search/page:3?q=Fan+Shroud&sa=             

This program is free software;  you can redistribute and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;  either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program;  if not, contact Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

This item is designed for a J-head full metal type, as you can see from the following website:(http://es.aliexpress.com/item/All-Metal-short-distance-J-head-hotend-for-3D-Printer-bowden-extruder-RepRap-MakerBot-Kossel-Delta/1849267580.html?recommendVersion=1) and you can customize it for use with 25*25 mm, 30*30 mm or 35*35 mm fan, and different measures of the hot end.
In new version 2.0,  fixes some printing problem, now it´s easy to print and you can use 40x40 mm fans or larger dimensions. it´s very important not use fans that his "y" dimension are longer than total extruder height included the extruder nozzle and heat block heights
In version 2.1,  added wall tube  to fan screw fasten, the thing is more strong*/
//
//                       ***** CUSTOMICE VARIALBES*****
//
//    ***************************BUILDING OPTIONS***************************  
//
top_face="BLIND";/* finish top side: top_face="OPEN" => open top face
                   finish top side: top_face="BLIND" => blind top face  */
nuts="NO";     /* fan, fastening with screws and nuts:  nuts="YES"
                   fan, fastening only with screws:  nuts="NO" */
ffsl=16;         // fastening fan screws length(you need use, almoust screw with length >= 1.5*"zv" fan housing, length "z" (thinckness mm)  
//
//    *********************************DIMENSION******************************** 
                  
                                    //FAN MEASURES//
//
xv=30.00;      // fan housing, length "x" ( whidit)  
yv=30.00;      // fan housing, length "y" ( heightmm) 
zv=10.10;      // fan housing, length "z" (thinckness mm) 
dto_1=3;    // Diameter of the screws   ( M2.5 = 2.50;  M3 = 3.00)
dtu_1=6.10;    // Maximum diameter locknut ( M2.5 = 5.45;  M3 = 6.10)
ets_1=2.15;    // Thickness locknut        ( M2.5 = 2.00;  M3 = 2.15)
tl=.25;        // Tolerance for screws and nuts (approx. 0.25 ≤ tl ≤ 0.30 )
dav=28.40;     // fan blades, maximum diameter
angt=120;      // Opening angle of the air outlet nozzle (between 100 - 150 degree)
angb=70;       // top clamp, bezel angle (between 40 - 90 degree,)(90 => without bezel)
//
/* Wall thickness of  mounting hole of fan frame  , distance from the inside face to  external  face from frame in direction "x" and "y" of the sides thereof. */  
//
epx=1.35;     // Wall thickness from "x" face
epy=1.35;     // Wall thickness from "y" face
//                              
//                        EXTRUDER MEASURES  (heat shink zone)
//
dbc=24.95;     // Diameter body cooler(heat shink) (Ø fins)
hcr=35.35;     // heat shink body height (fin area to the top slot)
dgce=9.10;     // diameter trhroat of the extruder. Slot located above the uppermost fin
hte=2.30;     // height throat of the extruder (height of the Slot)
grp=hte;      // Desired thickness think wall("hgcr"variable value or highter)
//
//                              //Ends measures //
// 
//                       HIDDEN VARIABLES (DON'T CHANGE IT)
//
hgcr=hte-tl;                 // height throat of the extruder less tolerance
dtor=dto_1+tl;               // Diameter of screws  plus tolerance
dtu=dtu_1+tl;                // Maximum diameter of the nut plus tolerance
ets=ets_1+tl;                // Thickness locknut plus tolerance
rtor=dtor/2;                 // Radius of the fan fastening screws
sprv=ffsl-(zv+1.5*grp+ets);  // Separation between the heat sink and fan(mm)
dcr=dbc+2*tl;                // Diameter of the heat sink (Ø fins) plus tolerance
rcr=dcr/2;                   // Radius of the heat sink
rgcr=dgce/2;                 // Radius of the trhroat of the extruder
rtu=dtu/2;                   // Radius of the locknut
ventilador=[xv,yv,grp];      // Fan body(frame)
//pi=3.14159265358979323846; // Pi number
Atp=hcr+hgcr;                // Thing, total height
Dtp=dcr+2*grp;               // Total thickenss (Diameter) of the holder body  
Rtp=Dtp/2;                   // Total radius of the holder body
ejez=Rtp+sprv-grp;           // "z" coordinate,  of the thing axis 
//

//
       /* Distances from the center of the fastening screw hole to the outside faces "x" and "y" of the fan */
 //            
deax=rtor+epx;          // "x" distance 
deay=rtor+epy;          // "y" distance 
//

pcv=(Atp-hgcr)-(hcr/2-yv/2);    // "z" coordinate  fan center
rt=rcr-((rcr-(rgcr+hgcr))/2);   // Radius of the nozzle
rtp=hgcr/2;                     // Radius of the small nozzle ends
rtt=rcr-rt;                     // Radius of the big nozzle ends
rttext=Rtp-grp/2;               // Radius of the big external ends
rltt=rgcr+hgcr/2;               // Position radius of the small nozzle ends
ang=angt/2;                     // half angle of nozzle hole
rmin= rgcr;
rmax=rgcr+(rgcr*tan(90-angb));
//
//                  coordinates from screws 

xt=xv/2-deax;                 // x coord. 
yt=yv/2-deay;                 // y coord. 
zt=ffsl-(1.5*grp+ets);        // z coord. 
xcoord=(rcr-(rgcr+hgcr))*cos(45)/2+(rgcr+hgcr)*cos(45);// "x" coordinate of big ends
ycoord=(rcr-(rgcr+hgcr))*sin(45)/2+(rgcr+hgcr)*sin(45);// "y" coordinate of big ends
incr=Atp-(xv+2*grp);
pincr=sqrt(incr*incr);
                           //coordenada terminaciones redondas
        //exteriores
    terexx=(xv/2+grp)+grp;
    terexy=cos(90-ang)*(Rtp);
    terexz=(sin(90-ang)+1)*(Rtp);
    //ajuste terminaciones redondas exgteriores
    iexy=cos(90-ang)*(grp/2);
    iexz=sin(90-ang)*(grp/2);
        //intermedias
    terimx=((xv/2+grp)+grp);
    terimy=cos(90-ang)*(rgcr+2*grp);
    terimz=(sin(90-ang)*(rgcr+2*grp))+Rtp;
    //ajuste terminaciones redondas intermedias
    iimy=cos(90-ang)*(grp);
    iimz=sin(90-ang)*(grp);
        //interiores
    terinx=((xv/2+grp)+grp);
    teriny=cos(90-ang)*(rgcr+grp);
    terinz=(sin(90-ang)*(rgcr+grp))+Rtp;
    //ajuste terminaciones redondas interiores
    iiny=cos(90-ang)*(grp/2);
    iinz=sin(90-ang)*(grp/2);
        //terminaciones abrazadera
    radio=rgcr+3*grp/2;
    terabx=(xv/2+grp)+grp;
    teraby=cos(135)*radio;
    terabz=sin(135)*radio;
    //ajuste terminaciones abrazadera
    iaby=cos(135)*(Rtp-(5*grp/2+rgcr))/2;
    iabz=sin(135)*(Rtp-(5*grp/2+rgcr))/2;
        //Definición puntos del bisel
    a=0;
    b=0;
    b1=-0.5;
    c=(cos(angb)+1)*rgcr;
    d=rgcr;
    e=hgcr/3;
    f=hgcr*2/3;
    g=hgcr;
    g1=g+0.5;
    h=a+g;
//                           ** Ends variables **
//
module BASE_BODY(){      // BASE BODY
      difference()
    {
        //Base maciza
         hull()
        {
            translate([-(xv/2+grp),-(yv/2+grp),0])color("Blue")
            cube ([xv+2*grp,yv+2*grp,grp], center=false);
            translate([-(xv/2+grp),0,Rtp]) rotate([0,90,0])
            cylinder(h=Atp,r=Rtp, $fn=90,center=false);
            STW();
            translate([-(xv/2+grp),(yv/2+grp),0])color("red")rotate([180,0,0])
            cube ([xv+2*grp,yv+2*grp,grp+sprv], center=false);
            //incremento base
            translate([(xv/2+grp),(yv/2+grp),0])color("aqua")rotate([180,0,0])
            cube ([incr,yv+2*grp,grp+sprv], center=false);
        }
        union()
        {
                                   //Perforaciones
            //alojamiento del extrusor
            translate([-(xv/2+grp-hgcr),0,Rtp]) rotate([0,90,0])
            cylinder(h=Atp+pincr,r=Rtp-grp, $fn=90,center=false);
            translate([-(xv+hgcr+2*grp)/2,0,Rtp]) rotate([0,90,0])
            cylinder(h=(hgcr+grp),r=rgcr+tl/2, $fn=90,center=false);
            //tornillos de sujeción
            SFH();
            //BISEL
            translate([-(xv/2+grp),0,Rtp]) rotate([0,90,0]) rotate_extrude($fn=90)
            polygon(points=[[a,b1],[c,b1],[c,b],[d,e],[d,f],[c,g],[c,g1],[a,g1]]);
            //conducto ventilador
            translate([0,0,-(sprv+2*grp)]) rotate([0,0,0])color("Blue")
            cylinder(h=sprv+grp*3,r1=dav/2,r2=Rtp-grp, $fn=90,center=false);
            difference()
            {
                hull()
                {
                    translate([0,0,0])color("Blue")
                    cylinder(h=rcr,r1=dav/2,r2=Rtp-grp, $fn=90,center=false);
                    translate([-(xv/2+grp-hgcr),0,Rtp]) rotate([0,90,0])
                    cylinder(h=Atp-hgcr,r=Rtp-grp, $fn=90,center=false);
                }
               STW(); 
            }
        }
    }
}
module NUTS_HOLES(){     // NUTS HOLES 

    union()
    {
        //perforaciones inferiores
        color ("red")translate([xt,yt,grp/2])
        cylinder(h=ets,r=rtu,$fn=6,center=false);
        color ("brown")translate([xt-dtu/2,yt-dtu/2+rtu,grp/2])rotate(0,90,0)
        cube([dtu,2*dtu,ets],center=false); 
        
        color ("red")translate([xt,-yt,grp/2])
        cylinder(h=ets,r=rtu,$fn=6,center=false);
        color ("brown")translate([xt-dtu/2,-yt-dtu/2+rtu,grp/2])rotate([0,0,-90])
        cube([2*dtu,dtu,ets],center=false); 
    
        //perforaciones Superiores
        mirror(0,90,0)
        {
            color ("red")translate([xt,yt,grp/2])rotate(90,0,90)
            cylinder(h=ets,r=rtu,$fn=6,center=false);
            color ("brown")translate([xt,yt+rtu,grp/2])rotate(-90,0,0)
            cube([dtu,2*dtu,ets],center=false);
            color ("red")translate([xt,-yt,grp/2])rotate(90,0,90)
            cylinder(h=ets,r=rtu,$fn=6,center=false);
            color ("brown")translate([xt,-yt+rtu,grp/2])rotate(-90,0,0)
            cube([dtu,2*dtu,ets],center=false);
        }
    }
}

module NOZBDTFB(){       // NOZZLE BODY TOP FACE BLIND
     difference()
    {
        hull()
        {
            translate([-(xv/2+2*grp),0,Rtp])rotate([90-ang,0,0])color("Blue")
            cube ([Atp+2*grp,Rtp+2*grp,grp], center=false);
            mirror([0,90,0])
            {
                translate([-(xv/2+2*grp),0,Rtp])rotate([90-ang,0,0])color("red")
                cube ([Atp+2*grp,Rtp+2*grp,grp], center=false);
            }
            translate([-(xv/2+2*grp),0.5*grp,Rtp+grp])rotate([90,0,0])color("green")
            cube ([Atp+2*grp,Rtp+4*grp,grp], center=false);
        }
        union()
        {
            //terminaciones redondas
            //Verticales exteriores
            translate([-terexx,terexy-iexy,terexz-iexz])rotate([0,90,0])color("red")/////
            cylinder (h=Atp+2*grp,r=grp/2,$fn=90, center=false);
            mirror([0,90,0])
            {
                translate([-terexx,terexy-iexy,terexz-iexz])rotate([0,90,0])color("Blue")
                cylinder (h=Atp+2*grp,r=grp/2,$fn=90, center=false);
            }
            //verticales interiores
            //Verticales exteriores
            translate([-terinx,teriny-iiny,terinz-iinz])rotate([0,90,0])color("pink")
            cylinder (h=Atp+2*grp,r=grp/2,$fn=90, center=false);
            mirror([0,90,0])
            {
                translate([-terinx,teriny-iiny,terinz-iinz])rotate([0,90,0])color("Blue")
                cylinder (h=Atp+2*grp,r=grp/2,$fn=90, center=false);
            }
            
            //horizontales
            translate([-(xv/2+grp),teriny-iiny,terinz-iinz])rotate([90-ang,0,0])
            cube([grp,Rtp-(rgcr+grp),grp/2], center=false); 
            mirror([0,90,0])
            {
                translate([-(xv/2+grp),teriny-iiny,terinz-iinz])rotate([90-ang,0,0])
                cube([grp,Rtp-(rgcr+grp),grp/2], center=false); ;
            }
        }
    }
}
module NOZBDTFO(){       // NOZZLE BODY  TOP FACE OPEN
        //Cilindro de formación de la arandela
        difference()
        {
            translate([-(xv/2+1.5*grp),0,Rtp])rotate([0,90,0])color("aqua")
            cylinder(h=Atp+1*grp,r=Rtp-grp, $fn=90,center=false);
            translate([-terabx-1,0,Rtp])rotate([0,90,0])color("silver")
            cylinder (h=Atp+2.5*grp,r=3*grp/2+rgcr,$fn=90, center=false);
            difference()
            {
                hull()
            {
                mirror([0,0,90])
                {
                    translate([-(xv/2+2*grp),0,-Rtp])rotate([45,0,0])color("Blue")
                    cube ([Atp+2*grp,Rtp+2*grp,grp], center=false);
                    mirror([0,90,0])
                    {
                        translate([-(xv/2+2*grp),0,-Rtp])rotate([45,0,0])color("red")
                        cube ([Atp+2*grp,Rtp+2*grp,grp], center=false);
                    }
                    translate([-(xv/2+2*grp),0.5*grp,-(5*grp)])rotate([90,0,0])color("green")
                    cube ([Atp+2*grp,Rtp+4*grp,grp], center=false);
                }
            }
            union()
            {
                //union de la Abrazadera
                //terminaciones grandes interiores
                translate([-terabx*1.1,+teraby+iaby,Rtp-terabz+iaby])rotate([0,90,0])
                cylinder (h=6*grp,r=(Rtp-(5*grp/2+rgcr))/2,$fn=90, center=false);
                mirror([0,90,0])
                {
                translate([-terabx*1.1,+teraby+iaby,Rtp-terabz+iaby])rotate([0,90,0])
                cylinder (h=6*grp,r=(Rtp-(5*grp/2+rgcr))/2,$fn=90, center=false);
                }
            }
        }
    }

    difference()
    {
        hull()
        {
            translate([-(xv/2+2*grp),0,Rtp])rotate([90-ang,0,0])color("Blue")
            cube ([Atp+2*grp,Rtp+2*grp,grp], center=false);
            mirror([0,90,0])
            {
                translate([-(xv/2+2*grp),0,Rtp])rotate([90-ang,0,0])color("red")
                cube ([Atp+2*grp,Rtp+2*grp,grp], center=false);
            }
            translate([-(xv/2+2*grp),0.5*grp,Rtp+grp])rotate([90,0,0])color("green")
            cube ([Atp+2*grp,Rtp+4*grp,grp], center=false);
        }
        union()
        {
            //Verticales exteriores
            translate([-(xv/2+grp),terexy-iexy,terexz-iexz])rotate([0,90,0])color("pink")
            cylinder (h=Atp+2*grp,r=grp/2,$fn=90, center=false); 
            mirror([0,90,0])
            {
                translate([-(xv/2+grp),terexy-iexy,terexz-iexz])rotate([0,90,0])color("Blue")
                cylinder (h=Atp+2*grp,r=grp/2,$fn=90, center=false);
            }
            //Verticales intermedias
            translate([-(xv/2+grp),terimy-iimy,terimz-iimz])rotate([0,90,0])color("pink")
            cylinder (h=grp,r=grp/2,$fn=90, center=false); 
            mirror([0,90,0])
            {
                translate([-(xv/2+grp),terimy-iimy,terimz-iimz])rotate([0,90,0])color("Blue")
                cylinder (h=grp,r=grp/2,$fn=90, center=false);
            }
            //Verticales interiores
            translate([-(xv/2+grp),teriny-iiny,terinz-iinz])rotate([0,90,0])color("pink")
            cylinder (h=grp,r=grp/2,$fn=90, center=false);
            mirror([0,90,0])
            {
                translate([-(xv/2+grp),teriny-iiny,terinz-iinz])rotate([0,90,0])color("Blue")
                cylinder (h=grp,r=grp/2,$fn=90, center=false);
            }
            //horizontales interiores
            translate([-(xv/2+grp),teriny-iiny,terinz-iinz])rotate([90-ang,0,0])
            cube([grp,grp/2,grp/2], center=false); 
            mirror([0,90,0])
            {
                translate([-(xv/2+grp),teriny-iiny,terinz-iinz])rotate([90-ang,0,0])
                cube([grp,grp/2,grp/2], center=false);
            }
        }
    }
}

module STW()             // SCREWS TUBE WALL    
{            
    color ("magenta") translate([xt,yt,0])
    cylinder(h=rcr+grp, r=rtor+grp,center=false, $fn=90);
    color ("gray") translate([-xt,yt,0])           
    cylinder(h=rcr+grp, r=rtor+grp, center=false, $fn=90); 
    color ("Black") translate([xt,-yt,0]) 
    cylinder(h=rcr+grp, r=rtor+grp, center=false, $fn=90);
    color ("Brown") translate([-xt,-yt,0])
    cylinder(h=rcr+grp, r=rtor+grp, center=false, $fn=90);
}
module STW1(){            // SCREWS TUBE WALL (not used)
    difference()
    {
        union()
        {
            hull()
            {
            color ("magenta") translate([xt,yt,0])
            cylinder(h=rcr+grp, r=rtor+grp,center=false, $fn=90);
            color ("gray") translate([-xt,yt,0])           
            cylinder(h=rcr+grp, r=rtor+grp, center=false, $fn=90); 
            color ("Black") translate([xt,-yt,0]) 
            cylinder(h=rcr+grp, r=rtor+grp, center=false, $fn=90);
            color ("Brown") translate([-xt,-yt,0])
            cylinder(h=rcr+grp, r=rtor+grp, center=false, $fn=90);
            color ("red") translate([-xt,-yt,0])
            cube([2*xt,rtor+grp,2*grp], center=false);
                mirror([0,90,0])
                {
                    color ("green") translate([-xt,-yt,0])
                    cube([2*xt,rtor+grp,2*grp], center=false);
                }
            }
        }
        translate([-(xv/2+grp),0,Rtp]) rotate([0,90,0])
        cylinder(h=Atp,r=Rtp-grp, $fn=90,center=false); 
    }      
 }

module SFH(){            // SCREWS FASTENING HOLES
    color ("magenta") translate([xt,yt,-zt])
    cylinder(h=ffsl, r=rtor,center=false, $fn=90);
    color ("gray") translate([-xt,yt,-zt])           
    cylinder(h=ffsl, r=rtor, center=false, $fn=90); 
    color ("Black") translate([xt,-yt,-zt]) 
    cylinder(h=ffsl, r=rtor, center=false, $fn=90);
    color ("Brown") translate([-xt,-yt,-zt])
    cylinder(h=ffsl, r=rtor, center=false, $fn=90);
 } 
 
     
     
module THING(){          // /FINISHED THING/ //
    if (top_face=="OPEN")
    {
        if (nuts=="YES")
        {
            color("red")rotate([0,270,0])
            difference()
            {
                BASE_BODY();
                NUTS_HOLES();
                NOZBDTFO();
            }
        }
        else if(nuts=="NO")
        {
            color("Blue")rotate([0,270,0])
            difference()
            {
                BASE_BODY();
                NOZBDTFO();
            }
        }
    }
    else if (top_face=="BLIND")
    {
        if (nuts=="YES")
        {
            color("gold")rotate([0,270,0])
            difference()
            {
                BASE_BODY();
                NUTS_HOLES();
                NOZBDTFB();
            }
        }
        else if(nuts=="NO")
        {
            color("green")rotate([0,270,0])
            difference()
            {
                BASE_BODY();
                NOZBDTFB();
            }
        }
    }
}
//
//Building the fan support
//
THING();
//
 
