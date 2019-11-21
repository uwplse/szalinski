
z_scale=0.25;//[0.1:0.1:5] 
low_limit=-10;//[-30:0.5:0] 
high_limit=10;//[0.1:0.5:30] 
amplitude=2;//[0.5:0.5:5]

quality=10;//[1:1:10]
qq = (11 - quality)/100;

r = amplitude/100;



for (v=[low_limit:qq:high_limit]){
    hull(){
    translate([amplitude*cos(v*57),amplitude*sin(v*57), z_scale*v])
    sphere(r);
        translate([0,0,z_scale*v])
        sphere(r);
        }}
    //Made by Sergo1999
        
        echo(quality, qq);