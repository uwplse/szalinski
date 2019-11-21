//Rev 1.1 3 May 2015
//Coded by Siti
//Use as you like, but give credit where credit is due.

//Height of pulley
height=25;
//Overall Diameter of pulley
OD=50;
//Bearing Overall Diameter
Bearing_OD = 22;
Bearing_Flange_ID = Bearing_OD-4;
//Bearing thickness.
Bearing_Thickness = 7;
//thickness of bearing support
catchthickness= height/2-Bearing_Thickness/2;
fudge=0.01*1;//fudge factor to avoid 0 thickness walls.
//Polygon count.
Polygon_Count=128;//[32:low, 64:Medium, 128:high, 256:Insane]
$fn=Polygon_Count*1;
//Diameter of curve at bottom of V
V_Groove_OD=5;
//Depth of groove.
V_Depth = 10;
//depth of V groove without radius subtracted
Vdeep = V_Depth+sqrt(2*V_Groove_OD/2*V_Groove_OD/2)-V_Groove_OD/2;
//length of side of square required for V cutout
squareside = sqrt(2*(Vdeep)*(Vdeep));
difference(){
    //basic pulley shape
    
cylinder(h=height, d=OD, center=true);
      
    //items to subtract
    union(){
        
         //top cone cutout
       translate([0,0,Bearing_Thickness/2+(height/2-Bearing_Thickness/2)/2+1]) 
        cylinder(h=height/2-Bearing_Thickness/2+fudge, r1=Bearing_OD/2,r2=Bearing_OD/2+(height/2-Bearing_Thickness/2)/2, center=true);
         //bottom cone cutout
       translate([0,0,-Bearing_Thickness/2-(height/2-Bearing_Thickness/2)/2-3]) 
        cylinder(h=height/2-Bearing_Thickness/2+fudge, r2=Bearing_Flange_ID/2,r1=Bearing_Flange_ID/2+(height/2-Bearing_Thickness/2)/2, center=true);
     //vrotation
        translate([0,0,catchthickness])cylinder(h=height, d=Bearing_OD, center=true);
                cylinder(h=height+fudge, d=Bearing_Flange_ID, center=true);
        //groove cutout
     rotate_extrude(convexity=10)
        difference(){
            //V cutout
            translate([OD/2,0,0]) rotate([0,0,45])
       square ([squareside,squareside],center = true);
     
        
        //radius of V groove 
        translate ([OD/2+sqrt(2*V_Groove_OD*V_Groove_OD)/2-sqrt(2*squareside*squareside)/2,0,0])rotate([0,0,135])difference(){
            translate([V_Groove_OD/2,V_Groove_OD/2,0])
            square ([(V_Groove_OD-fudge),(V_Groove_OD-fudge)],center = true);
            
               circle(d=V_Groove_OD,center = true);
        }}
     
    }
}