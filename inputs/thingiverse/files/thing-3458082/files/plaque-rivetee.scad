// CUSTOMIZABLE RIVETED PLATE
// by tokagehideto


/* [Size] */
//Width of the plate
width=15;
//Height of the plate
height=22;

/* [Rivets Position] */
//Distance between the rivets and the border
rivetsOffset=2.1;
//Rivets on the Right
RightRivets=1; //[1:yes,2:no] 
//Rivets on the Left
LeftRivets=1; //[1:yes,2:no] 
//Rivets on the Top
TopRivets=1; //[1:yes,2:no] 
//Rivets on the Bottom
BottomRivets=1; //[1:yes,2:no] 

/* [Rivets Size] */
//Top rivets size
TpRivetsSize=0.5;
//Bottom rivets size
BtmRivetsSize=0.5;
//Left rivets size
LRivetsSize=0.5;
//Right rivets size
RRivetsSize=0.5;

/* [Number of Rivets] */
//Number of rivets on top side
TpRivets=3;
//Number of rivets on bottom side
BtmRivets=5;
//Number of rivets on left side
LRivets=6;
//Number of rivets on right side
RRivets=6;

/* [Rivets Quality] */
//Rivets polycount... type '4' to make square rivets
def=25;

difference(){
    cube([width,height,1.2],true);
    c=0.45;
    s=.8;
    translate([-width/2, height/2, 1.2/2-c])
    rotate([45, 0, 0])
    cube([width+0.1, s, s]);
    translate([-width/2, -height/2, 1.2/2-c])
    rotate([45, 0, 0])
    cube([width+0.1, s, s]);
    translate([width/2, -height/2, 1.2/2-c])
    rotate([45, 0, 90])
    cube([height+0.1, s, s]);
    translate([-width/2, -height/2, 1.2/2-c])
    rotate([45, 0, 90])
    cube([height+0.1, s, s]);
    }
    
            if (BottomRivets== 1) {
                for (i = [0:BtmRivets-1]){
                translate([-width/2+rivetsOffset + i*((width-rivetsOffset*2            )/(BtmRivets-1)), 
                -height/2+rivetsOffset, .6])
                cylinder(.2,BtmRivetsSize,BtmRivetsSize,$fn=def);
                translate([-width/2+rivetsOffset + i*((width-rivetsOffset*2            )/(BtmRivets-1)), 
                -height/2+rivetsOffset, .8])
                sphere(BtmRivetsSize,$fn=def);
                }
            }
          
            if (TopRivets== 1) {
                for (i = [0:TpRivets-1]){
                translate([-width/2+rivetsOffset 
                + i*((width-rivetsOffset*2)/(TpRivets-1)), 
                height/2-rivetsOffset, .6])
                cylinder(.2,TpRivetsSize,TpRivetsSize,$fn=def);
                translate([-width/2+rivetsOffset 
                + i*((width-rivetsOffset*2)/(TpRivets-1)), 
                height/2-rivetsOffset, .8])
                sphere(TpRivetsSize,$fn=def);
                }
            }
            if (LeftRivets== 1) {
                for (i = [0:LRivets-1]){
                translate([-width/2+rivetsOffset, 
                -height/2+rivetsOffset + i*((height-rivetsOffset*2)/(LRivets -1)), .6])
                cylinder(.2,LRivetsSize,LRivetsSize,$fn=def);
                translate([-width/2+rivetsOffset, 
                -height/2+rivetsOffset + i*((height-rivetsOffset*2)/(LRivets -1)), .8])
                sphere(LRivetsSize,$fn=def);
                }
            }
           if (RightRivets== 1) {
               for (i = [0:RRivets-1]){
                translate([width/2-rivetsOffset, 
                -height/2+rivetsOffset + i*((height-rivetsOffset*2)/(RRivets            -1)), .6])
                cylinder(.2,RRivetsSize,RRivetsSize,$fn=def);
                translate([width/2-rivetsOffset, 
                -height/2+rivetsOffset + i*((height-rivetsOffset*2)/(RRivets -1)), .8])
                sphere(RRivetsSize,$fn=def);
                }
           }