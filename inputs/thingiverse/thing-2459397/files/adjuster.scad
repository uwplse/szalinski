

ratio = 10;
size = 100;

l1 = size;
l2 = size/ratio;
extend = 10;
width = 5;
bt = 2;

ah = l2;
bend_len = 1.2;
bend_thick = 0.9;


totlen = l1+l2+2*extend;

eah = ah*1.5+bend_len;

nt = floor (eah+1.0);
fbt = 5 * floor  (nt/5);

//echo ("eah = ", eah, "nt = ", nt);
//echo ("fbt = ", fbt);

module adjuster () 
{
  cube ([totlen,width, bt]);
  translate ([extend+l2,0,0]) 
    translate ([0,0,ah/2]) rotate (-90) rotate ([0,-90,0]) cylinder (r=ah,h=width, $fn=3);
  
  translate ([extend+l2-bend_thick/2,0,ah*1.5-1.]) 
    cube ([bend_thick, width, bend_len+1.5]); 
  
  translate ([extend+l2,0,eah]) {
    rotate ([0,9,0]) {

      //      translate ([0,-width/2,0]) rotate ([-90,0,0]) cylinder (r=1,h=2*width, $fs=0.2);

      translate ([0,0,bt*1.5]) {
	translate ([-l2,0,0]) cube ([l1+l2-bt*sqrt(3)/2,width, bt]);
	//  cube ([l1+l2,width/2, bt]);
	translate ([0,0,0]) 
	  rotate (90) rotate ([0,90,0]) cylinder (r=bt*2,h=width, $fn=3);
	translate ([-l2-bt,0,0]) cube ([bt*2,width, 2*bt]);
      
	translate ([l1-bt/sqrt(3),0,bt/2])   rotate ([-90,0,0]) cylinder (r=bt/sqrt(3),h=width, $fn=3);
      }
    }
    translate ([0,0,bt*1.5]) {
      for (i=[-nt:1:nt]) {
	rotate ([0,atan (i / l1),0]) translate ([l1+bt/sqrt(3)+1,0,bt/2])   rotate ([-90,,0]) rotate (180) cylinder (r=bt/sqrt(3),h=width, $fn=3);
      }
      
      for (i=[-fbt:5:fbt]) {
	rotate ([0,atan (i / l1),0]) translate ([l1+bt/sqrt(3)+1,0,bt/2])   rotate ([-90,,0]) rotate (180) cylinder (r=bt/sqrt(3)+.3,h=width, $fn=3);
	}
      
      intersection () {
	translate ([l1-width,0,-eah-1.5*bt]) cube ([width*2, width,(eah+1.5*bt)*2]);
	difference () {
	  rotate ([-90,0,0])   cylinder (r=l1+bt+3,h=width,$fa=1);
	  translate ([0,-0.1,0]) rotate ([-90,0,0])   cylinder (r=l1+bt,h=width+.2,$fa=1);
	}
      }
    }
  }
}


//rotate ([90,0,0]) 
adjuster ();



