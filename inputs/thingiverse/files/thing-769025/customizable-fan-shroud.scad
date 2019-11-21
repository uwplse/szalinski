/*customizable_fan_shroud.scad 
Copyright (C) 2015 Andrés Cabrera
Águilas (Spain),(local city info in: http://www.spain.info/en/que-quieres/ciudades-pueblos/otros-destinos/aguilas.html)

ORIGINAL THINGS:
http://www.thingiverse.com/thing:94086
and a lot of more designs this thing you can find on Thingiverse
http://www.thingiverse.com/search/page:3?q=Fan+Shroud&sa=             

This program is free software;  you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;  either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program;  if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

This thing is designed for a J-head full metal type, as you can see from the following website:(http://es.aliexpress.com/item/All-Metal-short-distance-J-head-hotend-for-3D-Printer-bowden-extruder-RepRap-MakerBot-Kossel-Delta/1849267580.html?recommendVersion=1) and you can customize it for use with 25*25 mm, 30*30 mm or 35*35 mm fan, and different measures of the hot end.
//
//                       ***** CUSTOMICE VARIALBES*****
*/
//    ***************************BUILDING OPTIONS***************************  
//
mt="BLIND"; /* finish top side: mt="OPEN" => open top face
               finish top side: mt="BLIND" => blind top face  */
mtt="NO";   /* fan, fastening with screws and nuts: mtt="YES" => with screws and nuts  
               fan, fastening with screws         : mtt="NO" => without nuts */
sprv=1;     // Desired separation between the heat sink and fan(mm)(To this measure the
            // program will add the thickness of the wall)
grp=2;      // Desired thickness of the wall of the piece ( 1,50-3,00 mm, máx=10 mm)
//
//
//    *********************************DIMENSIONES****************************** 
                  
                                    //FAN MEASURES//
//
xv=30;           // fan housing, length "x" (width mm)
yv=30;           // fan housing, length "y" (height mm)
zv=10;           // fan housing, length "z" (thinckness mm)
dtv1=3;          // Diameter of the screws    (M3=3.00; M4=4.00;  M5=5.00)
dts1=6.1;        // Maximum diameter locknut  (M3=6.10; M4=7.66;  M5=8.79)
ets=2.15;        // Thickness locknut         (M3=2.15; M4=2.90;  M5=3.70)
tl=.25;          // Tolerance for screws and nuts (approx. 0.25 ≤ tl ≤ 0.30 )
dav=28.50;       // Maximum diameter of the fan blades
angulo= 90;      // Opening angle of the air outlet nozzle (between 80 - 110)
angulo_bisel=60; // angle bevel  of the clamp upper (between 40 - 70 )
//
                   /* WALL THICKNESS OF THE FIXING HOLES OF THE FAN,*/  
//
epavx=1.40;     //Thickness from the face "x"
epavy=1.40;     //Thickness from the face "y"
//                              
//EXTRUDER MEASURES  (cooling zone)
//
dcr=25;       //Diameter body cooler(heat shink) (Ø fins)
hcr=35.60;    //heat shink body height (fin area to the top slot)
dgce=11.95;   //diameter trhroat of the extruder. Slot located above the uppermost fin
hgcr=2.40;    //height trhroat of the extruder (height of the Slot)
//
//                              //End of customice variables//
// 
                        //// Calculated variables (don´t change)////
//
rcr=dcr/2;                  //Radius of the heat shink  (fins)
rgcr=dgce/2;                //Radius of the trhroat of the extruder
dtv=dtv1+tl;                //Diameter of screws + tolerance
dts=dts1+tl;                //Maximum diameter of the nut
rtv=dtv/2;                  //Radius of the fan fastening screws
rts=dts/2;                  //Radius of the locknut
stvr=sprv+rcr;              //Total separation between heat shink and fan
ventilador=[xv,yv,grp];     //Fan body(frame)
//pi=3.14159265358979323846;  //Pi number 
Atp=hcr+hgcr;               //Total height of the piece
Gtp=dcr+grp;                //Total thickenss (Diameter) of the holder body  
Rtp=Gtp/2;                  //Total radius of the holder body
//
////////* Distances "x" and "y"  from the center of the hole of the clamping screw  to the external side of the  frame the fan *//////////////////////////////////////////////
 //            
deax=rtv+epavx;              //distance  "x"
deay=rtv+epavy;              //distance  "y"
//

pcv=(Atp-hgcr)-(hcr/2-yv/2);     //"x" and "y" position of the center of the fan
rt=rcr-((rcr-(rgcr+hgcr))/2);    //Radius of the nozzle
rtp=hgcr/2;                      //Radius of the small nozzle ends
rtt=rcr-rt;                      //Radius of the big nozzle ends
rltt=rgcr+hgcr/2;                //Radius of position of the small nozzle ends
ang=angulo/2;                    //opening half angle of the air outlet of the nozzle
angb= angulo_bisel;              //Angle Bezel
rmin= rgcr;
rmax=rgcr+(rgcr*tan(90-angb));
//
//                              
//                               coordinates of the fan screw 
//
xt=rcr-grp/2;                  // coord. x all screws
ytd=xv/2-deax;                 // coord. y right screws
zts=(hcr+(hcr/2-yv/2))-deay;   // coord. z top screws
zti=(hcr/2-yv/2);              // coord. z lower screws 
//

//
//                            ** End of variables **
//   
module cuerpo(){       // BODY PARTS
   difference()
    {
        //Cuerpo
        hull()
        {
            cylinder(h=Atp, r=Rtp, $fn=100, center=false);
            translate ([stvr,-(xv/2),pcv]) rotate (90,[0,1,0] )
            cube(ventilador, center=false);
        }
            union()
        {//Agujero para alojamiento de Extrusor
            color ("red")cylinder(h=hcr+hgcr*4, r=rgcr, $fn=90, center=false);
            //Agujeros de los tornillos del ventilador
            TN();
            //Agujero  tubo ventilador
            translate([0,0,hcr/2]) rotate([0,90,0]) color ("blue") 
            cylinder(h=(2*stvr), r1=(dav/2-grp), r2=dav/2, $fn=90, center=false);
            translate([0,0,-hgcr]) color ("green")
            cylinder(h=Atp, r=rcr, $fn=90, center=false);
            color ("gray")
            {
                hull()
                {
                    translate([rcr+grp+sprv,0,hcr/2]) rotate(90, [0,1,0])
                    cylinder(h=(grp), r1=dav/2-grp, r2=dav/2-grp, $fn=90, center=false);
                    cylinder(h=Atp-hgcr, r=rcr, $fn=100, center=false);
                }
            }
        }
    }
}
  
module T_Cerrada(){    // NOZZLE, TOP FACE BLIND
    color("red"){
        hull()
        {// Cuerpo de la tobera
            rotate([0,0,180-ang])translate([0,0,-Atp/1.5])color("green")
            cube([dcr,1,Atp*2.5], center=false);
            rotate([0,0,180+ang])translate([0,-1,-Atp/1.5])color("silver")
            cube([dcr,1,Atp*2.5], center=false);
        }
    }
}

module T_Abierta(){    // NOZZLE, TOP FACE OPEN        
    difference(){
        translate([0,0,Atp/2]) color("green")
        cylinder(h=Atp*1.5, r=(rcr), $fn=90, center=true);
        difference(){color("red")
            translate([0,-dcr/2,-Atp/2])
            cube([dcr/2,dcr,Atp*2], center=false);
                union(){//interiores//
            }
        }
       translate([0,0,Atp/2]) color("pink")
        cylinder(h=Atp*2, r=rgcr+hgcr, $fn=90, center=true);
    }
     difference(){
        color("red"){
            hull(){// Cuerpo de la tobera
                rotate([0,0,180-ang])translate([0,0,-Atp/1.5])color("green")
                cube([dcr,1,Atp*2.5], center=false);
                rotate([0,0,180+ang])translate([0,-1,-Atp/1.5])color("silver")
                cube([dcr,1,Atp*2.5], center=false);
            }
        }
        //terminaciones pequeñas de la abrazadera
        translate ([-cos(ang)*rltt,sin(ang)*rltt,-Atp/1.4]) color("brown")
        cylinder(h=Atp*2.6,r=rtp, $fn=90, center=false);
        translate ([-cos(ang)*rltt,-sin(ang)*rltt,-Atp/1.4]) color("blue")
        cylinder(h=Atp*2.6,r=rtp, $fn=90, center=false);
    }
    //terminaciones grandes de la abrazadera
    translate([0,rcr-rtt,-Atp/2])color("yellow")//Sup.
    cylinder(h=Atp*2.5,r=rtt, $fn=90, center=false);
    translate([0,-rcr+rtt,-Atp/2])color("black")//inf.
    cylinder(h=Atp*2.5,r=rtt, $fn=90, center=false);
        
   
 }

module BSL(){          // BEZEL CLAMP
    rmin= rgcr;
    rmax=rgcr+(rgcr*tan(90-angb));
    hmax=hgcr*sin(ang);
        difference()
    {
        conos();
        tubo();
    }
}    
module conos(){        // BEZEL TRAINING CONES
    translate([0,0,hcr+hgcr*2/3])
    cylinder(h=hgcr, r1=rmin, r2=rmax, $fn=90, center=false);
    translate([0,0,hcr+hgcr/3])
    mirror([0,0,1])
    {
        cylinder(h=hgcr, r1=rmin, r2=rmax, $fn=90, center=false);
    }
}
module tubo(){         // TUBE FOR BUILD THE BISEL
  difference()
    {
        translate([0,0,hcr])color("red")
        cylinder(h=hcr,r=rmax,center=true,$fn=90);
        cylinder(h=hcr*4,r=rmax-rmax*sin(ang)/3,center=false, $fn=90);
    }
}
module Tn_in(){        // BOTTOM SCREW HOLES
    color ("magenta") translate([rcr/1.5,ytd,zti+deay]) rotate([0,90,0])
    cylinder(h=rcr+sprv+zv, r=rtv, center=false, $fn=90);    
    mirror([00,90,00]){
        color ("magenta") translate([rcr/1.5,ytd,zti+deay]) rotate([0,90,0])
        cylinder(h=rcr+sprv+zv, r=rtv, center=false, $fn=90); 
    }
}
module TN(){           // HOLES ALL SCREWS
    //INFERIORES
    Tn_in();
    //SUPERIORES
    translate([00,00,zts])
    mirror([00,00,90])
    {
        Tn_in();
    }
}
module AT(){           // HOLES FOR HOUSING NUTS
    
    //INFERIORES
    color ("yellow") translate([xt,ytd,zti+deay]) rotate([90,0,90])
    cylinder(h=ets+tl, r=rts, center=false, $fn=6);
    color ("green") translate([xt+(ets+tl)/2,ytd*1.15,(zti+deay)]) rotate([0,00,0])
    cube([ets+tl,3*grp,(rtv/cos(60))*tan(60)],center=true);
    mirror([00,90,00]){
        color ("yellow") translate([xt,ytd,zti+deay]) rotate([90,0,90])
        cylinder(h=ets+tl, r=rts, center=false, $fn=6);   
        color ("green") translate([xt+(ets+tl)/2,ytd*1.15,(zti+deay)]) rotate([0,00,0])
        cube([ets+tl,3*grp,(rtv/cos(60))*tan(60)],center=true);
        
        //SUPERIORES
        translate([00,00,zts])
        mirror([00,00,90]){
            color ("yellow") translate([xt,ytd,zti+deay]) rotate([90,0,90])
            cylinder(h=ets+tl, r=rts, center=false, $fn=6);
            color ("green") translate([xt+(ets+tl)/2,ytd*1.15,(zti+deay)]) rotate([0,00,0])
            cube([ets+tl,3*grp,(rtv/cos(60))*tan(60)],center=true);
            mirror([00,90,00]){
                color ("yellow") translate([xt,ytd,zti+deay]) rotate([90,0,90])
                cylinder(h=ets+tl, r=rts, center=false, $fn=6);   
                color ("green") translate([xt+(ets+tl)/2,ytd*1.15,(zti+deay)]) rotate([0,00,0])
                cube([ets+tl,3*grp,(rtv/cos(60))*tan(60)],center=true);
            }
        }
    }
}
module cdr_compr(){    // TABLE OF CHECKING THE CORRECT POSITION OF MODULES
color("cyan")translate([xt,-xv/2,(hcr/2-yv/2)])rotate([0,00,0])
cube([1,30,30],center=false); 
 }                          
module PIEZA() {     /////////////////////////FINISHED thing//////////////////////////////
    if (mt=="OPEN")
    {
      if (mtt=="YES")
      {
          color("olive")
          difference()
          {
              cuerpo();
              union()
              {
                  T_Abierta();
                  BSL();
                  AT();
              }
          }
      }
      else if(mtt=="NO")
      {
          color("brown")
          difference()
          {
              cuerpo();
              union()
              {
                  T_Abierta();
                  BSL();
              }
          }
      }
  }
  else if (mt=="BLIND")
  {
      if (mtt=="YES")
      {
          color("green")
          difference()
          {
              cuerpo();
              union()
              {
                  T_Cerrada();
                  BSL();
                  AT();
              }
          }
      }
      else if (mtt=="NO")
      {
          color("pink")
          difference()
          {
              cuerpo();union()
              {
                  T_Cerrada();
                  BSL();
              }
          }
      }
  }
}
//
//building the fan support
//
PIEZA();
