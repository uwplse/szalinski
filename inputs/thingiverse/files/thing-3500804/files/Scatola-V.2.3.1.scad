/* [Dimensioni principali della scatola]*/
// Altezza interna della scatola
h = 0; //[0:1:200]
// Larghezza interna della scatola
l = 0; //[0:1:200]
// Profondità interna della scatola
p = 2; //[0.1:.1:200]
// espanzione addizionale della scatole in altezza e larghezza
tl = 5; //[0:10]
//spessore delle pareti (dovrebbe essere un multiplo dell'ugello)
mu = .8;//[0.8 :0.4:10]
/*[parametriper il dentino di chiusura della scatola]*/
// larghezza del dentino in percentuale della parete
pd = 0.5; //[0.1: 0.1: 1]
// altezza del dentino di bloccaggio
ad = .1; // [0.1: 0.1 : 5]
// taglio trasversale del dente in percentuale della parete
td = 0; //[0 : 0.1 : 20]
// tolleranza extra tra i dentini e il coperchio
ext = 0.05;

/* [Parametri cosmetici] */
// raggio di curvatura delle stondature
r = 0;//[0:0.1:30]
// Stondature a base
Btype = "F"; // [F:senza stondature, E:uguale alle stondature, B:base allungata]
// millimetri in altezza delle stondature alla base
b = 0;//[0:0.1:100]
// Stondatura coperchio
Ctype = "F"; // [F:senza stondature, E: uguale alle stondature, B: coperchio allungato]

/* [Opzioni del modello]*/
// componenti da tracciare
Rtype = "E"; // [E:entrambi affianchati, S:Solo scatola, C:Solo coperchio, Z:sovreppposti con sezionamemto]
//lunghezza minima dei segmenti di un arco in mm
fs = 0.4;//[0.2:0.1:3]
// indica il numero massimo di segmenti che una circoferenza può avere
fn = 40;//[10:100]

/* [Parametri di controllo] */
// grandezza minima
Ep = 0.01;
// dimenzione dell'ugello di stampa
ud = 0.4; // [0.1: 0.1 : 0.6]
// altezza del disco di riferimento dell'ugello 
uh = 0.12;
// posizione del disco di riferimento dell'ugello
up = [1,1,1]; //[0 : 0.01 : 200]
s2 = sqrt(2);

Main(Rtype,Btype,Ctype, l+tl, h+tl, p, mu, ad, r, b, $fs=fs, $fn=fn);
//Dentini([l+tl, h+tl, p], mu, ad, ext/2, pd, td);
//#Dentini(io=0.3);
//Dente();

/* Nota(1)
  in un'equazione di secondo grado [a*x^2+b*x+c = 0]
	se a = 1 e b è divisibile per due
	allora  x= -b/2 +- sqrt((b/2)^2 -c)
*/
/* Formula(1)
// raggio minimo dipendente dal bordo interno della scatola
ct = m - Ep
d = sqrt(2*(r - ct)^2) +-> r>=d 
=>
  se
    r - ct >= 0 cioè ct >= r // prima della riduzione
  allora
    r^2 >= 2*(r - ct)^2
    r >= sqrt(2)*(r - ct)
  altrimetni
    r == +inf
=> 
  r >= sqrt(2)*r - sqrt(2)*ct
  r- sqrt(2)*r >= -sqrt(2)*ct 
  r * (1-sqrt(2) >= -sqrt(2)*ct
  r >= -sqrt(2)*ct/(1-sqrt(2))
  r >= sqrt(2)*ct/(sqrt(2)-1)
*/
/* Formula(2)
// raggio minimo dipendente dal dentino sulla scatola
c1 = r -m +pd*m +ext/2 +Ep
   = r -(1-pd)*m +Ep +ext/2
c2 = r -m +pd*m -pd*td*m +ext/2 +Ep
   = r -(1-pd+pd*td)*m +Ep -ext/2
d  = sqrt(c1^2 +c2^2) +-> r>=d
=>
  d = sqrt((r -(1-pd)*m +Ep +ext/2)^2 + (r -(1-pd+pd*td)*m  +Ep +ext/2)^2)
  mx = -(1-pd)*m +Ep +ext/2
  my = -(1-pd+pd*td)*m  +Ep +ext/2
  d = sqrt((r + mx)^2 + (r + my)^2)
  se
    r+mx >= 0 // lapalissiana per costruzione a meno di epsilon
	mx <= 0 // l'epsilon ha portato il dentino oltre al raggio ma la costruzione è ancora valida, inoltre questo impone al radicando ad essere positivo
	r+my >= 0 cioè my >= -r // prima della riduzione
  allora
	  r^2 >= (r + mx)^2 + (r + my)^2
	  r^2 >= r^2 +2*mx*r + mx^2 + r^2 +2*my*r + my^2
	  0 >= r^2 +2*(mx+my)*r + mx^2 +my^2
	  r^2 +2*(mx+my)*r + mx^2 +my^2 <= 0
	  r = -(mx+my) +- sqrt( (mx+my)^2 -(mx^2 + my^2))

  altrimenti
    r == +inf
*/
/* Formula(3)
// calcoliamo l'altezza del bordo della scatola sulla curvatura
d = sqrt(2*(r - m)^2)
h = sqrt( r^2 - d^2 ) = sqrt( r^2 - 2*(r-m)^2)
// rapportiamo quest'altezza all'altezza massima impostabile in modo che sia uguale al muro

hm ((r-h+Ep)/r) <= m
se r-h+Ep <> 0 // dovrebbe essere sempre vero per come abbiamo scelto r e m prima
hm <= (m * r)/(r-h+Ep)
hm <= (m*r)/(r - sqrt( r^2 - 2*(r-m)^2) +Ep)
*/
/* Formula(4)
// altezza e stondatura del coperchio
	// se il coperchio deve essere senza stondature 
	//     l'altezza dello stesso è uguale all'altezza del dentino più l'altezza del muro
	//     l'allungamento della testa del coperchio è zero
	// se deve averre la stessa curvatura delle stondature
	//     l'allungamento ha la stessa dimesione della stondatura
	//     l'ltezza è uguale dentino più l'altezza per assorbire la stondatura (o l'altezza del muro se maggiore)
	//     si seguono più o meno gli stessi ragionamenti del raggio minimo dipendente dal dentino e l'altezza dell'allungamento
		c1 = r -m +pd*m +ext/2 +Ep
		   = r -(1-pd)*m +Ep +ext/2
		c2 = r -m +pd*m -pd*td*m +Ep +ext/2
		   = r -(1-pd+pd*tm)*m +Ep +ext/2
		d  = sqrt(c1^2 +c2^2)
		d = sqrt((r -(1-pd)*m +Ep +ext/2)^2 + (r -(1-pd+pd*td)*m +Ep +ext/2)^2)
		mx = -(1-pd)*m +Ep +ext/2
		my = -(1-pd+pd*td)*m  +Ep +ext/2
		d = sqrt((r + mx)^2 + (r + my)^2)
		h = sqrt( r^2 - d^2 )
	// se si deve avere una base allungata 
	//     l'allungamento segue un ragionamento simile altezza dell'allungamento della base
	//     l'altezza è uguale al dentino più il muro
		hm ((r-h+Ep)/r)<= m
		hm <= (m * r)/(r-h+Ep)
		hm <= (m * r)/(r-h+Ep)
*/
// Main
module Main(RT="E", BT="F", CT="F", x=10, y=10, z=10, m, dente, r=2, bs=2) {
  
  DI = [x, y, z];
  DE = ComposeOut(DI, m, dente);
  Provetta();

  // ************************************************************
  // le dimenzioni del muro limitano l'arrotondamento orizzontale
  //l'arrotondamento della scatola non può essere maggiore della metà della lunghezza o larghezza
  // ************************************************************
  // limite imposto dalle dimezioni della scatola
  ds = min(DE[0], DE[1])/2 -Ep; 
  // ************************************************************
  // limite agli stodamenti per la dimenzione del muro
  // ************************************************************
  // vedi formula(1)
  rm = m-Ep >=r ? 1/0 : (s2*(m-Ep))/(s2-1); 
  
  // ************************************************************
  // limite degli stondamenti per le impostazioni del dentino
  // ************************************************************
  // vedi formula(2)
  mx = min(0,-(1-pd)*m +Ep -ext/2);
  my = -(1-pd+pd*td)*m +Ep -ext/2;
  echo(Mx=mx,My=my);
  rd = my < -r ? 1/0 : (-(mx + my) + sqrt(pow(mx+my,2) - ((mx*mx) + (my*my))));
  
  echo(    "<b>Raggio Massimo<\b>");
  echo(str("<b>__per le dimensioni : </b>",ds));
  echo(str("<b>__per la scatola    : </b>",rm));
  echo(str("<b>__per il dentino    : </b>",rd));
  r1 = min(r, ds, rm, rd);
  
  // definito il raggio definiamo gli allungamenti
  
  // ************************************************************
  // allungamento massim della base
  // ************************************************************
  // vedi Formula(3)
  hb1 =  sqrt(r1*r1-2*pow(r1-m,2))/r1;
  bm1 = m/(1- hb1+Ep);
  echo(str("<b>Altezza Massima dell'allungamento alle base : </b>", bm1," [", hb1, "]"));
  
  bsm = BT == "F" ? 0: BT == "E" ? min(r1,bm1) : min(bs,bm1);
  
  // ************************************************************
  // allungamento massimo e altezza coperchio
  // ************************************************************
  // vedi Formula(4)
  cx = min(0,-(1-pd)*m +Ep +ext/2);
  cy = -(1-pd+pd*td)*m +Ep +ext/2;
  dc = pow(r1+cx, 2) + pow(r1+cy, 2);
  echo(Cx=cx,Cy=cy, Dc=dc, R = r1);
  hc = max(0,sqrt( pow(r1,2) - dc));
  bm2 = (m *r1)/(r1-hc+Ep);
  echo(str("<b>Altezza Massima dell'allungamento coperchio : </b>", bm2," [", hc, "]"));

  hb = max((CT == "E" ? max(m,r1-hc+Ep)+dente : CT == "B"? dente +m: r1+m), r1) +Ep;
  bc = CT == "F" ? 0 : CT == "B"? min(hb-Ep,bm2) : r1;  
  
  // ************************************************************
  // inizio direttive delle forme
  // ************************************************************
  
  if(RT == "E" || RT == "S" ) { Scatola(DI, m, dente, r1, bsm); }
  if(RT == "C")  Coperchio(DI, hb, m, dente, r1, bc);
  
  sx = DE[0]  < DE[1] ? DE[0]+2 : 0;
  sy = DE[1] <= DE[0] ? DE[1]+2 : 0;
  if(RT == "E") translate([sx , sy, 0]) Coperchio(DI, hb, m, dente, r1, bc);

  if(RT == "Z") {
    difference(){
      union() {
        Scatola(DI, m, dente, r1, bsm);
        translate([0, 0, DE[2]+dente*0.6]) Coperchio(DI, hb, m, dente, r1, bc);
      }
      translate ([-0.1, -0.1, -0.1]) cube([DE[0]/2, DE[1]/2, DE[2]+hb+dente]);
      translate([DE[0], DE[1]/2, -0.1]) resize([DE[0], DE[1]/2, 0])rotate([0,0,45])
          cube([1, 1, DE[2]+hb+dente]);
    }
  }
  if(RT == "dbg") {
    Dentini(dimInt, muro);
  }
}
//
function ComposeOut(dimInt, m, dente) = [
    dimInt[0] + 2*m,
    dimInt[1] + 2*m,
    dimInt[2] + m - dente];

//
module Scatola(DI=[10,10,10], m, dente, r, b) {
  DE= ComposeOut(DI, m, dente);

  b1 = min(b, DE[2]-Ep);
  echo("<b>Scatola</b>", DI, M=m, dente, R=r, Bh=b1, DE);

  difference() {
    union() {
      RoundCube(DE, r, b1);
      color("orange",1)
      translate([0, 0, DE[2]]) Dentini(DI, m, dente, -ext/2, pd, td );
    }
    translate([m, m, m]) color("green",1)  cube([DI[0], DI[1], DI[2]+.1]);
  }
}
/*
 * dimInt = dimesioni interne della scatola [w,d]
 */
module Dentini(DI=[10,15,5], l, alt, esp = 0, pd = 0.5, prd = 0) {
  
  dente = l*pd;
  rid = dente*prd;
  dx = DI[0] + 2*(dente + esp);
  dy = DI[1] + 2*(dente + esp);
  
  DE=ComposeOut(DI, l, alt);
  echo("<b>Dentini</b>", dim=DE, caratt=[dx ,dy, dente, rid], m=l, peso=pd, espansione=esp);
  
  Provetta();
  if(false) {  
    %translate([0,0,-0.01])
    difference() {
      cube([DE[0], DE[1], 0.1]);
      translate([l, l, -0.01]) cube([DI[0], DI[1],  0.12]);
    }   
  }
  E2  =Ep/2;
  translate([l-dente-esp, l-dente-esp, 0])
  hull() difference() {
    translate([0, 0, 0])cube([dx,dy,alt]);
    translate([  -E2,   -E2, -Ep]) rotate([0,0,  0]) Rettangolo(rid+Ep, alt+2*Ep);
    translate([dx+E2,   -E2, -Ep]) rotate([0,0, 90]) Rettangolo(rid+Ep, alt+2*Ep);
    translate([dx+E2, dy+E2, -Ep]) rotate([0,0,180]) Rettangolo(rid+Ep, alt+2*Ep);
    translate([  -E2, dy+E2, -Ep]) rotate([0,0,270]) Rettangolo(rid+Ep, alt+2*Ep);
  }
}
//
module Dente( w = 10, d=3, h = 3) {
  //#cube([w,d,h]);
  pw = min (1.5, w-0.1, d-0.1);
  ph = min (1.9, h-0.1);
  translate([pw/2, pw/2,0])
  minkowski() {
    cube([w-pw, d-pw, h-ph], false);
    PyramidThrunk(ph, pw, 0.001);
  }
}

//
module Coperchio( DI=[10,10,10], h, m, dente, r=0, b=0) {
  DE = ComposeOut(DI, m, dente);
  
  echo("<b>Coperchio</b>", [DE[0],DE[1],h], m, dente, R=r, T=b);
  difference() {
    RoundCube([DE[0], DE[1], h], r, 0, b);
    translate ([0,0, -Ep]) color("gray", 1) 
      Dentini(DI, m, dente+Ep, ext/2, pd, td);
    //translate ([0,0, 0])cube([ dimExt[0], dimExt[1]/2,altezza+0.01]);
  }
}

//
module RoundCube(v = [1,1,1], r = 0, rb = -1, rt = -1) {
  echo( "<b>RoundCube</b>", dim=v, r=r, base=rb, top=rt);
  consistentWidthRound = r > 0 && 2*r < v[0] && 2*r < v[1];
  maxb = max(0.01, max(rb, 0) + max(rt, 0));
  echo(maxb);
  consistentHeightRound = maxb >= 0 && maxb < v[2];
  if(consistentWidthRound && consistentHeightRound){
    echo("ok");
    translate([r, r, 0]){
      minkowski() {
        cube([v[0]-2*r, v[1]-2*r, v[2]-maxb]);
        ScalpelloMk(r, rt, rb, maxb);
      }
    }
  } else {
    cube(v);
  }
}

//
module Pyramid(h=2, b=2) {
	if( h>0 && b>0){
		p1 = b/2;
		polyhedron(
			[[ p1,  p1, 0],//0
			 [ p1, -p1, 0],
			 [-p1, -p1, 0],
			 [-p1,  p1, 0],
			 [ -0,   0, h]],//4
			[[0,1,2,3],  // bottom
			 [0,1,4],
			 [1,2,4],
			 [2,3,4],
			 [3,0,4]]
		);
	}
}
//
module PyramidThrunk(h = 2, b1=3, b2=1) {
  if(h>0 && b1>0 && b2 >=0) {
    if( b2==0) {
      Pyramid(h, b1);
    } else {
      p1 = b1/2;
      p2 = b2/2;
      polyhedron(
        [[ p1,  p1, 0],//0
         [ p1, -p1, 0],
         [-p1, -p1, 0],
         [-p1,  p1, 0],
         [ p2,  p2, h],
         [ p2, -p2, h],
         [-p2, -p2, h],
         [-p2,  p2, h]],//7
        [[0,1,2,3],  // bottom
         [4,5,1,0],  // front
         [7,6,5,4],  // top
         [5,6,2,1],  // right
         [6,7,3,2],  // back
         [7,4,0,3]] // left]
      );
    }
  }
} 
//
//ScalpelloMk(0.2,.2,.7,.5, $fn=40);
module ScalpelloMk(r = 0, ru = 0, rl = 0, h = 1) {
  echo("<b>Scalpello</b>",h=h, r=r, ru=ru, rl=rl);
  h1 = h-max(0,rl)-max(0,ru);
  if(r > 0){
    translate([0, 0, max(0,rl)]) 
      hull(){
        if(ru > 0) {
          translate([0, 0, max(0,h1)])
          HalfEllissoid(r, ru);
        }
        if(h1>0){
          cylinder(h=h1, r=r);
        }
        if(rl > 0){
          
          mirror([0,0,1]) HalfEllissoid(r, rl);
        }
      }
  }
}
//
module Rettangolo(l, h){
 polyhedron(
        [
         [ 0,  0, 0],//0
         [ 0,  l, 0],
         [ l,  0, 0],
         [ 0,  0, h],
         [ 0,  l, h],
         [ l,  0, h] //5
        ],
        [
         [0,2,1],  // bottom
         [0,1,4,3],  // cateto1
         [1,2,5,4], //ipo
         [0,3,5,2], // cateto2
         [3,4,5] //sotto
        ]
      );
}
//
module HalfEllissoid(r1 = 1, r2 = 1) {
  resize([2*r1, 2*r1, r2]) HalfSphere(r1);
}
//
module HalfSphere(r = 0, reduction= "none") {
  if(r>0) {
    hull() difference() {
      sphere(r);
      translate([-r, -r, -2*r]) cube(2*r, center = false);
      if(reduction == "half" || reduction == "quarter") translate([-r, -2*r, 0]) cube(2*r, center = false);
      if(reduction == "quarter") translate([-r, 0, 0]) cube(r, center = false);
    }
  }
}
//
module Provetta() {
  //translate(up)cylinder(d=ud, h=uh);
 }

