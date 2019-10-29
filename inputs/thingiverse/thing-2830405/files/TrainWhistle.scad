///////////////////////////////////////////////////////////////////////////////////////////
// Train Whistle Plug (for like https://www.adventure-in-a-box.com/make-train-whistle/)
// Ryan Stachurski
// 2018-03-17
///////////////////////////////////////////////////////////////////////////////////////////
innerRadius = 29/2;
length      = 28;
cut         = 1/9; //(percent of whole along Z)
hexRad      = 14.3/2; //Radius of a circle touching every vertices along the hex cap bolt (5/16")
hexHeight   = 5;
$fn=50;   

difference(){
    
    union(){
        cylinder(h=length, r=innerRadius);
        cylinder($fn=6,h=length+hexHeight,r=hexRad);
    }//end union
    translate([innerRadius-(innerRadius*2*cut),-innerRadius,-1]) cube([innerRadius*2,innerRadius*2,length+2]);
}

//profit 