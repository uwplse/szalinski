// https://www.thingiverse.com/thing:2611177
// Redesign by Josh Miller
// 30-Jan-18

// Adjust the following parameters:
//set this to equal your spool's hole size + 0.5mm for a tight fit
spool_hole=53.1;
//Set tapper so so the spool hole minus taper diameter is about 0.5mm to 1mm smaller than spool
taper_diameter=1.0;
taper_radious=taper_diameter/2;
rod_hole=8;//set this to the size of the rod that you are using as an axis for the spool Note: 1mm added for loose fit
rod_hole_support="yes";//[no,yes]
//height of the inner cylinder
retainer_height=15;
retainer_thickness=2.5;
resolution=100;//resolution of the model
lip_height=2.5;//thickness of the outer lip
// If you wish for any more customizable parameters, ask on the coments here: http://www.thingiverse.com/thing:2611177/#comments
////////Don't edit the following unless you know what you're doing/////////
module bushing(){//this is our bushing 
	difference(){
		union(){
            translate([0,0,lip_height]){//shift retainer up by thickness of lip height
                difference(){
                   cylinder(r1=spool_hole/2,r2=spool_hole/2-taper_radious,h=retainer_height,$fn=resolution);
                    //shift hole to get better preview
                    translate([0,0,-1])
				   cylinder(r=spool_hole/2-taper_radious-retainer_thickness,h=retainer_height+2,$fn=resolution);}}//inner subtraction
			cylinder(r=spool_hole/2+spool_hole/5-0.5,h=lip_height,$fn=resolution);//outer plate
            if (rod_hole_support=="yes") cylinder(r=rod_hole/2+retainer_thickness+0.5,h=lip_height+retainer_height,$fn=resolution*1/2);//
		}
        //shift hole to get better preview
		translate([0,0,-1])
        cylinder(r=rod_hole/2+0.5,h=lip_height+retainer_height+2,$fn=resolution);//spool rod hole
	}
}
bushing();//calling the first bushing 
