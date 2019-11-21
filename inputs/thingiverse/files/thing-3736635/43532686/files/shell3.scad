hCylindre1=4;  //[1:1:6]
thickness1=2;   //[1:1:5]
incAngle = 5;  //[1:1:30]
radius = 20;   //[5:1:30]
rotationsCount = 6;  //[1:1:10]
hCylindre2=2;   //[1:1:3] 
thickness2=1;    //[1:1:3] 
module cylindre (r,h,thikn){
    rotate (90,[0,1,0])
    rotate (90,[1,0,0])
    difference (){
        cylinder(r = r, h = h, center = true);
        cylinder(r = r-thikn, h = h+1, center = true);
    }
}

$fn=80;
rotate(-31.5,[0,1,0])
rotate(30,[1,0,0])
translate ([0,0,radius*.90])
rotate(18,[0,1,0])
for (i = [0 : incAngle : 360*rotationsCount]){
    rCylindre =radiusCompute(i);
    translate ([cos(i)*rCylindre,sin(i)*rCylindre,heightCompute(i)])
            rotate(i,[0,0,1])
            if (i<360*(rotationsCount-1))
                cylindre (rCylindre,hCylindre1,thickness1);
            else
                cylindre (rCylindre,hCylindre2,thickness2);

}

function radiusCompute(i) = radius-i/360*radius/rotationsCount;
function heightCompute(i)=
    sin (i/(360*rotationsCount)*90)*(radius*rotationsCount)*0.8;

    
