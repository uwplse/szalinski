stump_height=40; //40
stump_width=6; //6
fractal_depth=5; //6
growth=.6; //.6
smoothness=20;

$fn=smoothness;


module anemone(pos, radius, height, steps, smoothness){
    incr=height/steps;
    //echo(incr);

    translate(pos){
        idx=0;
        x=0;
        y=0;
        for(i=[0:incr:height]){
            idx=i/incr;
            rand=rands(0,radius/1,2);
            //echo([x,y]);
            x=x+rand[0];
            y=y+rand[1];
            //echo([x,y]);
            translate([x,y,i])
                rotate([0,0,2*idx])
                    cylinder(h=incr, r=radius, $fn=smoothness);          
        }
    }
}

/*
s=50;
color("blue") anemone(pos=[0,0,0], radius=2, height=25, steps=s);
color("red") anemone(pos=[20,20,0], radius=3, height=25, steps=s);
color("green") anemone(pos=[0,20,0], radius=4, height=25, steps=s);
color("orange") anemone(pos=[20,0,0], radius=5, height=25, steps=s);
*/

module tree(pos, height, width, rec, split_range, degen, smoothness){
      
    if(rec>0){
        translate(pos){
            //cylinder(h=height, r1=width, r2=width*2/3);
            anemone(pos=[0,0,0], radius=width, height=height, steps=30, smoothness=smoothness);
                        
            splits=rands(split_range[0],(split_range[1]+1),1)[0];
             
            for(i=[1:splits]){
                d=rands(.5,1,1)[0];
                angle=-90*rands(.9,1.5,1)[0];
                
                translate([0,0,height])
                    rotate([angle,0,0])
                    rotate([30,i*360/splits,0])
                        tree(pos=[0,0,0], 
                            height=height*degen, 
                            width=width*degen,
                            rec=rec-1, 
                            split_range=split_range, 
                            degen=d,
                            smoothness=smoothness);
            }
            
        }
    }
}


for(i=[0:0]){
    for(j=[0:0]){
        tree(pos=[i*150,j*150,0], 
                height=stump_height, width=stump_width, 
                rec=fractal_depth, 
                split_range=[1,4], degen=growth,
                smoothness=smoothness);
    }
}


