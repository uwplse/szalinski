//number of holes
n=6;
//Total height
totalHeight=60;
H=totalHeight;
//wall thickness (between holes, and hole exterior)
wall=2;
//Radius of holes
holeRadius = 10;
ir=holeRadius;

//where the holes should be
mode="normal";//[normal,inverse,through]
//ratio of decoration high over total high 
decorationRatio=0.61803398875;


module bullet(w,h){
    union(){
        cylinder(r=w/2,h=h-w/2);
        translate([0,0,h-w/2]) sphere(r=w/2);
    }
}

function outerR(R,r) = sqrt(pow(R-sqrt(pow(R-r,2)-r*r),2)+r*r)-r;
Ra=2/(1-pow(tan((PI/4-PI/(2*n))*(180/PI)),2));
R=(Ra*(ir+wall/2))+wall/2;

or=outerR(R,ir)+wall/2;
oh=H * decorationRatio;


module barrel(){
difference(){
    cylinder(r=R,h=H);
    for (i =[ 0:n-1])
        rotate([180,0,i*360/n])translate([R,0,-H-1])bullet(or*2,oh+1);
}
}

if (mode=="normal"){
    difference(){
        barrel();
        for (i =[ 0:n-1])
            rotate([180,0,i*360/n+180/n])translate([R-ir-wall,0,-H-wall])bullet(ir*2,H);
    }
}
if (mode=="inverse"){
    difference(){
        barrel();
        for (i =[ 0:n-1])
            rotate([0,0,i*360/n+180/n])translate([R-ir-wall,0,-wall])bullet(ir*2,H);
    }
}

if (mode=="through"){
    difference(){
        barrel();
        for (i =[ 0:n-1])
            rotate([0,0,i*360/n+180/n])translate([R-ir-wall,0,-wall])bullet(ir*2,H*2);
    }
}
