module rec(level=4, rr=2, lh=10, c=3, a=30, scale=0.8) {
  echo(level, rr, lh, c, a);
  cylinder(r1=rr, r2=rr*scale, h=lh);
  translate([0,0,lh]) sphere(rr*scale);
  if (level==1) translate([0,0,scale*lh]) sphere(lh/2);
  if (level==2) translate([0,0,(1+scale)*lh]) sphere(lh/2);
  if (level > 1) {
    translate([0,0,lh]) {
      for (r=[360/c:360/c:360])
        rotate([0,a,r]) 
			 rec(level=level-1, rr=rr*rands(0.5,1,1)[0], 
				lh=lh*rands(0.5,1,1)[0], c=floor(rands(2,6,1)[0]));
    }
  }
}

rec(c=5,$fn=32);