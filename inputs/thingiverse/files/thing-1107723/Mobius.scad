
// Number of divisions
ns = 50;

// of the shell (in your drawing/model units. e.g. mm)
Thickness= 10;

// measured at the mid-curve of the surface (in your drawing/model units. e.g. mm)
Diameter = 50;

// (in your drawing/model units. e.g. mm)
Width = 20;


/*
    Parametrized equations:
        x(u,v)=(1+v/2*cos(u/2))*cos(u)
        y(u,v)=(1+v/2*cos(u/2))*sin(u)
        z(u,v)=v/2*sin(u/2)
    with
        0<=u<2*PI
        -1<=v<=1
*/

Mobius();

module Mobius(){
    for (i=[1:ns])
    {
        ang1=360/ns*(i-1);
        ang2=360/ns*(i);
        v=Width/Diameter;
        PM=[pMb( v,ang1)+nMb( v,ang1)*Thickness/2,
            pMb(-v,ang1)+nMb(-v,ang1)*Thickness/2,
            pMb( v,ang2)+nMb( v,ang2)*Thickness/2,
            pMb(-v,ang2)+nMb(-v,ang2)*Thickness/2,
            pMb( v,ang1)-nMb( v,ang1)*Thickness/2,
            pMb(-v,ang1)-nMb(-v,ang1)*Thickness/2,
            pMb( v,ang2)-nMb( v,ang2)*Thickness/2,
            pMb(-v,ang2)-nMb(-v,ang2)*Thickness/2,
        ];
        polyhedron(points=PM,
        faces=[[0,1,5,4],[2,0,4,6],[3,2,6,7],[1,3,7,5],[0,2,3,1],[4,5,7,6]]);
    }
}

function pMb(v,ang)=[
        Diameter*(1+v/2*cos(ang/2))*cos(ang),
        Diameter*(1+v/2*cos(ang/2))*sin(ang),
        Diameter*v/2*sin(ang/2)
        ];
function puMb(v,ang)=[
        (-v/4*sin(ang/2))*cos(ang)-(1+v/2*cos(ang/2))*sin(ang),
        (-v/4*sin(ang/2))*cos(ang)+(1+v/2*cos(ang/2))*cos(ang),
        v/4*cos(ang/2)
        ];
function pvMb(v,ang)=[
        1/2*cos(ang/2)*cos(ang),
        1/2*cos(ang/2)*sin(ang),
        1/2*sin(ang/2)
        ];
function nMb(v,ang)=
        cross(puMb(v,ang),pvMb(v,ang))/norm(cross(puMb(v,ang),pvMb(v,ang)));
        