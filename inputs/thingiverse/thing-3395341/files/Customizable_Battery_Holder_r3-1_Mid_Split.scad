//Battery Holder Test File
//Uses trig to calculate offsets and hence should be scaleable easily



/*[Parameters]*/
//Battery Dimensions

//Battery Diameter AAA=10.5 AA=14.5
BD=14.5;
//Battery Length AAA=44.5 AA=50.5
BL=50.5;

//Holder Configuration

//Number of layers in holder - each layer is there and back
Q=6; //[1:10]

//How long to make each run - the diameter of the returns is added to this figure AAA=25 and AA=35 worked on my test prints
L=35; //[25:200]

//Which half to produce - you need both to stick together
part=1; //[0:First Part,1:Second Part]

//Wall Thickness - how thick do you want the walls to be, suggest 1.5mm changing this may have odd effects
WT=1.5; //[1:0.25:3]

//Angle of ramps only tested at 5 degrees!
Ang=5; //[3:30]


$fn=64; //[25:150]

/*[Hidden]*/

//Variables - edit here to configure how you want you holder to be
W=(BL+(2*WT)+2); //Width of each run add on 2xwalls thickness and 2mm tollerance
H=(BD+(2*WT)+2); //Height of each run add 2xWall Thickness plus 2mm as above
//AAA= 10.5mm dia 44.5mm long



//Trig Calcs

function Off_HL()=(H*sin(Ang)); //Offset for LHS
function Off_HR()=((L*cos(Ang))-(H*sin(Ang))); //Offset for RHS
function Off_VL(N)=((N+1)*(L*sin(Ang)))+(N*(H*cos(Ang))); //Vert OS for LHS
function Off_VR(N)=N*((L*sin(Ang))+(H*cos(Ang))); //Vert offset for RHS to be multiplied by blocks
function R()=(H); //Radius to make joint spheres
function Drop(N)=(N*(sin(Ang)));
function OW()=(2*R())+(L*cos(Ang));

// Doing part
difference(){
    union(){
    for(i=[1:Q]){
        Do_Layer(i);
        Do_Sphere(i);
    }
    Do_Hopper(Q+1);
    Do_Base();
}
Trim(); //Trim off either lid or base depeding upon parameters
 }

//Modules

module Do_Layer(Z){
    //First layer from origin upwards
    difference(){
        translate([0,0,Off_VR((Z-1)*2)]) rotate([0,-Ang,0]) cube([L,W,H]);
        //Cut out centre
        translate([-3,WT,WT+Off_VR((Z-1)*2)-Drop(3)]) rotate([0,-Ang,0]) cube([L+6,W-(2*WT),H-(2*WT)]);
 
        }
    //Second layer running back to origin
    difference(){
        translate([-Off_HL(),0,Off_VL((Z*2)-1)]) rotate([0,Ang,0]) cube([L,W,H]);
        //Cut out center
    translate([-Off_HL()-1,WT,WT+Off_VL((Z*2)-1)+Drop(2)]) rotate([0,Ang,0]) cube([L+6,W-(2*WT),H-(2*WT)]);
        
    }
}

module Do_Sphere(X){
    
    if(X!=1) {
        difference(){
        translate([0,0,Off_VR((X-1)*2)]) rotate([-90,0,0]) cylinder(r=R(),h=W);
            //Carve out internals
        translate([0,WT,Off_VR((X-1)*2)]) rotate([-90,0,0]) cylinder(r=(R()-WT),h=(W-(WT*2)));    
  
            //Clear out battery paths
         translate([-Off_HL(),WT,WT+Off_VL(((X-1)*2)-1)]) rotate([0,Ang,0]) cube([L+1,W-(WT*2),H-(WT*2)]);
 
            translate([-1,WT,WT+Off_VR((X-1)*2)]) rotate([0,-Ang,0]) cube([L+3,W-(2*WT),H-(2*WT)]);
            
        }
    translate([0,0,Off_VR((X-1)*2)]) rotate([-90,0,0]) cylinder(r=WT,h=W);

     translate([Off_HR(),((W/2)-4),Off_VR((2*X)-1)]) rotate([-90,0,0]) cylinder(r=WT-0.075,h=8);
        }
    
    //Other side
        
        difference(){
    translate([Off_HR(),0,Off_VR((2*X)-1)]) rotate([-90,0,0]) cylinder(r=R(),h=W);
    //Carve out cylinder
    translate([Off_HR(),WT,Off_VR((2*X)-1)]) rotate([-90,0,0]) cylinder(r=R()-(WT),h=W-(2*WT));
                    //Clear out battery paths
         translate([-Off_HL(),WT,WT+Off_VL(((X)*2)-1)]) rotate([0,Ang,0]) cube([L+1,W-(2*WT),H-(2*WT)]);
 
            translate([-1,WT,WT+Off_VR((X-1)*2)]) rotate([0,-Ang,0]) cube([L+3,W-(2*WT),H-(2*WT)]);
 
        }
    translate([Off_HR(),0,Off_VR((2*X)-1)]) rotate([-90,0,0]) cylinder(r=WT,h=W);
}

module Do_Hopper(Z){
    //First layer from origin upwards
    difference(){
   union(){
    //Hopper Box
        translate([0,0,Off_VR((Z-1)*2)]) rotate([0,-Ang,0]) cube([L+2*R(),W,(H)]);

   }
        //Carve out main hopper
        translate([0,WT,WT+Off_VR((Z-1)*2)]) rotate([0,-Ang,0]) cube([2*R()+L,W-(2*WT),(2*(H+WT))]); 

   
        //Add way through for batteries
        translate([-2,WT,(WT-Drop(2))+Off_VR((Z-1)*2)]) rotate([0,-Ang,0]) cube([(2*WT),W-(2*WT),H-(2*WT)]);
         
    //Trim back to fit wall (hopper box would othersie extend back, done for higher ramp angles)
           translate([((L+R())*cos(Ang)),-0.1,Off_VR((Z-1)*2)+((L+R())*sin(Ang))]) cube([(200*WT),W+0.2,(25*H)]);
   
        }
//Add back plate and screw holes for wall fixing
difference(){        
     //Back section to tie to wall
        translate([((L+R())*cos(Ang))-(2*WT),0,Off_VR((Z-1)*2)+((L+R())*sin(Ang))]) cube([(2*WT),W,(1.25*H)]);
    
        //screw holes
        translate([((L+R())*cos(Ang))-5,(W*.66666),Off_VR((Z-1)*2)+((L+R())*sin(Ang))+(H*.75)]) rotate([0,90,0]) cylinder(r=2.5, h=20);
   translate([((L+R())*cos(Ang))-5,(W*.33333),Off_VR((Z-1)*2)+((L+R())*sin(Ang))+(H*.75)]) rotate([0,90,0]) cylinder(r=2.5, h=20);
    }        
        //Connecting cylinder
            if(Z!=0) {
        difference(){
        translate([0,0,Off_VR((Z-1)*2)]) rotate([-90,0,0]) cylinder(r=R(),h=W);
            //Carve out internals
        translate([0,WT,Off_VR((Z-1)*2)]) rotate([-90,0,0]) cylinder(r=(R()-(WT+0.5)),h=(W-(WT*2)));    
  
            //Clear out battery paths
         translate([-Off_HL(),WT,WT+Off_VL(((Z-1)*2)-1)]) rotate([0,Ang,0]) cube([L+1,W-(WT*2),H-(WT*2)]);
 
            translate([-1,WT,(WT+Off_VR((Z-1)*2))-Drop(1)]) rotate([0,-Ang,0]) cube([L+3,W-(2*WT),H-(2*WT)]);
            

        }
    translate([0,0,Off_VR((Z-1)*2)]) rotate([-90,0,0]) cylinder(r=WT,h=W);
        }
}


module Do_Base(){
    function Top_Cut()=(1.25*BD)+(3*WT); //How much top to cut away for battery removal
    function Out_Length()=R()+(3*WT)+BD; //How long to make the outlet tube so it is clear of the main body
    function Out_X()=Out_Length()*cos(Ang); //How far in X axis to move for hopper length
    
     //First layer from origin upwards
    difference(){
        translate([-Out_X(),0,-Drop(Out_Length())]) rotate([0,-Ang,0]) cube([Out_Length(),W,H]);
        //Cut out centre
        translate([(2*WT)-Out_X(),WT,WT-Drop((Out_Length()-(2*WT/cos(Ang))))]) rotate([0,-Ang,0]) cube([Out_Length()-(2*WT),W-(2*WT),H-(2*WT)]);
 
        //Cut out end at half battery diameter
        translate([-Out_X()-(H*sin(Ang)),-0.1,(H/2)-Drop(Out_Length())]) rotate([0,-Ang,0]) cube([Top_Cut()+WT,W+0.2,(H/2)]);

        //Cut out Top and sides for battery removal
        translate([-(Out_X()),WT,H-WT-Drop(Out_Length())]) rotate([0,-Ang,0]) cube([Top_Cut(),W,(3*WT)]);
        
        //Cut out to aid battery removal
        
        hull(){
            translate([-Out_Length(),(W/2),-H]) cylinder(r=(W/4), h=(H*3));
            translate([BD-Out_Length(),(W/2),-H]) cylinder(r=(W/4), h=(H*3));
        }

        }
        //Add a stand
        //Put the stand in the correct place
        difference(){
        translate([((L*cos(Ang))+R())-(2*WT)-(H*sin(Ang)),0,-Drop(Out_Length())]) cube([(2*WT),W,((L+Out_Length())*sin(Ang))+H]);
            //recut the inner sphere to clear battery path
             //Carve out cylinder
    translate([Off_HR(),WT,Off_VR((1))]) rotate([-90,0,0]) cylinder(r=R()-(WT),h=W-(2*WT));
        }
    }
    
    
    
module Trim(){
    
//Cut off either main body (to give lid) or lid (to give body) including protrusion to act for location
    
if((part==1)){
   translate([-(3.5*R())-.01,(W/2),-90]) cube([(4*R())-5,W,1000]);
   translate([(R())+5,(W/2),-90]) cube([(2*OW())-5,W,1000]);
   translate([-(R())+0.1,(W/2)+5,-90]) cube([(2*OW())-5,W,1000]);
}

if((part==0)){
    //translate([-(55+L),-1,-100]) cube([8*L,(W/2)+1,1000]);
    
   translate([-(3.5*R()),-0.1,-90]) cube([(4*R())-5,(W/2)+0.1,1000]);
   translate([(R())+5,-0.1,-90]) cube([(2*OW())-5,(W/2)+0.1,1000]);
   translate([(0.5*R())-5,-0.1,-90]) cube([(0.5*R())+10,(W/2)+5.1,1000]);
 }     

//Front cutout to see batteries and clear blockages 

translate([-(W/2.5),(W/2),H]) cylinder(r=(W/4), h=(H*Q*8));
    
}

module Pegs(){ //Not used in center split design
    
if((part!=1)){    
    //use rounding cylinders as locating pegs)
    for(X=[1:Q]){
    //main run smaller peg that mates with other side
%    translate([Off_HR(),((W/2)-4),Off_VR((2*X)-1)]) rotate([-90,0,0]) cylinder(r=WT-0.075,h=8);
       
    if((X!=1)){ //do not put a peg in the base!
%        translate([0,((W/2)-4),Off_VR((X-1)*2)]) rotate([-90,0,0]) cylinder(r=WT-0.075,h=8);
    }
     }
 %   translate([0,((W/2)-4),Off_VR((Q)*2)]) rotate([-90,0,0]) cylinder(r=WT-0.075,h=8); //Final hole for hopper
 }
 }
    