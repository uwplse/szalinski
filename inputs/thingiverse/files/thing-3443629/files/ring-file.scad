
//parameters

amplitude = 1*1; 

number_of_rings = 4; 

thickness_of_ring = 1; 

RingSize = 15;

ringDiameter = RingSize + amplitude + thickness_of_ring/2;  



//ring size chart inputs
// US size 5 = 15
// US size 6 = 16
// US size 7 = 18
// US size 8 = 20
// US size 9 = 22

numTheta = PI*(ringDiameter+4*amplitude+4*thickness_of_ring)/thickness_of_ring; 

$fn = 16*1; 

//renders

    twistyring (r=ringDiameter, n=number_of_rings);

//modules

module twistyring (r,n) {
        for(t = [0:numTheta], k = [0:number_of_rings-1]) 

{ 

hull() 

     { 
         //first slice 

rotate(t*360/numTheta, [0, 0, 1]) 

translate([ringDiameter/2, 0, 0]) 

rotate(-360/numTheta*number_of_rings*amplitude*cos(t*360/numTheta*number_of_rings-k*360/number_of_rings), 
[0, 0, 1]) 

translate([0, 0, amplitude*cos(t*360/numTheta*number_of_rings-k*360/number_of_rings)]) 

rotate(90-360/numTheta*number_of_rings*amplitude*sin(t*360/numTheta*number_of_rings-k*360/number_of_rings), 
[1, 0, 0]) 

translate([amplitude*sin(t*360/numTheta*number_of_rings-k*360/number_of_rings), 0, 0]) 

cylinder(d=thickness_of_ring, h = 0.1, center = true); 


         //second slice 

rotate((t+1)*360/numTheta, [0, 0, 1]) 

translate([ringDiameter/2, 0, 0]) 

rotate(-360/numTheta*number_of_rings*amplitude*cos((t+1)*360/numTheta*number_of_rings-k*360/number_of_rings), 
[0, 0, 1]) 

translate([0, 0, amplitude*cos((t+1)*360/numTheta*number_of_rings-k*360/number_of_rings)]) 

rotate(90-360/numTheta*number_of_rings*amplitude*sin((t+1)*360/numTheta*number_of_rings-k*360/number_of_rings), 
[1, 0, 0]) 

translate([amplitude*sin((t+1)*360/numTheta*number_of_rings-k*360/number_of_rings), 0, 0]) 

cylinder(d=thickness_of_ring, h = 0.1, center = true); 

     } 

}

}
