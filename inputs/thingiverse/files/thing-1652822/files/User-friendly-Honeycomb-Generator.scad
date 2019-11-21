radius = 4;
inscribedOrCircumscribed = 0;//	[0:Use inscribed (corner to corner) radius, 1:Use circumscribed (edge to edge) radius]
//(inscribed radius)*cos(30)=circumscribed radius
combRadius = radius*cos(30)*(1-inscribedOrCircumscribed)+radius*inscribedOrCircumscribed;
combWidth = 2*combRadius;
//distance between edges of honeycomb holes
combSeperation = 2;
//Thickness/extrusion in the z direction
thickness = 1;
//Extends the wall thickness for a thicker outside edge. Might cause slow build times for large arrays.
overlap = 0; //[0:Don't use overlapping shapes, 1:Use overlapping shapes]
//Number of holes in the X direction
X_Count = 3;
//Number of holes in the Y direction
Y_Count = 3;
l=1/cos(30);
y=l*sin(30);
//radius*cos(30) = combWidth/2
//radius=(combWidth/2)/cos(3);


//hexagon(h=thickness,w=combWidth);
honeycomb(X_Count,Y_Count);
//hollowHexagon(thickness,combWidth,combSeperation/2);


module hexagon(h=1,w=1){
    //l*cos(30)=1,  
    
    hexPoints=[[1,y],[0,l],[-1,y],[-1,-y],[0,-l],[1,-y]];
    linear_extrude(h){
        polygon((w/2)*hexPoints);
    }   
}
module hollowHexagon(h=1,cW=10,wallWidth=1){
    difference(){
        hexagon(h,cW+wallWidth*2+overlap*wallWidth*2);
        
        translate([0,0,-1]){
            hexagon(h+2,cW);
        }
        
    }
    
}

module honeycomb(xCount, yCount){
    yShift=sin(60)*(combWidth+combSeperation);
    for (j =[0:yCount-1]){
        translate([0,yShift*j,0]){
            for (i = [0:xCount-1]) {
               translate([(combWidth*.5+combSeperation*.5)*(j%2),0,0]){
               translate([i*(combWidth+combSeperation),0,0]){
                  hollowHexagon(thickness,combWidth,combSeperation/2);
               } 
               }
            
            }
        }
    
    }
    
    
    
}