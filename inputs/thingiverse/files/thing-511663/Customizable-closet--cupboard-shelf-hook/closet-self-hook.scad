/*
Create a closet self hook for 3D printing
By: Dave Borghuis / zeno4ever
Version : 1.0
Date : 22-10-2014
For sugestions email me at : dave@daveborghuis.nl
*/

//Hight of the holes
hookhight = 13;

//Depth of the self support
hookdepth = 12; 

//Distance between holes
hookdistance = 17; 

//width of the whole hook
hookwidth = 13; 

//Depth of the hook
holedepth = 12; 

cutdepth = 2; 
cuthigth = 4;


module hook()
{
	difference() {
		//base blok
		union() {
			cube([holedepth,hookwidth,hookhight]);
			translate([0,0,hookdistance+hookhight]) cube([holedepth,hookwidth,hookhight]);
			translate ([-hookdepth,0,0]) cube([hookdepth,hookwidth,hookdistance+2*hookhight]);
		}
		//make holes
		{
			cube([cutdepth,hookwidth,cuthigth]);
			translate([0,0,hookdistance+hookhight]) cube([cutdepth,hookwidth,cuthigth]);
		}
	}
}

hook();

