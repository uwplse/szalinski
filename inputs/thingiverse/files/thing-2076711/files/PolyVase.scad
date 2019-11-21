/*
	Tjark's low poly random sinus vase
	A parametric Vase with random cornercount per layer. Actually this model isn't a hollow body. You have to configure your 3D-slicer to "vase mode". Play around with the given parameters.
	Author: Tjark alias Shark
	Contact: www.thingiverse.com/SharkNado
	
	License: Public domain - do whatever you want (just please dont claim you made it)
    
    Version: 0.1	
*/

//Layers
layers = 15;  // [2:200]

//Layerheight
layerHeight = 7;

//Radius Offset
radiusOffset = 50;

//Amplitude
amp = 20;

//Random Seed
randSeed = 3;

//Rotation per layer
rotateZ=42;

//Phase Shift
phase = 0;

//Minimum Edges
minEdges = 5; //[3:100]

//Maximum Edges
maxEdges = 10; //[3:100]





fns=rands(minEdges,maxEdges,layers+1,randSeed);



for(h=[0:layers-1]){
    rgb(100/layers*(layers-h),20,100/layers*h)hull(){
        rotate([0,0,h*rotateZ]){
            translate([0,0,layerHeight*h])cylinder(d=dynamicRadius(h),h=0.1,$fn=fns[h]);
        }
        rotate([0,0,(h+1)*rotateZ]){
            translate([0,0,layerHeight*(h+1)]){
                cylinder(d=dynamicRadius(h+1),h=0.1,$fn=fns[h+1]);
            }
        }
       
    }
}
module rgb(r,g,b){
    color([r/100,g/100,b/100])children();
}

function dynamicRadius(h) = sin((h-1+phase)/(layers/2)*180)*amp+radiusOffset;