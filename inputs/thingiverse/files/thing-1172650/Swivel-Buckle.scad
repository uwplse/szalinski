part = "both"; // [male:Male Only, female:Female, both:Two parts]

// 4" strap

// Strap width
strapw = 100;

// Strap/slot thickness
strapt = 6;
// number of slots for the strap
slots = 2; // [0:5]

// thickness of buckle body
buckleh = 6;

// depth of teeth for the slots
teeth=2; // [0:3]

// 1" strap
//strapw = 26;
//strapt = 3;
//slots = 3;
//buckleh = 3;
//teeth = 0;

bucklet = max(5,strapw/8);   // total width = strapw+bucklet
swiveld = max(8,strapw/10);    // diameter of post    
swivelm = swiveld/3;           // overhang around post
swivelh = max(2,buckleh/2);    // height of swivel

// clearance for swivel
swivelc = 0.4;

// throat taper
ttaper = 1.25;

// extra width/height scaling on the female post hole to allow
// rotation and encourage the post to stay where it should stay.
swivelsc = 1.1;

$fn=72;

// common body
module body() {
   so = swiveld*2 + swivelm;
   difference() {
      hull() {
         cylinder(d=swiveld+swivelm+bucklet,h=buckleh);
         
         // front corners
         sy1 = so+(teeth+strapt)*2-strapt/2;
         translate([-strapw/2,sy1,0])
            cylinder(d=strapt+bucklet,h=buckleh);
         translate([strapw/2,sy1,0])
            cylinder(d=strapt+bucklet,h=buckleh);

         // back corners
         sy2 = so+(teeth+strapt)*slots*2+strapt/2;
         translate([-strapw/2,sy2,0])
            cylinder(d=strapt+bucklet,h=buckleh);
         translate([strapw/2,sy2,0])
            cylinder(d=strapt+bucklet,h=buckleh);
      }
      
      if(slots>0) {
         // slots
         for(s=[1:slots]) {
            translate([0,so+(teeth+strapt)*s*2,-.1])
            union() {
               hull() {
                  translate([-strapw/2,0,0])
                     cylinder(d=strapt,h=buckleh*2);
                  translate([strapw/2,0,0])
                     cylinder(d=strapt,h=buckleh*2);
               }
               if( teeth ) {
                  sp = max(5,strapw/8);
                  for(t=[sp/2*(s%2):sp:strapw/2-sp/2]) {
                     translate([t,strapt/2,0])
                        cylinder(d=teeth*2,h=buckleh*2);
                     translate([-t,strapt/2,0])
                        cylinder(d=teeth*2,h=buckleh*2);
                  }
               }
            }
         }
      }
   }
}

module post() {
   // a tapered post means no major overhang we need to support,
   // but start the taper a little higher up so the bottom of
   // the print isn't _starting_ with a taper, which tends to
   // be quite a bit weaker.
   cylinder(d=swiveld,h=swivelh);
   translate([0,0,swivelc*3])
      cylinder(d1=swiveld,d2=swiveld+swivelm,
      h=swivelh-swivelc*2);
   translate([0,0,swivelh+swivelc])
      cylinder(d=swiveld+swivelm,h=swivelh);
}

// need to find the distance of a chord from center of
// circle d1 that's length d2.
// a = 2*sqrt(r^2-d^2), a = d2, r = d1/2, solve for d
function chordD(d1,d2) = 
   sqrt((d1/2)*(d1/2) - (d2/2)*(d2/2));

module slot() {
   sc = swiveld+swivelm*2;
   
   // just a touch larger/deeper than the post itself to
   // encourage the post to stay in that area
   translate([0,0,-swivelc]) scale([swivelsc,swivelsc,1])
      post();

   // hole to insert the entire post to start the connection
   translate([0,sc,0]) cylinder(d=sc,h=swivelh);

   // A short throat between the swivel point and the
   // initial opening.
   // Cut this just wide enough so there's a point
   // of friction (a click, if you will) that it won't back
   // out of easily. This is a pretty fiddly value, but
   // if the friction point is basically just the post diameter
   // then it seems to work. It might need some adjustment
   // if the printer's internal hole sizes are really
   // dialed in.
   // FIXME: might be best to build a spring into this.
   // NOTE: can't just hull() the post.
   hull() {
      // chordD() centers the throat diameter swiveld
      // right in the spot we need it.
      translate([0,chordD(swivelsc*swiveld,swiveld),0])
         cylinder(d=swiveld,h=swivelh);
      
      // the scaling here tapers the throat out.
      translate([0,sc,0]) scale([ttaper,ttaper,1])
         cylinder(d=swiveld,h=swivelh);
   }
   
   // Drop the tapered section since the post
   // overhang has a tendency to sag a touch during printing,
   // leaving an excessively tight fit.
   translate([0,0,swivelc*2])
   hull() {
      translate([0,chordD(swivelsc*swiveld,swiveld),0])
         cylinder(d1=swiveld,d2=swiveld+swivelm,
            h=swivelh-swivelc*2);
      translate([0,sc,0])
         scale([ttaper,ttaper,1])
            cylinder(d1=swiveld,d2=swiveld+swivelm,
               h=swivelh-swivelc*2);
   }
   
   // post top clearance slot
   translate([0,0,swivelh-0.1])
   hull() {
      cylinder(d=sc,h=swivelh+.2);
      translate([0,sc,0]) cylinder(d=sc,h=swivelh+.2);
   }
}

module male() {
   body();
   translate([0,0,buckleh]) post();
}

module female() {
   difference() {
      body();
      translate([0,0,-.01]) slot();
   }
}

if( part=="both" ) {
   offset = (strapw/2+bucklet*2);
   translate([offset,0,0]) male();
   translate([-offset,0,0]) female();
} else if( part=="male" ) {
   male();
} else if( part=="female" ) {
   female();
}