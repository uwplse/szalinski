sphereRadius = 18;
extraClearance  = 2; 
fittingClearance = 0.8;
ductExtraLength = 4;
airHoleAngle = 25;
airHoleRadius = 1;

rotate ([180,0,0]){

translate ([-sphereRadius-extraClearance-8,0,-sphereRadius-extraClearance])
difference (){
translate ([-(sphereRadius+extraClearance),-(sphereRadius+extraClearance),-2])
cube ([2*(sphereRadius+extraClearance),2*(sphereRadius+extraClearance)+5,(sphereRadius+extraClearance)+2]);

rotate ([-90,0,airHoleAngle])
cylinder (r= airHoleRadius, h = 2*(sphereRadius+extraClearance), $fn = 15);

rotate ([-90,0,-airHoleAngle])
cylinder (r= airHoleRadius, h = 2*(sphereRadius+extraClearance), $fn = 15);


sphere (r = sphereRadius, $fn = 80);


rotate ([-90,0,0])
cylinder (d = 4, h = (sphereRadius+extraClearance+6), $fn = 15);


translate ([0,sphereRadius+extraClearance-0.8,0])
rotate ([-90,0,0])
cylinder (d1 = 4, d2= 13.5, h =5.85, $fn = 20);

translate ([0,+2.5,-1.1])
cube ([2*(sphereRadius+extraClearance)-2,2*(sphereRadius+extraClearance)+5-2,2.1], center = true);
}




translate ([sphereRadius+extraClearance+8,0,-sphereRadius-extraClearance])
difference (){
    union()
    {
translate ([-(sphereRadius+extraClearance),-(sphereRadius+extraClearance),2.5])
cube ([2*(sphereRadius+extraClearance),2*(sphereRadius+extraClearance)+5,(sphereRadius+extraClearance)-2.5]);
translate ([0,+2.5,+1.5])
cube ([2*(sphereRadius+extraClearance)-2-fittingClearance,2*(sphereRadius+extraClearance)+5-2-fittingClearance,3], center = true);
    }

sphere (r = sphereRadius, $fn = 80);


rotate ([-90,0,airHoleAngle])
cylinder (r= airHoleRadius, h = 2*(sphereRadius+extraClearance), $fn = 15);

rotate ([-90,0,-airHoleAngle])
cylinder (r= airHoleRadius, h = 2*(sphereRadius+extraClearance), $fn = 15);


rotate ([-90,0,0])
cylinder (d = 4, h = (sphereRadius+extraClearance+6), $fn = 15);


translate ([0,sphereRadius+extraClearance-0.8,0])
rotate ([-90,0,0])
cylinder (d1 = 4, d2= 13.5, h =5.85, $fn = 20);

}

}


difference(){
union(){
cylinder (d=12.5, h =ductExtraLength+0.1, $fn = 20);
translate ([0,0,ductExtraLength])
cylinder (d1 = 12.5, d2= 4, h =6+fittingClearance, $fn = 20);
}

translate ([0,0,-0.1])
cylinder (d1 = 10, d2= 4, h =4+ductExtraLength+fittingClearance, $fn = 20);

cylinder (d = 4, h = (sphereRadius+extraClearance), $fn = 15);

}
