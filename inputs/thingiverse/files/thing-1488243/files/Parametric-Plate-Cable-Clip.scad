//////////////////////////////////////////////
// Parametric Cable Clip for holed plates by Christoph Queck, chris@q3d.de, wwww.q3d.de
// April 2016
// Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
// http://creativecommons.org/licenses/by-sa/4.0/
/////////////////////////////////////////////

//Hole Distance in mm (I recommend skipping one hole)
Hole_Distance=16;

abstand = Hole_Distance;

//Hole Diameter in mm
Hole_Diameter=5;

loch=Hole_Diameter;

//Plate Thickness in mm
Thickness=2.2;

dicke=Thickness;

//Height in mm
Height=10;

hoehe=Height;

//Multiplier for fitting the Plugs
Fitting_multiplier=1;//[0:0.1:2]

fitting=(Fitting_multiplier/8)+0.9;
//Amount of clips
Amount=1;//[1, 4, 9]

///////////////////not yet implemented, stiffness multiplier
//Stiffness=1;

//stif=Stiffness;

if (Amount==1){
    clip();
    }
    
if (Amount==4){
    translate([(-abstand-loch*1.5-4)/2,(loch/1.5+2),0])clip();
    translate([-(-abstand-loch*1.5-4)/2,(loch/1.5+2),0])clip();
    translate([(-abstand-loch*1.5-4)/2,-(loch/1.5+2),0])clip();
    translate([-(-abstand-loch*1.5-4)/2,-(loch/1.5+2),0])clip();
    }

if (Amount==9){
    translate([0,(loch*1.2+4),0])clip();
    translate([0,0,0])clip();
    translate([0,-(loch*1.2+4),0])clip();
    
    translate([(-abstand-loch*1.5-4),(loch*1.2+4),0])clip();
    translate([(-abstand-loch*1.5-4),0,0])clip();
    translate([(-abstand-loch*1.5-4),-(loch*1.2+4),0])clip();
    
       translate([-(-abstand-loch*1.5-4),(loch*1.2+4),0])clip();
    translate([-(-abstand-loch*1.5-4),0,0])clip();
    translate([-(-abstand-loch*1.5-4),-(loch*1.2+4),0])clip();
    }


module clip(){
union(){
	difference(){
		union(){
			//body
			translate([0,0,hoehe/2])cube([abstand+2,loch*6/5,hoehe],center=true); 
			//stiftedurch
			translate([-abstand/2,0,hoehe])cylinder(r=loch/2*0.95,h=dicke*2,center=true,$fn=32);
			translate([abstand/2,0,hoehe])cylinder(r=loch/2*0.95,h=dicke*2,center=true,$fn=32);
			//stuetze
			translate([-abstand/2,0,hoehe/2])cylinder(r=(loch/2+loch/3.7),h=hoehe,center=true,$fn=32);
			translate([abstand/2,0,hoehe/2])cylinder(r=(loch/2+loch/3.7),h=hoehe,center=true,$fn=32);
			//schraegeunten
			translate([-abstand/2,0,hoehe+dicke*0.5])cylinder(r1=loch/2-loch/5,r2=loch/5*3*fitting,h=dicke,center=true,$fn=32);
			translate([abstand/2,0,hoehe+dicke*0.5])cylinder(r1=loch/2-loch/5,r2=loch/5*3*fitting,h=dicke,center=true,$fn=32);
			//schraegeoben
			translate([-abstand/2,0,hoehe+(dicke+1)])cylinder(r1=loch/5*3*fitting,r2=loch/2-loch/5,h=2,center=true,$fn=32);
			translate([abstand/2,0,hoehe+(dicke+1)])cylinder(r1=loch/5*3*fitting,r2=loch/2-loch/5,h=2,center=true,$fn=32);

		}
		union(){
			//kabelausschnitt
			difference(){
				translate([0,0,hoehe])scale([1,1,hoehe/10+(1-abstand/33)])rotate([90,0,0])cylinder(r=abstand/3.3333333,h=loch*2,$fn=64,center=true);
				translate([-abstand/2,0,hoehe/2])cylinder(r=loch/2,h=hoehe+1,center=true,$fn=32);
				translate([abstand/2,0,hoehe/2])cylinder(r=loch/2,h=hoehe+1,center=true,$fn=32);
				translate([-abstand/2,-loch/2,hoehe+0.1])cube([abstand,loch,hoehe]);
			}
			//clip ausschnitt
			translate([-abstand/2,0,hoehe+dicke*5])cube([loch/3.7,loch*2,dicke*10],center=true);
			translate([abstand/2,0,hoehe+dicke*5])cube([loch/3.7,loch*2,dicke*10],center=true);
			//clip verlaengerung
			union(){
				intersection(){
					union(){
						translate([-abstand/2,0,hoehe-loch*1])cube([loch/3.7,loch*2,loch*10],center=true);
						translate([abstand/2,0,hoehe-loch*1])cube([loch/3.7,loch*2,loch*10],center=true);
					}
					union(){              
						translate([-abstand/2,0,hoehe-loch/2])cylinder(r=loch/5*3,h=loch,center=true,$fn=32);
						translate([abstand/2,0,hoehe-loch/2])cylinder(r=loch/5*3,h=loch,center=true,$fn=32);
					}
				}
				difference(){
					union(){
						translate([-abstand/2,0,hoehe-loch/2])cylinder(r=loch/5*3,h=loch,center=true,$fn=32);
						translate([abstand/2,0,hoehe-loch/2])cylinder(r=loch/5*3,h=loch,center=true,$fn=32);
					}
					union(){
						translate([-abstand/2,0,hoehe-loch/2])cylinder(r=loch/2,h=loch,center=true,$fn=32);
						translate([abstand/2,0,hoehe-loch/2])cylinder(r=loch/2,h=loch,center=true,$fn=32);

					}
				}
			}          
		}
	}
	//brueckeunten
	translate([0,0,1])cube([abstand+2,loch*6/5,2],center=true);
}
}