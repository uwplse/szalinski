depth=3;
num_segments=4;

//  Snowflakes
//
// Always growing outwards at 60 degrees

module branch_shape(pos){
    y=pos[0];
    x=pos[1];
    union(){
        square([y,x]);
        polygon([
            [y/3,-x/6],
            [y*2/3,-x/6],
            [y*2/3,x+x/6],
            [y/3,x+x/6]
            ]);
    }
}


module snowflake(rec, tot_rec, length, width, shrink, seg_rand, branch_rand){
 

    if(rec>0 && length>1){
        //cube([1,length, width]);
        
        base_w=(rec==tot_rec)?width/2:width;
   
        rotate([-90,0,0])
            linear_extrude(height=length, scale=shrink)
                translate([-base_w/2, -width/2, 0])
                //square([base_w, width]); // width of branch, thickness of flake
                branch_shape([base_w, width]);
        
        for(segment=[1:num_segments]){
            threshold=segment/(num_segments+1);
            //echo(threshold);
            if(seg_rand[segment]<threshold){
                 translate([0, length*segment/num_segments,0]){    
                    
                    // Reduce length of branches the close they are to the center
                    new_scale=shrink*branch_rand[segment]*segment/num_segments;
                    //echo(rec, p);
                    snowflake(rec-1, tot_rec, length*new_scale, width*shrink, shrink,
                        seg_rand, branch_rand);
                    rotate([0,0,-60])
                        snowflake(rec-1, tot_rec, length*new_scale, width*shrink, shrink,
                        seg_rand, branch_rand);
                    rotate([0,0,60])
                        snowflake(rec-1, tot_rec, length*new_scale, width*shrink, shrink,
                        seg_rand, branch_rand);
                }  
             }
         }
    }
}


seg_rand=rands(0,.8,num_segments+1); 
branch_rand=rands(1,2,num_segments+1);

echo(seg_rand);
echo(branch_rand);

in=25.4;

//branch_shape([5,10]);

difference(){
    for(i=[0:5]){
        rotate([0,0,i*60])
            snowflake(rec=depth, tot_rec=depth, length=3/2*in, width=.5*in, shrink=.3, 
                seg_rand=seg_rand, branch_rand=branch_rand);
    }

translate([0,0,-1/2*in])
    cube([150,150,1*in], center=true);
}
