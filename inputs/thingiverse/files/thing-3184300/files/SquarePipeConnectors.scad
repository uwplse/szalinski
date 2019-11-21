// Square tubing corner connector
// based off design by  David O'Connor  david@lizardstation.com   14 August 2018

// modified to add tapered protrusions, spacers, and a new corner option
// JH Oct 29, 2018

// Copyright Creative Commons Attribution Unported 3.0 (CC-BY-3.0)
//   (https://creativecommons.org/licenses/by/3.0/)

// Connector type
fittingType = 1;// [0:Fit_Check, 1:Plug, 2:L, 3:Union, 4:T, 5:Corner, 6:Sliced Corner, 7:Cross, 8:Mid_Edge, 9:Mid_Face, 10:Interior]
// Center cube dimension (mm)
centerDim = 25;// [6:0.1:40]
// Protrusion center dimension (mm) 
protrusionCenterDim = 22.45; // [6:0.1:30]
// Protrusion end dimension (mm)
protrusionEndDim = 22.2; // ([6:0.1:32] 
// Protrusion length (mm)
protrusionLength = 33;// [6:0.2:60]
// Protrusion Spacer (mm)
protrusionSpacer = 0.0; // [0.0:0.1:20]
// Roundoff radius
roundoffRadius = 1.5;// [0.0:0.5:3.0]
// Add Flat Edge
flatEdge = 0; // [0: No, 1:Yes]
// Flat Edge Depth
edgeDepth = 4; // [0:0:6]

// edgeDepth is not an exact measurement, just a 'more or less" slider and it can vary depening on how much taper used

// The Flat Edge is to help print without using supports, although if the center cube is larger than protrusion or you use a spacer
// then you might need to suppot those little overhangs in the center

bracket(cd=centerDim, pcd=protrusionCenterDim, ped=protrusionEndDim, pl=protrusionLength, ps=protrusionSpacer, r=roundoffRadius, fe=flatEdge, ed=edgeDepth, type=fittingType);

module bracket(cd, pcd, ped,  pl, ps, r, fe, ed, type) {
    fcd = (ps==0 || (pcd+ps>cd)) ? cd : pcd+ps;
    acd = fcd<pcd ? pcd : fcd; // center cube can't be smaller than prutusion, if using spacer then make them the same size for accuracy
    aped = (ped<pcd) ? ped : pcd;  // limit protrusion end so it can't flare larger then rest

    difference()  {
         union() { 
             if (type==0) {
                 test(acd, pcd, aped,  pl, ps, r);
             }
             else {
                fitting(acd, pcd, aped,  pl, ps, r, type);
             }
         };
        if ((fe==1 && type!=0) || type==6) {
            slice(acd, pcd, aped, pl, ps, ed, r, type);
        }
    }
 }
 
 // goes two mm below and above the protrusion end you've set
 module test(cd,pcd,ped,pl,ps,r) {
    cubeHeight = cd * 0.25;
    m = (pl/2 + cubeHeight/2); // this is how much to move the protrusions from center 
    cube([cubeHeight, 5*cd, cd], center=true);
    for (i = [-2:2]) {
        echo(pcd+i,ped+i);
        translate([m, cd*i, 0]) {
            rotate([0, 90, 0]) {
                protrusion(pcd+i, ped + i, pl, ps, r);
            }
        }
    }          
 }
 

 
 module fitting(acd, pcd, ped,  pl, ops, r, type) {
    echo(type);
     // the center cube
    cube([acd, acd, acd], center=true); 
    
    ps = ops - (acd - pcd);
    echo(ps); 
    m = (pl/2 + acd/2 + ps); // this is how much to move the protrusions from center 
    
    // All the parts have at least one protrusion ... this is it
    translate([0, 0, m])
        protrusion(acd, pcd, ped, pl, ps, r);

    // The rest depend on the type selected
    if ((type==3) || (type==4) || (type==7) || (type==8) || (type==9) || (type==10)) 
        translate([0, 0, -m])
            rotate([0, 180, 0])
            protrusion(acd, pcd, ped, pl, ps, r);
    
    if ((type==2) || (type==4) || (type==5) || (type==6) || (type==7) || (type==8) || (type==9) || (type==10)) 
        translate([m, 0, 0])
            rotate([0, 90, 0])
                protrusion(acd, pcd, ped, pl, ps, r);
    
    if ((type==7) || (type==9) || (type==10))
        translate([-m, 0, 0])
            rotate([0, 270, 0])
                protrusion(acd, pcd, ped, pl, ps, r);
        
    if ((type==5) || (type==6) || (type==8) || (type==9) || (type==10))
        translate([0, m, 0])
            rotate([270, 0, 0])
                protrusion(acd, pcd, ped, pl, ps, r);
    
    if(type==10)
        translate([0, -m, 0])
            rotate([90, 0, 0])
                protrusion(acd, pcd, ped, pl, ps, r);          
 }
 
 // slice off part of the connector to aid in printing without supports
 module slice(cd, pcd, ped, pl, ps, ed, r, type) {
     di = (cd + pl*2 + ps*2) * 0.5 * 1.414;
     os = pl + cd;
     cutSize = cd + pl*2 + ps*3;
     pt = pcd - ped;
     
    if (type==6) {
        cc = cd * 1.5;
        rotate([-35.26, 45, 0])
        translate([-0, 0, -cd-1])    
            cube([cc,cc+5,cc],center=true);
    }
    else if ( type==1 || type==3 ) {
        di = (pcd - (pcd * 1.414)) * 0.5;
        rotate([0, 0, -45])
            translate([0, -(pcd - di - ed), 0])
                cube([pcd,pcd,cutSize],center=true);
    }            
    else if (type==7 || type==4 || type==2) {
        rotate([-45, 0, 90])
            translate([0, -(4+di-((pt*0.5) + ps))+ed, 0])    
                cube([cutSize,os,cutSize],center=true);
    }
   else {
        rotate([-35.26, 0, 135])
            translate([0, -(2+di-((pt*0.5) + ps))+ed, 0])    
                cube([cutSize,os,cutSize],center=true);
    }
 }

// Create the protrusion, with rounded corners and taper
module protrusion(acd, pcd, ped, pl, ps, r) {
   $fn = 50;
    minkowski() { 
        linear_extrude (height = pl, scale=(ped/pcd), center=true) // tapered square 
            square([pcd-r*2, pcd-r*2], center=true);
        cylinder(r=r,h=1,center=true);
    };
    
    //if there's a protrusion spacer let's add that while we're here
    if (ps!=0) {
        minkowski() { 
           translate([0, 0, -(pl/2 + ps/2)])
            cube([acd, acd, ps], center=true);
            //sphere(r=1);
        }
    }
}  



