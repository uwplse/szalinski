//Bookstand created by Sara Gonzalez, University of Florida.  All dimensions are in mm and angles in degrees.



//Width of book spine in mm
width = 90; 
//Width of book cover (single side) in mm
cover = 150; 
//Height of book in mm
bookheight = 220;  

//Angle that book is open on stand, measured from horizontal, 90 deg is closed, 0 deg is fully open
openang = 40; // [0:85]
//Angle that book is leaning back, measured from vertical
repose = 45; //[10:85]
//Thickness of model
thickness = 5; 



ledgex = cover/2;  //xyz dimensions of book ledge
//Thickness and length of bookcover ledge (do not change)
ledgey = 10;
ledgez = 5;
A=width;
B=cover;
C=thickness;
D=width + 2*(thickness/tan(90-openang));
reposeht = bookheight*sin(repose)*sin(repose);

//calculate legs points
ptx0347 = .45*cover*cos(openang) + .5*width;
ptx1256 = .55*cover*cos(openang) + .5*width;
pty2367 = bookheight;
pty04 = -.45*cover*sin(openang);
pty15 = -.55*cover*sin(openang);
ptz0123 = .2*bookheight;
ptz4567 = .65*bookheight;

polypoints = [
    [ptx0347,pty04,ptz0123],
    [ptx1256,pty15,ptz0123], 
    [ptx1256,pty2367,ptz0123], 
    [ptx0347,pty2367,ptz0123], 
    [ptx0347,pty04,ptz4567], 
    [ptx1256,pty15,ptz4567], 
    [ptx1256,pty2367,ptz4567], 
    [ptx0347,pty2367,ptz4567]];

polyfaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
      
difference(){
rotate([-repose,0,0]){   
    
        linear_extrude(height=bookheight){
                polygon(points = [ [0,0], [0,C], [D/2,C], [D/2 + B*cos(openang), C-B*sin(openang) ], [A/2 + B*cos(openang), -B*sin(openang)], [A/2, 0] ]);
                mirror([0])   
                polygon(points = [ [0,0], [0,C], [D/2,C], [D/2 + B*cos(openang), C-B*sin(openang) ], [A/2 + B*cos(openang), -B*sin(openang)], [A/2, 0] ]);}
        
        
        translate([A/2+(B/2)*cos(openang),-(B/2)*sin(openang), ledgez/2]){ rotate(-openang) cube([ledgex, ledgey, ledgez], center=true);}
        
        mirror([0]){translate([A/2+(B/2)*cos(openang),-(B/2)*sin(openang), ledgez/2]){ rotate(-openang) cube([ledgex, ledgey, ledgez], center=true);}}
        
        
        polyhedron( polypoints, polyfaces);
        
        mirror([0])
            polyhedron( polypoints, polyfaces);
    
}
//Slice z<0 material
translate([-cover-.5*width, -.5*bookheight, -bookheight]){
    cube(size = [2*cover+width,2*bookheight,bookheight]);}
}
