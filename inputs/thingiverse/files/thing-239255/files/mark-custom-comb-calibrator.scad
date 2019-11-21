//make a calibration comb any size you want
//for checking slicer and printer settings
//mark peeters 2-1-2014

/* [calibration comb settings] */
//smallest tooth width (mm)
start_w=0.2;
//largest tooth (mm)(not exact but close)
end_w=1;
//tooth width increments(mm)
step_w=.05;
//space between teeth(mm)
spacing=1;
//tooth length(mm)
comb_l=5;
//tooth height(mm)
comb_h=.6;
//solid comb base height(mm)
base=2;


echo("total mm length of comb is",(end_w/step_w+1)*(end_w/2)+(spacing*end_w/step_w));

//make the base
cube([(end_w/step_w+1)*(end_w/2)+(spacing*end_w/step_w),base,comb_h]);

//make the teeth
for (i = [0:step_w:end_w]) {
//echo("tooth # is now",1+i/step_w);//for debug
//echo("tooth W is now",start_w+i);//for debug
translate([(i/step_w+1)*(i/2)+(spacing*i/step_w),0,0])cube([start_w+i,comb_l,comb_h]);
}

