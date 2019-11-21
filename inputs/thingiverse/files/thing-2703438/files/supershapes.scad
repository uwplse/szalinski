/*

    SuperShapes generator
    Fernando Jerez 11/12/2017
    
    License: CC-Attribution

*/


// Full shape or Half-top
shape = "half"; // [full: Full Shape, half:Half-top]

// Shape1 
s1_m = 6; 
s1_n1 = 0.5;
s1_n2 = 1.7;
s1_n3 = 1;

// Shape2 
s2_m = 10; 
s2_n1 = 0.15;
s2_n2 = 1.7;
s2_n3 = 3;

// Z-Scale
zscale=1;

// Twist multiplier (0 = no twist)
twist = 0; // [-2:0.1:2]
// Waving height
waving = 0; // [0:10]
// Waving radius
waving_r = 0; //[0:10]

/* [Hidden] */
r = 50;
stepP = 1;
stepM = 2;
meridians = 360/stepM;

inilat = (shape=="half")?0:-90;
endlat = 90;
parallels = (endlat-inilat) / stepP;
a=1;
b=1;

sshape1 = [s1_m,s1_n1,s1_n2,s1_n3]; //longitude
sshape2 = [s2_m,s2_n1,s2_n2,s2_n3]; //latitude

// samples
/* SHAPE1
sshape1 = [7,0.20,1.70,1.70]; //longitude
sshape2 = [7,0.20,1.70,1.70]; //latitude
*/
/* SHAPE 2
sshape1 = [6,0.50,1,2.50]; //longitude
sshape2 = [20,10,5,5]; //latitude
*/
/* SHAPE 3
sshape1 = [8,60,55,1000]; //longitude
sshape2 = [4,250,1000,100]; //latitude
*/
/* Shape 4
sshape1 = [5,0.10,1.70,1.70]; //longitude
sshape2 = [1,0.30,0.50,0.50]; //latitude
*/

/* Cactus
sshape1 = [20,2,0,15]; //longitude
sshape2 = [7,1,0,20]; //latitude
*/

/* heart 
sshape1 = [2,0.10,2.50,1.70]; //longitude
sshape2 = [40,8,40,0]; //latitude
*/
 

// Superformula
function superf(ang,n)= 
    let(
     t1 = pow( abs((1/a) * cos(n[0]*ang/4)   ),n[2]),
     t2 = pow( abs((1/b) * sin(n[0]*ang/4)   ),n[3]),
     r = pow(t1+t2,-1/n[1])
    ) r;
    


// Build Polyhedron
scale([1,1,1])
rotate([0,0,0])
polyhedron(
points = 
[
    for(lat=[inilat:stepP:endlat-1])
        for(lon=[-180:stepM:180-stepM])
            let
            (
            r1 = superf(lon+lat*twist,sshape1),
            r2 = superf(lat,sshape2),
            r = 40 +10*cos(lon*waving_r), 
            x = r* (r1*cos(lon)*r2*cos(lat)),
            y = r* (r1*sin(lon)*r2*cos(lat)) ,
            z = (r*zscale) * r2*sin(lat) * (0.6+0.4*cos((lon)*waving))
            )
            [x,y,z]
        
    


]
,
faces = 
concat(
    [
    for(z = [0:parallels-2])
        for(s = [0:meridians-1])
            let(
                // clockwise from left-down corner
                f1 = s + meridians*z,
                f2 = s + meridians*(z+1),
                f3 = ((s+1) % meridians) + meridians*(z+1),
                f4 = ((s+1) % meridians) + meridians*z
            )
        
            [f1,f2,f3,f4]
 
    ],
    [[ for(s = [0:meridians-1]) ((inilat==0)?0:meridians)+s]], // bottom
    [[ for(s = [1:meridians]) meridians*(parallels)-s]] // top
 
)

);