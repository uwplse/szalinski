// Height of the vase [mm]
Height=300; // [20:300]
// Width of the vase [mm]
Width=84; // [10:150]
// Base width 
Base=42; // [10:150]
Twist=-1; // [-5:.1:5]
Poly=6; //[4:2:20]
/* [Hidden] */


_b=Base;
_h=1.111*Height;
_amp=Width/2-Base/2;
//r=_b/2+_amp;
s=max(1,Height/60);

r=[for(i=[0:s:_h]) 15/16*(_b+_amp*sin(i/_h*360))];
x=rands(0.5,1,3);
color([x[0],x[1],x[2],1]) union()
for(j=[0:15])rotate(j*22.5)translate([-.01,-.005,0])
for(v=[0:s:.9*_h]){  
translate([0,0,v]) 
    {
//    Poly=Poly;
    

 	angles0=[ for (i = [0:Poly*16-1]) i*(360/Poly) ];
 	angles1=[ for (i = [0:Poly*16-1]) i*(360/Poly) ];
 	coords0=[ 
        for (th=angles0) [(r[v/s]+cos(th+Twist*(v/s)*(360/Poly)))*cos((th/16))
            , (r[v/s]+cos(th+Twist*(v/s)*(360/Poly)))*sin((th/16)),0] ];
 	coords1=[ 
        for (th=angles1) [(r[v/s+1]+cos(th+Twist*(v/s+1)*(360/Poly)))*cos((th)/16)
            , (r[v/s+1]+cos(th+Twist*(v/s+1)*(360/Poly)))*sin((th)/16),s] ];
            
    coords=concat(coords0,coords1,[[0,0,0],[0,0,s]]);
// 	echo(coords);
//    triangles=[ for(i=[0:Poly*16-2])  [i,i+1,i+Poly*16+1]];
    triangles=concat(
        [ concat([for(i=[0:Poly]) i] ,Poly*32)],
        [ for(i=[0:Poly-1])  [i+Poly*16+1,i+1,i]],
        [ for(i=[0:Poly-1])  [i+Poly*16,i+Poly*16+1,i]],
        [ concat([for(i=[Poly*17:-1:Poly*16]) i]  ,Poly*32+1)],
        [[Poly*16,0,Poly*32,Poly*32+1]],
        [[Poly,Poly*17,Poly*32+1,Poly*32]]
        );
//echo(coords[1]);
//for(i=[])

 polyhedron( coords, triangles, 10 );

    
    
}

}



