//Hex bolt socket design
//Measuremesnts in mm'

//Ratchet sqaure drive size
S=6;

// Socket Depth
D=15;

// Fastener Head size
H=10;

//Resolution of outer socket layer 
$fn=50;


   module Socket(){
 difference(){
 difference(){
 //Socket outer body
cylinder(h=D+S, r=1.25*H, center=true);
 //Socket inner hex
translate (v=[0,0,-(S/2)-(D/2)]) cylinder($fn=6,h=D, r=H, center=false);     
     //Head and cap
 }
 //Remove square for ratchet drive
  translate (v=[-(S/2),-(S/2),(D/2)-(S/2)]) cube([S,S,S+1],center=false);          
 }} 
      Socket();