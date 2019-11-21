
/* [Card settings] */
height = 30; //Height of card or length if you will
width = 135; // widt of card
depth = 1; // the depth or thickness of the card
figureOffset = 30; // how many mm from the right side should snowflake be placed
holeOffset = 10; //how many mm from the right side shuld the card hole be placed
$fn = 32; //The resolution of circle faces

/* [Text settings] */
size = 12; //Text size;
textDepth = 1; // Thickness of text;
nameFont = "Liberation Sans:style= Italic"; //Font for big text
adverbFont = "Liberation Sans:style= Italic"; //Font for small text
name = "Thingiverse"; // Large text;
adverb = "For:"; // Small text;

/* [Snowflake settings] */
el = 10; // edge length at max radius
ft = textDepth; // flake thickness
cmt = el / 20; // crystal max thickness
xw = 1; // extrude width
nc = 4; // number of crystals
bw = 1; // backbone width

rs = 46619; //[0:100000]

//rs = floor(rands(0,pow(10,6),1)[0]); // random number seed.
//rs = 46619;
//rs = 338992;
//rs = 55176;
//rs = 713944;
//rs = 434209;
//rs = 310382;
//rs = 208475;


module tag(){

  textHeight = size+size/8 + size/2;

  marginL = width/20;
  marginB = (height/2-textHeight/2);

  echo(textHeight);
  echo(height);
  echo(marginB);
  color([0.2,0.7,0.2])translate([marginL,marginB,depth])union(){
    translate([0,size+size/8,0])linear_extrude(textDepth)text(adverb, size = size/2,font = adverbFont);
    translate([0,0,0])linear_extrude(textDepth)text(name, size, font = nameFont);
  }

  color([0.2,0.7,0.2])translate([marginL,marginB/3,depth])cube([width-(height/1.5),size/12,textDepth]);
  color([0.2,0.7,0.2])translate([marginL,height-(marginB/3)-size/12,depth])cube([width-(height/1.5),size/12,textDepth]);
  color([0.2,0.7,0.2])translate([width-figureOffset,height/2,depth])snowflake();

  color([0.9,0,0])difference(){
    cube([width,height,depth]);
    translate([width,0,0])rotate(45)cube(height/2,center = true);
    translate([width,height,0])rotate(45)cube(height/2,center = true);
    translate([width-holeOffset,height/2,-1])cylinder(h = depth+2, r=height/10);
  }
}


tag();


echo("Random number seed: ", rs);

cit = xw; // crystal min thickness
th = sqrt(3) * el/2; // triangle height

// random vector (x, y, length, direction, thickness)
rv = rands(0,1,nc*5, seed_value = rs);

// the idea on how to do this is loosely based on origami snowflakes as at:
// http://www.marthastewart.com/276331/how-to-make-paper-snowflakes
// combined with Wilson Bentley's observations of snowflakes
// http://en.wikipedia.org/wiki/Wilson_Bentley

module flake_part(){
	rotate([0,0,30]) translate([0,-el/2,0])
		square([bw,el], center = true);
	for(i = [0:nc-1]){
		assign(yr = sqrt(rv[i*4]),
		   xr = rv[i*4+1] * sqrt(rv[i*4]),
		   rt = (rv[i*4+2]<(1/3))?0:(rv[i*4+2]<(2/3))?60:120,
		   sl = rv[i*4+3],
		   ct = (rv[i*4+4])*(rv[i*4+4])){
			if(((rt != 120) || (yr + sl/2 < 1)) && (sl*el/2 > xw)){
				translate([xr*el/2, -yr*th,0]) rotate(rt)
					square([sl*el/2, cit + max(0,cmt*ct/2-cit)],
					   center = true, $fa = 60);
			}
		}
	}
}

module snowflake(){
  linear_extrude(height=ft){
		for(ri = [0:60:300]){
			rotate([0,0,ri]) flake_part();
			rotate([0,180,ri]) flake_part();
		}
	}
}

echo("Done!");
