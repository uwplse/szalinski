// by Les Hall
// started 4-16-2014


/* [Details] */

// extent of array
size = [3, 3, 3];

// 1 for hexagonal, 0 for orthogonal
hexagonal = 1;  // [0:1]

// number of separate threads
threads = 2;  // [1:9]

// number of loops per thread
periods = 3;  // [1:9]

// diameter of hole inside Mobius rings (mm)
insideDiameter = 8;  // [0:32]

// size of each loop (mm)
amplitude = 8;

// thickness of wire (mm)
minDetail = 2;

// number of steps per thread
numTheta = 64;  // [32:256]

// number of sides
$fn = 8;  // [3:16]



/* [Hidden] */
ringDiameter = insideDiameter + 2*amplitude + minDetail;
spacing = [ringDiameter+amplitude, ringDiameter+amplitude, 1.25*amplitude];


// the whole structure
for(x=[0:size[0]-1], y=[0:size[1]-1], z=[0:size[2]-1])
translate([spacing[0]*(x + hexagonal*(pow(-1, y+1)+1)*cos(60)/2), spacing[1]*y*(1*(1-hexagonal)+hexagonal*sin(60)), spacing[2]*z])
rotate(-z*360/threads/periods, [0, 0, 1])
wovenRing();


// one Mobius Ring
module wovenRing()
{
	for(t = [0:numTheta-1], k = [0:threads-1])
	hull()
   {
		slice(0, numTheta, periods, threads, ringDiameter, amplitude, t, k);
		slice(1, numTheta, periods, threads, ringDiameter, amplitude, t, k);
	}
}


//one slice
module slice(offset, numTh, numT, thr, Dia, amp, t, k)
{
	rotate((t+offset)*360/numTh, [0, 0, 1])
	translate([Dia/2, 0, 0])
	rotate(numT*(t+offset)*360/numTh-k*360/thr, [0, 1, 0])
	translate([amp, 0, 0])
	rotate(90, [1, 0, 0])
	cylinder(d=minDetail, h=minDetail, center = true);
}


