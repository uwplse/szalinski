height = 5;
slope = 3.5;
clipWidth = 10;

trueHeight = height + 1;
draftHeight = trueHeight - slope;



linear_extrude(height = clipWidth) {
    polygon(points = [  [0,0],
                        [24,0],
                        [24,2], 
                        [4,2],
                        [4,2 + trueHeight], //2+6=8
                        [25,2 + draftHeight], 
                        [25,2 + draftHeight + 2.5], 
                        [0,2 + trueHeight + slope ] 
                       ]);

}
                    