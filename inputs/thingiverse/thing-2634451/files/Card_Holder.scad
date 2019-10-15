/* [Card Dimensions] */
//Card Height
ch=25;
//Card Width
cw=45;
//Stack Thickness
st=5;
//Card Pack count
cp=11;

/* [Side Angles] */
//Start Angle
sa=20;
//End Angle
ea=40;

/* [Print Tweakables] */
//Nozzle thickness
n=0.4;
//Layers
l=2;
//Circle Roundness
$fn=12;

/* [Debugging] */
// Show Sides (Disable for fast render)
showSides=true;

cardHolder();

module cardHolder(){
    dividers(side=0);
    if (showSides==true){
        hull(){dividers(side=1);}
        hull(){dividers(side=2);}
    }
}

module dividers(side=0){
    dt=n*l;//divider thickness;
    tl=(st*cp)+(dt*(cp+1));//Total Length
    fl=tl/cp;//fractional length
    ta=-sa+ea;//Total Angle;
    fa=ta/cp;//fractional angle;
    for (i=[0:cp]){
        //Divider
        translate([-i*fl,0,0])rotate([0,-sa-(fa*i),0]){
        translate([-(n*l)/2,0,0]){
            roundedCube(n*l,cw,ch,side=side);}//Divider
        }
    }
    //Bottom plate
    translate([0,0,-(n*l)/2])rotate([0,-90,0])roundedCube(n*l,cw,tl,side=side);
}

module roundedCube(x,y,z,side=0){
    if (side==0){
        cube([x,y,z]);
        translate([x/2,0,0])rotate([-90,0,0])cylinder(h=y,r=x/2);//Round top
        translate([x/2,0,z])rotate([-90,0,0])cylinder(h=y,r=x/2);//Round top
    }
    if (side==1){
        translate([x/2,-n*l,0])rotate([-90,0,0])cylinder(h=n*l,r=x/2);//Round top
        translate([x/2,-n*l,z])rotate([-90,0,0])cylinder(h=n*l,r=x/2);//Round top
    }
    if (side==2){
        translate([x/2,y,0])rotate([-90,0,0])cylinder(h=n*l,r=x/2);//Round top
        translate([x/2,y,z])rotate([-90,0,0])cylinder(h=n*l,r=x/2);//Round top
    }
}