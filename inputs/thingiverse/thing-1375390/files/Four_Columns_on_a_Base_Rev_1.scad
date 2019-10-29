//Circuit Board Holder

// Gather Parameters
/* [Base Dimensions]*/
// Base Width (All dimensions in mm)
BaseSideToSide = 120;
// Base Depth
BaseFrontToBack=80;
// Base thickness
BaseThickness = 4;
// Side to side distance between post centers
/* [Post Locations] */
// Side to Side distance between post centers
PostSideToSide = 58;
// Front to back distance between post centers
PostFrontToBack = 50;
// Distance from left edge to left post centers
PostFromLeft = 15;
// Distance from front edge to front post centers
PostFromFront = 17;
/* [Post and Hole Sizes] */
// Post Diameter
PostDia = 5;
// Post Height above Base
PostHeight=8;
// PostScrew Hole Diameter
PostHoleDia = 2.5;
//Mounting hole diameter (use 0 for no mounting holes)
MountHoleDia = 4;
//Mounting hole inset from base edges.
MountHoleInset = 5;


/* [Hidden] */
$fn=50;

// Modules

module post(Phgt, Pdia, Xloc, Yloc) {
    
    translate([Xloc, Yloc, 0]) {
    cylinder(h=Phgt, d=Pdia);
        }
    }

// Calculate Dimensions
TotalPostHeight = PostHeight + BaseThickness;



    
/* First join the base and posts, then join the post holes, then join the base indents, then join the mounting holes, then subtract the groups of joined holes and indents from the first joined group of base plus posts. */
   

difference() { 
 // join the base and posts 
union() {
cube([BaseSideToSide, BaseFrontToBack, BaseThickness]);    
post(TotalPostHeight, PostDia, PostFromLeft, PostFromFront);
post(TotalPostHeight, PostDia, PostFromLeft + PostSideToSide, PostFromFront);
post(TotalPostHeight, PostDia, PostFromLeft, PostFromFront + PostFrontToBack);
post(TotalPostHeight, PostDia, PostFromLeft + PostSideToSide, PostFromFront + PostFrontToBack);
}
 // join the post screw holes to be subtracted
union() {
post(1.1*TotalPostHeight, PostHoleDia, PostFromLeft, PostFromFront);
post(1.1*TotalPostHeight, PostHoleDia, PostFromLeft + PostSideToSide, PostFromFront);
post(1.1*TotalPostHeight, PostHoleDia, PostFromLeft, PostFromFront + PostFrontToBack);
post(1.1*TotalPostHeight, PostHoleDia, PostFromLeft + PostSideToSide, PostFromFront + PostFrontToBack);
}
// join the post screw indents on bottom face
union() {
post(PostHoleDia,2 * PostHoleDia, PostFromLeft, PostFromFront);
post(PostHoleDia,2 * PostHoleDia, PostFromLeft + PostSideToSide, PostFromFront);
post(PostHoleDia,2 * PostHoleDia, PostFromLeft, PostFromFront + PostFrontToBack);
post(PostHoleDia,2 * PostHoleDia, PostFromLeft + PostSideToSide, PostFromFront + PostFrontToBack);
}

 // join the base mounting holes
 union() {
  post(1.1*BaseThickness, MountHoleDia,  BaseSideToSide/2, MountHoleInset); 
  post(1.1*BaseThickness, MountHoleDia,  BaseSideToSide/2, BaseFrontToBack - MountHoleInset);
   post(1.1*BaseThickness, MountHoleDia,  MountHoleInset, BaseFrontToBack/2); 
  post(1.1*BaseThickness, MountHoleDia,  BaseSideToSide - MountHoleInset, BaseFrontToBack/2); 
}
}

 


    