//use <gopro_mounts_mooncactus.scad>


/****************************
** GoPro Mounts parameters **
****************************/
//DON'T CHANGE
gopro_connector_z = 14.7*1; 
//DON'T CHANGE
gopro_hole2base=10.85*1;

/*********************
** 360Rig Paramters **
*********************/
//Model to render
model = "Full Frame"; //[Full Frame, Simple Edge, Main Edge]
//Number of horizontal Cameras
N=5; //[4:10]
//ratio octagon/cube, sizes the corners 12/5=2.4
ratio = 2.4; 
//the roundes of the face holes
faceR=10;
//the size of the border (x2)
B=gopro_connector_z*2;
//the maximum camera dimension 
MaxCamDim=80;
// total size of the rig (cube)
S=MaxCamDim+B;
//edje smoothness (0 to disable)
Smoothness=0; // [0:7]
//Tolerance (for better fitting of edjes)
tol=1;
//select External GoProConnector
ExtGoPro=1;// [1:yes, 0:no]
//select External 1/4" nut for tripods
ExtQIN=1;// [1:yes, 0:no]
// diameter for screwdriver hole, set to 0 to disable
driverHoles = 6.5;
// Set the alternation of orientation (0= side, 1=top, -1 = bottom)
orientations = [0,-1,0,-1,0,-1,0,-1,0,-1,0,-1];
// Orientation for individual edges
orient = 0; // [0,1]


module octahedron(size) {
    s=size/2;
      p=[
            [s,0,0],
            [0,s,0],
            [0,0,s],
            [-s,0,0],
            [0,-s,0],
            [0,0,-s],
        ];
       f=[
            [0,2,1],
            [3,2,4],
            [4,2,0],
            [0,1,5],
            [0,5,4],
            [3,1,2],
            [3,4,5],
            [5,1,3]
            
        ];
    polyhedron(p,f);
}

function inscribedSOct(a) = sqrt(6)*a/6;

module face(s, d, h) {
    hull(){
        for (p = [[-1,-1,0],[1,-1,0],[-1,1,0],[1,1,0]]){
            translate(p*(s/2-d))
                cylinder(r=d,h = h,center=true);
        }
    }
}

module faceO(n,S,o=0){
    faces=[
            [0,0,0],
            [0,270,0],
            [90,0,0],
            [270,0,0],
            [0,90,0],
            [180,0,0],
    ];
    
    rotate(faces[n-1]) rotate([0,0,90*o]) translate([0,0,S/2]) children();
}

module tripodConnector(d1,h1,d2,h2){
    translate([0,0,-h2])
    rotate([0,0,30])
    union(){
        cylinder(d=d1,h=h1,$fn=6);
        cylinder(d=d2,h=h2);
    }
}

module goproConnector2(){
    translate([0,0,gopro_hole2base-0.2]) rotate([-90,0,90]) gopro_connector("double");
}

module goproConnector3(z=B/4){
    gopro_connector("triple");
    translate([0,gopro_connector_z-0.2-B/8+z/2,0])
				cube([gopro_connector_z,z,gopro_connector_z], center=true);
}

module cornerO(){
       rotate([0,atan(sqrt(2)),45]) 
            children();
    for ( a = [
                [atan(sqrt(2)),0,-45],
                [atan(sqrt(2)),0,45],
                ] )
        rotate(a) 
                rotate([0,0,30]) children();
    for ( a = [
                [180-atan(sqrt(2)),0,-45],
                [180-atan(sqrt(2)),0,45],
                [-atan(sqrt(2)),0,45],
                ] )
        rotate(a) 
                rotate([0,0,-30]) children();
    for ( a = [
                [0,180-atan(sqrt(2)),45],
                [0,180-atan(sqrt(2)),180-45],
                ] )
        rotate(a) 
                rotate([0,0,-60]) children();
}

module frame(S,B,ratio){
difference(){
    intersection(){
        cube(S,center=true);
        octahedron(S*ratio);
    }
    for (a = [[0,0,0],[90,0,0],[0,90,0]]) {
        rotate(a) face(S-B,faceR,S+1);
    }
    
    //removing inner corners
    cb=15;
    cd=faceR;
    cornerO()
          translate([0,0,sqrt(3)*(S-B-cd/2.0)/2-cb])
                cylinder(d=cd,h=cb, $fn=3);
}
}

module edge(S,B,ratio,extra=0){
    intersection(){
        frame(S,B,ratio);
        translate([-extra,-extra,-S/2]) cube(S);
    }
}

function outerAngle()=270-360/N;

function apothem(n,s) = (s*cos(180/n))/(2*sin(180/n));

function edjeDesplacement(N,S) = apothem(N,sqrt(2)*S/2) ;

function tRatio(N,s) = apothem(N,sqrt(2)*s/2) - apothem(4,sqrt(2)*s/2);

function diagD(d) = sqrt(2)*d/2; 

module sedge(S,B,ratio,extra=0,Smoothness){
translate(diagD(tRatio(N,S-B))*[1,1,0])
    if (Smoothness > 0) {
        ms=Smoothness;
        minkowski(){
            edge(S-ms,B-ms*2,ratio,0);
            sphere(d=ms,$fn=15);
        }
    }
    else {
        edge(S,B,ratio,0);
    }
}


module edgeConnectors(S,B,o=0){
    r = (o%2)*90 + o * outerAngle()/2;
    orot = o==0? 1 : sign(o);
    difference(){
        children(0);
         //holes for Screwdriver
        if(driverHoles > 0){
            translate(diagD(tRatio(N,S-B))*[1,1,0])
            faceO(5,S,o)
            translate([0,(S-B)/2-gopro_hole2base,-gopro_connector_z/2]) 
            rotate([0,r,0])
            rotate([0,orot*-90,0])
             cylinder(d=driverHoles,h=S);
        }
    }
    // side Connector
    translate(diagD(tRatio(N,S-B))*[1,1,0])
    faceO(5,S,o)
        translate([0,(S-B)/2-gopro_hole2base,-gopro_connector_z/2]) 
            rotate([0,r,0])
            rotate([0,orot*90,0]) goproConnector3(0);
}

module PosSideA(){
    translate(diagD(tRatio(N,S-B))*[1,1,0])
translate([0,(S-B)/2,0])
rotate([0,0,180- outerAngle()/2]) children(0);
}

module PosSideB(){
    translate(diagD(tRatio(N,S-B))*[1,1,0])
        translate([(S-B)/2,0,0])
        rotate([0,0,90 + outerAngle()/2]) children(0);
}

module edge2edgeCon(s){
    translate([0,-s/8,0])
    rotate([0,0,-30])
    difference(){
        cylinder(d=s,h=S,center=true,$fn=3);
        cube(S-B,center=true);
    }
}

module SimpleEdgeModifications(o){
    edgeConnectors(S,B,o)
    difference(){
    children(0);
    // edge cut
    PosSideA()
        translate(-[S/2,0,S/2]) cube([S,B,S]);
    PosSideB()
        translate(-[S/2,0,S/2]) cube([S,B,S]); 
    //negative e2e connector
    PosSideA()
        translate([B/4,0,0])
        edge2edgeCon(B/2.7+tol);
    }
    //possitive e2e connector
    PosSideB()
        translate([-B/4,0,0]) mirror([0,1,0])
        edge2edgeCon(B/2.7);
}

module MainEdgeConnectors(o){
difference(){
     edgeConnectors(S,B,o)
     difference(){
        children(0);
         //holes for Screwdriver
         if(driverHoles > 0){
             for (z=[S/2,-S/2+B/2])
            rotate([0,0,outerAngle()/2-180])
            translate(diagD(tRatio(N,S-B/2))*[0,1,0])
            translate([0,(S-B)/2-gopro_hole2base,-gopro_connector_z/2+z]) 
                    rotate([0,-90,0]) 
              cylinder(d=driverHoles,h=S);
         }
     }
    
    //hole for 1/4" nut for tripod compatibility
    if (ExtQIN)
    translate(diagD(tRatio(N,S-B))*[1,1,0])
    rotate([0,180-atan(sqrt(2)),45]) 
        translate([0,0,inscribedSOct(S*ratio*sqrt(2)/2)-inscribedSOct(Smoothness/3)])
            tripodConnector(13,20,6.5,22);
}
//external connector for GoPro accessories
    if (ExtGoPro)
    translate(diagD(tRatio(N,S-B))*[1,1,0])
    rotate([-atan(sqrt(2)),0,-45]) 
        translate([0,0,inscribedSOct(S*ratio*sqrt(2)/2)-inscribedSOct(Smoothness/3)-0.1])
            goproConnector2();

//Top and Bottom connectors
    difference(){
        for (z=[S/2,-S/2+B/2])
            rotate([0,0,outerAngle()/2-180])
            translate(diagD(tRatio(N,S-B/2))*[0,1,0])
            translate([0,(S-B)/2-gopro_hole2base,-gopro_connector_z/2+z]) 
                    rotate([0,90,0]) goproConnector3();
        if(model != "Full Frame")
        PosSideB()
            rotate([0,0,outerAngle()/2-90]) translate(-[B,0,S/2])  cube([B,B,S]);
    }
}

module full(){
for (i = [1:N-1]) {
    a = i*360/N;
    rotate([0,0,a]) //translate([1,1,0])
        edgeConnectors(S,B,orientations[i]) sedge(S,B,ratio,0,Smoothness);
MainEdgeConnectors(orientations[0])
 sedge(S,B,ratio,0,Smoothness);
}
// fix debugging
    //Debugging: camera/case fitting
    /*
%for (a = [0:360/N:360]){
    rotate([0,0,a]) 
        translate(diagD(tRatio(N,S-B))*[1,1,0])
    faceO(5,S) cube([80,60,40],center=true);
}
%for (z=[S/2,-S/2+B/2])
    rotate([0,0,outerAngle()/2-180])
    translate(diagD(tRatio(N,S-B/2))*[0,1,0]+[0,0,z])
    cube([80,60,40],center=true);
*/

}

if (model=="Full Frame")
    full();
else if (model=="Simple Edge")
    SimpleEdgeModifications(orient)
        sedge(S,B,ratio,0,Smoothness);
else
    MainEdgeConnectors(orient) SimpleEdgeModifications()
        sedge(S,B,ratio,0,Smoothness);


/* [Hidden] */
    
    // This tab is useful only if you have selected "rod" as the secondary head. The optional rod diameter (also the captive nut internal diameter)
gopro_captive_rod_id= 3.8;
// The angle the rod makes with the axis (0 is colinear, 90 is a right angle)
gopro_captive_rod_angle= 45; // [0:90]
// Optional captive nut thickness with freeplay (tightest would be 3.2)
gopro_rod_nut_th= 3.6;
// Optional captive nut diameter with freeplay (from corner to corner)
gopro_rod_nut_od= 8.05;
// How much is the protruding output of the rod on the rod attachment (can be zero), useful if you don't want a captive nut with still a tight coupling
gopro_captive_protruding_h= 0.5;

// The gopro connector itself (you most probably do not want to change this but for the first two)

// The locking nut on the gopro mount triple arm mount (keep it tight)
gopro_nut_d= 9.2;
// How deep is this nut embossing (keep it small to avoid over-overhangs)
gopro_nut_h= 2;
// Hole diameter for the two-arm mount part
gopro_holed_two= 5;
// Hole diameter for the three-arm mount part
gopro_holed_three= 5.5;
// Thickness of the internal arm in the 3-arm mount part
gopro_connector_th3_middle= 3.1;
// Thickness of the side arms in the 3-arm mount part
gopro_connector_th3_side= 2.7;
// Thickness of the arms in the 2-arm mount part
gopro_connector_th2= 3.04;
// The gap in the 3-arm mount part for the two-arm
gopro_connector_gap= 3.1;
// How round are the 2 and 3-arm parts
gopro_connector_roundness= 1;
// How thick are the mount walls
gopro_wall_th= 3;

gopro_connector_wall_tol=0.5+0;
gopro_tol=0.04+0;

//
// ============================= GOPRO CONNECTOR =============================
//

module gopro_torus(r,rnd)
{
	translate([0,0,rnd/2])
		rotate_extrude(convexity= 10)
			translate([r-rnd/2, 0, 0])
				circle(r= rnd/2, $fs=0.2);
}

module gopro_rcyl(r,h, centered, rnd=1)
{
	translate([0,0,center ? -h/2 : 0])
	hull() {
		translate([0,0,0]) gopro_torus(r=r, rnd=rnd);
		translate([0,0,h-rnd]) gopro_torus(r=r, rnd=rnd);
	}
}

module gopro_connector(version="double", withnut=true, captive_nut_th=0, captive_nut_od=0, captive_rod_id=0, captive_nut_angle=0)
{
	module gopro_profile(th)
	{
		hull()
		{
			gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([0,0,th-gopro_connector_roundness])
				gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([-gopro_connector_z/2,gopro_connector_z/2,0])
				cube([gopro_connector_z,gopro_wall_th,th]);
		}
	}
	difference()
	{
		union()
		{
			if(version=="double")
			{
				for(mz=[-1:2:+1]) scale([1,1,mz])
						translate([0,0,gopro_connector_th3_middle/2 + (gopro_connector_gap-gopro_connector_th2)/2]) gopro_profile(gopro_connector_th2);
			}
			if(version=="triple")
			{
				translate([0,0,-gopro_connector_th3_middle/2]) gopro_profile(gopro_connector_th3_middle);
				for(mz=[-1:2:+1]) scale([1,1,mz])
					translate([0,0,gopro_connector_th3_middle/2 + gopro_connector_gap]) gopro_profile(gopro_connector_th3_side);
			}

			// add the common wall
			translate([0,gopro_connector_z/2+gopro_wall_th/2+gopro_connector_wall_tol,0])
				cube([gopro_connector_z,gopro_wall_th,gopro_connector_z], center=true);

			// add the optional nut emboss
			if(version=="triple" && withnut)
			{
				translate([0,0,gopro_connector_z/2-gopro_tol])
				difference()
				{
					cylinder(r1=gopro_connector_z/2-gopro_connector_roundness/2, r2=11.5/2, h=gopro_nut_h+gopro_tol);
					cylinder(r=gopro_nut_d/2, h=gopro_connector_z/2+3.5+gopro_tol, $fn=6);
				}
			}
		}
		// remove the axis
		translate([0,0,-gopro_tol])
			cylinder(r=(version=="double" ? gopro_holed_two : gopro_holed_three)/2, h=gopro_connector_z+4*gopro_tol, center=true, $fs=1);
	}
}
