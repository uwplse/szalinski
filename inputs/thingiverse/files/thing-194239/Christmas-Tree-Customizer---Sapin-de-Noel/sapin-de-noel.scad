//origin size [mm]
rad=80; // [20:200]
//number of level
etage=6; // [1:20]
//number of branch
branche=9; // [3:16]
//twist (0 not twisted)
torsion=2; // [0:6]
//how to hang your tree
base=3; //[1:use a wooden foot,2:hole on the top,3:both,4:none]

module etoile(type = 1, r1 = rad/4, r2 = rad/2, n = branche, h = 10*etage, t =5)
{
	linear_extrude(height = h, twist = 360*t/n, convexity = t)
	difference() {
		circle(r2);
		for (i = [0:n-1]) {
				if (type == 1) rotate(i*360/n) polygon([
						[ 2*r2, 0 ],
						[ r2, 0 ],
						[ r1*cos(180/n), r1*sin(180/n) ],
						[ r2*cos(360/n), r2*sin(360/n) ],
						[ 2*r2*cos(360/n), 2*r2*sin(360/n) ],
				]);
				if (type == 2) rotate(i*360/n) polygon([
						[ 2*r2, 0 ],
						[ r2, 0 ],
						[ r1*cos(90/n), r1*sin(90/n) ],
						[ r1*cos(180/n), r1*sin(180/n) ],
						[ r2*cos(270/n), r2*sin(270/n) ],
						[ 2*r2*cos(270/n), 2*r2*sin(270/n) ],
				]);
		}
	}
}

module nut(type = 2, r1 = 16, r2 = 21, r3 = 30, s = 6, n = 7, h = 100/5, t = 8/5)
{
        difference() {
                cylinder($fn = s, r = r3, h = h);
                translate([ 0, 0, -h/2 ]) etoile(type, r1, r2, n, h*2, t*2);
        }
}

module arbre (i, rad)
{
if (i>=2)
{
translate ([0,0,10*(i-1)]) cylinder (r1=0, r2=rad*(1/(i+1)), h=(10+etage)/3);
}
translate ([0,0,10*(i-1)+((10+etage)/3)]) cylinder (r1=rad*(1/(i+1)), r2=0, h=10+etage);
}
{
translate ([0,0,-10*etage/2])
difference ()
{
for (i=[1:etage])
{
difference ()
{
arbre (i,rad);
translate ([0,0,10*(i-1)-1]) nut(type = 1, r1 = rad*(1/(i+1))/2, r2 = rad*(1/(i+1)), s=7, r3=2*rad*(1/(i+1)), n = branche, h = 11+etage, t=torsion);
}

}
//how to hang your tree
//change base variable [1:use a wooden foot,2:hole on the top,3:both,4:none]
if (base==1 || base==3) 
{
if (rad > 90)
{
    cube(size = [5,30,30], center = true);
		cube(size = [30,5,20], center = true);
} else {   
    cube(size = [5,rad/3,30], center = true);
		cube(size = [rad/3,5,20], center = true);
}
}
if (base==2 || base==3) 
{
translate ([0,0,11*etage]) rotate ([0,90,0]) cylinder (r=1, h=rad, center=true);
}
}
}