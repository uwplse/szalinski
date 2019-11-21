/*          
            Shabbat Candle Holder
            Steve Medwin
            April 2015
*/
$fn=100*1.0;  
// preview[view:north east, tilt:top diagonal]

// user parameters
// height (mm) =
Top = 50;    // [40:70]
// height (mm) =
Middle = 30;    // [20:40]
// at middle (mm) =
Width = 40;     // [30:80]
// side (mm) =
Star = 20;      // [10:30]
// in star
Taper = 3;   // [1:4]
// diameter (mm) =
Candle = 25.0;  // [9:30] 

// other parameters
// star of david
s = Star; 
t = 5*1.0; 
h = tan(60)*s/2;
h1 = t/sin(30);
h2 = h + t*2;
ztaper = Taper/4;

// polygon profile that is rotated
Xr = Candle/2;
Xa = h2; 
Yb = 9.3*1.0;
Xc = 9.3*1.0;
Yd = 18.6*1.0;
Xe = Width/2;
Ye = Middle;
Xf = Xr + 4;
Yf = Top;
Yg = Yf - 4;

difference() {
    rotate_extrude(convexity=10)
    polygon( points=[[0,0],[Xa,0],[Xa,Yb/2],[Xc,Yb/2],[Xc,Yd],[Xe,Ye],[Xf,Yf],[0,Yg]]); 
    translate([0,0,Ye]) cylinder(h = Yf, r=Xr, $fn=50);     // subtract cylinder for candle
}

for (i=[0:5]) {
   rotate([0,0,60*i])   translate([0,h2,0]) 
   linear_extrude(height = Yb, center = false, convexity = 10, twist = 0, scale = ztaper) 
   polygon(points=[[s/2,0],[0,h],[-s/2,0],[s/2+h1*cos(30),-t],[0,h+h1],[-s/2-h1*cos(30),-t]], paths=[[0,1,2],[3,4,5]]);
   }
       
