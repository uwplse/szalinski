// TPU coin card


// percentage inset of coin into card, suggset 60 for hard plastic, 70 for tpu
inset = 70;  // [51:90]
// percentage of coin diameter for viewing window
windowp = 85; // [ 0:95]
// If the top doesn't build right, try making it solid
toptype = 1; // [ 0:round , 1:partial flat, 2:solid ]

// horizontal wall thickness
hwall = 0.5;
// vertical wall thickness
vwall = 1.5;
// border band wall width; suggest 2 for tpu, 0 for hard plastic
bwall = 2; 
// side walls need to be a hair thicker than other horizontal walls
swall = 2;

// slot thickness for two of the thickest coin (1.7*2 for 2 quarters)
sloth = 3.4;

// coin diameters rounded up for tolerance, 2 columns (mm, penny=19.05, nickle=21.21, dime=17.91, quarter=24.26)
coins = [ [ 19.2, 24.3], [21.3, 18], [ 24.3, 19.2 ] ];
// coin thicknesses (mm, rounded up) (penny=1.52, nickle=1.95, dime=1.35, quarter=1.75)
coinh = [ [ 1.5, 1.7 ], [ 2, 1.5 ] , [ 1.7, 1.5 ] ];
// penny quarter
// nickle dime
// quarter penny

/* [extras] */
$fn = 50;
// round corner radius
roundr = 3;
    
function widest(v, i=0, r1=0, r2=0) = i<len(v) ? widest(v,i+1,r1>r2?r1:r2, v[i][0]+v[i][1]) : (r1>r2?r1:r2);

width = widest(coins)* inset/100 + hwall;
height = vwall + sloth + vwall;
height2 = height+sloth*2;

function makeoffsets(v, i=0, off=[swall, swall]) = i<len(v) ? concat( [ off+v[i]*0.5], 
    makeoffsets(v,i+1,off+v[i]+[hwall,hwall])) : [off];

offsets = makeoffsets(coins);
echo(offsets);

lengthv = offsets[len(offsets)-1];
length = (lengthv[0]>lengthv[1] ? lengthv[0] : lengthv[1])-hwall+swall; 
// center the shorter side
centero = (lengthv[0]>lengthv[1]) ? [ 0, (lengthv[0]-lengthv[1])/2] : [ (lengthv[1]-lengthv[0])/2, 0];

echo("width",width, lengthv, "length",length, len(coins));
echo("centero",centero,lengthv);
echo(coins);

/* [Hidden] */
eps = 0.01;

module roundcorner(x=0,y=0,r=0) 
{
    translate([x,y,-eps]) rotate([0,0,r])
    difference() {
        translate([-eps,-eps,0]) cube([roundr+eps, roundr+eps, height+eps*2]);
        translate([roundr,roundr,0]) cylinder(r=roundr, h=height+eps*2);
    }
}

difference() {  
    union() {
        difference() {
            cube([width, length, height]);
            // cutouts for coins
            translate([0,0,vwall]) for (i=[0:len(coins)-1]) {
                translate([ coins[i][0]*(inset-50)/100, offsets[i][0]+centero[0], 0]){
                    translate([0,0,sloth-coinh[i][0]*2])
                    cylinder(h=coinh[i][0]*2, d=coins[i][0]);
                    // window
                    translate([0,0,-vwall-0.01])
                    cylinder(h=(toptype==2)?height/2:height2, d=coins[i][0]*windowp/100);
                }
                translate([ width-coins[i][1]*(inset-50)/100, offsets[i][1]+centero[1],0]) {
                    //translate([0,0, sloth-coinh[i][1]*2])
                    cylinder(h=coinh[i][1]*2, d=coins[i][1]);
                    // window
                    translate([0,0,-vwall-0.01])
                    cylinder(h=toptype==2?height/2:height2,  d=coins[i][1]*windowp/100);
               }
            }
        }
        // put back a thin border to hold it together
        difference() {
            union() {
                cube([width, length, vwall]);
                translate([0,0,vwall+sloth]) cube([width, length, vwall]);
            }
            translate([bwall, bwall, -1]) cube([width-bwall*2, length-bwall*2, height+2]);
        }
        // try a strip down the top middle to reduce unprintable overhangs
        if (toptype==1)
            translate([width/3, 0, vwall+sloth]) cube([width/3, length, vwall]);
    }
    // round the corners
    roundcorner();
    roundcorner(width,0,90);
    roundcorner(width, length, 180);
    roundcorner(0,length,-90);
}

