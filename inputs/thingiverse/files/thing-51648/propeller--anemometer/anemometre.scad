

N=3;    // nombres de pales


difference() {
cylinder(h = 3, r=15, center =true);
cylinder(h = 7, r=8.5, center =true);
}


for ( i = [0 : N-1] )

{
    rotate( i * 360 / N, [0, 0, 1])


translate(v = [30, 0, 0]) 
{ 
cube (size = [40,5,3], center =true);             

}

rotate( i * 360 / N, [0, 0, 1])

translate(v = [51, 3, 13.4]) 
difference()  {
    sphere(r = 15, $fn=100);

    union() {
       sphere(r = 12, $fn=100); 

       translate(v = [0, 10, 0])
       cube (size = [32,21,32], center =true);
}
}
}