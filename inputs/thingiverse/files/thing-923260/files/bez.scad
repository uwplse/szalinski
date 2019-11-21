////////////////////
//Easy Bez-curve generator by Torleif Ceder 2015 Creative Commons - Attribution - Share Alike
////////////////////
// preview[view:south west, tilt:top diagonal]
//RandomSeed
seed = 1789; //[1111:9999]
part = 0; //[1,2,3,4,5]
controlpoints=5;//[1:20]
thickest=15;//[5:50]
detail = 0.02; //[0.01:0.001:0.5]
fn = 10; //[8:30]
rad=5;//[1:0.5:12]
tang=2;//[1:10]
//some random 4D points
v = [
  for(i = [0: controlpoints])[rands(0, 100*sign(i), 1)[0], rands(0, 100*sign(i), 1)[0], rands(0, 100*sign(i), 1)[0], rands(1, thickest, 1)[0]]
];
module yourmodule(i){
    //anything in this module will be copeid and rotatdet along curve (v) at (detail) intevall
    for (j=[0:360/rad:360]){
    rotate([j,0,0])translate([0,0, bez2(i, v)[3]*0.5])
        
        // anything here//////////////
        scale([0.5,0.5,1])rotate([0, 90, 0])cube( [bez2(i, v)[3]/2*tang,bez2(i, v)[3]/2,bez2(i, v)[3]/2], $fn= fn,center=true);
    //////////////////
        }
    }  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
//main call
bline(v);
// Bline module
module bline(v) {
     translate([bez2(0  , v)[0],bez2(0  , v)[1],bez2(0  , v)[2]])rotate(bez2euler (0,v))           yourmodule(0);
    for(i = [detail: detail: 1]) {
      
        translate([bez2(i  , v)[0],bez2(i  , v)[1],bez2(i  , v)[2]])rotate(bez2euler (i,v))           yourmodule(i);
           
        
      hull() {
        translate([bez2(i, v)[0], bez2(i, v)[1], bez2(i, v)[2]]) rotate(bez2euler(i, v)) rotate([0, 90, 0]) {
          sphere(d = bez2(i, v)[3], $fn = fn);
        };
        translate(t(bez2(i - detail, v))) rotate(bez2euler(i - detail, v)) rotate([0, 90, 0]) sphere(d = bez2(i - detail, v)[3], $fn = fn);
      }
    }
  }
  //The recusive
function bez2(t, v) = (len(v) > 2) ? bez2(t, [
  for(i = [0: len(v) - 2]) v[i] * t + v[i + 1] * (1 - t)
]): v[0] * t + v[1] * (1 - t);

//
function lim31(l, v) = v / len3(v) * l;

function len3(v) = sqrt(pow(v[0], 2) + pow(v[1], 2) + pow(v[2], 2));
// unit normal to euler angles
function bez2euler(i, v) = [0, -asin(bez2v(i, v)[2]), atan2(bez2xy(bez2v(i, v))[1], bez2xy(bez2v(i, v))[0])];

function bez2xy(v) = lim31(1, [v[0], v[1], 0]); // down xy projection
function bez2v(i, v) = lim31(1, bez2(i - 0.0001, v) - bez2(i, v)); // unit vector at i
function t(v) = [v[0], v[1], v[2]];
