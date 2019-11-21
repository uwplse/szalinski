// Parametric filament spool bushing 
// http://www.thingiverse.com/thing:288144
// Design by Kyle Randall "3D-ME"
//1-20-15; fixed bug on Customizer app to let users select the number of bushings made, thanks esquehill for catching that!

// Adjust the following parameters:
spool_hole=32;//set this to equal your spool's hole size
rod_hole=8;//set this to the size of the rod that you are using as an axis for the spool
retainer_height=13;//you can add a number here//height of the inner cylinder
resolution=50;//resolution of the model
lip_height=3;//thickness of the outer lip
bushings=1; //[1,2]
//number of bushings to render (one or two)
// If you wish for any more customizable parameters, ask on the coments here: http://www.thingiverse.com/thing:288144/#comments
////////Don't edit the following unless you know what you're doing/////////
module bushing(){//this is our bushing 
	difference(){
		union(){
			difference(){	
				cylinder(r1=spool_hole/2-0.5,r2=spool_hole/2-1,h=retainer_height,$fn=resolution);
				cylinder(r=spool_hole/2-spool_hole/18-0.5,h=retainer_height,$fn=resolution);}
			cylinder(r=spool_hole/2+spool_hole/5-0.5,h=lip_height,$fn=resolution);
		}
		cylinder(r=rod_hole/2+0.5,h=lip_height+2,$fn=resolution);
	}
}
module two(){//this is a bushing placed to the right of the other one
	translate([spool_hole*1.5,0,0]){
		bushing();
	}
}
bushing();//calling the first bushing 
if (bushings==2) two();//and the second if true
