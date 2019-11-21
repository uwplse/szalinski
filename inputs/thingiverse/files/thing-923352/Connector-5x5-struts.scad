// Combination of n,s,e,w,u,d (lower case = no support, upper case=with support)
directions = "nsewud";

cube([7,7,7],center=true);


if (search("u",directions)) stick(); //up
if (search("d",directions)) rotate ([180,0,0]) stick("yellow",false);
if (search("n",directions)) rotate ([-90,0,0]) stick("green",false);
if (search("s",directions)) rotate ([90,0,0]) stick("blue",false);
if (search("e",directions)) rotate ([90,0,90]) stick("white",false);
if (search("w",directions)) rotate ([90,0,-90]) stick("brown",false);

if (search("U",directions)) stick("red",true); //up
if (search("D",directions)) rotate ([180,0,0]) stick("yellow",true);
if (search("N",directions)) rotate ([-90,0,0]) stick("green",true);
if (search("S",directions)) rotate ([90,0,0]) stick("blue",true);
if (search("E",directions)) rotate ([90,0,90]) stick("white",true);
if (search("W",directions)) rotate ([90,0,-90]) stick("brown",true);

module stick(col="red",support=false) {
    color(col){
        translate ([0,0,10]) {
            if (support==true) translate ([0,0,0.5]) cube([0.1,7,13],center=true);
            difference() {
                cube([7,7,15],center=true);
                cube([5,5,17],center=true);
            }
        }
    }
}
