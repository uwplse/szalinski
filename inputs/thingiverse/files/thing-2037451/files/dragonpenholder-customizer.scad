/*

Phyllotaxis III: Dragon penholder

Fernando Jerez 2016

*/

// Phyllotaxis angle 
angle = 137.51;

// Pattern #1
pattern1 = "bulb"; // [bulb:Bulb, spike:Spike]
// Pattern #2
pattern2 = "spike"; // [bulb:Bulb, spike:Spike]

// Draw one Pattern #2 every N steps
pattern2_every = 3;

// For spikes: Set scale factor
spikes_scale = 1;


// For bulbs: Set top decoration
bulb_type="flat"; // [hole:Hole, ball:Ball, flat:Flat ]


/* [Hidden] */

$fn = 16;
c = 3;
num = 350;
phy = angle;

difference(){
union(){
    translate([0,0,-c*15]) cylinder(r1=42,r2=40,h=c*30,$fn=30);
    for(i=[0:num]){
        //r = c*sqrt(i);
        r = 40;//15*sin(i*0.25);
        z = c*15*cos(i*0.5);
        gy = 30;//90*cos(i*0.5);
        
        sx = c*(0.3+2*abs(sin(i*0.25)));
        sy = sx;
        sz = sx;
        
        rx = 0;
        ry = 0;//i*0.25;
        rz = phy*i;
        translate([0,0,z])
        rotate([rx,0,rz]){
            translate([r,0,0]){

                    scale([sx,sy,sz]){
                            rotate([0,90-gy,0]){
                        
                                if(i%pattern2_every==0){
                                    // Pattern 2  
                                    if(pattern2=="spike"){
                                        spike(i);
                                    }else{
                                        bulb(i);
                                    }
                                    
                                }else{
                                    // pattern 1
                                    if(pattern1=="spike"){
                                        spike(i);
                                    }else{
                                        bulb(i);
                                    }
                                }
                    }
                }
            }
        }
         
    }

}

translate([0,0,-c*25]) cylinder(r=80,h=c*10);
translate([0,0,c*15]) cylinder(r=80,h=c*10);
translate([0,0,-c*15 + 5]) cylinder(r=37,h=c*30,$fn=30);

}

// some modules for geometry
module spike(i){
    z = 1+(spikes_scale/5)*sqrt(i/num);
    scale([1,1,z])
    color("orange")
    
    cylinder(r1=c*0.75, r2 = c*0.1, h = c);
}


module bulb(i){
    rotate([0,20,0]){
    difference(){
        cylinder(r1=c*0.8,r2 = c*0.3, h = c*0.5,$fn=15);

        if(bulb_type=="hole"){
            translate([0,0,c*0.2])
            cylinder(r1=c*0,r2=c*0.3,h=c*0.5,$fn = 6);
            
        }
    
    }
    if(bulb_type=="ball"){
        translate([0,0,c*0.5])
        //cylinder(r1=c*0,r2=c*0.3,h=c*0.5,$fn = 6);
        sphere(r = c*0.25, $fn=10);
    }
    }
    

}

