// "Circular Logic" parametric font by Hans Loeblich

// preview[view:south, tilt:top]

// character width
w = 3;
// character height
h = 5; 
// stroke width (recommend s < min(w,h)/3 to keep some space between strokes )
s = 0.9; 
// x spacing, space characters horizontly by w * xs
xs = 1.1; 
// y spacing, space lines vertically by h * ys
ys = 1.1; 
// how many points to use when drawing a cicular arc
resolution = 20; // [4:4:64]

/* [Hidden] */
$fn = resolution;
$err = 0.002;

linear_extrude(1)
  AllChars(w,h,s,xs,ys,false);

// to use this, comment out other lines and from OpenSCAD menu click View -> Animate
// a toolbar will appear below the preview pane, set fps=60 and steps=240 or similar values for the animation to begin
//animated_demo();

module animated_demo(txt) {
  w = osc(2,9,1,0);
  h = 12;
  s = osc(0.1,4,1,0);
  xs = 1.1;
  ys = 1.1;
  $fn = 64;
  echo(w,h,s);
  color([0,1,1,1]) title("CIRCULAR","LOGIC",w,h,s,xs);
}

//color([0,1,1,1]) title("CIRCULAR","LOGIC",10,10,3,1.1);
//title("THE QUICK BROWN FOX JUMPS","OVER THE LAZY DOG",w,h,s,xs);
//title("the quick brown fox jumps","over the lazy dog",w,h,s,xs);
//title("IF YOU CAN READ THIS", "YOURE NOT STROKING IT HARD ENOUGH",3,3,2,xs);
//linear_extrude(1) texter("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse elementum, leo vel lacinia gravida, neque leo scelerisque neque, a tincidunt diam velit a turpis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse convallis, leo sed pulvinar aliquet, eros enim tristique ex, nec cursus enim leo et magna. Nullam laoreet tortor nec quam porta, non pretium lorem interdum. Ut eu ullamcorper arcu. Cras faucibus ex turpis, at bibendum quam interdum non. Ut sodales arcu nisl. Morbi id sem a elit convallis facilisis eu eu ipsum. Aenean sodales sem nec mollis vestibulum. Donec a velit gravida, bibendum velit eu, commodo ipsum. Integer ut euismod nulla. Nam non risus justo. Donec auctor justo vitae orci sollicitudin consequat. Morbi eu quam eu quam auctor commodo. Nulla at suscipit nisl.",w,h,s,xs,false);

// sine oscillator amplitude varies from xmin to xmax, freq is cycles/(total anim time), phase is 0-1 range with 1 being a full wavelength
function osc(xmin=0,xmax=1,freq=1,phase=0) = xmin + (xmax - xmin) * (sin(360*freq*$t+360*phase)+1)/2;

module title(line1, line2, w,h,s, xs) {
  function center(l) = (l*w+(l-1)*w*(xs-1))/2;
  l1 = len(line1);
  l2 = len(line2);
  avg = (l1 + l2) / 2;
  translate([0,-s/2]) {
    translate([-center(l1),2*s]) texter(line1,w,h,s,xs);
    translate([-center(avg),0]) square([center(avg)*2,s]);
    translate([-center(l2),-h-s]) texter(line2,w,h,s,xs);
  }
}

module AllChars(w,h,s,hs,vs,showRule=false) {
  translate([0,h*vs*4]) texter("ABCDE abcde",w,h,s,hs,showRule);
  translate([0,h*vs*3]) texter("FGHIJ fghij",w,h,s,hs,showRule);
  translate([0,h*vs*2]) texter("KLMNO klmno",w,h,s,hs,showRule);
  translate([0,h*vs*1]) texter("PQRST pqrst",w,h,s,hs,showRule);
  translate([0,h*vs*0]) texter("UVWXYZuvwxyz",w,h,s,hs,showRule);
  translate([0,h*vs*-1]) texter("01234",w,h,s,hs,showRule);
  translate([0,h*vs*-2]) texter("56789",w,h,s,hs,showRule);
}

// texter writes a string to 2d font
// txt: string to be displayed
// w: character width
// h: character height
// s: stroke width
// xs: horizontal spacing (distance between characters == w*xs), a value of 1 leaves no space
// showRules: if true, display horizontal guidelines that characters are constructed along
module texter(txt,w,h,s,xs=1.2, showRules=false) {
  
  function osc(xmin=0,xmax=1,freq=1,phase=0) = xmin + (xmax - xmin) * (sin(360*freq*$t+360*phase)+1)/2;
  // calculate the space between strokes given a total dimension and number of strokes to space evenly within
  function space_size(x,s,divs) = (x-divs*s)/(divs-1);
  
  H = space_size(w,s,3); // horizontal gap between strokes, upper or lowercase
  V = space_size(h,s,3); // vertical gap between strokes, uppercase
  v = space_size(h,s,5); // vertical gap between strokes, lowercase
  
  if (showRules) {
    _s = s * 0.05;
    _s = s * 0.05;
    _s2 = _s /2;
    color([1,0,1]) {
      translate([0,0*s + 0*V-_s2]) square([100,_s]);
      translate([0,1*s + 0*V-_s2]) square([100,_s]);
      translate([0,1*s + 1*V-_s2]) square([100,_s]);
      translate([0,2*s + 1*V-_s2]) square([100,_s]);
      translate([0,2*s + 2*V-_s2]) square([100,_s]);
      translate([0,3*s + 2*V-_s2]) square([100,_s]);
    }
    color([0,1,1]) {
      translate([0,-1*s + -1*v-_s2]) square([100,_s]);
      translate([0, 0*s + -1*v-_s2]) square([100,_s]);
      translate([0, 0*s +  0*v-_s2]) square([100,_s]);
      translate([0, 1*s +  0*v-_s2]) square([100,_s]);
      translate([0, 1*s +  1*v-_s2]) square([100,_s]);
      translate([0, 2*s +  1*v-_s2]) square([100,_s]);
      translate([0, 2*s +  2*v-_s2]) square([100,_s]);
      translate([0, 3*s +  2*v-_s2]) square([100,_s]);
      translate([0, 3*s +  3*v-_s2]) square([100,_s]);
      translate([0, 4*s +  3*v-_s2]) square([100,_s]);
    }
  }
  
  // constants representing arc quadrants, for orientation paramter 'o'
  topRight = 0;
  topLeft = 1;
  bottomLeft = 2;
  bottomRight = 3;
  
  // create a 90 arc that fills the dimensions of w x h, 
  // with radius R, stroke-width s, orientation o, and translation offset tr
  module arc90(w,h,R,s,o=0,tr=[0,0]) {
    // apply padding to size, so that pieces are guaranteed to overlap, 
    // regardless of floating point precision issues
    we = w + $err;
    he = h + $err;
    Re = R + $err;
    
    // widen w,h if < stroke width
    wmax = max(w,s)+$err;
    hmax = max(h,s)+$err;
    
    xh = (o == 1 || o == 2) ? R : (s > w ? s - w : 0);
    xv = (o == 1 || o == 2) ? 0 : (s > w ? 0 : w - s);
    yh = o > 1 ? 0 : (s > h ? 0 : h - s);
    yv = o > 1 ? R : (s > h ? s - h : 0);
    // translation offset if box widened for stroke width
    tr2 = [(o == 1 || o == 2) ? 0 : we-wmax, (o > 1) ? 0 : he-hmax];
    translate(tr+tr2) {
      translate([(o == 1 || o == 2) ? R : wmax-Re, o > 1 ? Re : hmax-Re])
        difference() {
          circle(R);
          circle(R-s);
          translate([-R,o > 1 ? 0 : -2*R]) square(R*2);
          translate([o == 1 || o == 2 ? 0 : -2*R,-R]) square(R*2);
        }
      
      if ((w > R) && (2*w >= s)) horizont(w - R, hmax, s, [xh, yh]);
      if ((h > R) && (2*h >= s)) vertical(wmax, h - R, s, [xv, yv]);
    }
  }

  // p: position [0-1] range from bottom to top, accounting for stroke width
  module horizont(w,h,s,tr=[0,0]) {
    $err = 0;
    translate([tr[0]-$err,tr[1]]) square([w+2*$err,s]);
  }

  // p: position [0-1] range from bottom to top, accounting for stroke width
  module vertical(w,h,s,tr=[0,0]) {
    $err = 0;
    translate([tr[0],tr[1]-$err]) square([s,h+2*$err]);
  }

  if ($fn % 4 != 0) echo("Warning: $fn value recommended to be multiple of 4");
  if (w < s *  3) echo("Warning: Value out of recommended bound:  w > s * 3");
  if (h < s *  5) echo("Warning: Value out of recommended bound:  h > s * 5");
  if (w > h * 10) echo("Warning: Value out of recommended bound:  w > h * 10");
  if (h > w * 10) echo("Warning: Value out of recommended bound:  h > w * 10");

  module A() {
    x = w/2; y = h; R = min(x,y);
    arc90(x,y,R,s,topLeft);
    arc90(x,y,R,s,topRight,[x,0]);
    horizont(w-2*s,y,s,[s,1*s + 1*V]);
  } module B() {
    x = 2*s + 2*H; y = 1*s + 0.5*V; R = min(x,y);
    vertical(w,h,s,0);
    arc90(x,y,R,s,topRight,   [s,2*s + 1.5*V]);
    arc90(x,y,R,s,bottomRight,[s,1*s + 1.0*V]);
    arc90(x,y,R,s,topRight,   [s,1*s + 0.5*V]);
    arc90(x,y,R,s,bottomRight,[s,0*s + 0.0*V]);
  } module C() {
    x = w; y = h/2; R = min(x,y);
    arc90(x,y,R,s,bottomLeft);
    arc90(x,y,R,s,topLeft,[0,y]);
  } module D() {
    x = 2*s + 2*H; y = 1.5*s + 1*V; R = min(x,y);
    vertical(w,h,s);
    arc90(x,y,R,s,bottomRight,[s,0]);
    arc90(x,y,R,s,topRight,   [s,y]);
  } module E() {
    F();
    horizont(w,h,s);
  } module F() {
    vertical(w,h,s);
    horizont(w,h,s,[0,1*s + 1*V]);
    horizont(w,h,s,[0,2*s + 2*V]);
  } module G() {
    x = w/2; y = h/2; R = min(x,y);
    arc90(x,y,R,s,topLeft,[0,1.5*s + 1*V]);
    arc90(x,y,R,s,bottomLeft);
    arc90(x,(h-s)/2,min(x,(h-s)/2),s,bottomRight,[x,0]);
    horizont(x,h,s,[x,1*s + 1*V]);
    horizont(x,h,s,[x,2*s + 2*V]);
  } module H() {
    vertical(w,h,s);
    vertical(w,h,s,[2*s + 2*H,0*s + 0*V]);
    horizont(w,h,s,[0*s + 0*H,1*s + 1*V]);
  } module I() {
    vertical(w,h,s,[1*s + 1*H,0*s + 0*V]);
    horizont(w,h,s,[0*s + 0*H,2*s + 2*V]);
    horizont(w,h,s,[0*s + 0*H,0*s + 0*V]);
  } module J() {
    x = w/2; y = (h+s)/2; R = min(x,y);
    vertical(w,1*s + 1*V,s,[2*s + 2*H, 2*s + 1*V]);
    arc90(x,y,R,s,bottomLeft);
    arc90(x,y,R,s,bottomRight,[x,0]);
  } module K() {
    x = w-s; y = (h+s)/2; R = min(x,y);
    arc90(x,y,R,s,topRight,[s,0]);
    arc90(x,y,R,s,bottomRight,[s,y-s]);
    vertical(w,h,s);
  } module L() {
    horizont(w,h,s);
    vertical(w,h,s);
  } module M() {
    x = (w+s)/4; y = h; R = min(x,y);
    arc90(x,y,R,s,topLeft);
    arc90(x,y,R,s,topRight,[x,0]);
    arc90(x,y,R,s,topLeft,[2*x-s,0]);
    arc90(x,y,R,s,topRight,[3*x-s-$err,0]);
  } module N() {
    x = w/2; y = h; R = min(x,y);
    arc90(x,y,R,s,topLeft);
    arc90(x,y,R,s,topRight,[x,0]);
  } module O() {
    x = w/2; y = h/2; R = min(x,y);
    arc90(x,y,R,s,bottomLeft);
    arc90(x,y,R,s,bottomRight,[x,0]);
    arc90(x,y,R,s,topLeft,[0,y]);
    arc90(x,y,R,s,topRight,[x,y]);
  } module P() {
    x = w-s; y = (h+s)/4; R = min(x,y);
    arc90(x,y,R,s,topRight,[s,h-y]);
    arc90(x,y,R,s,bottomRight,[s,h-2*y]);
    vertical(w,h,s);
  } module Q() {
    x = w/2; y = 2*s + 1*v; R = min(x,y);
    O();
    translate([x,0]) intersection() {
      square([x,y]);
      arc90(x,y,R,s,topRight);
    }
  } module R() {
    x = w-s; y = (h+s)/2; R = min(x,y);
    P();
    arc90(x,y,R,s,0,[s,0]);
  } module S() {
    x = 1.5*s + 1*H; y = 1*s + 0.5*V; R = min(x,y);
    arc90(w,y,R,s,topLeft,    [0,2*s + 1.5*V]);
    arc90(x,y,R,s,bottomLeft, [0,1*s + 1*V]);
    arc90(x,y,R,s,topRight,   [1.5*s + 1*H,1*s + 0.5*V]);
    arc90(w,y,R,s,bottomRight,[0,0]);
  } module T() {
    vertical(w,h,s,[1*s + 1*H,0]);
    horizont(w,h,s,[0,2*s + 2*V]);
  } module U() {
    x = w/2; y = h; R = min(x,y);
    arc90(x,y,R,s,bottomLeft);
    arc90(x,y,R,s,bottomRight,[w/2,0]);
  } module V() {
    x = w-s; y = h; R = min(x,y);
    vertical(w,h,s);
    arc90(x,y,R,s,bottomRight,[s,0]);
  } module W() {
    x = (w + s)/4; y = h; R = min(x,y);
    arc90(x,y,R,s,bottomLeft,[0,0]);
    arc90(x,y,R,s,bottomRight,[x,0]);
    arc90(x,y,R,s,bottomLeft,[2*x-s,0]);
    arc90(x,y,R,s,bottomRight,[3*x-s-$err,0]);
  } module X() {
    x = w/2; y = (h+s)/2; R = min(x,y);
    arc90(x,y,R,s,bottomLeft,[0,y-s]);
    arc90(x,y,R,s,bottomRight,[x,y-s]);
    arc90(x,y,R,s,topLeft,[0,0]);
    arc90(x,y,R,s,topRight,[x,0]);
  } module Y() {
    x = w/2; y = (h+s)/2; R = min(x,y);
    arc90(x,y,R,s,bottomLeft,[0,y-s]);
    arc90(x,y,R,s,bottomRight,[x,y-s]);
    vertical(w,h/2,s,[1*s + 1*H,0]);
  } module Z() {
    _7();
    horizont(w,h,s);
  } module _0() {
    O();
  } module _1() {
    vertical(w,h,s,[1*s + 1*H,0]);
  } module _2() {
    x = 1.5*s + 1*H; y = 1*s + 0.5*V; R = min(x,y);
    y2 = 1*s + 1*V; R2 = min(x,y2);
    arc90(w,y,R,s,topRight,[0,3*y-s]);
    arc90(x,y,R,s,bottomRight,[x,2*y-s]);
    arc90(x,y2,R2,s,topLeft,[0,s]);
    horizont(w,h,s);
  } module _3() {
    x = w; y = (h+s)/4; R = min(x,y);
    arc90(x,y,R,s,bottomRight,[0,0]);
    arc90(x,y,R,s,topRight,   [0,1*y]);
    arc90(x,y,R,s,bottomRight,[0,2*y-s]);
    arc90(x,y,R,s,topRight,   [0,3*y-s]);
  } module _4() {
    vertical(w,h,s,[2*s + 2*H,0]);
    horizont(w,h,s,[0,1*s + 1*V]);
    vertical(w,2*s + 1*V,s,[0,1*s + 1*V]);
  } module _5() {
    x = 1.5*s + 1*H; y = 1*s + 0.5*V; R = min(x,y);
    horizont(w,h,s,[0,2*s + 2*V]);
    vertical(w,0.5*s + 0.5*V,s,[0,2*s + 1.5*V]);
    arc90(w,y,R,s,bottomRight);
    arc90(x,y,R,s,topRight,[x,1*s + 0.5*V]);
    arc90(x,y,R,s,bottomLeft,[0,1*s + 1*V]);
  } module _6() {
    x = w/2; y = (h+s)/4; R = min(x,y);
    arc90(w,h-y,R,s,topLeft,[0,y]);
    arc90(x,y,R,s,topLeft,[0,y]);
    arc90(x,y,R,s,topRight,[x,y]);
    arc90(x,y,R,s,bottomRight,[x,0]);
    arc90(x,y,R,s,bottomLeft,[0,0]);
  } module _7() {
    x = 1.5*s + 1*H; y = 1*s + 1*V; R = min(x,y);
    y2 = y; R2 = min(x,y2);
    arc90(x,y+$err,R,s,bottomRight,[x,y]);
    arc90(x,y2+s,R2,s,topLeft,[0,0]);
    horizont(w,h,s,[0,2*s + 2*V]);
  } module _8() {
    x = w/2; y = (h+s)/4; R = min(x,y);
    arc90(x,y,R,s,topLeft,[0,3*y-s]);
    arc90(x,y,R,s,topRight,[x,3*y-s]);
    arc90(x,y,R,s,bottomRight,[x,2*y-s]);
    arc90(x,y,R,s,bottomLeft,[0,2*y-s]);
    arc90(x,y,R,s,topLeft,[0,y]);
    arc90(x,y,R,s,topRight,[x,y]);
    arc90(x,y,R,s,bottomRight,[x,0]);
    arc90(x,y,R,s,bottomLeft);
  } module _9() {
    x = w/2; y = (h+s)/4; R = min(x,y);
    x2 = w; y2 = 1*s + 1*V;
    arc90(x2,y2+s+V/2,min(x,y),s,bottomRight,[0,0]);
    arc90(x,y,R,s,topLeft,[0,3*y-s]);
    arc90(x,y,R,s,topRight,[x,3*y-s]);
    arc90(x,y,R,s,bottomRight,[x,2*y-s]);
    arc90(x,y,R,s,bottomLeft,[0,2*y-s]);
  } module a() {
    y = (h+s)/4;
    o();
    vertical(w,y,s,[2*s + 2*H,0]);
  } module b() {
    o();
    vertical(w,2.5*s + 2*v,s,[0,1.5*s + 1*v]);
  } module c() {
    x = w; y = (h+s)/4; R = min(x,y);
    arc90(x,y,R,s,topLeft,[0,y]);
    arc90(x,y,R,s,bottomLeft,[0,0]);
  } module d() {
    y = (h+s)/4;
    o();
    vertical(w,2.5*s + 2*v,s,[2*s + 2*H,y]);
  } module e() {
    x = 1.5*s + 1*H; y = 1.5*s + 1*v; R = min(x,y);
    arc90(x,y,R,s,topLeft,[0,y]);
    arc90(x,y,R,s,topRight,[w/2,y]);
    arc90(w,1*s + 0.5*V,R,s,bottomLeft,[0,0]);
    horizont(w-s,h,s,[s/2,1*s + 1*v]);
    vertical(w,s/2,s,[2*s + 2*H,1*s + 1*v]);
  } module f() {
    x = (w+s)/2; y = 1*s+1*v; R = min(x,y);
    vertical(w,(h-s)/2,s,[1*s + 1*H,0]);
    horizont(w,h,s,[0,2*s + 2*v]);
    arc90(x,y,R,s,topLeft,[1*s + 1*H,3*s + 2*v]);
  } module g() {
    o();
    x = 1.5*s + 1*H; y = 1.5*s + 1*v; R = min(x,y);
    //vertical(w,1*s + 1*v,s,[2*s + 2*H,0.5*s + 0*v]);
    arc90(x+s/2,y+s+v,R,s,bottomRight,[x-s/2,-1*s + -1*v]);
  } module h() {
    x = w/2; y = (h+s)/2; R = min(x,y);
    vertical(w,4*s + 3*v,s,[0,0]);
    arc90(x,y,R,s,topLeft,[0,0]);
    arc90(x,y,R,s,topRight,[x,0]);
  } module i() {
    y = (h-s)/4;
    vertical(w,(h+s)/2,s,[1*s + 1*H,0]);
    //vertical(w,s,s,[1*s + 1*H,4*s + 4*v]);
    vertical(w,s,s,[1*s + 1*H,3*s + 3*v]);
  } module j() {
    x = 1.5*s + 1*H; y = 2*s + 1*v; R = min(x,y);
    //vertical(w,2*s + 2*v,s,[1*s + 1*H,1*s + 0*v]);
    arc90(x+0.5*s,y+2*s+2*v,R,s,bottomRight,[0,-1*s + -1*v]);
    vertical(w,s,s,[1*s + 1*H,3*s + 3*v]);
  } module k() {
    h2 = (h+s)/2;
    x = w-s; y = (h2 + s)/2; R = min(x,y);
    arc90(x,y,R,s,topRight,[s,0]);
    arc90(x,y,R,s,bottomRight,[s,y-s]);
    vertical(w,4*s + 3*v,s);
  } module l() {
    vertical(w,4*s + 3*v,s,[1*s + 1*H,0]);
  } module m() {
    x = (w+s)/4; y = (h+s)/2; R = min(x,y);
    arc90(x,y,R,s,topLeft);
    arc90(x,y,R,s,topRight,[x,0]);
    arc90(x,y,R,s,topLeft,[2*x-s,0]);
    arc90(x,y,R,s,topRight,[3*x-s-$err,0]);
  } module n() {
    x = w/2; y = (h+s)/2; R = min(x,y);
    arc90(x,y,R,s,topLeft);
    arc90(x,y,R,s,topRight,[x,0]);
  } module o() { 
    x = 1.5*s + 1*H; y = 1.5*s + 1*v; R = min(x,y);
    arc90(x,y,R,s,topRight,[x,y]);
    arc90(x,y,R,s,topLeft,[0,y]);
    arc90(x,y,R,s,bottomRight,[x,0]);
    arc90(x,y,R,s,bottomLeft,[0,0]);
  } module p() {
    o();
    vertical(w, 2.5*s + 2*v,s,[0,-1*s + -1*v]);
  } module q() {
    o();
    vertical(w, 2.5*s + 2*v,s,[2*s + 2*H,-1*s + -1*v]);
  } module r() {
    x = w; y = (h+s)/4; R = min(x,y);
    vertical(w,y,s);
    arc90(w,y,R,s,topLeft,[0,y]);
  } module s() {
    h2 = (h+s)/2;
    x = w/2; y = (h2+s)/4; R = min(x,y);
    arc90(w,y,R,s,topLeft,[0,3*y-s]);
    arc90(x,y,R,s,bottomLeft,[0,2*y-s]);
    arc90(x,y,R,s,topRight,[x,y]);
    arc90(w,y,R,s,bottomRight);
  } module t() {
    vertical(w,3*(h-5*s)/4+s*4,s,[1*s + 1*H,0]);
    horizont(w,h,s,[0,2*s + 2*v]);
  } module u() {
    x = w/2; y = (h+s)/2; R = min(x,y);
    arc90(x,y,R,s,bottomLeft);
    arc90(x,y,R,s,bottomRight,[w/2,0]);
  } module v() {
    x = w-s; y = (h+s)/2; R = min(x,y);
    vertical(w,y,s);
    arc90(x,y,R,s,bottomRight,[s,0]);
  } module w() {
    x = (w + s)/4; y = (h+s)/2; R = min(x,y);
    arc90(x,y,R,s,bottomLeft,[0,0]);
    arc90(x,y,R,s,bottomRight,[x,0]);
    arc90(x,y,R,s,bottomLeft,[2*x-s,0]);
    arc90(x,y,R,s,bottomRight,[3*x-s-$err,0]);
  } module x() {
    h2 = (h+s)/2;
    x = w/2; y = ((h2+s)/2); R = min(x,y);
    arc90(x,y,R,s,bottomLeft,[0,y-s]);
    arc90(x,y,R,s,bottomRight,[x,y-s]);
    arc90(x,y,R,s,topLeft,[0,0]);
    arc90(x,y,R,s,topRight,[x,0]);
  } module y() {
    u();
    x = (w+s)/2; y = 1*s + 1*v; R = min(x,y);
    arc90(2*s+H,y+3*s+2*v,min(1.5*s+H,y+s/2),s,bottomRight,[x-s,-1*s-1*v]);
  } module z() {
    x = w/2; y = (h-s)/4; R = min(x,y);
    arc90(x,y,R,s,bottomRight,[x-$err,y]);
    arc90(x,y+s,R,s,topLeft);
    horizont(w,h,s);
    horizont(w,h,s,[0,2*s + 2*v]);
  }

  for (i = [0:len(txt)-1]) {
    c = txt[i];
    translate([i*w*xs,0]) {
           if (c=="A") A();
      else if (c=="B") B();
      else if (c=="C") C();
      else if (c=="D") D();
      else if (c=="E") E();
      else if (c=="F") F();
      else if (c=="G") G();
      else if (c=="H") H();
      else if (c=="I") I();
      else if (c=="J") J();
      else if (c=="K") K();
      else if (c=="L") L();
      else if (c=="M") M();
      else if (c=="N") N();
      else if (c=="O") O();
      else if (c=="P") P();
      else if (c=="Q") Q();
      else if (c=="R") R();
      else if (c=="S") S();
      else if (c=="T") T();
      else if (c=="U") U();
      else if (c=="V") V();
      else if (c=="W") W();
      else if (c=="X") X();
      else if (c=="Y") Y();
      else if (c=="Z") Z();
      else if (c=="a") a();
      else if (c=="b") b();
      else if (c=="c") c();
      else if (c=="d") d();
      else if (c=="e") e();
      else if (c=="f") f();
      else if (c=="g") g();
      else if (c=="h") h();
      else if (c=="i") i();
      else if (c=="j") j();
      else if (c=="k") k();
      else if (c=="l") l();
      else if (c=="m") m();
      else if (c=="n") n();
      else if (c=="o") o();
      else if (c=="p") p();
      else if (c=="q") q();
      else if (c=="r") r();
      else if (c=="s") s();
      else if (c=="t") t();
      else if (c=="u") u();
      else if (c=="v") v();
      else if (c=="w") w();
      else if (c=="x") x();
      else if (c=="y") y();
      else if (c=="z") z();
      else if (c=="0") _0();
      else if (c=="1") _1();
      else if (c=="2") _2();
      else if (c=="3") _3();
      else if (c=="4") _4();
      else if (c=="5") _5();
      else if (c=="6") _6();
      else if (c=="7") _7();
      else if (c=="8") _8();
      else if (c=="9") _9();
    } 
  }
}