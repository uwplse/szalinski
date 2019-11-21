//Remote generation: 0 is for gen2, 1 is for gen3
gen=0; //[0:Generation2, 1:Generation3]

//Put in holes to mount with screws?
holes=1; //[0:no, 1:yes]

//Cut out the bottom to better reach the buttons
cut_bottom=1; //[0:no, 1:yes]

/* [Hidden] */

/*
HueHolder Gen2 and Gen3
Version 6, January 2015
Written by MC Geisler (mcgenki at gmail dot com)

A convenient storage for your remote control.

Have fun!

License: Attribution 4.0 International (CC BY 4.0)

You are free to:
    Share — copy and redistribute the material in any medium or format
    Adapt — remix, transform, and build upon the material
    for any purpose, even commercially.
*/


//to fix the scales so both remotes fit
scaleall=40/39.5;


//for scaling to gen2 remote (from gen3 remote)
//0 entry is radius and height of gen2 remote, 1 entry is for gen3 remote (original holder was for gen3)
rr=[43.5/scaleall,40];
zz=[28,23];

//for scaling to gen2 remote (from gen3 remote) if gen=0
scale_r=rr[gen]/rr[1]*scaleall;
scale_z=zz[gen]/zz[1];

rotate ([270,0,0])
{
  difference()
	{
		//original size gen3 hole: 40mm radius maximal, 23mm height
		//gen2 size: 42mm radius, 26mm height 
		//gen2 hole: 44mm radius, 28mm height

                echo ("Outer radius of remote:", 39.5*scale_r);
		scale([scale_r,scale_r,scale_z])
			rotate_extrude($fn=100) 
				polygon( points=[[0,0],[30.5,0],[34.2,3.5],[37,7],[39.3,11],[41,15],[42.2,20],[42.5,25],
					[41,26],[39.5,26.5],[38,26.5],[36.5,26],
					[35,25],[35,23],[39.5,23],[38,15],[33,8],[28,4],[22,2],[0,2]] );

		//cut off lower part
		translate([-90,0,-1]) 
			cube(size=[160,160,60], center=false);

		if (holes == 1)
                {       
                    //two holes for mounting
                    translate([-15,-10,-.1]) 
			cylinder(h=3.2, r1=2, r2=5);
                    translate([15,-10,-.1]) 
			cylinder(h=3.2, r1=2, r2=5);
                }
                
                if (cut_bottom==1)
                {
                    //cut off diagonally
                    translate([0,-rr[gen]*sqrt(2),rr[gen]+2*scale_z]) 
			rotate([0,0,45])
				cube(size=rr[gen]*2, center=true);
		}
  	}
};