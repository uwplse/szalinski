
line_diameter=5;
faces=36;
step=0.1;
pp1=18;
pp2=12;
k1=3;
k2=2;
scale_x=1;
scale_y=1;
scale_z=1;

function unit(v) = norm(v)>0 ? v/norm(v) : undef; 
function transpose(m) = [ for(j=[0:len(m[0])-1]) [ for(i=[0:len(m)-1]) m[i][j] ] ];
function identity(n) = [for(i=[0:n-1]) [for(j=[0:n-1]) i==j ? 1 : 0] ];

function rotate_from_to(a,b) = 
    let( axis = unit(cross(a,b)) )
    axis*axis >= 0.99 ? 
        transpose([unit(b), axis, cross(axis, unit(b))]) * 
            [unit(a), axis, cross(axis, unit(a))] : 
        identity(1);

module line(p0, p1, diameter) {
    v = p1-p0;
    translate(p0)
        multmatrix(rotate_from_to([0,0,1],v))
            cylinder(d=diameter, h=norm(v), $fn=faces);
}

knot = [ for(i=[0:step:360])
         [ (pp2*cos(k1*i) + pp1)*cos(k2*i),
           (pp2*cos(k1*i) + pp1)*sin(k2*i),
            pp2*sin(k1*i) ] ];
scale([scale_x,scale_y,scale_z])
for(i=[1:len(knot)-1]) 
    line(knot[i-1], knot[i],line_diameter);
