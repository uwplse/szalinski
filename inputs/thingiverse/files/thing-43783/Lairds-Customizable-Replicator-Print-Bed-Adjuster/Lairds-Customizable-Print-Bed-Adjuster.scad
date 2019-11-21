// Customizable Replicator Bed Adjustment Clip

// How long a clip do you need, in mm? (50 fits Replicator)
len = 50*1;
// How much do you want the clip to lower the Replicator print bed?
height=5;
// How thick should the clip "wings" be?
t=1*1;
// How much should the "wings" stick up?
tail=10*1;
// How thick is the board it clips around, plus a little clearance?
around=7*1;	

width=around+2*t;

translate([-len/2,-width/2,0]) 
difference() {
	cube([len,width,height+tail]);
	translate([-1,t,height]) cube([len+2,around,tail+1]);
	}