// Width of guide rod
width = 8;
// Lenght from motor holder and bearing block
lenght = 63;
// Thickness
thickness = 2;
// Gap between leveler and guide rod
gap=.3;
  
union() {
    translate([width/2+gap,0,0]) rotate([90,0,0]) linear_extrude(width) r();
    translate([-width/2-(thickness+gap),0,0]) rotate([90,0,0]) linear_extrude(width) r();
    //rotate_extrude(angle=180, convexity=20, $fn=100) translate([width/2+.2,0,0]) r();
    rotate([0,0,-90]) Tube_Sect(Height=lenght,Dout=(width+gap*2)+(thickness*2),Din=width+gap*2,StartAngle=0,EndAngle=180,Faces=50);
}

module r() {
    square([2,lenght]);
}

// thanks to jpmendes http://forum.openscad.org/This-seems-to-be-ultra-basic-I-cannot-have-the-rotate-extrude-angle-parameter-working-td15180.html
module Tube_Sect(Height,Dout,Din,StartAngle,EndAngle,Faces) { 
                        
        StartAngle= (StartAngle < 0) ? 360+StartAngle : StartAngle; 
        EndAngle= (EndAngle < 0) ? 360+EndAngle : EndAngle; 
        echo(StartAngle, EndAngle); 
        EndAngle2 =  (EndAngle < StartAngle) ? StartAngle : EndAngle; 
        StartAngle2 =  (EndAngle < StartAngle) ? EndAngle : StartAngle; 
        
        
        if (EndAngle2-StartAngle2<360){ 
        
                NSides= (Faces < 3 || Faces==undef)  ?  DefaultFaces : Faces; 
                n=floor((EndAngle2-StartAngle2)/120); 
                Sect1=EndAngle2-StartAngle2-n*120; 
                Sect2= (n>0) ? 120 : 0; 
                Sect3=(n>1) ? 120 : 0; 

         intersection(){ 
                rotate_extrude(, $fn=floor(NSides*360/(EndAngle2-StartAngle2))) 
                       translate([Din/2,0,0]) square([(Dout-Din)/2,Height]); 
                
                  union(){ 
                                hull(){ 
                                        rotate(StartAngle2) cube([0.001,Dout,Height+1]); 
                                        rotate((StartAngle2+Sect1)) cube([0.001,Dout,Height+1]); 
                                } 
                                        hull(){ 
                                        rotate((StartAngle2+Sect1)) cube([0.001,Dout,Height+1]); 
                                        rotate((StartAngle2+Sect1+Sect2)) cube([0.001,Dout,Height+1]); 
                                } 
                                        hull(){ 
                                        rotate((StartAngle2+Sect1+Sect2)) cube([0.001,Dout,Height+1]); 
                                        rotate((StartAngle2+Sect1+Sect2+Sect3)) cube([0.001,Dout,Height+1]); 
                                } 
                        }	
                } 
                } else { echo("Only rotations less than 360 degrees are supported");} 
                
}