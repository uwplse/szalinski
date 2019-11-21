// author: clayb.rpi@gmail.com
// Remixed by chris@chris-crockett.com
// date: 2013-12-29
// units: mm
// description: a customizable meeple character for games

use <write/Write.scad>  //Change to directory where write.scad resides;
// preview[view:south, tilt:top]

/* [Basic Stats] */
// How many do you need? 1, 8, 10, a legion?
QTY=1;

//Size, in mm, of the meeple. 16 is about right for Carcassonne, 12 for Lords of Waterdeep or go big with a 100mm monster meeple.
SIZE=16;

//For multiple meeples, you might need to adjust the layout for certain equipment
X_OFF = SIZE+2;
Y_OFF = SIZE+4;

/* [Equipment] */
//What sort of headgear should your meeple wear, if any
HEADGEAR=0; //[0:None,1:Fez,2:Bowler Hat,3:Wizard Hat,4:Crown,5:Helm,6:Cleric Helm]
//What should your meeple be holding?
LEFTHAND=0; //[0:None,1:Staff,2:Wizard Staff,3:Shield,4:Sword,5:Mace,6:Shortbow,7:Longbow,8:Greatbow,9:War Mace,10:Maul,11:Buckler,12:Round Shield,13:Fireball]
RIGHTHAND=0; //[0:None,1:Staff,2:Wizard Staff,3:Shield,4:Sword,5:Mace,6:Shortbow,7:Longbow,8:Greatbow,9:War Mace,10:Maul,11:Buckler,12:Round Shield,13:Fireball]
//Currently only affects shields
GRIP_DISTANCE=2; //[2:Close,3:Middle,4:Far]

/* [Decorations] */
//Size of badge, text or symbol
BADGE_HEIGHT = 6;
//Letters are applied to each successive meeple generated, one letter each, repeating text as needed.  Number your meeples, spell out names or messages, go nuts.
CHESTTEXT="y";
//Font:
FONT="Futuristic.dxf"; //[write/Letters.dxf:Basic,write/orbitron.dxf:Futuristic,write/knewave.dxf:Round,write/BlackRose.dxf:Classic,write/braille.dxf:Braille]
//Instead of, or in addition to, a character, include a symbol on the meeple
CHEST_SYMBOL=1;//[0:One Character per Meeple, 1: Entire phrase on each meeple ,2:Club, 3:Diamond, 4:Heart,5:Spade,6:Fireball, 99:Customizer Polygon, 100:Symbol specified in file]
// assumes that the DXF file is 10mm x 10mm starting at 0x0. This does not work in the Thingiverse Customizer yet
SYMBOL_FILENAME="test.dxf"; 
CUSTOM_SYMBOL= [[[2.875000036,4.999999878],[-0.125000173,1.999999951],[0.874999802,1.999999951],[-1.125000149,-0.999999976],[-0.125000173,-0.999999976],[-2.875000036,-4.999999878],[1.87500006,0],[0.874999802,0],[2.624999971,2.999999927],[1.87500006,2.999999927]],[[0,1,2,3,4,5,6,7,8,9]] ]; //[draw_polygon:10x10
// Set to true to also inset the selected symbol into the back of the meeple.
DO_CUTOUT=0;//[0:No,1:Yes] 
//If you want the details to be set out a bit (on the front) set this to something greater than 0 but probably less than 1.
DETAIL_OUTSET=0.25;
//Font vertical offset
FONT_V_OFFSET=0;

/* [Hidden] */
//Add serial numbers to the feet.. highly experimental
SERIALIZE=false; //[false:No,true:Yes]
SERIALIZABLE=false;
SERIAL_ONLY=false;
// Starting numerical index for serial numbers on the right foot.
SERIALIZE_START=0;
//Fixed text for the left foot
SERIALIZE_SERIES="N";
//Font size for the serial numbers
SERIALIZE_SIZE=4;
//Max number of characters for each side of the serialization
SERIALIZE_LENGTH=3;

/* [Hidden] */
MAIN_COLOR="Silver";
DETAIL_COLOR="Gray";
DETAIL_COLOR2="Silver";
ROWS=floor(sqrt(QTY));
COLUMNS=floor(QTY/ROWS);
//Fingertip to fingertip size of the meeple
WIDTH = SIZE;
//Height of the meeple from bottom of the foot to the top of the head, not including headgear.
HEIGHT = WIDTH;
//Depth of the meeple from front to back
THICK = ceil(WIDTH*6/16);
echo("Meeple Thickness:",THICK);
echo("Detail Height:", THICK+DETAIL_OUTSET);
//Size of the head
HEAD_DIAM = WIDTH*5/16;
ROUNDED_RADIUS = WIDTH/16;
//Size of the cutout between the feet.
FOOT_CUTOUT_DIAM = WIDTH*5/16;
AFTER_SCALING=1; //for when I decide to scale down afterward:
$fn=50;

//Headgear

module fez_2d() {
 FEZ_CROWN = HEAD_DIAM*0.8;
 FEZ_BRIM = FEZ_CROWN * (5.5/4);
 FEZ_HEIGHT = FEZ_CROWN;
 FEZ_POSITION = HEIGHT-HEAD_DIAM/3;
 translate([0,FEZ_POSITION])
 {
  translate([0,FEZ_HEIGHT]) scale([1,0.2,1]) circle(FEZ_CROWN/2);
  polygon(points=[[-FEZ_CROWN/2,FEZ_HEIGHT],[FEZ_CROWN/2,FEZ_HEIGHT],[FEZ_BRIM/2,0],[-FEZ_BRIM/2,0]], paths=[[0,1,2,3]]);
 }
}

module bowler_hat_2d() {
  //Bowler Hat, because I want to:
  intersection(){
   union(){
    translate([-0.5*(HEAD_DIAM * 1.2),HEIGHT-HEAD_DIAM/3])
     square([HEAD_DIAM*1.2,HEAD_DIAM*0.2]);
    translate([0,HEIGHT-HEAD_DIAM/5])
     circle(r=HEAD_DIAM/2);
    }
   translate([-HEAD_DIAM*1.2/2, HEIGHT-HEAD_DIAM/3]) square(HEAD_DIAM*1.2);
  }
}

module helm_2d() {
  intersection(){
   union(){
    translate([-0.5*(HEAD_DIAM * 1.2),HEIGHT-HEAD_DIAM/3])
     square([HEAD_DIAM*1.2,HEAD_DIAM*0.2]);
    translate([0,HEIGHT-HEAD_DIAM/5])
     circle(r=HEAD_DIAM/2);
    }
   translate([-HEAD_DIAM*1.2/2, HEIGHT-HEAD_DIAM/3]) square(HEAD_DIAM*1.2);
  }
  translate([-HEAD_DIAM*0.1,HEIGHT-HEAD_DIAM+HEAD_DIAM*0.4]) square([HEAD_DIAM*0.2, HEAD_DIAM*1]);
}

module helm_l2_2d() {
  intersection(){
   union(){
    translate([-0.5*(HEAD_DIAM * 1.2),HEIGHT-HEAD_DIAM/3])
     square([HEAD_DIAM*1.2,HEAD_DIAM*0.2]);
    }
   translate([-HEAD_DIAM*1.2/2, HEIGHT-HEAD_DIAM/3]) square(HEAD_DIAM*1.2);
  }
  translate([-HEAD_DIAM*0.1,HEIGHT-HEAD_DIAM+HEAD_DIAM*0.4]) square([HEAD_DIAM*0.2, HEAD_DIAM*1]);
}

module cleric_helm_2d() {
  intersection(){
   union(){
    translate([-0.5*(HEAD_DIAM * 1.2),HEIGHT-HEAD_DIAM/3])
     square([HEAD_DIAM*1.2,HEAD_DIAM*0.2]);
    translate([0,HEIGHT-HEAD_DIAM*0.1])
     rotate([0,0,90]) circle(r=HEAD_DIAM/1.6, $fn=5);
    }
   translate([-HEAD_DIAM*1.2/2, HEIGHT-HEAD_DIAM/3]) square(HEAD_DIAM*1.2);
  }
  translate([-HEAD_DIAM*0.1,HEIGHT-HEAD_DIAM+HEAD_DIAM*0.4]) square([HEAD_DIAM*0.2, HEAD_DIAM*1.2]);
}

module cleric_helm_l2_2d() {
  intersection(){
   union(){
    translate([-0.5*(HEAD_DIAM * 1.2),HEIGHT-HEAD_DIAM/3])
     square([HEAD_DIAM*1.2,HEAD_DIAM*0.2]);
/*    translate([0,HEIGHT-HEAD_DIAM*0.1])
     rotate([0,0,90]) circle(r=HEAD_DIAM/1.6, $fn=5);*/
    }
   translate([-HEAD_DIAM*1.2/2, HEIGHT-HEAD_DIAM/3]) square(HEAD_DIAM*1.2);
  }
  translate([-HEAD_DIAM*0.1,HEIGHT-HEAD_DIAM+HEAD_DIAM*0.4]) square([HEAD_DIAM*0.2, HEAD_DIAM*1.2]);
}

module wiz_hat_2d() {
  translate([-0.5*(HEAD_DIAM * 1.2),HEIGHT-HEAD_DIAM/3])
  square([HEAD_DIAM*1.2,HEAD_DIAM*0.2]);
  translate([0,HEIGHT-HEAD_DIAM/3]) polygon(points=[[-HEAD_DIAM/2,0],[HEAD_DIAM/2,0],[0,HEAD_DIAM]], paths=[[0,1,2]]);
}

module crown_2d(){
 CROWN_POSITION = HEIGHT;
 translate([0,CROWN_POSITION-HEAD_DIAM/4])
  polygon(points=[
   [-HEAD_DIAM/2,0],
   [-HEAD_DIAM/2,1.5*HEAD_DIAM/5],
   [-HEAD_DIAM/2+HEAD_DIAM/8,HEAD_DIAM/5],
   [-HEAD_DIAM/2+2*HEAD_DIAM/8,1.5*HEAD_DIAM/5],
   [-HEAD_DIAM/2+3*HEAD_DIAM/8,HEAD_DIAM/5],
   [-HEAD_DIAM/2+4*HEAD_DIAM/8,1.5*HEAD_DIAM/5],
   [-HEAD_DIAM/2+5*HEAD_DIAM/8,HEAD_DIAM/5],
   [-HEAD_DIAM/2+6*HEAD_DIAM/8,1.5*HEAD_DIAM/5],
   [-HEAD_DIAM/2+7*HEAD_DIAM/8,HEAD_DIAM/5],
   [HEAD_DIAM/2,1.5*HEAD_DIAM/5],
   [HEAD_DIAM/2,0]
  ], paths=[[0,1,2,3,4,5,6,7,8,9,10]]);
}

// Ambidextrous equipment
module staff_2d(){
 staffWidth=WIDTH/16; //Seems like a good ratio
 translate([(WIDTH/2-staffWidth*2),0.5]) rotate([0,0,-5]) square([staffWidth,HEIGHT]);
}

module wiz_staff_2d(
){
 staffWidth=WIDTH/16; //Seems like a good ratio
 translate([(WIDTH/2-staffWidth*2),0.5])
 rotate([0,0,-5])
 union() {
  square([staffWidth,HEIGHT-staffWidth]);
  translate([staffWidth/2,HEIGHT-staffWidth, 0]) circle(r=staffWidth);
 }
}

module shield_2d() {
 SHEILD_HEIGHT=HEIGHT/2.5;
 SHEILD_WIDTH=SHEILD_HEIGHT*0.8;
 translate([WIDTH/2-SHEILD_WIDTH/GRIP_DISTANCE,HEIGHT/2-SHEILD_HEIGHT/2]) 
  polygon( points=[
    [0,0],
    [-SHEILD_WIDTH/2+SHEILD_WIDTH/8,2*SHEILD_HEIGHT/10],
    [-SHEILD_WIDTH/2, 4*SHEILD_HEIGHT/10],
    [-SHEILD_WIDTH/2, SHEILD_HEIGHT],
    [-SHEILD_WIDTH/2+3*SHEILD_WIDTH/8, 9*SHEILD_HEIGHT/10],
    [0,SHEILD_HEIGHT],
    [SHEILD_WIDTH/2-3*SHEILD_WIDTH/8, 9*SHEILD_HEIGHT/10],
    [SHEILD_WIDTH/2, SHEILD_HEIGHT],
    [SHEILD_WIDTH/2, 4*SHEILD_HEIGHT/10],
    [SHEILD_WIDTH/2-SHEILD_WIDTH/8,2*SHEILD_HEIGHT/10]
   ], paths=[[0,1,2,3,4,5,6,7,8,9]]);
//square([SHEILD_WIDTH,SHEILD_HEIGHT]);
}

module round_sheild_2d(){
 SHEILD_HEIGHT=HEIGHT/3;
 SHEILD_WIDTH=SHEILD_HEIGHT;
 translate([WIDTH/2-SHEILD_WIDTH/GRIP_DISTANCE,HEIGHT/2])
 circle(r=SHEILD_HEIGHT/1.5);
}

module round_sheild_l2_2d(){
 SHEILD_HEIGHT=HEIGHT/3;
 SHEILD_WIDTH=SHEILD_HEIGHT;
 translate([WIDTH/2-SHEILD_WIDTH/GRIP_DISTANCE,HEIGHT/2]){
  difference(){
   circle(r=SHEILD_HEIGHT/1.5);
   circle(r=SHEILD_HEIGHT/1.8);
  }
  difference(){
   circle(r=SHEILD_HEIGHT/2);
  }
 }
}

module buckler_2d(){
 SHEILD_HEIGHT=HEIGHT/3;
 SHEILD_WIDTH=SHEILD_HEIGHT;
 translate([WIDTH/2-SHEILD_WIDTH/GRIP_DISTANCE,HEIGHT/2])
 circle(r=SHEILD_HEIGHT/2);
}

module sword_2d(){
 swordWidth=WIDTH/16; //Seems like a good ratio
 translate([(WIDTH/2-swordWidth*2),HEIGHT/2-ROUNDED_RADIUS+0.5]) rotate([0,0,-5])
  union(){
   square([swordWidth,HEIGHT/2]);
   polygon(points=[
    [0,HEIGHT/2],
    [swordWidth/2,HEIGHT/2+swordWidth],
    [swordWidth,HEIGHT/2]
   ],paths=[[0,1,2]]);
  }
}

module mace_2d(){
 maceWidth=WIDTH/16; //Seems like a good ratio
 translate([(WIDTH/2-maceWidth*2),HEIGHT/2-ROUNDED_RADIUS+0.5])
 rotate([0,0,-5])
 union() {
  square([1,HEIGHT/2-maceWidth]);
  translate([maceWidth/1.5,HEIGHT/2-maceWidth, 0]) circle(r=maceWidth);
 }
}

module warmace_2d(){
 maceWidth=WIDTH/16; //Seems like a good ratio
 translate([(WIDTH/2-maceWidth*2),HEIGHT/2-ROUNDED_RADIUS+0.5])
 rotate([0,0,-5])
 union() {
  square([1,HEIGHT/2-maceWidth]);
  translate([maceWidth/1.5,HEIGHT/2-maceWidth, 0]) circle(r=maceWidth);
  translate([maceWidth/1.5,HEIGHT/2-maceWidth*3.5, 0]) rotate([0,0,45]) square(maceWidth*2);
  translate([maceWidth/1.5,HEIGHT/2-maceWidth*3, 0]) circle(r=maceWidth);
 }
}

module maul_2d(){
 maceWidth=WIDTH/16; //Seems like a good ratio
 translate([(WIDTH/2-maceWidth*2),HEIGHT/2-ROUNDED_RADIUS+0.5])
 rotate([0,0,-5])
 union() {
  square([1,HEIGHT/2-maceWidth]);
  translate([maceWidth/1.5,HEIGHT/2-maceWidth*2.5, 0]) rotate([0,0,0]) square([maceWidth*3.5,maceWidth*2],center=true);
 }
}

module maul_l2_2d(){
 maceWidth=WIDTH/16; //Seems like a good ratio
 translate([(WIDTH/2-maceWidth*2),HEIGHT/2-ROUNDED_RADIUS+0.5])
 rotate([0,0,-5])
 union() {
  translate([maceWidth/1.5,HEIGHT/2-maceWidth*2.5, 0]) rotate([0,0,0]) square([maceWidth*3.5,maceWidth*2],center=true);
 }
}

module bow_2d(bowSize=3){
 //bow size: 3 = Shortbow, 4 = longbow, 5=Greatbow
 bowWidth=WIDTH/32;
 translate([0,HEIGHT/2]){
  intersection(){
   difference() {
    circle(WIDTH/2);
    circle(WIDTH/2-bowWidth);
   }
   translate([WIDTH/bowSize,-WIDTH/2]) square(WIDTH); 
  }
  intersection() {
   circle(WIDTH/2);
   translate([WIDTH/bowSize,-WIDTH/2]) square([bowWidth,WIDTH]); 
  }
 }
}

module fireball_2d(){
 sf=SIZE/24;
 translate([(WIDTH/2),HEIGHT/2-ROUNDED_RADIUS+0.5])
 rotate([0,0,-5])
 scale([sf,sf])
 translate([-1,4,0])
 fireball_poly();
}

module fireball_poly(){
  scale([25.4/90, -25.4/90, 1]) union()
  {
      polygon([[9.603407,12.305750],[9.487987,12.447850],[9.369839,12.588650],[9.249061,12.728350],[9.125753,12.866550],[9.000013,13.003250],[8.871940,13.138350],[8.741633,13.271850],[8.609189,13.403450],[7.847125,14.227050],[6.839377,15.100650],[5.608262,15.950450],[4.176094,16.702650],[2.565188,17.283250],[0.797860,17.618650],[-1.103575,17.634650],[-3.116802,17.257850],[-4.349514,16.850050],[-5.493683,16.367750],[-6.548503,15.811450],[-7.513168,15.181650],[-8.386875,14.479150],[-9.168817,13.704350],[-9.858190,12.857850],[-10.454188,11.940350],[-10.847608,11.188650],[-11.182669,10.400250],[-11.459207,9.576050],[-11.677064,8.716650],[-11.836077,7.822950],[-11.936085,6.895650],[-11.976927,5.935650],[-11.958442,4.943450],[-11.867103,3.998850],[-11.696608,3.112350],[-11.462360,2.282750],[-11.179758,1.508850],[-10.864204,0.789350],[-10.531100,0.123250],[-10.195846,-0.490750],[-9.873843,-1.053850],[-9.740674,-1.285250],[-9.608025,-1.518850],[-9.480790,-1.749050],[-9.363862,-1.970650],[-9.262136,-2.178050],[-9.180503,-2.365750],[-9.123858,-2.528450],[-9.097094,-2.660650],[-9.106604,-2.773350],[-9.147194,-2.924250],[-9.213085,-3.105150],[-9.298495,-3.307950],[-9.397641,-3.524550],[-9.504739,-3.746950],[-9.614008,-3.966950],[-9.719664,-4.176350],[-10.188846,-5.131350],[-10.649901,-6.233250],[-11.019680,-7.480550],[-11.215029,-8.871750],[-11.152797,-10.405350],[-10.749833,-12.079850],[-9.922984,-13.893750],[-8.589101,-15.845650],[-8.441988,-15.999250],[-8.274150,-16.121150],[-8.090281,-16.210150],[-7.895075,-16.266150],[-7.693227,-16.288150],[-7.489432,-16.274150],[-7.288383,-16.224150],[-7.094775,-16.137150],[-6.919707,-16.016750],[-6.772231,-15.870650],[-6.654026,-15.703150],[-6.566766,-15.518950],[-6.512136,-15.322450],[-6.491816,-15.118150],[-6.507476,-14.910650],[-6.560806,-14.704450],[-6.685802,-14.331850],[-6.785042,-13.988250],[-6.858582,-13.673250],[-6.906482,-13.386350],[-6.928812,-13.126950],[-6.925612,-12.894750],[-6.896972,-12.689150],[-6.842942,-12.509650],[-6.771292,-12.364950],[-6.675022,-12.222450],[-6.556088,-12.080550],[-6.416437,-11.937750],[-6.258017,-11.792350],[-6.082779,-11.642950],[-5.892671,-11.487950],[-5.689644,-11.325750],[-5.487403,-11.164250],[-5.275019,-10.991950],[-5.054363,-10.807550],[-4.827307,-10.609850],[-4.595724,-10.397450],[-4.361484,-10.169250],[-4.126460,-9.923850],[-3.892525,-9.659950],[-3.592108,-9.291050],[-3.310856,-8.914050],[-3.048421,-8.530550],[-2.804456,-8.141950],[-2.578613,-7.750050],[-2.370543,-7.356250],[-2.179900,-6.962150],[-2.006334,-6.569450],[-1.585574,-7.737850],[-1.204682,-8.933050],[-0.891678,-10.140950],[-0.674584,-11.347550],[-0.581424,-12.539050],[-0.640214,-13.701450],[-0.878970,-14.820750],[-1.325718,-15.882950],[-1.399738,-16.047550],[-1.447208,-16.217450],[-1.468768,-16.390050],[-1.465068,-16.562350],[-1.436768,-16.731650],[-1.384518,-16.895150],[-1.308958,-17.049950],[-1.210738,-17.193350],[-1.184098,-17.225350],[-1.156208,-17.256350],[-1.127088,-17.286350],[-1.096748,-17.316350],[-1.065208,-17.345350],[-1.032478,-17.373350],[-0.998568,-17.400350],[-0.963488,-17.425350],[-0.770247,-17.534650],[-0.565583,-17.604650],[-0.354884,-17.634650],[-0.143543,-17.624650],[0.063052,-17.579650],[0.259509,-17.497650],[0.440439,-17.378950],[0.600451,-17.224550],[1.391261,-16.259150],[2.146802,-15.216050],[2.839974,-14.082650],[3.443674,-12.846450],[3.930803,-11.494650],[4.274260,-10.014750],[4.446943,-8.394150],[4.421753,-6.620050],[4.425153,-6.620050],[4.428553,-6.620050],[4.431953,-6.620050],[4.435353,-6.620050],[4.438753,-6.620050],[4.442153,-6.620050],[4.445553,-6.620050],[4.448953,-6.620050],[4.538893,-6.728050],[4.631743,-6.831650],[4.726963,-6.931650],[4.824023,-7.027650],[4.922393,-7.120650],[5.021533,-7.211650],[5.120913,-7.300650],[5.219993,-7.388650],[5.224693,-7.388650],[5.229393,-7.388650],[5.234093,-7.388650],[5.238793,-7.388650],[5.243493,-7.388650],[5.248193,-7.388650],[5.252893,-7.388650],[5.257593,-7.388650],[5.343313,-7.465650],[5.426263,-7.540650],[5.506213,-7.614650],[5.582923,-7.687650],[5.656153,-7.760650],[5.725673,-7.833650],[5.791243,-7.906650],[5.852633,-7.980650],[5.929023,-8.081950],[6.000393,-8.192350],[6.064093,-8.314850],[6.117473,-8.452050],[6.157883,-8.606950],[6.182663,-8.782150],[6.189163,-8.980650],[6.174743,-9.205150],[6.167843,-9.324150],[6.172743,-9.441750],[6.189023,-9.557150],[6.216303,-9.669750],[6.254193,-9.778550],[6.302313,-9.883050],[6.360273,-9.982050],[6.427683,-10.075050],[6.464473,-10.119050],[6.503433,-10.161050],[6.544523,-10.201050],[6.587683,-10.239050],[6.632883,-10.275050],[6.680063,-10.309050],[6.729183,-10.341050],[6.780193,-10.371050],[6.940996,-10.444050],[7.108071,-10.492050],[7.278603,-10.515050],[7.449777,-10.515050],[7.618780,-10.487050],[7.782797,-10.435050],[7.939012,-10.359050],[8.084612,-10.258450],[8.636829,-9.718550],[9.027008,-9.139850],[9.278723,-8.530850],[9.415548,-7.900150],[9.461058,-7.256250],[9.438828,-6.607650],[9.372438,-5.962850],[9.285448,-5.330350],[9.202008,-4.728850],[9.134698,-4.122150],[9.100358,-3.509750],[9.115818,-2.891550],[9.197908,-2.267150],[9.363464,-1.636450],[9.629321,-0.999050],[10.012315,-0.354850],[10.493186,0.400750],[10.908544,1.178050],[11.257531,1.974350],[11.539290,2.786550],[11.752965,3.612050],[11.897697,4.447950],[11.972627,5.291350],[11.976927,6.139450],[11.911607,6.974550],[11.778081,7.799150],[11.577390,8.610550],[11.310579,9.405950],[10.978693,10.182650],[10.582776,10.937950],[10.123873,11.669050],[9.603027,12.373250],[9.603027,12.373250],[9.603027,12.373250],[9.603027,12.373250],[9.603027,12.373250],[9.603027,12.373250],[9.603027,12.373250],[9.603027,12.373250],[9.603027,12.373250],[9.603029,12.373350],[9.603030,12.373350],[9.603032,12.373450],[9.603034,12.373550],[9.603036,12.373650],[9.603037,12.373750],[9.603039,12.373750]]);
  }
}

module symbol_diamond_3d(){
 translate([0,(HEIGHT)/2.5,THICK]) rotate([0,0,45]) cube([BADGE_HEIGHT,BADGE_HEIGHT, 1], center=true);
}

module fireball_3d(Thickness=DETAIL_OUTSET, Size=BADGE_HEIGHT)
{ 
//Scaling factor:
 sf=Size/10;
 translate([0,HEIGHT/2.5,THICK])
  scale([sf,sf,1])

  linear_extrude(Thickness)
   fireball_poly();
}


module symbol_club_3d()
{
 //Scaling factor:
 sf=BADGE_HEIGHT/10;
 translate([0,HEIGHT/2.5,THICK])
  scale([sf,sf,1])
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(DETAIL_OUTSET)
      polygon([[0.069495,-17.719250],[-2.992551,-17.098250],[-5.488424,-15.405950],[-7.168792,-12.898150],[-7.784322,-9.830650],[-7.713735,-8.754050],[-7.506316,-7.723950],[-7.168576,-6.748150],[-6.707028,-5.834250],[-6.989628,-5.874250],[-7.274713,-5.907250],[-7.562654,-5.930250],[-7.853824,-5.940250],[-10.915870,-5.319250],[-13.411743,-3.626950],[-15.092111,-1.119150],[-15.707641,1.948350],[-15.092111,5.015850],[-13.411743,7.523650],[-10.915870,9.215950],[-7.853824,9.836950],[-6.830628,9.767950],[-5.846854,9.569050],[-4.910901,9.252150],[-4.031170,8.829150],[-4.001410,9.086250],[-3.979620,9.345850],[-3.966230,9.607750],[-3.961630,9.871650],[-4.574018,12.926050],[-6.246254,15.418050],[-8.730944,17.100250],[-11.780695,17.725450],[-5.985899,17.725450],[-0.191103,17.725450],[5.603693,17.725450],[11.398489,17.725450],[8.484501,16.997350],[6.122767,15.294050],[4.539694,12.843050],[3.961690,9.871650],[3.966690,9.617050],[3.980850,9.363450],[4.002790,9.111950],[4.031170,8.863850],[4.910829,9.281150],[5.846970,9.586150],[6.830875,9.773350],[7.853825,9.837350],[10.915870,9.216350],[13.411743,7.524050],[15.092111,5.016250],[15.707641,1.948750],[15.092111,-1.113350],[13.411743,-3.609150],[10.915870,-5.289550],[7.853825,-5.905050],[7.598239,-5.905050],[7.345589,-5.891050],[7.095109,-5.869050],[6.846034,-5.840050],[7.313011,-6.753950],[7.662697,-7.729850],[7.882062,-8.759850],[7.958082,-9.836450],[7.337122,-12.903950],[5.644808,-15.411750],[3.136989,-17.104050],[0.069514,-17.725050],[0.069515,-17.725150],[0.069516,-17.725350],[0.069517,-17.725450]]);
  }
}

module symbol_heart_3d()
{
 //Scaling factor:
 sf=BADGE_HEIGHT/10;
 translate([0,HEIGHT/2.5,THICK])
  scale([sf,sf,1])

  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(DETAIL_OUTSET)
      polygon([[-8.874966,-17.718750],[-10.659593,-17.539405],[-12.320736,-17.024892],[-13.823115,-16.210490],[-15.131449,-15.131482],[-16.210457,-13.823148],[-17.024858,-12.320769],[-17.539372,-10.659626],[-17.718716,-8.875000],[-17.718784,-8.752712],[-17.718667,-8.630591],[-17.717892,-8.508723],[-17.715981,-8.387197],[-17.712459,-8.266100],[-17.706850,-8.145518],[-17.698678,-8.025539],[-17.687466,-7.906250],[-17.652229,-6.544891],[-17.442253,-5.035003],[-16.834093,-3.187740],[-15.604304,-0.814258],[-13.529441,2.274287],[-10.386061,6.266740],[-5.950717,11.351946],[0.000034,17.718750],[6.397052,10.857169],[11.023344,5.492694],[14.166819,1.382110],[16.115387,-1.717799],[17.156958,-4.050248],[17.579441,-5.858455],[17.670751,-7.385633],[17.718784,-8.875000],[17.538097,-10.659626],[17.020043,-12.320769],[16.200637,-13.823148],[15.115892,-15.131482],[13.801820,-16.210490],[12.294436,-17.024892],[10.629753,-17.539405],[8.843784,-17.718750],[7.059158,-17.539405],[5.398015,-17.024892],[3.895636,-16.210490],[2.587302,-15.131482],[1.508294,-13.823148],[0.693892,-12.320769],[0.179379,-10.659626],[0.000034,-8.875000],[-0.180653,-10.659626],[-0.698707,-12.320769],[-1.518113,-13.823148],[-2.602859,-15.131482],[-3.916930,-16.210490],[-5.424314,-17.024892],[-7.088997,-17.539405]]);
  }
}

module symbol_spade_3d()
{
 //Scaling factor:
 sf=BADGE_HEIGHT/10;
 translate([0,HEIGHT/2.5,THICK])
  scale([sf,sf,1])

   scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(DETAIL_OUTSET)
      polygon([[0.000000,-17.718750],[-5.437500,-11.875000],[-9.375000,-7.312500],[-12.031250,-3.812500],[-13.687500,-1.187500],[-14.593750,0.781250],[-14.937500,2.343750],[-15.031250,3.625000],[-15.062500,4.906250],[-14.906250,6.406250],[-14.468750,7.812500],[-13.781250,9.093750],[-12.843750,10.218750],[-11.750000,11.125000],[-10.468750,11.812500],[-9.031250,12.250000],[-7.531250,12.406250],[-6.000000,12.250000],[-4.593750,11.812500],[-4.281250,11.656250],[-5.284205,14.069119],[-6.994969,15.986175],[-9.255123,17.253894],[-11.906250,17.718750],[11.281250,17.718750],[8.730697,17.148928],[6.576112,15.823797],[4.961596,13.891455],[4.031250,11.500000],[4.625000,11.812500],[6.031250,12.250000],[7.562500,12.406250],[9.062500,12.250000],[10.468750,11.812500],[11.750000,11.125000],[12.875000,10.218750],[13.781250,9.093750],[14.468750,7.812500],[14.906250,6.406250],[15.062500,4.906250],[15.062500,4.781250],[15.062500,4.687500],[15.062500,4.593750],[15.062500,4.468750],[15.062500,4.375000],[15.062500,4.281250],[15.062500,4.187500],[15.031250,4.062500],[15.000000,2.906250],[14.843750,1.625000],[14.312500,0.062500],[13.281250,-1.968750],[11.500000,-4.593750],[8.843750,-7.968750],[5.062500,-12.312500],[0.000000,-17.718750]]);
  }
}

module symbol_customizer_poly_3d()
{
 echo("Using Customizer Polygon");
 //Scaling factor:
 sf=BADGE_HEIGHT/10;
 translate([0,HEIGHT/2.5,THICK])
  scale([sf,sf,1])
  linear_extrude(DETAIL_OUTSET)
   polygon(CUSTOM_SYMBOL[0],CUSTOM_SYMBOL[1]);
}


module text_3d(TEXT="w", TEXT_POSITION=[0,(HEIGHT/2.5)+FONT_V_OFFSET, THICK]) {
 if (DETAIL_OUTSET > 0) {
  translate(TEXT_POSITION) scale([1,1,2*DETAIL_OUTSET]) write(TEXT, h=BADGE_HEIGHT, center=true, font=FONT);
 }
 if (DETAIL_OUTSET <= 0) {
  translate(TEXT_POSITION) write(TEXT, h=BADGE_HEIGHT, center=true, font=FONT);
 }
}

module symbol_file(){
 // Scaling factor:
 sf = BADGE_HEIGHT/10;
 //Load art from a DXF file
 echo("Loading art from", SYMBOL_FILENAME);
 color(DETAIL_COLOR) translate([0,(HEIGHT)/2.5,THICK]) scale(sf) translate([-5,-5,0]) linear_extrude(height=DETAIL_OUTSET) import(SYMBOL_FILENAME);
 color(DETAIL_COLOR2) if ( SYMBOL2_FILENAME != "" ) translate([0,(HEIGHT)/2.5,THICK]) scale(sf) translate([-5,-5,0]) linear_extrude(height=DETAIL_OUTSET*2) import(SYMBOL2_FILENAME);
}

module chest_decoration(index){
 if (CHEST_SYMBOL == 0) {
  if (len(CHESTTEXT)) color(DETAIL_COLOR) text_3d(CHESTTEXT[index % len(CHESTTEXT)]);
 }
 if (CHEST_SYMBOL == 1) {
  if (len(CHESTTEXT)) color(DETAIL_COLOR) text_3d(CHESTTEXT);
 }
 if (CHEST_SYMBOL == 2) color(DETAIL_COLOR) symbol_club_3d();
 if (CHEST_SYMBOL == 3) color(DETAIL_COLOR) symbol_diamond_3d();
 if (CHEST_SYMBOL == 4) color(DETAIL_COLOR) symbol_heart_3d();
 if (CHEST_SYMBOL == 5) color(DETAIL_COLOR) symbol_spade_3d();
 if (CHEST_SYMBOL == 6) color(DETAIL_COLOR) fireball_3d();

 if (CHEST_SYMBOL == 99) symbol_customizer_poly_3d();
 if (CHEST_SYMBOL == 100) symbol_file();
}

module serialize(left,right){
 // first we need to figure out how much space there is:
 XOffset=FOOT_CUTOUT_DIAM/2;
 FootWidth=(WIDTH-FOOT_CUTOUT_DIAM)/2-ROUNDED_RADIUS;
 // embedding the text further into the foot for clearer text (both inset and outset hopefully)
 translate([-XOffset-FootWidth/2,0.25,THICK/2]) rotate([90,-45,0]) write(str(left),h=SERIALIZE_SIZE, center=true);
 translate([XOffset+FootWidth/2,0.25,THICK/2]) rotate([90,-45,0]) write(str(right),h=SERIALIZE_SIZE, center=true);
}

module serial_gaps(){
 //make holes in the feet, into which serial numbers can be merged later, in Makerware for instance
 XOffset=FOOT_CUTOUT_DIAM/2;
 FootWidth=(WIDTH-FOOT_CUTOUT_DIAM)/2-ROUNDED_RADIUS;
 translate([-XOffset-FootWidth/2,-0.5,THICK/2]) rotate([-90,0,0]) linear_extrude(height=1,scale=0.8) square([FootWidth, THICK-2], center=true);
 translate([XOffset+FootWidth/2,-0.5,THICK/2]) rotate([-90,0,0]) linear_extrude(height=1,scale=0.8) square([FootWidth,THICK-2], center=true);
 
}

module meeple_2d() {

  // head
  translate([0, HEIGHT - HEAD_DIAM / 2])
  circle(r=HEAD_DIAM / 2);

  // body
  difference() {
    hull() {
      translate([-(WIDTH /2 - ROUNDED_RADIUS), ROUNDED_RADIUS])
      circle(r=ROUNDED_RADIUS);

      translate([WIDTH /2 - ROUNDED_RADIUS, ROUNDED_RADIUS])
      circle(r=ROUNDED_RADIUS);

      translate([0, HEIGHT - HEAD_DIAM])
      circle(r=ROUNDED_RADIUS);
    }

    // foot cutout
    circle(r=FOOT_CUTOUT_DIAM / 2);
  }

  // arms
  hull() {
    translate([WIDTH / 2 - ROUNDED_RADIUS, HEIGHT / 2])
    circle(r=ROUNDED_RADIUS);

    translate([-WIDTH / 2 + ROUNDED_RADIUS, HEIGHT / 2])
    circle(r=ROUNDED_RADIUS);

    translate([0, HEIGHT / 2 + ROUNDED_RADIUS])
    circle(r=HEAD_DIAM / 2);
  }
}

module doMeeple(index){
 if (! SERIAL_ONLY){
 color(DETAIL_COLOR){
 linear_extrude(height=THICK+DETAIL_OUTSET){
  //hats
  if (HEADGEAR == 1) fez_2d();
  if (HEADGEAR == 2) bowler_hat_2d();
  if (HEADGEAR == 3) wiz_hat_2d();
  if (HEADGEAR == 4) crown_2d();
  if (HEADGEAR == 5) helm_2d();
  if (HEADGEAR == 6) cleric_helm_2d();
  //left hand gear
  if (LEFTHAND == 1) staff_2d();
  if (LEFTHAND == 2) wiz_staff_2d();
  if (LEFTHAND == 3) shield_2d();
  if (LEFTHAND == 4) sword_2d();
  if (LEFTHAND == 5) mace_2d();
  if (LEFTHAND == 6) bow_2d();
  if (LEFTHAND == 7) bow_2d(bowSize=4);
  if (LEFTHAND == 8) bow_2d(bowSize=5);
  if (LEFTHAND == 9) warmace_2d();
  if (LEFTHAND == 10) maul_2d();
  if (LEFTHAND == 11) buckler_2d();
  if (LEFTHAND == 12) round_sheild_2d();
  if (LEFTHAND == 13) fireball_2d();

  //right hand gear
  if (RIGHTHAND == 1) mirror([1,0,0]) staff_2d();
  if (RIGHTHAND == 2) mirror([1,0,0]) wiz_staff_2d();
  if (RIGHTHAND == 3) mirror([1,0,0]) shield_2d();
  if (RIGHTHAND == 4) mirror([1,0,0]) sword_2d();
  if (RIGHTHAND == 5) mirror([1,0,0]) mace_2d();
  if (RIGHTHAND == 6) mirror([1,0,0]) bow_2d();
  if (RIGHTHAND == 7) mirror([1,0,0]) bow_2d(bowSize=4);
  if (RIGHTHAND == 8) mirror([1,0,0]) bow_2d(bowSize=5);
  if (RIGHTHAND == 9) mirror([1,0,0]) warmace_2d();
  if (RIGHTHAND == 10) mirror([1,0,0]) maul_2d();
  if (RIGHTHAND == 11) mirror([1,0,0]) buckler_2d();
  if (RIGHTHAND == 12) mirror([1,0,0]) round_sheild_2d();
  if (RIGHTHAND == 13) mirror([1,0,0]) fireball_2d();
 }
 }
 color(DETAIL_COLOR2){
  linear_extrude(height=THICK+2*DETAIL_OUTSET){
   //Hats:
   if (HEADGEAR == 5) helm_l2_2d();
   if (HEADGEAR == 6) cleric_helm_l2_2d();
   //left hand
   if (LEFTHAND == 10) maul_l2_2d();
   if (LEFTHAND == 12) round_sheild_l2_2d();
   //right hand
   if (RIGHTHAND == 10) mirror([1,0,0]) maul_l2_2d();
   if (RIGHTHAND == 12) mirror([1,0,0]) round_sheild_l2_2d();
  }
 }

  color(MAIN_COLOR){
   difference() {
    linear_extrude(height=THICK)
     meeple_2d();
     translate([THICK*0.8,0.25,THICK*0.5]) rotate([90,0,0]) CCTag(Size=THICK*0.5);
    if (DO_CUTOUT) translate([0,0,-THICK]) mirror([1,0,0]) chest_decoration(index);
    if ( SERIALIZE && ! SERIALIZABLE ){
     color("Red") serialize(SERIALIZE_SERIES,index+SERIALIZE_START);
    }
    if ( SERIALIZABLE ) {
     color("Red") serial_gaps();
    }
   }
  }
  chest_decoration(index);
 if ( SERIALIZE && SERIALIZABLE ){
  color(MAIN_COLOR) translate([0,0.5,0]) serialize(SERIALIZE_SERIES,index+SERIALIZE_START);
  }
 }
 if ( SERIAL_ONLY){
  color(MAIN_COLOR) translate([0,0.5,0]) serialize(SERIALIZE_SERIES,index+SERIALIZE_START);
 }
}

module star_5(radius=10){
 polygon(points=[
  from_polar(radius, 0),
  from_polar(radius, 72),
  from_polar(radius, 72*2),
  from_polar(radius, 72*3),
  from_polar(radius, 72*4)],
  paths=[[0,2,4,1,3]]);
}

function from_polar(r=1,theta=60) = [r*cos(theta),r*sin(theta)];

module CCTag(Size=10,Thickness=1, DoBorder=true, flush=false,center=false,$fn=10)
{
 Border = Size/30;
 BorderRadius=Size/10;
 ChevronWidth=Size/4;
 ChevronAngle=35;
 
 translate([0,0,flush?-Thickness:center?-Thickness/2:0])
  { 
   if ( DoBorder && Size >= 10 )
   { translate([0,0,Thickness/2]) 
    difference(){
     cube([Size,Size,Thickness],center=true);
     cube([Size-Border*2, Size-Border*2, Thickness*2],center=true); 
    }
   } 
   intersection(){
    union(){
     translate([0,-Size/3.5,0]) linear_extrude(height=Thickness) rotate([0,0,90]) star_5(radius=Size/6);
     translate([Size/3.5,Size/3.5,0]) linear_extrude(height=Thickness) rotate([0,0,90]) star_5(radius=Size/6);
     translate([-Size/3.5,Size/3.5,0]) linear_extrude(height=Thickness) rotate([0,0,90]) star_5(radius=Size/6);
     translate([0,ChevronWidth/1.0,0]){
      union(){
       rotate([0,0,-ChevronAngle]) translate([0,-ChevronWidth,0]) cube([Size,ChevronWidth,Thickness]);
       mirror([1,0,0]) rotate([0,0,-ChevronAngle]) translate([0,-ChevronWidth,0]) cube([Size,ChevronWidth,Thickness]);
       }
       }
      }
     cube([Size-Border*3,Size-Border*3, Thickness*2],center=true);
    }
   }
  }

module main() {
 scale([AFTER_SCALING,AFTER_SCALING,AFTER_SCALING]){
  // Do the actual meeple rendering, depending on quantity:
  for(j = [0:ROWS-1]){
   for(i = [0:COLUMNS-1]) {
    translate([i*X_OFF,j*Y_OFF]) doMeeple(j*COLUMNS+i);
   }
  }

  if (QTY > ROWS*COLUMNS){
   for (j = [0:QTY-ROWS*COLUMNS-1]) {
    translate([(COLUMNS)*X_OFF, floor(j)*Y_OFF]) doMeeple(ROWS*COLUMNS+j);
   }
  }
 }
}

main();
