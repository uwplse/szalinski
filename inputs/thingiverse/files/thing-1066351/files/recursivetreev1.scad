module rec(level=3, rr1=2, rr2=1.8, lh=20, c=3, a=45, amod=.1, deltarr=.6, deltalh=.8 , deltaa=1.1, roffset = 0) {
  cylinder(r1=rr1, r2=rr2,h=lh);
  if (level > 1) {
    translate([0,0,lh]) {
      for (r=[360/c:360/c:360])
        translate([0,0,-rr1 ]) rotate([0,a -((r - 360/c ) * amod) ,r + roffset]) rec(level=level-1, rr1=rr2, rr2=rr2*deltarr, lh=lh *deltalh, c=c,  a=a*deltaa, amod=amod, deltarr=deltarr, deltalh=deltalh, deltaa=deltaa, roffset=roffset+1);
    }
  }
}

rec(level=4, rr1=2, rr2=1.2, lh=20, c=5, a=25, amod=0.35, deltarr=.5, deltalh=.75, deltaa=.7, roffset = -50, $fn=20);