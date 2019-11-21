//Number of rows.
rows=10;
//Number of columns.
columns=5;
//Thickness of bottom plate
bottomthickness=3;
//Thickness of top plate
topthickness=2;
//Total height incl bottom and top.
totalheight=15;
//Chamfer of top and bottom plate.
chamfer=0.8;
//Bottom- and top plate corner radius
cornerRadius=10;
//Inside diameter. Slightly larger then case.
holeD=12.5;
//Distance between cases.
holeCC=15;
//Dept of hole in bottom plate
holedepth=2;
//Diameter of screw hole in top plate
screwD=3.2;
//Diameter of screw hole in standoff
screwholeD=2.8;
//Diameter of standoff 
pinD=5;
//Show top. Set to 0 when generating bottom stl.
showTop=1;
//Show bottom. Set to 0 when generating top stl.
showBase=1;

$fn=100;

module hole(xpos,ypos,zpos){
    translate([xpos,ypos,zpos]){
        cylinder(h=holedepth+2,d=holeD);
    }
}
module screwhole(xpos,ypos,zpos,depth,diameter){
    translate([xpos,ypos,zpos]){
        cylinder(h=depth+2,d=diameter);
    }
}
module screwpin(xpos,ypos,zpos,height){
    translate([xpos,ypos,zpos]){
        difference(){
            cylinder(h=height,d=pinD);
            screwhole(0,0,-1,height+2,screwholeD);
        }
    }
}
module holes(zpos=0){
    for(r=[0:rows-1]){
        for(c=[0:columns-1]){
            hole(r*holeCC,c*holeCC,zpos);
        }
    }
}
module corner(thickness,chamfer,xpos,ypos,zpos){
    translate([xpos,ypos,zpos]){
        rotate_extrude(convexity=1)
            polygon( points=[[0,0],[cornerRadius,0],[cornerRadius,thickness-chamfer],[cornerRadius-chamfer,thickness],[0,thickness]]);
        }
    }

module base(){
   difference(){
        hull(){    
            corner(bottomthickness,chamfer,0,0,0);
            corner(bottomthickness,chamfer,rows*holeCC-holeCC,0,0);
            corner(bottomthickness,chamfer,0,columns*holeCC-holeCC,0);
            corner(bottomthickness,chamfer,rows*holeCC-holeCC,columns*holeCC-holeCC,0);
        }
        holes(bottomthickness-holedepth);
    }
    pinLength=totalheight-bottomthickness-topthickness;
    screwpin(holeCC/2,holeCC/2,bottomthickness,pinLength);
screwpin((rows-1.5)*holeCC,holeCC/2,bottomthickness,pinLength);
screwpin(holeCC/2,(columns-1.5)*holeCC,bottomthickness,pinLength);
screwpin((rows-1.5)*holeCC,holeCC/2,bottomthickness,pinLength);
screwpin((rows-1.5)*holeCC,(columns-1.5)*holeCC,bottomthickness,pinLength);
    tmp=rows/2;
    if(tmp==floor(tmp)){
screwpin((rows-1)/2*holeCC,holeCC/2,bottomthickness,pinLength);
screwpin((rows-1)/2*holeCC,(columns-1.5)*holeCC,bottomthickness,pinLength);
    }
}

module top(){
    translate([0,0,totalheight-topthickness]){
        difference(){
            hull(){    
                corner(topthickness,chamfer,0,0,0);
                corner(topthickness,chamfer,rows*holeCC-holeCC,0,0);
                corner(topthickness,chamfer,0,columns*holeCC-holeCC,0);
                corner(topthickness,chamfer,rows*holeCC-holeCC,columns*holeCC-holeCC,0);
            }
            holes(-1);
            screwhole(holeCC/2,holeCC/2,-1,topthickness,screwD);
            screwhole((rows-1.5)*holeCC,holeCC/2,-1,topthickness,screwD);
            screwhole(holeCC/2,(columns-1.5)*holeCC,-1,topthickness,screwD);
            screwhole((rows-1.5)*holeCC,(columns-1.5)*holeCC,-1,topthickness,screwD);
            tmp=rows/2;
            if(tmp==floor(tmp)){
                screwhole((rows-1)/2*holeCC,holeCC/2,-1,topthickness,screwD);
                screwhole((rows-1)/2*holeCC,(columns-1.5)*holeCC,-1,topthickness,screwD);
            
            }
        }
    }
}


if(showBase){
    base();
}
if(showTop){
    top(); 
}