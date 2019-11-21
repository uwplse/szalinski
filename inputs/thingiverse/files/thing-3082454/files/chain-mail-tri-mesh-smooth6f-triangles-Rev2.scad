
//Chain Mail Tri-mesh Improved
// Licenced under the Creative Commons - Attribution - Share Alike license
//2017 Don Fyler
// Rev 1 Nov 11,2017  Cleaned up and made revisable
//Rev 2 Sept 22,2018  Modified to print triangular pattern

//-----------------------------------------------------------------------------------------
//Brief description of model
//Each ring is made from 3 sections that are the same except rotated.  Each of the sections is made of 3 arcs. 
//The first arc (arc1) defines the general size of the ring, the shape of the ring, and how far the ring goes up and down in the z direction. 
//Arc2 and arc3 are the larger up and down loops.  Arc3 is the same as arc2 except flipped 180 degrees.  
//After arc1 is defined, there is only one (if any) solutions for arc2 and arc3.  This means you dont get any options for adjusting them except what you can do to arc1.  This makes for some unexpected behavior and it will take some practice to get what you want.
//Set "overlap" to -5 if you want to see what the individual arcs look like.
// Sorry for the complexity of the program but it took some effort to get all the arcs to match up in 3-space.
//--------------------------------------------------------------------------------------



//resolution, needs to be high for clean joints(default=20)
$fn=20;
//overall scale of everything to simply scale mesh(default=1.02)
scalar=1.02;

//angle sweep of initial arc.  ang1=0 will make hexagon rings. (default=20)
ang1=20; //[0:45]
 //From 0 deg to 90 deg (flat to full wave in rings)(default=65)
tilt=65;//[0:90]

// the max radius of a ring at the center of the wire will usually be arc1_offset+arc1_radius
//mm offset from center for arc1(default=5mm)
arc1_offset = 5; 
//mm radius of arc1 (default=3mm)
arc1_radius = 3; 
//mm diameter of ring wire(default=3.6mm)
wire_dia=3.6; 
//mm total Z thickness after flat is cut. A reasonable size flat is necessary to stick to the bed (default=3.4mm)
thickness=3.4; 
// degrees of arc overlap to make sure OpenSCAD joins the arcs(default=1 )
overlap=1; 
//mm clearance offset so rings do not touch during printing.  Leave about 2 layers gap  between rings to be sure they dont stick to each other. (default=.9)
clearance=.9;
//number of rings per side of triangle(default=3)
triangle_size= 3;
//number of triangles. Print 2 joined triangles to save time
number_of_triangles=2;//[1,2]

//  preview[view:south, tilt:top]

module hide_parameters(){
}


bendoffset1=arc1_offset*scalar;//arc1 offset -scaled
bendrad1=arc1_radius*scalar;//arc1 bend radius -scaled
dia=wire_dia*scalar;  // diameter of spagetti -scaled 
thick=thickness*scalar;  //flattened thickness (cropped)


offset=2*(bendoffset1+bendrad1)-dia-clearance*scalar;// spacing of rings as printed, adjust to make sure rings do not touch
//echo("offset=",offset);

p1=[bendrad1,0,0];  //point at end for arc1 (unrotated)
n1=[bendrad1,1,0];  //unit normal at end of  arc1

R1=[[cos(ang1/2),sin(ang1/2),0],[-sin(ang1/2),cos(ang1/2),0],[0,0,1]]; //rotation matrix 1 (1/2 of ang1 about z)
T1=[bendoffset1,0,0];  //translate 1

R2=[[1,0,0],[0,cos(tilt),sin(tilt),0],[0,sin(tilt),cos(tilt)]]; //rotation matrix about x (tilt ang about x)

R3=[[cos(60),-sin(60),0],[sin(60),cos(60),0],[0,0,1]]; // rotation matrix about z(-60deg about z)
p1a=(p1*R1+T1)*R2*R3; //point at end of arc 1
n1a=(n1*R1+T1)*R2*R3; //normal point
V2=n1a-p1a; //normal vector
P1v=V2*p1a;  // plane equation is V2[0]*x+V2[1]*y+V2[2]*z = P1v
//echo ("P1v=",P1v);
//echo("p1a=",p1a);
//echo("n1a=",n1a);
//echo("V2=",V2);

//Note: arc1 has been rotated -60deg about z so arc2 ends on x axis

xpos=[P1v/V2[0],0,0];  //get point were plane goes through the x axis.
//echo("xpos=",xpos);

ap2=[norm(xpos-p1a)+xpos[0],0,0]; // get point on x axis were new arc ends.
//echo("ap2=",ap2);

coord_mid=(p1a+ap2)/2;
angx=atan(p1a[2]/p1a[1]);  // x axis rotation
Rx=[[1,0,0],[0,cos(angx),-sin(angx),0],[0,sin(angx),cos(angx)]];
Rxn=[[1,0,0],[0,cos(angx),sin(angx),0],[0,-sin(angx),cos(angx)]];
p1ax=p1a*Rx;
n1ax=n1a*Rx;
coord_midx=coord_mid*Rx;
ap2x=ap2*Rx;


angz=-atan((p1ax[0]-ap2x[0])/(p1ax[1]-ap2x[1]));
Rz=[[cos(angz),-sin(angz),0],[sin(angz),cos(angz),0],[0,0,1]];
Rzn=[[cos(angz),sin(angz),0],[-sin(angz),cos(angz),0],[0,0,1]];
p1az=p1ax*Rz;
n1az=n1ax*Rz;
coord_midz=coord_midx*Rz;
ap2z=ap2x*Rz;
V2z=n1az-p1az;
//echo("V2z=",V2z);

angy=atan(V2z[0]/V2z[2]);
Ry=[[cos(angy),0,sin(angy)],[0,1,0],[-sin(angy),0,cos(angy)]];
Ryn=[[cos(angy),0,-sin(angy)],[0,1,0],[sin(angy),0,cos(angy)]];
p1ay=p1az*Ry;
n1ay=n1az*Ry;
coord_midy=coord_midz*Ry;
ap2y=ap2z*Ry;
V2y=n1ay-p1ay;
//echo("V2y=",V2y);

thet=atan(V2y[2]/V2y[1]);
//echo("thet=",thet);
pivotz =coord_midy[2] - (coord_midy[1]-p1ay[1])/tan(thet);
pivot=[coord_midy[0],coord_midy[1],pivotz];
radvec=p1ay-pivot;
rad2=norm(radvec);
//echo("rad2=",rad2);

//routine to draw an arc segment 
module arc_seg(big_rad, little_rad,angle){
    intersection(){
        rotate_extrude(convexity=10)
            translate([big_rad,0,0])
                circle(little_rad);
        linear_extrude(bendrad1*2,center=true)
        polygon([[0,0],[(big_rad+little_rad*2)*cos(angle/2),-(big_rad+little_rad*2)*sin(angle/2)],
                    [(big_rad+little_rad*2),0],
                    [(big_rad+little_rad*2)*cos(angle/2),(big_rad+little_rad*2)*sin(angle/2)]]);
    }
}

//arc_seg(10,2,120);

//first arc
module arc1(){
    rotate([tilt,0,0])
    translate([bendoffset1,0,0])
    arc_seg(bendrad1,dia/2,ang1);
}

//second arc 
module arc2(){
    rotate([angx,0,0])
    rotate([0,0,angz])
    rotate([0,angy,0])
    translate(pivot)
    rotate([0,-90,0])
    arc_seg(rad2,dia/2,thet*2+overlap);

}

//arc2 and arc3
module arc22(){
   arc2();
   rotate([180,0,0]) arc2();
}

//one entire ring
module loop(){
    union(){
    rotate([0,0,-60]) arc1();
    rotate([0,0,60]) arc1();
    rotate([0,0,180]) arc1();
    arc22();
    rotate([0,0,120]) arc22();
    rotate([0,0,240]) arc22();
    }
}
loop_size=(bendoffset1+bendrad1+dia)*2;//size of loop plus extra

//create flats on extremities of the ring
module flat_loop(){
      intersection(){
         loop();
         translate([0,0,0])cube([loop_size,loop_size,thick*2],center=true);
     } 
 }


module triangle(size){
    for(nloop=[0:size-1]){
        xstart=nloop*offset*cos(30);
        ystart=nloop*offset*1.5;
        xinc=2*offset*cos(30);
        for(nh=[0:size-nloop-1]){
            translate([xstart+xinc*nh,ystart,0])rotate([0,0,90])flat_loop();
        }
        if(size-nloop>=2)for(nh=[0:size-nloop-2]){
           translate([xstart+xinc/2+xinc*nh,ystart+offset*cos(60),0])rotate([0,0,-90])flat_loop(); 
        }      
    }
}

module triangle2(size){
    for(nloop=[0:size-1]){
        xstart=nloop*offset*cos(30);
        ystart=-nloop*offset*1.5-offset;
        xinc=2*offset*cos(30);
        for(nh=[0:size-nloop-1]){
            translate([xstart+xinc*nh,ystart,0])rotate([0,0,-90])flat_loop();
        }
        if(size-nloop>=2)for(nh=[0:size-nloop-2]){
           translate([xstart+xinc/2+xinc*nh,ystart-offset*cos(60),0])rotate([0,0,90])flat_loop(); 
        }      
    }
}
 
echo("x step", 2*offset*cos(30));
      
triangle(triangle_size);
if (number_of_triangles==2)triangle2(triangle_size);

//debugging stuff
//*/
//arc1();
//rotate([0,0,60])arc22();
//loop();

/*
translate(p1a) sphere(1/2);
translate(n1a) sphere(1/2);
translate([xpos[0],0,0]) sphere(1/2);
translate([ap2[0],0,0]) sphere(1/2);
translate(coord_mid) sphere(1/2);

translate(p1az) sphere(1/2);
translate(n1az) sphere(1/2);
translate(ap2z) sphere(1/2);
translate(coord_midz) sphere(1/2);

translate(p1ay) sphere(1/2);
translate(n1ay) sphere(1/2);
translate(ap2y) sphere(1/2);
translate(coord_midy) sphere(1/2);
*/

