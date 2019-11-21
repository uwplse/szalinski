dv=22.6; //vial diameter: check actual vial size
hd=25; //hole depth
as=1.5; //annular space 2*dr
nr=3; //number of rows
nc=5; //number of columns
is=6; //spacing between holes
wt=2; //wall thickness
fnc=15; //number of fragments:
        //15 for editing, 360 for rendering
m=0.001; //manifold margin
ew=0.4; //extrusion width
rt=2.1*ew; //raft thickness

id=dv+as; //inner diameter
od=id+2*wt; //outer diameter
ih=hd+m; //inner hole height
oh=hd+wt; //outer hole height
cd=id+is; //center distance

dxy=-id/2-is; // -17.5; //x & y translation
rl=nc*cd+is; //rack length set value
rw=nr*cd+is; //rack width set value
rh=hd+wt; //rack height
rs=0.5; //rack skewness
mr=10; //minkowski radius
fnm=15; //minkowski fragment number:
        //15 for editing, 360 for rendering
lo=rl-2*mr; //rack length outside
wo=rw-2*mr; //rack width outside
li=rl-2*wt-2*(mr-wt); //rack length inside
wi=rw-2*wt-2*(mr-wt); //rack width inside

//outer shape
CubePointsO = [
  [  0,  0,  0 ],  //0
  [ lo,  0,  0 ],  //1
  [ lo,  wo,  0 ],  //2
  [  0,  wo,  0 ],  //3
  [  -rs,  -rs,  rh ],  //4
  [ lo+rs,  -rs,  rh ],  //5
  [ lo+rs,  wo+rs,  rh ],  //6
  [  -rs,  wo+rs,  rh ]]; //7
  
CubeFacesO = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

//inner shape
CubePointsI = [
  [  0,  0,  0 ],  //0
  [ li,  0,  0 ],  //1
  [ li,  wi,  0 ],  //2
  [  0,  wi,  0 ],  //3
  [  -rs,  -rs,  rh ],  //4
  [ li+rs,  -rs,  rh ],  //5
  [ li+rs,  wi+rs,  rh ],  //6
  [  -rs,  wi+rs,  rh ]]; //7
  
CubeFacesI = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
//column rafts
CubePointsC = [
  [  0,  dxy,  0 ],  //0
  [ rt,  dxy,  0 ],  //1
  [ rt,  -dxy+rw-cd-is,  0 ],  //2
  [  0,  -dxy+rw-cd-is,  0 ],  //3
  [  0,  dxy-rs,  oh ],  //4
  [ rt,  dxy-rs,  oh ],  //5
  [ rt,  -dxy+rw+rs-cd-is,  oh ],  //6
  [  0,  -dxy+rw+rs-cd-is,  oh ]]; //7
  
CubeFacesC = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
//row rafts
CubePointsR = [
  [  dxy,  0,  0 ],  //0
  [  dxy, rt,  0 ],  //1
  [  -dxy+rl-cd-is, rt,  0 ],  //2
  [  -dxy+rl-cd-is,  0,  0 ],  //3
  [  dxy-rs,  0,  oh ],  //4
  [  dxy-rs, rt,  oh ],  //5
  [  -dxy+rl+rs-cd-is, rt,  oh ],  //6
  [  -dxy+rl+rs-cd-is,  0,  oh ]]; //7
  
CubeFacesR = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

rotate([0,0,90]) { 
difference()
{
    union()
    {
        $fn=fnm;
        translate([mr+dxy,mr+dxy,0.5]) //make z=mr when using sphere in the minkowski's below
        difference()
        {
            minkowski() //outside rack shape
            { 
                polyhedron( CubePointsO, CubeFacesO );
                cylinder(r=mr, center=true); //try sphere
            };

            translate([0,0,wt])
            minkowski() //inside rack shape
            {
                polyhedron( CubePointsI, CubeFacesI );
                cylinder(r=mr-wt, center=true); //try sphere
            };
        };
        
        echo(-id/2-is,nc*cd+is,nr*cd+is);

        for (c=[0:nc-1]) //outer shape vial holders
            for (r=[0:nr-1])
            {
                translate([c*cd,r*cd,0])
                cylinder(d=od,h=oh,$fn=fnc);
            };
            
        for (c=[0:nc-1]) //column rafts
        {
            translate([c*cd-rt/2,0,0])
            polyhedron( CubePointsC, CubeFacesC );
        };  
        for (r=[0:nr-1]) //row rafts
        {
            translate([0,r*cd-rt/2,0])
            polyhedron( CubePointsR, CubeFacesR );
        };   
    };

    for (c=[0:nc-1]) //inner shape vial holders
        for (r=[0:nr-1])
        {
            translate([c*cd,r*cd,0])
            cylinder(d=id,h=ih,$fn=fnc);
        };
    for (ch=[0:nc-1]) //column header
    {
        translate([ch*cd-rt/2, -id/2-is/2,0.5])
        rotate([0,180,180])
        linear_extrude(height = 1) 
        text(chr(65+ch), font = "Liberation Sans:style=Bold", size = is*0.9,halign="center", valign ="center");
    };
    for (rh=[0:nr-1]) //row header
    {
        translate([-id/2-is/2,rh*cd-rt/2,0.5])
        rotate([0,180,180])
        linear_extrude(height = 1)  
        text(chr(49+rh), font = "Liberation Sans:style=Bold", size = is*0.9,halign="center", valign ="center");
    };
};

};