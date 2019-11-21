/////////////////////////////////////
//Plant Pot Lid 
//Created by James Eckert  10/5/2017
//http://www.jeplans.com
///////////////////////////////

//CUSTOMIZER VARIABLES

PlanterDiameter=126;    //mm
PlantHoleDiameter=40;   //mm
Hexsize=6;              // [6,7,8,9,10,11,12]
Which_Side="left";      // [right,left] 
Edge_Thickness=1.6;     //mm
Edge_Lip=8;             //mm
MeshThickness=1;        //mm

//CUSTOMIZER VARIABLES END


$fn=90; 



difference() {

union(){

    //Outer lip/edge
    translate(v = [0, 0, Edge_Lip/2]) { 
        difference() {

            minkowski() {
                cylinder(Edge_Lip-3, (PlanterDiameter/2)+Edge_Thickness, (PlanterDiameter/2+Edge_Thickness),  true);
                sphere(1.5);
            }
            cylinder(Edge_Lip*3, PlanterDiameter/2, PlanterDiameter/2,  true);
        }
    }
    
    //Inner Ring
    translate(v = [0, 0, Edge_Lip/4]) { 
        cylinder(Edge_Lip/2, (PlantHoleDiameter/2)+Edge_Thickness, (PlantHoleDiameter/2+Edge_Thickness),  true);
    }
    
    // Mesh Grate
    //figure out offsets
     startnum=-(PlanterDiameter/2); 
     numsteps=ceil(((PlanterDiameter/2+Hexsize*2)+(PlanterDiameter/2))/(Hexsize*2));
     endnum=((numsteps-1)*(Hexsize*2))+startnum;
     xstartnum=-(PlanterDiameter/2);
     xnumsteps=ceil(((PlanterDiameter/(Hexsize+(Hexsize/2))))/2);
     xendnum=(Hexsize*2*1.7*(xnumsteps-1))+xstartnum;
     xoffset=-(xendnum+xstartnum)/2;
     yoffset=-(endnum+startnum)/2;
    
  
    difference() {
        cylinder(MeshThickness, (PlanterDiameter/2)+Edge_Thickness, (PlanterDiameter/2+Edge_Thickness),  false);

        linear_extrude(height = MeshThickness*3, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0){
     
           xpos=Hexsize;
             for(cclplmt = [0-((PlanterDiameter/2)) : Hexsize*2 : PlanterDiameter/2+Hexsize*2]) {
                 
              for (xstep=[ 0 : 2 :(PlanterDiameter/(Hexsize+(Hexsize/2))) ]) {
                  //echo ( xoffset+((xpos*(0+xstep))*1.7)-(PlanterDiameter/2));
                   translate(v= [ xoffset+((xpos*(0+xstep))*1.7)-(PlanterDiameter/2) ,yoffset+cclplmt]) circle(Hexsize, $fn=6);	
                   translate(v= [ xoffset+((xpos*(1+xstep))*1.7)-(PlanterDiameter/2) ,yoffset+cclplmt+Hexsize]) circle(Hexsize, $fn=6);
                  
              }
                 

             }
        }
    }
    
 difference() {
    //Middle rib
    translate(v = [0, 0, Edge_Lip/2]) { 
        cube([Edge_Thickness*2,PlanterDiameter+10+PlanterDiameter/12,Edge_Lip],true);
        }
        translate(v = [0, 0, Edge_Lip]) { 
        cylinder(Edge_Lip, PlanterDiameter/2, PlanterDiameter/2,  true);
    }

    translate(v = [0, 0, MeshThickness-Edge_Lip/2]) { 
        difference() {
            translate(v = [0, 0, Edge_Lip]) { 
            cylinder(Edge_Lip, PlanterDiameter/2, PlanterDiameter/2,  true);
            }
            translate(v = [0, 0, Edge_Lip]) { 
            cylinder(Edge_Lip+2, PlanterDiameter/2-(PlanterDiameter/9), PlanterDiameter/2-(PlanterDiameter/9),  true);
            }
        }
    }

    translate(v = [0, PlanterDiameter/2-(PlanterDiameter/9)-12, MeshThickness]) { 
        rotate(a=[90,0,90]) {
            linear_extrude(height = Edge_Thickness*3, center = true, convexity = 10, twist = 0){
             polygon(points=[[10,0],[12,0],[12,Edge_Lip/2],[0,Edge_Lip/2]]);
            }
        }
    }

    translate(v = [0, -(PlanterDiameter/2-(PlanterDiameter/9)-12), MeshThickness]) { 
        rotate(a=[90,0,-90]) {
            linear_extrude(height = Edge_Thickness*3, center = true, convexity = 10, twist = 0){
             polygon(points=[[10,0],[12,0],[12,Edge_Lip/2],[0,Edge_Lip/2]]);
            }
        }
    }

}
    
}
// Cut out center
cylinder(Edge_Lip*3, PlantHoleDiameter/2, PlantHoleDiameter/2,  true);

if (Which_Side=="left") {
translate(v = [((PlanterDiameter+Edge_Thickness*2)/4)+2, 0, Edge_Lip/2]) { 
    cube([((PlanterDiameter+Edge_Thickness*2)/2)+4,PlanterDiameter+(PlanterDiameter/5)+4,(Edge_Lip*2)],true);
    
}
} else {
translate(v = [-(((PlanterDiameter+Edge_Thickness*2)/4)+2), 0, Edge_Lip/2]) { 
    cube([((PlanterDiameter+Edge_Thickness*2)/2)+4,PlanterDiameter+(PlanterDiameter/5)+4,(Edge_Lip*2)],true);
}
}
}


module Clips(Cheight){  // Create Clips
    difference(){
        cube([Edge_Thickness*2+3.4,Cheight+4,3],true);

        union(){
        cube([Edge_Thickness*2+.4,Cheight+.4,5],true);

        rotate([0,0,45]) {
            translate([Cheight*.34,Cheight*.34,0]){
                triangle_points =[[0,0],[Edge_Thickness*2+.6,0],[0,Edge_Thickness*2+.6]];
                 triangle_paths =[[0,1,2]];
                 linear_extrude(height = 6, center = true, convexity = 10, twist = 0)
                 polygon(triangle_points,triangle_paths,10);
                }
            }
        }
    }
}



if (Which_Side=="left") {
    xclipos=(Edge_Thickness*2+2)*2;
    translate([xclipos,0,0]){
        translate([-(Edge_Thickness*2+2),0,1.5]){
            Clips(Edge_Lip);
        }
        translate([(Edge_Thickness*2+2),0,1.5]){
                Clips(Edge_Lip/2);
        }
    }
} else {
    xclipos=-(Edge_Thickness*2+2)*2;
    translate([xclipos,0,0]){
        translate([-(Edge_Thickness*2+2),0,1.5]){
            Clips(Edge_Lip);
        }
        translate([(Edge_Thickness*2+2),0,1.5]){
                Clips(Edge_Lip/2);
        }
    }

}