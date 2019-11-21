wide=35;
thick = 3;
deep = 4;
places = 3;
step = wide / (places);
holerange=2;
hole_start=2.75;

 module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);
}

difference () {
    cube ([wide, wide, thick]);
    holestep = holerange / (places * places);
    for (x = [0:places - 1]) {
        for (y = [0:places -1]) {
            rad = hole_start + (x * (places) + y) * holestep;
            echo (x, y, rad);
            translate ([ (x + 0.5) * step, (y + 0.5) * step, thick - deep + 0.01]) cylinder_outer(radius=rad , height = deep, fn=6); 
        }
    }
}