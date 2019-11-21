// Dorsal Hand Brace v1 by Gyrobot
// http://www.gyrobot.co.uk
//
// preview[view:south west, tilt:top]

Hand = "Right" ; // [Left,Right]
//Width across knuckles
Hand_Width = 90 ;
//Do you required tensioners?
Tensioners = "Yes" ; // [Yes,No]
Index_Finger = "Yes" ; // [Yes,No]
Middle_Finger = "Yes" ; // [Yes,No]
Ring_Finger = "Yes" ; // [Yes,No]
Little_Finger = "Yes" ; // [Yes,No]
//Width of strap is maximised at "Hand Width" / 4
Strap_Width = 15 ; //
//Do you want the strap any thicker?
Strap_Height = 2 ; // Height of Strap

// Start of Code

hw = Hand_Width ;
fw = (Hand_Width/4) - 2.5;
sw = (Strap_Width > Hand_Width/4) ? Hand_Width/4 : Strap_Width;
sh = Strap_Height ;


//
// Call Strap Module
//
linear_extrude (sh)
{
    strap(hw,sw) ;
    mirror ([1,0,0]) strap(hw,sw) ;
}

//
// Call Finger Modules
//
if (Index_Finger=="Yes")
    {
        fl = sw-4 ;
        fx = fw*1.5;
        finger(fw,fl,fx,sh,sw);
    }
else
    {    
        xmirr = Hand=="Left" ? 1 : -1; 
        linear_extrude(sh)
        translate ([fw*1.5*xmirr,0,0]) square ([fw,sw],center=true);
    }


if (Middle_Finger=="Yes")
    {
        fl = sw-1 ;
        fx = fw*0.5;
        finger(fw,fl,fx,sh,sw);
    }
else
    {
        xmirr = Hand=="Left" ? 1 : -1; 
        linear_extrude(sh)
        translate ([fw*0.5*xmirr,0,0]) square ([fw,sw],center=true);
    }


if (Ring_Finger=="Yes")
    {
        fl = sw-4 ;
        fx = fw*-0.5;
        finger(fw,fl,fx,sh,sw);
    }
else
    {
        xmirr = Hand=="Left" ? 1 : -1;
        linear_extrude(sh)
        translate ([fw*-0.5*xmirr,0,0]) square ([fw,sw],center=true);
    }


if (Little_Finger=="Yes")
    {
        fl = sw-7 ;
        fx = fw*-1.5;
        finger(fw,fl,fx,sh,sw);
    }
else
    {
        xmirr = Hand=="Left" ? 1 : -1;
        linear_extrude(sh)
        translate ([fw*-1.5*xmirr,0,0]) square ([fw,sw],center=true);
    }


// Strap

module strap(hw,sw)
{
    $fn = 64 ;
    difference ()
    {
        translate ([hw/-2,0,0])
        {
            scale ([hw/sw,1,1]) // Elliptical Strap End
            {
                circle (d=sw); 
            }
        }
        square ([hw-10,sw],center=true);
        translate ([hw*-0.6,0,0])
        {
            scale ([40/sw,1,1]) // Elliptical Hole
            {
                circle (d=sw/2);
            }
        }
    }
}

// Finger
module finger(fw,fl,fx,sh,sw)
{
    $fn = 32 ;
    yoff = ((fw+sh*1.5)/2)-(sw/2);
    fxoff = Hand=="Left" ? fx : fx*-1;
    translate ([fxoff,0,0])
    {
        difference()
        {
            union ()
            {
                if (Tensioners=="Yes")
                {
                    linear_extrude (sh+3) //Tensioner Boss
                    circle (d=sw);
                    translate ([0,-sw,0]) //Tensioner Reels
                    {                
                        difference ()
                        {
                            linear_extrude (sh+2) circle (d=sw-5,$fn=6); // Hexagonal Profile
                            rotate_extrude(convexity=10)// Groove
                            translate ([(sw-5)/2,(sh+2)/2,0])
                            circle (d=2);
                            rotate ([90,0,0])
                            {
                                translate ([0,(sh+2)/2,0])
                                cylinder (h=sw-5,d=2,center=true); // Centre Hole
                           }
                        }
                    }
                }
                linear_extrude (sh)
                square ([fw,sw],center=true);
                linear_extrude (sh+2)
                {
                    difference()
                    {
                        hull() // Finger Loop - Outer Profile
                        {
                            translate ([0,yoff,0])circle (d=fw+2.5);
                            translate ([0,fl+yoff,0])circle (d=fw+2.5);
                        }
                        hull() // Finger Loop - Inner Profile
                        {
                            translate ([0,yoff,0])circle (d=fw-2.5);
                            translate ([0,fl+yoff,0])circle (d=fw-2.5);
                        }
                    }               
                }             
            }
            if (Tensioners=="Yes")
            {
                translate ([0,0,1]) linear_extrude (sh*5) circle (d=sw-5,$fn=6); // Tensioner Hexagonal Pocket
                cylinder (d=sw-8,h=sh*10,center=true); // Tensioner Relief Hole
                translate([0,sw/2-2,(sh+2)/2+1]) cube([2,sw,2],center=true); //Tendon Channel - Tensioner
            }
            translate([0,fl+yoff+fw/2,(sh+2)/2]) cube ([2,fl,2],center=true); //Tendon Channel - Finger Loop
        }
    }
}