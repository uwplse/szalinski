//rolling pin is default value
//alt value wide teeth is wide cut
//alt both wide&narrow is narrow cut

//  wide noodle teeth
wide_noodle_teeth=1;

//  narrow noodle teeth
narrow_noodle_teeth=1;

translate ([-25,70,40]) rotate ([90,18.3,0])
union () {union () {
// below is roller
difference (){cylinder (140,40,40);translate ([0,0,-1])cylinder (162,20,20);}

// below is wide noodle cutters
scale ([wide_noodle_teeth,wide_noodle_teeth,1]) difference (){cylinder (4,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([wide_noodle_teeth,wide_noodle_teeth,1]) translate ([0,0,40])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([wide_noodle_teeth,wide_noodle_teeth,1]) translate ([0,0,60])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([wide_noodle_teeth,wide_noodle_teeth,1]) translate ([0,0,80])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([wide_noodle_teeth,wide_noodle_teeth,1]) translate ([0,0,100])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([wide_noodle_teeth,wide_noodle_teeth,1]) translate ([0,0,120])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([wide_noodle_teeth,wide_noodle_teeth,1]) translate ([0,0,136])difference (){cylinder (4,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([wide_noodle_teeth,wide_noodle_teeth,1]) translate ([0,0,20])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

// below adds thin noodle cutters
scale ([narrow_noodle_teeth,narrow_noodle_teeth,1]) translate ([0,0,10])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([narrow_noodle_teeth,narrow_noodle_teeth,1]) translate ([0,0,30])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([narrow_noodle_teeth,narrow_noodle_teeth,1]) translate ([0,0,50])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([narrow_noodle_teeth,narrow_noodle_teeth,1]) translate ([0,0,70])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([narrow_noodle_teeth,narrow_noodle_teeth,1]) translate ([0,0,90])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([narrow_noodle_teeth,narrow_noodle_teeth,1]) translate ([0,0,110])difference (){cylinder (2,40,40);translate ([0,0,-1])cylinder (162,30,30);}

scale ([narrow_noodle_teeth,narrow_noodle_teeth,1]) translate ([0,0,133])difference (){cylinder (4,40,40);translate ([0,0,-1])cylinder (162,30,30);}

// below is axle
translate ([0,0,-15]) cylinder (170,18,18); 
translate ([0,0,-15]) sphere(18);
translate ([0,0,155]) sphere(18);

//below is handle number one
rotate ([0,0,60]) union (){translate ([0,-7.5,-15]) cube ([70,15,10]);
translate ([70,0,-15]) cylinder (30,18,18); 
translate ([70,0,-15]) sphere(18);
translate ([70,0,15]) sphere(18);}

//below is handle number two
translate ([0,-7.5,150]) cube ([70,15,10]);
translate ([70,0,120]) cylinder (30,18,18); 
translate ([70,0,150]) sphere(18);
translate ([70,0,120]) sphere(18);
}
}
