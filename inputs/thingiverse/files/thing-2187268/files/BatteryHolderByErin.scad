/*
   FLEXBATTER: Flexing battery holder with built-in spring
 
   This file generates battery holders for arbitrary cylindrical sizes.
   The number of batteries compartments, the number of batteries in each compartment
   and the battery size are fully parametrized.
 
   The usual metallic spring at the minus pole is replaced by a
   flexible printed spring, which is pressing the contacts firmly to 
   the battery.
 
   The contacts for the plus and minus pole can easily be made by
   a few windings of the uninsulated ends of the connecting wires.
   Each battery compartment contains are several holes to the outside
   as well ad to the neighboring compartments, through which connecting
   wires can be passed for easy configuring of parallel, serial or
   balanced-serial battery packs.
   
   The preconfigured battery sizes are:
   AA, AAA, C, D, 18650(Li-Ion), 18650P(protected Li-Ion), CR123A(16340)
   
   Given that the printed plastic spring needs to be flexible, ABS is the material
   of choice here.
 
 
   2014-09-09 Heinz Spiess, Switzerland
   2015-07-25 multi-cell compartments added
 
   released under Creative Commons - Attribution - Share Alike licence (CC BY-SA)


   Updated by Aaron Ciuffo 
    1 April 2016
   Changes:
     * removed depricated assign() statements
     * switched to block quotes
     * added meta-module battery() to make library calls easier
     * implemented battery definition and lookup to make library calls easier
     * added customizer section
     * fixed missing cutouts inside parallel cells on Y face as per Heinz suggestion

    5 April 2016
      * updated engraving to alternate +/-; -/+; +/- in cells
        - thanks to [infinigrove](http://www.thingiverse.com/infinigrove)

    Usage:
      * battery(type = <battery name>, n = <num parallel cells>, m = <num series cells>);


*/

/* [Battery Type and Configuration] */
cell = 1; //[0:AAA, 1:AA, 2:C, 3:D, 4:Li18650, 5:Li18650P, 6:CR123A, 7:Li26650]
ParallelCells = 3; //[1:10]
SeriesCells = 1; //[1:3]
AlternateSymbols = 1; //[0:False, 1:True]


/* [Hidden] */
// preview[view:south, tilt:top]
// not sure what these do, but they are refferenced by several battery vars
ew=0.56;   // extrusion width
eh=0.25;   // extrusion height


// Defined battery types
/*
module flexbatter18650(n=1,m=1,deepen=0,df=1,oh=0){
   flexbatter(n=n,m=m,deepen=deepen,df=df,oh=oh,l=65.2,lcorr=0.3,d=18.4,hf=0.75,shd=3,eps=0.28);
}  
*/
Li18650 = [
  ["len", 65.2],            // l:       length of cell
  ["dia", 18.4],          // d:       diameter of cell
  ["cellHeight", 0.75],   // hf:      relative height of cell (1 = full diameter)
  ["screwHole", 3],     // shd:     screw hole diamter
  ["eps", 0.28],          // eps:     extra diameter space
  ["overHang", 0],        // oh:      overhang to avoid lifting of cell
  ["lenCorrect", 0.3],    // lcorr:   length correction for multi-cell compartments 
  ["cutDepth", 0],        // deepen:  relative deepning for side grip
  ["df", 1]               // df:      relative deepening radius
];

/*
module flexbatter18650P(n=1,m=1){
   flexbatter(n=n,m=m,l=70,lcorr=0,d=18.4,hf=0.75,shd=3,eps=0.28);
} 
*/
Li18650P = [
  ["len", 70],            // l:       length of cell
  ["dia", 18.4],          // d:       diameter of cell
  ["cellHeight", 0.75],   // hf:      relative height of cell (1 = full diameter)
  ["screwHole", 3],       // shd:     screw hole diamter
  ["eps", 0.28],          // eps:     extra diameter space
  ["lenCorrect", 0],      // lcorr:   length correction for multi-cell compartments 
];


/*
module flexbatterCR123A(n=1,m=1){
   flexbatter(n=n,m=m,l=35.1,lcorr=0,d=16.7,hf=0.75,shd=3,xchan=[0.5],eps=0.28);
}  
*/
CR123A = [
  ["len", 35.1],            // l:       length of cell
  ["dia", 16.7],            // d:       diameter of cell
  ["cellHeight", 0.75],     // hf:      relative height of cell (1 = full diameter)
  ["screwHole", 3],         // shd:     screw hole diamter
  ["eps", 0.28],            // eps:     extra diameter space
  ["overHang", 0],          // oh:      overhang to avoid lifting of cell
  ["springExtra", 0],       // el:      extra spring length
  ["xChan", [0.5]],         // xchan:
];

/*
module flexbatterD(n=1,m=1){
   flexbatter(n=n,m=m,l=61.5,lcorr=0,d=34.0,hf=0.75,shd=3,eps=0.28);
} 
*/
D = [
  ["len", 61.5],            // l:       length of cell
  ["dia", 34.0],            // d:       diameter of cell
  ["cellHeight", 0.75],     // hf:      relative height of cell (1 = full diameter)
  ["screwHole", 3],         // shd:     screw hole diamter
  ["eps", 0.28],            // eps:     extra diameter space
  ["lenCorrect", 0],        // lcorr:   length correction for multi-cell compartments 
  ["df", .01],
  ["cutDepth", 0.8],
  ["overHang", ew]
];



/*
module flexbatterC(n=1,m=1,deepen=0,df=1,oh=0){
   flexbatter(n=n,m=m,deepen=deepen,df=df,oh=oh,l=49.6,lcorr=2,d=26.4,hf=0.75,shd=3,eps=0.28);
}  
*/
C = [
  ["len", 49.6],            // l:       length of cell
  ["dia", 26.4],            // d:       diameter of cell
  ["cellHeight", 0.75],     // hf:      relative height of cell (1 = full diameter)
  ["screwHole", 3],         // shd:     screw hole diamter
  ["eps", 0.28],            // eps:     extra diameter space
  ["overHang", ew],         // oh:      overhang to avoid lifting of cell
  ["springExtra", 0],       // el:      extra spring length
  ["lenCorrect", 2],        // lcorr:   length correction for multi-cell compartments 
  ["cutDepth", 0.67],       // deepen:  relative deepning for side grip
  ["df", 0.07]              // df:      relative deepening radius
];

/*
module flexbatterAA(n=1,m=1,Xdeepen=0,Xdf=1,Xoh=0){
   flexbatter(n=n,m=m,Xdeepen=deepen,Xdf=df,oh=oh,Xl=50.0,Xlcorr=1.6,Xd=14.4,Xhf=0.80,Xshd=2.5,Xel=0.5,eps=0.28);
}  
*/
AA = [
  ["len", 50],            // l:       length of cell
  ["dia", 14.4],          // d:       diameter of cell
  ["cellHeight", 0.80],   // hf:      relative height of cell (1 = full diameter)
  ["screwHole", 2.5],     // shd:     screw hole diamter
  ["eps", 0.28],          // eps:     extra diameter space
  ["overHang", ew],       // oh:      overhang to avoid lifting of cell
  ["springExtra", 0.5],   // el:      extra spring length
  ["lenCorrect", 1.6],    // lcorr:   length correction for multi-cell compartments 
  ["cutDepth", 0.7],      // deepen:  relative deepning for side grip
  ["df", 0.25]            // df:      relative deepening radius
];


/*
module flexbatterAAA(n=1,m=1,deepen=0,df=1,oh=0){
   flexbatter(n=n,m=m,deepen=deepen,df=df,oh=oh,l=44.5,lcorr=1.6,d=10.5,hf=0.84,shd=2,el=1,xchan=[0.5],eps=0.2);
}  
*/
AAA = [
  ["len", 44.5],          // l:       length of cell
  ["dia", 10.5],          // d:       diameter of cell
  ["cellHeight", 0.84],   // hf:      relative height of cell (1 = full diameter)
  ["screwHole", 2],       // shd:     screw hole diamter
  ["eps", 0.2],           // eps:     extra diameter space
  ["overHang", 0.4],      // oh:      overhang to avoid lifting of cell
  ["springExtra", 1],     // el:      extra spring length
  ["xChan", 0.5],         // xchan:   relative position of traversal wire channels
  ["lenCorrect", 1.6],    // lcorr:   length correction for multi-cell compartments 
  ["cutDepth", 0.70],     // deepen:  relative deepning for side grip
  ["df", .25]             // df:      relative deepening radius
];

/*
module flexbatter26650(n=1,m=1){
   flexbatter(n=n,m=m,l=65.7,lcorr=0,d=26.4,hf=0.72,shd=3,eps=0.28);
}  
*/
Li26650 = [
  ["len", 65.7],          // l:       length of cell
  ["dia", 26.4],          // d:       diameter of cell
  ["cellHeight", 0.72],   // hf:      relative height of cell (1 = full diameter)
  ["screwHole", 3],       // shd:     screw hole diamter
  ["eps", 0.28],          // eps:     extra diameter space
  ["lenCorrect", 0],      // lcorr:   length correction for multi-cell compartments 
];

// array for customizer
batteryTypes = [AAA, AA, C, D, Li18650, Li18650P, CR123A, Li26650];


module battery(type = AA, n = 1, m = 1, alt = 1) {
  // the search(["foo"], array, num_returns_per_match = 1) returns an array containing
  // the index of the element in array that contains "foo". Element 0 is the match
  l = type[search(["len"], type, num_returns_per_match = 1)[0]][1];
  d = type[search(["dia"], type, num_returns_per_match = 1)[0]][1];
  hf = type[search(["cellHeight"], type, num_returns_per_match = 1)[0]][1];
  shd = type[search(["screwHole"], type, num_returns_per_match = 1)[0]][1];
  eps = type[search(["eps"], type, num_returns_per_match = 1)[0]][1];
  oh = type[search(["overHang"], type, num_returns_per_match = 1)[0]][1];
  el = type[search(["springExtra"], type, num_returns_per_match = 1)[0]][1];
  xchan = type[search(["xChan"], type, num_returns_per_match = 1)[0]][1];
  lcorr = type[search(["lenCorrect"], type, num_returns_per_match = 1)[0]][1];
  deepen = type[search(["cutDepth"], type, num_returns_per_match = 1)[0]][1];
  df = type[search(["df"], type, num_returns_per_match = 1)[0]][1];

  flexbatter(
    n = n==undef ? 1 : n,                   // number of compartments side by side
    m = m==undef ? 1 : m,                   // number of cells in one compartment
    l = l==undef ? 65 : l,                  // length of cell
    d = d==undef ? 18 : d,                  // diameter of cell
    hf = hf==undef ? 0.75 : hf,             // relative hight of cell (1=full diameter)
    shd = shd==undef ? 3 : shd,             // screw hole diameter
    eps = eps==undef ? 0.28 : eps,          // extra diameter space 
    oh = oh==undef ? 0 : oh,                // overhang to avoid lifting of cell
    el = el==undef ? 0 : el,                // extra spring length (needed for small cells)
    xchan = xchan==undef ? [1/4, 3/4] : xchan, // relative position of traversal wire channels
    deepen = deepen==undef ? 0 : deepen,    // relative deepening for side grip of batteries 
    df = df==undef ? 1 : df,                // relative deepening radius
    lcorr = lcorr==undef ? 0 : lcorr,       // length correction for multicell compartments
    alt = alt,                              // alternate the battery symbols
    $fn = 24
  );
}

module customizer() {
  color("gold")
  battery(type = batteryTypes[cell], n = ParallelCells, m = SeriesCells, alt = AlternateSymbols);
}

customizer();

//battery(type = AA, n = 5, m = 1, alt = true);
//flexbatter1xAAx3();

// build a cube with chamfered edges
module chamfered_cube(size,d=1){
   hull(){
     translate([d,d,0])cube(size-2*[d,d,0]);
     translate([0,d,d])cube(size-2*[0,d,d]);
     translate([d,0,d])cube(size-2*[d,0,d]);
   }
}


// draw an arc width height h between radius r1..r2 and angles a1..a2
module arc(r1,r2,h,a1=0,a2=0){
     if(a2-a1<=180){
        difference(){
           cylinder(r=r2,h=h);
           translate([0,0,-1])cylinder(r=r1,h=h+2);
	   rotate(a2)translate([-r1-r2,0,-1])cube([2*(r1+r2),2*(r1+r2),h+2]);
	   rotate(a1+180)translate([-r1-r2,0,-1])cube([2*(r1+r2),2*(r1+r2),h+2]);
        }
     } else {
           difference(){
              cylinder(r=r2,h=h);
              translate([0,0,-1])cylinder(r=r1,h=h+2);
              intersection(){
	       rotate(a2)translate([-r1-r2,0,-1])cube([2*(r1+r2),2*(r1+r2),h+2]);
	       rotate(a1+180)translate([-r1-r2,0,-1])cube([2*(r1+r2),2*(r1+r2),h+2]);
	      }
           }
     }
}

                           
// sline - generate a "snake line" of width w and height h 
// with a arbitrary sequence of segments defined by a radius and a turning angle
//
//   angle[i] > 0  left turn / counter-clockwise
//   angle[i] < 0  left turn / clockwise
//   angle[i] = 0  straight segment with length radius[i]
//
                           
// Heinz Spiess, 2014-09-06 (CC BY-SA)
                           
module sline(angle,radius,i,w,h){
   r = abs(radius[i]);
   a = angle[i];
   scale([angle[i]>=0?1:-1,1,1])

      //assign(r=abs(radius[i]))assign(a=angle[i])
         translate([a?r:0,0,0]){
	    translate([-w/2,-r-0.01,0])cube([w,0.02,h]); // tiny overlap!
            if(a)arc(r-w/2,r+w/2,0,a,h=h);
	    else if(r>0)translate([-w/2,-r,0])cube([w,r,h]);
      if(i+1<len(angle))
           rotate(angle[i])
	      translate([a?-r:0,a?0:-r,0])
	         sline(angle,radius,i+1,w,h);
  }
}

// moved this to the hidden section above - not sure what they do, but they're 
// floating between modules here
//ew=0.56;   // extrusion width
//eh=0.25;   // extrusion height


//
//  FLEXBATTER:  Flexing battery holder with integrated plastic spring
//


module flexbatter(
  n=1,             // number of compartments side by side
  m=1,             // number of cells in one compartment
  l=65,            // length of cell
  d=18,            // diameter of cell
  hf=0.75,         // relative hight of cell (1=full diameter)
  shd=3,           // screw hole diameter
  eps=0.28,        // extra diameter space 
  oh=0,            // overhang to avoid lifting of cell
  el=0,            // extra spring length (needed for small cells)
  xchan=[1/4,3/4], // relative position of traversal wire channels
  deepen=0,        // relative deepening for side grip of batteries 
  df=1,            // relative deepening radius
  lcorr=0,         // length correction for multicell compartments
  alt = true,      // alternate the symbols
  $fn=24
  ){

  w = (m>1?6:4)*ew;  // case wall thickness
  wz = 2;            // bottom wall thickness
  ws = 2*ew; // spring wall thickness
  ch = ws; // edge chamfering

  r = d/5+2*ws; // linear spring length (depends on sline() call!)
  L = m*l+lcorr;// corrected overall lenth
  lc = L/m;     // corrected cell length

   for(i=[0:n-1])translate([0,i*(d+2*w-ws),0]){ // generate n battery cases
      jmin = deepen > 0 ? 0 : -1;
      difference(){
         
         union(){
            difference(){
               // main body
               translate([0,-w-d/2,0])
	          chamfered_cube([L+w,d+2*w+(i<n-1?ws:0),hf*d+wz+ch],ch);
	       // main cavity
               //assign(jmin=deepen>0?0:-1)
	       for(j=[0:m-1])translate([j*lc,0,0])hull(){
                  translate([-0.01,-d/2+(j>jmin?oh:0),wz])cube([lc/4,d-(j>jmin?2*oh:0),d+1]);
                  translate([lc*0.75,-d/2+(j<m-1?oh:0),wz])cube([lc/4+0.01,d-(j<m-1?2*oh:0),d+1]);
               }
	       // cavity for locating plastic spring
               translate([-1,-d/2,-1])cube([2,d,d+wz+2]);
	       // small cylindrical carving of walls and bottom
	       translate([-1,0,d/2+wz])rotate([0,90,0])cylinder(r=d/2+eps,h=L+1);
               if(i<n-1)translate([-1,d+2*w-ws,d/2+wz])rotate([0,90,0])cylinder(r=d/2+eps,h=L+1);
            }
      
            // plastic spring for minus pole
            for(sy=[-1,1])scale([1,sy,1]) { //assign(D=d+2*w-2*ws-0.7){
               D = d + 2 * w - 2 * ws - 0.7;
               translate([ch,d/2+w-ws/2,0])rotate(-90)
		  //sline([90,0,120,90,120,90,0],[d/8+2,d/6,d/8-1,d/8,-d/8,d/8,d/2],0,ws,hf*d+w);
		  sline([0,180,0,180,0,-180,0,90,0],[r+ch+el,D/4,el,D/12,el/2,D/12,1+el/2,D/5,D/3],0,ws,hf*d+wz);


            }
         }
      
         // lower and upper holes for contacts
         for(z=[-2*ws,2*ws])
            translate([-2*ws,-w,wz-ws/2+d/2+z])cube([L+2*w+2,2*w,ws]);
      
         // longitudinal bottom wire channel
         translate([-2*ws,0,0])rotate([0,90,0])cylinder(r=wz/2,h=L+w+2+r,$fn=5);
      
         // traversal bottom wire channels
         for(x=L*xchan)translate([x,-d/2-w-1,-eh]) rotate([-90,0,0])cylinder(r=wz/2,h=d+2*w+ws+2,$fn=6);
   
         // grip deepening
	 if(deepen!=0)
	    for (j=[(deepen>0?0:m-1):m-1]) {

	    //assign(adeepen=deepen>0?deepen:-deepen)
	    adeepen=deepen>0?deepen:-deepen;
            translate([j*lc+lc/2-0.5,-d/2-w-0.01,wz+d+df*l])
	       rotate([-90,0,0])
	          cylinder(r=df*l+adeepen*d,h=d+2*w+2*ws+2,$fn=72);
	 //         if(i==0)cylinder(r1=df*l+adeepen*d+ch,r2=df*l+adeepen*d,h=ch+0.02,$fn=72);
	          if(i==n-1)translate([0,0,d+2*w-ch])cylinder(r2=df*l+adeepen*d+ch,r1=df*l+adeepen*d,h=ch+0.02,$fn=72);

               }
         // conical screw holes in corners
         for(x=[7+shd,L-2*shd])for(y=[-d/2+shd,d/2-shd])
             translate([x,y,-1]){
                cylinder(r=shd/2,h=wz+2);
                translate([0,0,wz-shd/2+1])cylinder(r1=shd/2,r2=shd,h=shd/2+0.01);
             }

         // holes for wires passing inside
         for(sy=[-1,1])scale([1,sy,1]){
	    translate([L-1,-d/2,wz])cube([w+2,2,2]);
            for(x=[3,L-7])translate([x,-d/2-w-ws-1,wz])cube([3,w+ws+3,2]); 
            translate([3,-d/2+w/2-0.75,-1])cube([3,1.5,wz+2]); 
            translate([-0.5,-d/2+w/2,0])rotate([0,90,0])cylinder(r=w/2,h=6.5,$fn=5);
         }

         // engrave battery symbol
    // engrave battery symbol
      #for(j=[0:m-1])translate([j*lc,0,0]){
          sy=(l>12*shd)?1:-1; // for short batteries +- on the side
          translate([w+l/2,d/4+1,wz])cube([l/5,d/4.5,4*eh],true);

           //if (i==1) {
          if ((i % 2 == 0) && (alt)) {
          translate([w+l/2+l/10,d/4+1,wz])cube([d/7,d/10,4*eh],true);
           // engrave plus symbol
             translate([w+l/2+l/(sy>0?5:10),sy*(d/4+1),wz]){
                cube([1,d/4,4*eh],true);
                cube([d/4,1,4*eh],true);
                 }
          // engrave minus symbol
             translate([w+l/2-l/(sy>0?5:10),sy*(d/4+1),wz])
                cube([1,d/4,4*eh],true);
             }
             else {
                 translate([w+l/2-l/10,d/4+1,wz])cube([d/7,d/10,4*eh],true);
           // engrave plus symbol
             translate([w+l/2-l/(sy>0?5:10),sy*(d/4+1),wz]){
                cube([1,d/4,4*eh],true);
                cube([d/4,1,4*eh],true);
                 }
          // engrave minus symbol
             translate([w+l/2+l/(sy>0?5:10),sy*(d/4+1),wz])
                cube([1,d/4,4*eh],true);
             }

      }

         /*
	 for(j=[0:m-1])translate([j*lc,0,0]){
	    translate([w+l/2,d/4+1,wz])cube([l/5,d/4.5,4*eh],true);
	    translate([w+l/2+l/10,d/4+1,wz])cube([d/7,d/10,4*eh],true);
	    // engrave plus symbol
	    //assign(sy=(l>12*shd)?1:-1){ // for short batteries +- on the side
	    sy=(l>12*shd)?1:-1; // for short batteries +- on the side
	       translate([w+l/2+l/(sy>0?5:10),sy*(d/4+1),wz]){
	          cube([1,d/4,4*eh],true);
	          cube([d/4,1,4*eh],true);
               }
	    // engrave minus symbol
	       translate([w+l/2-l/(sy>0?5:10),sy*(d/4+1),wz])
	          cube([1,d/4,4*eh],true);
            
	 }
         */
         //correction for middle separators
         //if(i<n-1) translate([-d,d/2+w-ws/2,-1])cube([d,ws/2+0.1,d+2]);
	 //else translate([1,d/2+w,-0.01])cylinder(r1=ch,r2=0,h=ch);
         //if(i>0) translate([-d,-d/2-w-0.1,-1])cube([d,ws/2+0.1,d+2]);
	 //else translate([1,-d/2-w,-0.01])cylinder(r1=ch,r2=0,h=ch);


      }


      // horizontal contact bulges (+ and - pole)
      for(x=[-0.3,L])
         hull()for(y=[-3+el,3-el])
            translate([x,y,wz+d/2])sphere(r=ws);
   
      // vertical contact bulge (+ pole only)
      if(0)hull()for(z=[-3+el,3-el])for(x=[0,w-ws])
            translate([L+x,0,wz+d/2+z])sphere(r=ws);



   }

}

// everything below this point is depricated in favor of the battery() module

/*
module flexbatter18650(n=1,m=1,deepen=0,df=1,oh=0){
   flexbatter(n=n,m=m,deepen=deepen,df=df,oh=oh,l=65.2,lcorr=0.3,d=18.4,hf=0.75,shd=3,eps=0.28);
}  

module flexbatter18650P(n=1,m=1){
   flexbatter(n=n,m=m,l=70,lcorr=0,d=18.4,hf=0.75,shd=3,eps=0.28);
}  

module flexbatterCR123A(n=1,m=1){
   flexbatter(n=n,m=m,l=35.1,lcorr=0,d=16.7,hf=0.75,shd=3,xchan=[0.5],eps=0.28);
}  

module flexbatterD(n=1,m=1){
   flexbatter(n=n,m=m,l=61.5,lcorr=0,d=34.0,hf=0.75,shd=3,eps=0.28);
}  

module flexbatterC(n=1,m=1,deepen=0,df=1,oh=0){
   flexbatter(n=n,m=m,deepen=deepen,df=df,oh=oh,l=49.6,lcorr=2,d=26.4,hf=0.75,shd=3,eps=0.28);
}  

module flexbatterAA(n=1,m=1,deepen=0,df=1,oh=0){
   flexbatter(n=n,m=m,deepen=deepen,df=df,oh=oh,l=50.0,lcorr=1.6,d=14.4,hf=0.80,shd=2.5,el=0.5,eps=0.28);
}  

module flexbatterAAA(n=1,m=1,deepen=0,df=1,oh=0){
   flexbatter(n=n,m=m,deepen=deepen,df=df,oh=oh,l=44.5,lcorr=1.6,d=10.5,hf=0.84,shd=2,el=1,xchan=[0.5],eps=0.2);
}  

module flexbatter26650(n=1,m=1){
   flexbatter(n=n,m=m,l=65.7,lcorr=0,d=26.4,hf=0.72,shd=3,eps=0.28);
}  


module flexbatter18650x1(){ // AUTO_MAKE_STL
  flexbatter18650(n=1);
}

module flexbatter18650Px1(){ // AUTO_MAKE_STL
  flexbatter18650P(n=1);
}

module flexbatterCR123Ax1(){ // AUTO_MAKE_STL
  flexbatterCR123A(n=1);
}

module flexbatterAAx1(){ // AUTO_MAKE_STL
  flexbatterAA(n=1);
}

module flexbatterAAAx1(){ // AUTO_MAKE_STL
  flexbatterAAA(n=1);
}

module flexbatterCx1(){ // AUTO_MAKE_STL
  flexbatterC(n=1);
}

module flexbatter26650x1(){ // AUTO_MAKE_STL
  flexbatter26650(n=1);
}

module flexbatter18650x2(){ // AUTO_MAKE_STL
  flexbatter18650(n=2);
}

module flexbatter18650Px2(){ // AUTO_MAKE_STL
  flexbatter18650P(n=2);
}

module flexbatterAAx2(){ // AUTO_MAKE_STL
  flexbatterAA(n=2);
}

module flexbatterAAAx2(){ // AUTO_MAKE_STL
  flexbatterAAA(n=2);
}

module flexbatterCx2(){ // AUTO_MAKE_STL
  flexbatterC(n=2);
}

module flexbatter26650x2(){ // AUTO_MAKE_STL
  flexbatter26650(n=2);
}

module flexbatter18650x3(){ // AUTO_MAKE_STL
  flexbatter18650(n=3);
}

module flexbatter18650Px3(){ // AUTO_MAKE_STL
  flexbatter18650P(n=3);
}

module flexbatterAAx3(){ // AUTO_MAKE_STL
  flexbatterAA(n=3);
}

module flexbatterAAAx3(){ // AUTO_MAKE_STL
  flexbatterAAA(n=3);
}

module flexbatter26650x3(){ // AUTO_MAKE_STL
  flexbatter26650(n=3);
}

module flexbatter18650x4(){ // AUTO_MAKE_STL
  flexbatter18650(n=4);
}

module flexbatter18650Px4(){ // AUTO_MAKE_STL
  flexbatter18650P(n=4);
}

module flexbatterAAx4(){ // AUTO_MAKE_STL
  flexbatterAA(n=4);
}

module flexbatterAAAx4(){ // AUTO_MAKE_STL
  flexbatterAAA(n=4);
}

module flexbatter26650x4(){ // AUTO_MAKE_STL
  flexbatter26650(n=4);
}

module flexbatter1x18650x2(){ // AUTO_MAKE_STL
  flexbatter18650(n=2,m=1,deepen=0.70,df=0.30,oh=ew);
}

module flexbatter1x18650x3(){ // AUTO_MAKE_STL
  flexbatter18650(n=3,m=1,deepen=0.70,df=0.30,oh=ew);
}

module flexbatter1x18650x4(){ // AUTO_MAKE_STL
  flexbatter18650(n=4,m=1,deepen=0.70,df=0.30,oh=ew);
}

module flexbatter1x18650(){ // AUTO_MAKE_STL
  flexbatter18650(n=1,m=1,deepen=0.70,df=0.30,oh=ew);
}

module flexbatter2x18650(){ // AUTO_MAKE_STL
  flexbatter18650(n=1,m=2,deepen=0.70,df=0.30,oh=ew);
}

module flexbatter2x18650x2(){ // AUTO_MAKE_STL
  flexbatter18650(n=2,m=2,deepen=0.70,df=0.30,oh=ew);
}

module flexbatter1xAAAx2(){ // AUTO_MAKE_STL
  flexbatterAAA(n=2,m=1,deepen=0.70,df=0.25,oh=0.4);
}

module flexbatter1xAAAx3(){ // AUTO_MAKE_STL
  flexbatterAAA(n=3,m=1,deepen=0.70,df=0.25,oh=0.4);
}

module flexbatter1xAAAx4(){ // AUTO_MAKE_STL
  flexbatterAAA(n=4,m=1,deepen=0.70,df=0.25,oh=0.4);
}

module flexbatter1xAAA(){ // AUTO_MAKE_STL
  flexbatterAAA(n=1,m=1,deepen=0.70,df=0.25,oh=0.4);
}

module flexbatter2xAAA(){ // AUTO_MAKE_STL
  flexbatterAAA(n=1,m=2,deepen=0.70,df=0.25,oh=0.4);
}

module flexbatter3xAAA(){ // AUTO_MAKE_STL
  flexbatterAAA(n=1,m=3,deepen=0.70,df=0.25,oh=0.4);
}

module flexbatter2xAAAx2(){ // AUTO_MAKE_STL
  flexbatterAAA(n=2,m=2,deepen=0.70,df=0.25,oh=0.4);
}

module flexbatter1xAAx2(){ // AUTO_MAKE_STL
  flexbatterAA(n=2,m=1,deepen=0.70,df=0.25,oh=ew);
}

module flexbatter1xAAx3(){ // AUTO_MAKE_STL
  flexbatterAA(n=3,m=1,deepen=0.70,df=0.25,oh=ew);
}

module flexbatter1xAAx4(){ // AUTO_MAKE_STL
  flexbatterAA(n=4,m=1,deepen=0.70,df=0.25,oh=ew);
}

module flexbatter1xAA(){ // AUTO_MAKE_STL
  flexbatterAA(n=1,m=1,deepen=0.70,df=0.25,oh=ew);
}

module flexbatter2xAA(){ // AUTO_MAKE_STL
  flexbatterAA(n=1,m=2,deepen=0.70,df=0.25,oh=ew);
}

module flexbatter3xAA(){ // AUTO_MAKE_STL
  flexbatterAA(n=1,m=3,deepen=0.70,df=0.25,oh=ew);
}

module flexbatter2xAAx2(){ // AUTO_MAKE_STL
  flexbatterAA(n=2,m=2,deepen=0.70,df=0.25,oh=ew);
}

module flexbatter1xCx2(){ // AUTO_MAKE_STL
  flexbatterC(n=2,m=1,deepen=0.67,df=0.07,oh=ew);
}

module flexbatter1xCx3(){ // AUTO_MAKE_STL
  flexbatterC(n=3,m=1,deepen=0.67,df=0.07,oh=ew);
}

module flexbatter1xCx4(){ // AUTO_MAKE_STL
  flexbatterC(n=4,m=1,deepen=0.67,df=0.07,oh=ew);
}

module flexbatter1xC(){ // AUTO_MAKE_STL
  flexbatterC(n=1,m=1,deepen=0.67,df=0.07,oh=ew);
}

module flexbatter2xC(){ // AUTO_MAKE_STL
  flexbatterC(n=1,m=2,deepen=0.67,df=0.07,oh=ew);
}

module flexbatter3xC(){ // AUTO_MAKE_STL
  flexbatterC(n=1,m=3,deepen=0.67,df=0.07,oh=ew);
}

module flexbatter2xCx2(){ // AUTO_MAKE_STL
  flexbatterC(n=2,m=2,deepen=0.67,df=0.07,oh=ew);
}
*/
// uncomment as needed:

//flexbatterCR123A(n=2);
//rotate([0,0,0])translate([0,0,-9])flexbatter18650(n=1);
//translate([0,40,0])rotate([90,0,0])translate([0,0,-9])flexbatter18650(n=1);
//translate([0,80,0])rotate([180,0,0])translate([0,0,-9])flexbatter18650(n=1);
//translate([0,120,0])rotate([-90,0,0])translate([0,0,-9])flexbatter18650(n=1);
//translate([0,33,0])flexbatter18650(n=2);
//translate([0,90,0])flexbatter18650(n=3);
//translate([-90,33,0])flexbatter18650(n=4);
//translate([0,28,0])flexbatterAA(n=1);
//translate([0,50,0])flexbatterAAA(n=1);
//flexbatterC(n=1);
//flexbatterD(n=1);
//translate([-25,0,0])flexbatter3xAA();
//translate([0,40,0])flexbatter2xAA();
//translate([0,80,0])flexbatter2xAAx2();
//flexbatter2xAA();


