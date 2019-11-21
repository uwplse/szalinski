Seed=1;//[0:0.001:1000]
part = 1; //[1,2,3,4,5,6]
show="naked";//[naked,spiky]
/* [Hidden] */
// global things
glx=rnd(1,3);
gly=4-glx;
ringseg = max(3, round(rnd(1,8))*2);//ring profile
moderator=0.2;
//late addition that gets passed thru all steps since a globalvaiable dont scale very well
//  controling spikes properties
spike1 = [abs(rnd(-5, 30-(ringseg/6))), 0, rnd(-0.5, 0.4), rnd(-0, 1.7)];
spike2 = [abs(rnd(-5, 30-(ringseg/6))), 0, rnd(-0.4, 0.5), rnd(-0, 1.7)];

grove = [rnd(0.5, 1.5), rnd(0.2, 0.3), rnd(0.1, 0.3)];
grove2 = [rnd(1, 1), rnd(0.2, 0.3), rnd(0.1, 0.3)];
r = 90;
r2 = 90;
r3 = 90;
l = rnd(50, 150);
l2 = rnd(50, 150);
lenseg = round(rnd(ringseg/4,ringseg/2));
echo (lenseg);


//here we make three packages of XYZs, Radus, 3 grove values and a list of XYZ points that make a profile
start = [
  [0, 0, 0], r, grove, xring(ringseg), rnd(2, 10)
];

end = [
  [sin(r) * l, 0, cos(r) * l], r2, grove2, xring(ringseg), rnd(10, l/3)
];
end2 = [end[0] + [sin(r2) * l2, 0, cos(r2) * l2], r2, grove, xring(ringseg), rnd(5, 10)];

// here we finally get go 
union(){
seg(start, end, lenseg, spike1, 1, 0);
seg(end, end2, lenseg, spike2, 0, 1);
}



module seg(p1, p2, div, spike, cap1 = 1, cap2 = 1) 
//segment constructor. These steps until quad are unnessearily complicated
//but it pretty much runs throu intermediates of p1 and p1 package and twostep calles for the construction of polygons connecting them  ringbridge via brige

{
  m1 = lerp(p1, p2, min(p1[2][2], 1 - p2[2][1]));
  m2 = lerp(p1, [p2[0], lerp(p1[1], p2[1], 0.5), p2[2], p2[3], p2[4]], max(1 - p2[2][1], p1[2][2]));

  

  if (cap1 == 1) cap(p1[2][0], p1, 1);
  bridge(p1[2][0], p1, m1, 1, spike);
  for ( in = [0: 1 / div: 1 - (1 / div)]) {
     bridge(1, lerp(m1, m2, SC3(in) ), lerp(m1, m2, SC3(in +(1 / div))), 1, spike);

  }

  bridge(1, m2, p2, p2[2][0], spike);
  if (cap2 == 1) cap(p2[2][0], p2, 0);

}

//endcaps
module cap(s1, ip1, reverse) {
  r1 = ringtrans(ringscale(ringrot(ip1[3], ip1[1]), s1 * ip1[4]), ip1[0]);
  c1 = avrg(r1);
  ring1 = concat(r1);
  last1 = len(ring1);
  color(rndc()) for (i = [0: last1 - 1]) {

    if (reverse == 1) polyhedron([ring1[i], ring1[(i + 1) % last1], c1], [
      [1, 0, 2]
    ]);
    else polyhedron([ring1[i], ring1[(i + 1) % last1], c1], [
      [0, 1, 2]
    ]);
  }
}
module bridge(s1, ip1, ip2, s2, spike) {
  r1 = ringtrans(ringscale(ringrot(ip1[3], ip1[1]), s1 * ip1[4]), ip1[0]);
  r2 = ringtrans(ringscale(ringrot(ip2[3], ip2[1]), s2 * ip2[4]), ip2[0]);
  c1 = avrg(r1);
  c2 = avrg(r2);
  ring1 = concat(r1);
  ring2 = concat(r2);
  last1 = len(ring1);
  last2 = len(ring2);

 ringbridge(ring1, ring2, spike);

 
}

module ringbridge(r1, r2, spike) {
// ok were ready to show what we got
  n = len(r1);
  cbr = concat(r1, r2);
// so we made a lumpy sausage, What if we reused that spaceship code to make it more agressive, quad replaces polyhedron but does alot more than a sqare. now skip to quad

if(show=="spiky")
{
 for (i = [0: n - 1]) {
    quad(      [cbr[n + i], cbr[n + (i + 1) % n], cbr[(i + 1) % n], cbr[i]], spike    );
  }

}
else{

   l=[for(i=[0:n])[i, (i+1)%n,n+(i+1)%n,n+i]];
   polyhedron(     concat(r1,r2),l);
}
};





module point(p1, p2, div) {

  translate(p1[0]) sphere(2);
}

module line(p1, p2, div) {
  hull() {
    translate(p1[0]) sphere(1);
    translate(p2[0]) sphere(1);
  }
}


//**********************************************************************
//**********************************************************************
//**********************************************************************
// base colors fo quad module , this should not be here
C0 = (un(rndc()) + [2, 0, 0]);
C1 = (un(rndc()) + [2, 2, 0]);
C2 = (un(rndc()) + [0, 2, 2]);
// quad  is the magic part, ring in this context is just four points the intended extention to polygon  never took place. 
// modifyer is what previous passed as spike 
// so this is a common  recursive non branching  extrusion .
module quad(ring, modifyer, i = 0) {
  c = avrg(ring); // center point list of XYZs
  n = un(p2n(ring[0], ring[1], ring[3]) + p2n(ring[3], ring[1], ring[2]));//unit normal of square is the avarege of its triangle. and base for extrude direction

  area = (polyarea(ring[0], ring[1], ring[3]) + polyarea(ring[3], ring[1], ring[2]));// finding combined area with herons formula
  ex = modifyer[0];   // extrude height
  sc = 0.7 * (3 - i) / (4 - ex / area);// extrude downscale
  sn = ([modifyer[1], modifyer[2]]); // things about the bending of spikes
  ns = sn[0] * n * ex;
  ew = sn[1] * n * ex;
  nsc = sn[0];
  ewc = sn[1];
  // echo(area);
// i guess modifyer modify it self here
  nextmodifyer = [modifyer[0] * modifyer[3], modifyer[1], modifyer[2], modifyer[3]];
// now the recusion if area is big enought and iterations is small and ex i significant for the area.
  if (i < 4 && area > 100 && abs(ex) > sqrt(area) * 0.1) {
// these are the new point of the extruded quad
    ep0 = lerp(c + n * ex, ((ring[0] + n * ex) + ns - ew), sc - ewc * 0.2 + nsc * 0.2);
    ep1 = lerp(c + n * ex, ((ring[1] + n * ex) - ns - ew), sc - ewc * 0.2 - nsc * 0.2);
    ep2 = lerp(c + n * ex, ((ring[2] + n * ex) - ns + ew), sc + ewc * 0.2 - nsc * 0.2);
    ep3 = lerp(c + n * ex, ((ring[3] + n * ex) + ns + ew), sc + ewc * 0.2 + nsc * 0.2);

    //    echo(ep0,ep1,ep2,ep3);
//And the color stuff. color and normals make best friends for pretty fake light
    color(un((C0 * abs(n[0]) + C1 * abs(n[1]) + C2 * abs(n[2]) + [1, 1, 1] * abs(n[2])) / 4)) {
//extrusion sided   
//Yes right this is recyled code so instead of making sides by polyhedra we just lazy call quad with i=100 to halt recursion and making do it for us huh.
      quad([ring[0], ring[1], ep1, ep0], modifyer, 100);
      quad([ring[1], ring[2], ep2, ep1], modifyer, 100);
      quad([ring[2], ring[3], ep3, ep2], modifyer, 100);
      quad([ring[3], ring[0], ep0, ep3], modifyer, 100);
    }
    quad([ep0, ep1, ep2, ep3], nextmodifyer, i + 1); // this one contious the spike forward
    //if (i==0){       polyhedron([ring[0],ring[1],ring[2],ring[3],c],[[0,1,3],[1,2,3]]);}
  } else if (i == 100 || abs(ex) < sqrt(area) * 0.1)
// cach the spacial case of 100 and do normal polyhedron 
{
    color(un((C0 * abs(n[0]) + C1 * abs(n[1]) + C2 * abs(n[2]) + [1, 1, 1] * abs(n[2])) / 4)) polyhedron([ring[0], ring[1], ring[2], ring[3], c + (n * ex / 10)], [
      [1, 0, 4],
      [2, 1, 4],
      [3, 2, 4],
      [0, 3, 4]
    ]);
  } else {
// dont remember what this was a fix for or if 

    color(un((C0 * abs(n[0]) + C1 * abs(n[1]) + C2 * abs(n[2]) + [1, 1, 1] * abs(n[2])) / 4))
      //ERROR: Unable to convert point at index 0 to a vec3 of numbers WARNING: PolySet has degenerate polygons 
    if (avrg(ring, len(ring)) != undef) {
      polyhedron([ring[0], ring[1], ring[2], ring[3], c + (n * ex)], [
        [1, 0, 4],
        [2, 1, 4],
        [3, 2, 4],
        [0, 3, 4]
      ]);
    }

  }

}
// thats it
//**********************************************************************

// ring operators transform ring profiles never mind
function ringrot(r = [ [0, 0, 0]
], v) = [ for (i = [0: len(r) - 1]) let (inx = r[i][0], iny = r[i][1], inz = r[i][2])[
  inx * sin(v) - inz * cos(v),  iny,  inx * cos(v) + inz * sin(v) ]];
function ringscale(v, scale) = [ for (i = [0: len(v) - 1])
  [   v[i][0] * scale,   v[i][1] * scale,   v[i][2] * scale  ]];
function ringtrans(v, t) = [ for (i = [0: len(v) - 1])  [   v[i][0] + t[0],   v[i][1] + t[1],   v[i][2] + t[2]  ]];
// more ring function concernigng generation skip this 
function xring(x = 8, i = 0.5) = mirring([  for (i = [(360 / x) * 0.5: 360 / x: 359])[0, sin(i)*glx, cos(i)*gly] + rndV2(2/x+0.2)]);
function basering(x = 8) = mirring([  for (i = [(360 / x): 360 / x: 359])[0, sin(i), cos(i)] + rndV2(3)]);
function mirring(ring) =let (n = floor((len(ring) - 1) / 2))
concat(  [    for (i = [0: n]) ring[i]  ], [    for (i = [0: n])[ring[n - i][0], -ring[n - i][1], ring[n - i][2]]  ]);
function rndV2(t = 1) = [rands(-t, t, 1)[0], rands(-t, t, 1)[0], rands(-t, t, 1)[0]];

//**********************************************************************
//**********************************************************************
// helper functions 

function avrg(v) = sumv(v, len(v) - 1) / len(v); 
// averages any regular list of anything numeric

function sumv(v, i, s = 0) = (i == s ? v[i] : v[i] + sumv(v, i - 1, s));
// sums any regular list of anything numeric

function lerp(start, end, bias) = (end * bias + start * (1 - bias));
//lerp linear interpolation between two values

function p2n(pa, pb, pc) =
let (u = pa - pb, v = pa - pc) un([u[1] * v[2] - u[2] * v[1], u[2] * v[0] - u[0] * v[2], u[0] * v[1] - u[1] * v[0]]);
//polygon to normal vector

function len3(v) = len(v) == 2 ? sqrt(pow(v[0], 2) + pow(v[1], 2)) : sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
//lengh of 2 or 3d vector

function un(v) = v / max(len3(v), 0.000001) * 1;
//unit normal 

function polyarea(p1, p2, p3) = heron(len3(p1 - p2), len3(p2 - p3), len3(p2 - p1));
// what i says

function rnd(a = 0, b = 1) = (rands(min(a, b), max(a, b), 1)[0]);
//random number 

function rndc() = [rands(0, 1, 1)[0], rands(0, 1, 1)[0], rands(0, 1, 1)[0]];
//random color triplet or other use 0 to 1 triplet

function v3rnd(c) = [rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0] * c, rands(-1, 1, 1)[0]] * c;
//general use -1 to 1 triplet

function heron(a, b, c) =
let (s = (a + b + c) / 2) sqrt(abs(s * (s - a) * (s - b) * (s - c)));
// Heron of Alexandria was a Greek mathematician, Heron's formula gives the area of a triangle by nothing but lengths of its sides

function SC3 (a)= let( b=clamp(a))(b * b * (3 - 2 * b));// smoothcurve and its two friends
function clamp (a,b=0,c=10)=min(max(a,b),c);
function gauss(x)=x+(x-SC3(x));