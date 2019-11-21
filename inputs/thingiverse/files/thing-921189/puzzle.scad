//make sure each stone is quite unique
randomizer_seed=1;
cube_size=20;

// Which one would you like to see?
part = "both"; // [first:Puzzle Only,second:Board Only,both:Puzzle and Board]


/* [Hidden] */
d=1;
ran=rands(cube_size/4,1.5*cube_size,9,randomizer_seed);



module a(){
polyhedron(
  points=[ [0,0,0],[0,4*cube_size,0],[4*cube_size,4*cube_size,0],[4*cube_size,0,0],[0,0,ran[0]],[0,2*cube_size,ran[1]],[0,4*cube_size,ran[2]],[2*cube_size,0,ran[3]],[2*cube_size,2*cube_size,ran[4]],[2*cube_size,4*cube_size,ran[5]],[4*cube_size,0,ran[6]],[4*cube_size,2*cube_size,ran[7]],[4*cube_size,4*cube_size,ran[8]] ],                                 
  faces=[ [2,1,0],[2,0,3],[0,5,4],[1,6,5],[1,5,0],[0,4,7],[7,10,3],[0,7,3],[3,10,11],[11,12,2],[3,11,2],[2,12,9],[9,6,1],[2,9,1],[4,5,7],[5,8,7],[7,8,10],[8,11,10],[5,6,9],[5,9,8],[8,9,12],[8,12,11] ]                        
 );
}


module r(n){
difference(){
a();
translate([-10,cube_size*n+cube_size-d,-1])
cube([6*cube_size,4*cube_size,2*cube_size]);
translate([-cube_size,-4*cube_size+d+cube_size*n,-1])
cube([6*cube_size,4*cube_size,2*cube_size]);
}
}


module p(n,m){
union(){
difference(){
r(n);
translate([cube_size*m+cube_size-d,-cube_size,-1])
cube([4*cube_size,6*cube_size,2*cube_size]);
translate([-4*cube_size+d+cube_size*m,-cube_size,-1])
cube([4*cube_size,6*cube_size,2*cube_size]);
}

}
}

module stones(){
for(i=[0,1,2,3]){
for(j=[0,1,2,3]){
p(i,j);
}
}
}

module board(){
difference(){
translate([-1,-1,-1])
cube([4*cube_size+2,4*cube_size+2,4]);
for(i=[0,1,2,3]){
for(j=[0,1,2,3]){
translate([d/2+cube_size*i,d/2+cube_size*j,0])
cube([cube_size-d,cube_size-d,8]);
}
}
for(i=[0,1,2,3]){
for(j=[0,1,2,3]){
translate([(cube_size/8)+cube_size*i,(cube_size/8)+cube_size*j,-5])
cube([3*cube_size/4,3*cube_size/4,10]);
}
}
}
}

print_part();

module print_part() {
	if (part == "first") {
		stones();
	} else if (part == "second") {
        translate([0,0,1])
		board();
	} else if (part == "both") {
		stones();
        board();

	} else {
		stones();
        board();

	}
}




