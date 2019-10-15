tilesize = 24;
tilethickness = 2;
tilequantity = 10;
wallthickness = 3;
openinglip = 4;
tilehalf = tilesize/2;

//base
difference() {
cube([((tilesize+2)+(wallthickness*2)),((tilesize+2)+(wallthickness*2)),wallthickness],true);
cube([tilesize-4,tilesize-4,wallthickness*2],true);
}


//left wall
translate([
((tilehalf+1+(wallthickness/2))*-1),
0,
((tilequantity*tilethickness/2)+(wallthickness*.5))])

cube([
wallthickness,
((tilesize+2)+(wallthickness*2)),
((tilequantity*tilethickness)+(wallthickness*2))],true);

//right wall
translate([
(tilehalf+1+(wallthickness/2)),
0,
((tilequantity*tilethickness/2)+(wallthickness*.5))])

cube([
wallthickness,
((tilesize+2)+(wallthickness*2)),
((tilequantity*tilethickness)+(wallthickness*2))],true);

//back wall
translate([
0,

(tilehalf+1+(wallthickness/2)),

((tilequantity*tilethickness/2)+(wallthickness*.5))])

cube([
((tilesize+2)+(wallthickness*2)),

wallthickness,

((tilequantity*tilethickness)+(wallthickness*2))],

true);

difference(){
//front wall
translate([
0,((tilehalf+1+(wallthickness/2))*-1),((tilequantity*tilethickness/2)+(wallthickness*.5))])
cube([
((tilesize+2)+(wallthickness*2)),wallthickness,((tilequantity*tilethickness)+(wallthickness*2))],true);

translate([
0,((tilehalf+1+(wallthickness/2))*-1),wallthickness*2])
cube([(tilesize+2)-(openinglip*2),wallthickness*2,(tilequantity*tilethickness*4)],true);
}


