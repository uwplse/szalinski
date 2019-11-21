//This is a fix for loading filament for some PTFE couplers
//
//While on the CR-10 I have no issues in loading, on the Ender 3 shipped ATM seems to be a different kind of coupler which makes almost impossible to push through, despite filament being cut (two ways) properly, twisted, so on.., so I designed this very tiny thing :) which guides the filament better.
//
//Print it at 0.04, you might need to scale it to fit perfectly, with no play in the threaded hole, if it not fits already, then the coupler will push it when screwing in.
//
//Take care to mount it in proper direction in between the extruder cover and PTFE coupler as shown in image where the fix is pictured in green in thingiverse page.
//
//Have better time in loading now..:)

// published at
// https://www.thingiverse.com/thing:3654254



// Edit the part between the scissors 
// ------8<------------------------

// The height of the fix, needs to fill the gap between the end of the coupler's thread and end of the extruder's threaded hole.
TubeHeight=2; 

// The interior diameter the extruder's threaded hole.
TubeDiam=5.2;

// The diameter of the hole toward the extruder,  needs to be a bit larger than the hole from gear where the filament enters for filament to pass through with ease.
ExtruderHoleDiam=4.8;

// The diameter of the hole toward the coupler needs to be the same or a bit smaller than the diameter of the brass hole, for filament to pass through with ease.
CouplerHoleDiam=1.9;

// Details of the thing, a large number will require more polygons and computational power. 
Details=50;

// ------8<------------------------


difference() {
cylinder(h = TubeHeight, r1 = (TubeDiam-0.1)/2, r2 = (TubeDiam-0.1)/2, center = true/false, $fn = Details);
cylinder(h = TubeHeight, r1 = CouplerHoleDiam/2, r2 = ExtruderHoleDiam/2, center = true/false, $fn = Details);
}