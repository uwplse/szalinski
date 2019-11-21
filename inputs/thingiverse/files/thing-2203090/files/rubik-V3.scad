
//the actual length of one side of each small cube
cle=19.7;
//the gap between spinning parts
gap=0.3;
//the sphere that everything rotates around
sph=23;
// the radius of curvature for the edges of some of the cubes
rad=2.5;

//[hidden]
//the space reserved for each cube
csp=cle+gap;

//stuff for the beams
b_beamR=cle/4;  //beam is half the size of a cube, and radius is half the diameter
b_spinR=1.5*b_beamR; //half of what is left
b_beamL=cle*3+gap*2-2*cle/4; // full length of the cube less half of an endcap


module endCapRotation(radius,height)
{
    hh=height/2;
    rotate_extrude()polygon(points=[[0,hh],[radius-hh,hh],[radius,0],[radius-hh,-hh],[0,-hh]]);
}

module centerBeams()
{
    
	union()
    {
        // these are the long axles    
        rotate(90, [0, 1, 0])cylinder(h = b_beamL, r=b_beamR, center = true);
        rotate(90, [1, 0, 0])cylinder(h = b_beamL, r=b_beamR, center = true);
        rotate(90, [0, 0, 1])cylinder(h = b_beamL, r=b_beamR, center = true);

        // these are the cylinders that the end caps spin around
        translate([ 0, 0, b_beamL/2 ])                       endCapRotation(b_spinR,b_beamR);
        translate([ 0, 0, -b_beamL/2 ])                      endCapRotation(b_spinR,b_beamR);
        translate([ 0,b_beamL/2, 0])   rotate(90, [1, 0, 0]) endCapRotation(b_spinR,b_beamR);
        translate([ 0, -b_beamL/2, 0]) rotate(90, [1, 0, 0]) endCapRotation(b_spinR,b_beamR);
        translate([ b_beamL/2, 0, 0 ]) rotate(90, [0, 1, 0]) endCapRotation(b_spinR,b_beamR);
        translate([ -b_beamL/2, 0, 0 ])rotate(90, [0, 1, 0]) endCapRotation(b_spinR,b_beamR);
        // some support posts for #2 endcap above these will have to be broken off
        translate([0.5,3,-1.5*cle-gap])cube([2,1,4]);
        translate([1.0,1,-1.5*cle-gap])cube([1,5,0.6]);
        translate([0.5,-4,-1.5*cle-gap])cube([2,1,4]);
        translate([1.0,-6,-1.5*cle-gap])cube([1,5,0.6]);
	}

}

module caps()
{
    difference() 
    {
        translate([ 0, 0, cle+gap+cle/4 ]) cube([cle, cle, cle/2], center = true);
        // the space for the centerBeam to spin in
        translate([ 0, 0, cle+gap+cle/4 ]) endCapRotation(b_spinR+gap,b_beamR+2*gap);
        translate([ 0, 0, cle+gap+cle/4-b_beamR/2 ]) cylinder(h = b_beamR, r =b_beamR+gap, center = true);
        sphere(r=sph+gap, center = true);
	}
}

module edges()
{
    _lrg=sph*2;
	union()
    {
		difference()
        {
            // this is the rotational sphere
			sphere(r=sph, center = true, $fn=30);
			//less the parts that are on other small cubes
            translate([-_lrg/2+cle/4+gap, 0, 0]) cube([_lrg,_lrg,_lrg], center = true);	
			translate([0,-_lrg/2+cle/4+gap , 0]) cube([_lrg,_lrg,_lrg], center = true);
			translate([0, 0, _lrg/2+cle/4-gap]) cube([_lrg,_lrg,_lrg], center = true);
			translate([0, 0, -_lrg/2-cle/4+gap]) cube([_lrg,_lrg,_lrg], center = true);
            //some sloped edges in hope of making it not catch so much while you are turning it
            //translate([cle/2-2.2,cle, -cle/4])rotate([45,0,-20])cube([cle/4+.5,cle/8,1.5],center=true);
            //translate([cle/2-2.2,cle, cle/4])rotate([-45,0,-20])cube([cle/4+.5,cle/8,1.5],center=true);
            //translate([cle,cle/3+1.1, -cle/4+.4])rotate([45,0,-70])cube([cle/4+.5,cle/8,1.5],center=true);
            //translate([cle,cle/3+1.1, cle/4-.4])rotate([-45,0,-70])cube([cle/4+.5,cle/8,1.5],center=true);
            translate([0,cle/2+4,0.7])rotate([0,45,0])cube([cle,cle,1.5],center=true);
            translate([0,cle/2+4,-0.7])rotate([0,-45,0])cube([cle,cle,1.5],center=true);
            translate([cle/2+4,cle/4,cle/4-.4])rotate([45,0,0])cube([cle,cle/2,1.5],center=true);
            translate([cle/2+4,cle/4,-cle/4+.4])rotate([-45,0,0])cube([cle,cle/2,1.5],center=true);
		}
		difference()
        {
            translate([ cle+gap,cle+gap, 0 ]) cube([cle,cle,cle], center = true);
            sphere(r=sph+gap, center = true);
		}
        // this is the actual cube
        translate([cle/2+gap, cle/2+gap, -cle/4+gap]) cube([cle-gap, cle-gap, 2*(cle/4-gap)]);
	}
}

module edge_strength()
{
    translate([cle/2, cle/2-gap, -cle/4+gap]) cube([cle/2*.9, cle/2*.9, cle/2-2*gap]);
}
module corners()
{
    _lrg=sph*2;
	union(){
		difference()
        {
			sphere(r=sph, center = true, $fn=30);
			translate([-_lrg/2+cle/4, 0, 0]) cube([_lrg,_lrg,_lrg], center = true);	
			translate([0, -_lrg/2+cle/4, 0]) cube([_lrg,_lrg,_lrg], center = true);
			translate([0, 0, -_lrg/2+cle/4]) cube([_lrg,_lrg,_lrg], center = true);
            //some sloped edges to make it turn better
            translate([5,cle/2+4,5.7])rotate([0,45,0])cube([cle,cle,1.5],center=true);
            translate([12,cle/2,.7])rotate([-45,0,0])cube([cle,cle,1.5],center=true);
            translate([1,cle/2,12])rotate([-45,90,0])cube([cle,cle,1.5],center=true);
		}
		// this is the actual cube
        translate([ cle+gap, cle+gap, cle+gap ]) cube([cle,cle,cle], center = true);
	}

}
module corner_strength()
{
    translate([ cle-cle/3, cle-cle/3, cle-cle/3 ]) cube([cle/3,cle/3,cle/3], center = true);
}

//this is what to remove from the cube to make a G
module letterG()
{
	rotate([90,0,0]){
	  union(){
		translate([2.1, 2.1, 20]) cylinder(r=1.25, h=21, center = true, $fn = 15);
		translate([-2.1, 2.1, 20]) cylinder(r=1.25, h=21, center = true, $fn = 15);
		translate([-2.1, -2.1, 20]) cylinder(r=1.25, h=21, center = true, $fn = 15);
		translate([0, 1.05, 20]) cube([6.7,2.1,21], center = true);
		translate([0, 2.1, 20]) cube([4.2,2.5,21], center = true);
		translate([-1.05, 0, 20]) cube([2.1,6.7,21], center = true);
		translate([-2.1, 0, 20]) cube([2.5,4.2,21], center = true);
        // make a little support for the overhang
		translate([2.5, 0.325, 20 ]) cube([6, 0.75 ,21], center = true);
        translate([8.5, 0.325, 20 ]) cube([4, 0.75 ,21], center = true);
        translate([5, 0.325, 10.5 ]) cube([11, 0.75 ,2], center = true);
        translate([5, 0.325, cle+10.5 ]) cube([11, 0.75 ,2], center = true);
	  }	
		
	  difference(){
		translate([8.7, 8.7, 20]) cube([rad,rad,21], center = true);
		translate([7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
	  }
		
	  difference(){
		translate([-8.7, 8.7, 20]) cube([rad,rad,21], center = true);
		translate([-7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
	  }

	  difference(){
		translate([-8.7,-8.7, 20]) cube([rad,rad,21], center = true);
		translate([-7.35,-7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);		
      }
    }
}

//this is what to remove from the cube to make a E
module letterE()
{
	translate([cle/4+.01,4,-20])  cube([cle/2,3.4,cle+0.02], center=true);
	translate([cle/4+.01,-4,-20])  cube([cle/2,3.4,cle+0.02], center=true);	
}

//this is what to remove from the cube to make a B
module letterB()
{
	rotate([0,90,0]){
		difference(){
		translate([-8.7, -8.7, 20]) cube([rad,rad,21], center = true);
		translate([-7.35, -7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
		}
		
		difference(){
		translate([-8.7, 8.7, 20]) cube([rad,rad,21], center = true);
		translate([-7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
		}
		
		difference(){
		translate([-8.7, 0 , 20]) cube([rad,5,21], center = true);
		translate([-7.35, -rad, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
		translate([-7.35, rad, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
		}

		translate([-rad,4,20])   cylinder(r=1.67,h=21, center=true, $fn=15);
		translate([-rad,-4,20])  cylinder(r=1.67, h = 21, center=true, $fn = 15);	
		translate([0,4,20])   cube([5,3.4,21], center = true);
		translate([0,-4,20])  cube([5,3.4,21], center = true);	
	}	
}


hideAxels=0;
hideX=0; // which layer to hide in the X direction. should be 0 for normal print
hideY=0;
hideZ=0;

if(hideAxels!=1)
centerBeams();


// Center caps
if(hideX!=2 && hideY!=2 && hideZ!=3)
difference(){
    rotate(180, [0, 1, 0]) caps();
    letterE();
}
if(hideX!=2 && hideY!=2 && hideZ!=1)
difference(){
    rotate(90, [0, 0, 1]) caps();     
    translate([0,0,40]) letterE();
    // now part of the B so the cap looks the same as those around it
    translate([-cle,0,cle+gap])rotate([0,90,0])
    {
        difference(){
            translate([-8.7, 0 , 20]) cube([rad,5,21], center = true);
            translate([-7.35, -rad, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
            translate([-7.35, rad, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
        }
        difference(){
            translate([-8.7, -8.7, 20]) cube([rad,rad,21], center = true);
            translate([-7.35, -7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
		}
		
		difference(){
            translate([-8.7, 8.7, 20]) cube([rad,rad,21], center = true);
            translate([-7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
		}
    }
}
if(hideX!=2 && hideY!=3 && hideZ!=2)
difference(){
    rotate(90, [1, 0, 0]) caps();  
    letterG();
    translate([-cle,-cle-gap,0])rotate([180,-90,0])
    {
        difference(){
            translate([8.7, 8.7, 20]) cube([rad,rad,21], center = true);
            translate([7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
        }
    }
}
if(hideX!=2 && hideY!=1 && hideZ!=2)
difference(){
    rotate(90, [-1, 0, 0]) caps(); 
    translate([0,40,0]) letterG();
    translate([cle,cle+gap,0])rotate([0,-90,0])
    {
        difference(){
            translate([8.7, 8.7, 20]) cube([rad,rad,21], center = true);
            translate([7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
        }
    }
}

if(hideX!=1 && hideY!=2 && hideZ!=2)
difference(){
    rotate(90, [0, 1, 0]) caps();   
    letterB();
    translate([cle+gap,-cle,0])rotate([180,-90,90])
    {
        difference(){
            translate([8.7, 8.7, 20]) cube([rad,rad,21], center = true);
            translate([7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
        }
    }
}
if(hideX!=3 && hideY!=2 && hideZ!=2)
difference(){
    rotate(90, [0, -1, 0]) caps(); 
    translate([-40,0,0])letterB();
    translate([-cle-gap,cle,0])rotate([180,-90,-90])
    {
        difference(){
            translate([8.7, 8.7, 20]) cube([rad,rad,21], center = true);
            translate([7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
        }
    }
    translate([-cle-gap,-cle,0])rotate([180,90,-90])
    {
        difference(){
            translate([8.7, 8.7, 20]) cube([rad,rad,21], center = true);
            translate([7.35, 7.35, 20]) cylinder(r=rad, h=21, center = true, $fn = 15);	
        }
    }
}

// Corners
if(hideX!=1 && hideY!=1 && hideZ!=1)
union(){
    difference(){
        rotate(90, [0, 0, 1]) rotate(90, [1, 0, 0]) corners();   
        translate([20, 40, 20]) letterG();
        translate([20, 20, 40]) letterE();
        translate([0, 20, 20]) letterB();
    } 
    rotate(90, [0, 0, 1]) rotate(90, [1, 0, 0]) corner_strength();
}
if(hideX!=3 && hideY!=1 && hideZ!=1)
union(){
    difference(){
        rotate(180, [0, 0, 1]) rotate(90, [1, 0, 0]) corners();
        translate([-20, 40, 20]) letterG();
        translate([-20, 20, 40]) letterE();
        translate([-40, 20, 20]) letterB();
    } 
    rotate(180, [0, 0, 1]) rotate(90, [1, 0, 0]) corner_strength();
}
if(hideX!=3 && hideY!=3 && hideZ!=1)
union(){
    difference(){
        rotate(270, [0, 0, 1]) rotate(90, [1, 0, 0]) corners();
        translate([-20, 0, 20]) letterG();
        translate([-20, -20, 40]) letterE();
        translate([-40, -20, 20]) letterB();
    } 
    rotate(270, [0, 0, 1]) rotate(90, [1, 0, 0]) corner_strength();
}

if(hideX!=1 && hideY!=3 && hideZ!=1)
union(){
    difference(){
        rotate(360, [0, 0, 1]) rotate(90, [1, 0, 0]) corners();
        translate([20, 0, 20]) letterG();
        translate([20, -20, 40]) letterE();
        translate([0, -20, 20]) letterB();
    } 
    rotate(360, [0, 0, 1]) rotate(90, [1, 0, 0]) corner_strength();
}
if(hideX!=3 && hideY!=1 && hideZ!=3)
union(){
    difference(){
        rotate(90, [0, 0, 1]) rotate(90, [0, 1, 0]) corners();
        translate([-20, 40, -20]) letterG();
        translate([-20, 20, 0]) letterE();
        translate([-40, 20, -20]) letterB();
    } 
    rotate(90, [0, 0, 1]) rotate(90, [0, 1, 0])corner_strength();
}

if(hideX!=3 && hideY!=3 && hideZ!=3)
union(){
    difference(){
        rotate(180, [0, 0, 1]) rotate(90, [0, 1, 0]) corners();
        translate([-20, 0, -20]) letterG();
        translate([-20, -20, 0]) letterE();
        translate([-40, -20, -20]) letterB();
    }
    rotate(180, [0, 0, 1]) rotate(90, [0, 1, 0]) corner_strength();
}

if(hideX!=1 && hideY!=3 && hideZ!=3)
union(){
    difference(){
        rotate(270, [0, 0, 1]) rotate(90, [0, 1, 0]) corners();
        translate([20, 0, -20]) letterG();
        translate([20, -20, 0]) letterE();
        translate([0, -20, -20]) letterB();
    }
    rotate(270, [0, 0, 1]) rotate(90, [0, 1, 0]) corner_strength();
}
if(hideX!=1 && hideY!=1 && hideZ!=3)
union(){
    difference(){
        rotate(360, [0, 0, 1]) rotate(90, [0, 1, 0]) corners();
        translate([20, 40, -20]) letterG();
        translate([20, 20, 0]) letterE();
        translate([0, 20, -20]) letterB();
    }
    rotate(360, [0, 0, 1]) rotate(90, [0, 1, 0]) corner_strength();
}

// Edges
if(hideX!=2 && hideY!=1 && hideZ!=1)
union(){
    difference(){
        rotate(90, [0, 0, 1]) rotate(90, [1, 0, 0]) edges();
        translate([0, 40, 20]) letterG();
        translate([0, 20, 40]) letterE();
        translate([-20, 20, 20]) letterB();
    }
    rotate(90, [0, 0, 1]) rotate(90, [1, 0, 0]) edge_strength();
}
if(hideX!=3 && hideY!=2 && hideZ!=1)
union(){
    difference(){
        rotate(180, [0, 0, 1]) rotate(90, [1, 0, 0]) edges();
        translate([-20, 20, 20]) letterG();
        translate([-20, 0, 40]) letterE();
        translate([-40, 0, 20]) letterB();
    }
    rotate(180, [0, 0, 1]) rotate(90, [1, 0, 0]) edge_strength();
}

if(hideX!=2 && hideY!=3 && hideZ!=1)
union(){
    difference(){
        rotate(270, [0, 0, 1]) rotate(90, [1, 0, 0]) edges();
        translate([0, 0, 20]) letterG();
        translate([0, -20, 40]) letterE();
        translate([-20, -20, 20]) letterB();
    }
    rotate(270, [0, 0, 1]) rotate(90, [1, 0, 0]) edge_strength();
}
if(hideX!=1 && hideY!=2 && hideZ!=1)
union(){
    difference(){
        rotate(360, [0, 0, 1]) rotate(90, [1, 0, 0]) edges();
        translate([20, 20, 20]) letterG();
        translate([20, 0, 40]) letterE();
        translate([0, 0, 20]) letterB();
    }
    rotate(360, [0, 0, 1]) rotate(90, [1, 0, 0]) edge_strength();
}
if(hideX!=3 && hideY!=2 && hideZ!=3)
union(){
    difference(){
        rotate(90, [0, 0, 1]) rotate(90, [0, 1, 0]) edges();
        translate([-20, 20, -20]) letterG();
        translate([-20, 0, 0]) letterE();
        translate([-40, 0, -20]) letterB();
    }
    rotate(90, [0, 0, 1]) rotate(90, [0, 1, 0]) edge_strength();
}
if(hideX!=2 && hideY!=3 && hideZ!=3)
union(){
    difference(){
        rotate(180, [0, 0, 1]) rotate(90, [0, 1, 0]) edges();
        translate([0, 0, -20]) letterG();
        translate([0,-20, 0]) letterE();
        translate([-20, -20, -20]) letterB();
    }
    rotate(180, [0, 0, 1]) rotate(90, [0, 1, 0]) edge_strength();
}

if(hideX!=1 && hideY!=2 && hideZ!=3)
union(){
    difference(){
        rotate(270, [0, 0, 1]) rotate(90, [0, 1, 0]) edges();
        translate([20, 20, -20]) letterG();
        translate([20, 0, 0]) letterE();
        translate([0, 0, -20]) letterB();
    }
    rotate(270, [0, 0, 1]) rotate(90, [0, 1, 0]) edge_strength();
}

if(hideX!=2 && hideY!=1 && hideZ!=3)
union(){
    difference(){
        rotate(360, [0, 0, 1]) rotate(90, [0, 1, 0]) edges();
        translate([0, 40, -20]) letterG();
        translate([0,20, 0]) letterE();
        translate([-20, 20, -20]) letterB();
    }
    rotate(360, [0, 0, 1]) rotate(90, [0, 1, 0]) edge_strength();
}

if(hideX!=3 && hideY!=1 && hideZ!=2)
union(){
    difference(){
        rotate(90, [0, 0, 1]) edges();
        translate([-20, 40, 0]) letterG();
        translate([-20, 20, 20]) letterE();
        translate([-40, 20, 0]) letterB();
    }
    rotate(90, [0, 0, 1]) edge_strength();
}

if(hideX!=3 && hideY!=3 && hideZ!=2)
union(){
    difference(){
        rotate(180, [0, 0, 1]) edges();
        translate([-20, 0, 0]) letterG();
        translate([-20,-20, 20]) letterE();
        translate([-40, -20, 0]) letterB();
    }
    rotate(180, [0, 0, 1]) edge_strength();
}

if(hideX!=1 && hideY!=3 && hideZ!=2)
union(){
    difference(){
        rotate(270, [0, 0, 1]) edges();
        translate([20, 0, 0]) letterG();
        translate([20,-20, 20]) letterE();
        translate([0, -20, 0]) letterB();
    }
    rotate(270, [0, 0, 1]) edge_strength();
}

if(hideX!=1 && hideY!=1 && hideZ!=2)
union(){
    difference(){
        rotate(360, [0, 0, 1]) edges();
        translate([20, 40, 0]) letterG();
        translate([20,20, 20]) letterE();
        translate([0, 20, 0]) letterB();
    }
    rotate(360, [0, 0, 1]) edge_strength();
}

// finally some thin supports to hold up the cube, these will have to break away
translate([0,0,-cle/2-gap+gap*.95/2])difference()
{
    cube([cle*3+2*gap-rad*2,cle*3+2*gap-rad*2,gap*0.95],center=true);
    cube([cle*3+2*gap-rad*2-1,cle*3+2*gap-rad*2-1,gap],center=true);
}
translate([0,0,cle/2+gap/2])difference()
{
    cube([cle*3+2*gap-rad*2,cle*3+2*gap-rad*2,gap*0.95],center=true);
    cube([cle*3+2*gap-rad*2-1,cle*3+2*gap-rad*2-1,gap],center=true);
}
