//agoramachina 2019

$fn=40;
n = 6;
radius = 50;
height = 2;

summon_circle();

// Generate matrix of n points
function points(n) = [
    for (i=[1:n+1])
        [radius*cos(i*(360/n)), radius*sin(i*(360/n)),0]
    ];   

// Find unit vector with direction v. Fails if v=[0,0,0].
function unit(v) = norm(v)>0 ? v/norm(v) : undef; 

// Find the transpose of a rectangular matrix
function transpose(m) = 
  [ for(j=[0:len(m[0])-1]) [ for(i=[0:len(m)-1]) m[i][j] ] ];
      
// Identity matrix with dimension n
function identity(n) = [for(i=[0:n-1]) [for(j=[0:n-1]) i==j ? 1 : 0] ];

// Computes the rotation with minimum angle that brings a to b
// Fails if a and b are opposed to each other
function rotate_from_to(a,b) = 
    let( axis = unit(cross(a,b)) )
    axis*axis >= 0.99 ? 
        transpose([unit(b), axis, cross(axis, unit(b))]) * 
            [unit(a), axis, cross(axis, unit(a))] : 
        identity(3);

// Given points p0 and p1, draw a thin cylinder with its
// bases at p0 and p1
module line(p0, p1, diameter=1) {
    v = p1-p0;
    translate(p0)
        multmatrix(rotate_from_to([0,0,1],v))
            cylinder(d=diameter, h=norm(v), $fn=4);
}

module summon_circle(){
    for (i=[0:n]){    
        for (j=[0:n]){
                line (points(n)[i], points(n)[j], diameter=2);
        }
    }
}
