// Set graph title

graph_title = ["t","h","r","e","e"," ","g","r","a","p","h","s"];

// Choose tick coordinates

// List with Y coordinates for horizontal axis (major ticks)
Ycoords_major = [-10,0,10];
// List with Y coordinates for horizontal axis (minor ticks)
Ycoords_minor = [-8,-6,-4,-2,2,4,6,8];


// List with X coordinates for vertical axis (major ticks)
Xcoords_major = [-10,0,10];
// List with X coordinates for vertical axis (minor ticks)
Xcoords_minor = [-8,-6,-4,-2,2,4,6,8];

// SET FIGURE HIGHT AND WIDTH
// these height and width are used, in combination with the  min/max X/Y waarden gebruikt to scale the graph. The required scale factor is also used to properly position the axis labels and actual graphs (the lines).

// height in mm
H = 80;
// widhth in mm
B = 80;

// SET HOW FAR TICKS EXTEND BEYOND GRAPH AREA

s_uit = 4;

// SET AXIS HEIGHT (RADIUS, r) AND WITH 

r_as = 0.5;
h_as = 1;

// DRAWING THE AXIS

Xmin = min(Xcoords_major);
Xmax = max(Xcoords_major);
Ymin = min(Ycoords_major);
Ymax = max(Ycoords_major);

// detremine delta X and delta Y
delta_X = Xmax - Xmin;
delta_Y = Ymax - Ymin;

// determine scale factor for X and Y
f_X = B / delta_X;
echo("SCALE FACTOR X = ", f_X);
f_Y = H / delta_Y;
echo("SCALE FACTOR Y = ", f_Y);

// GROUND LAYER
// during development, it's convenient to comment out this section

LO = [-80,-100];
RB = [50,70];
h = 0.2;
translate([LO[0],LO[1],-h])cube([RB[0]-LO[0],RB[1]-LO[1],h]);

// Import wall-functie
// Call wall with 'wall(r, h, coords1, coords2)'
use <Wall.scad>;

// Draw horizontal axis (major ticks)
 for(i = [0: len(Ycoords_major)-1]){
    x1 = Xmin*f_X - s_uit;
    y1 = Ycoords_major[i]*f_Y; 
    x2 = Xmax*f_X + s_uit;
    y2 = y1;
    wall(r_as, h_as,[x1,y1,0],[x2,y2,0]);
        };
// Draw horizontal axis (minor ticks)
 for(i = [0: len(Ycoords_minor)-1]){
    x1 = Xmin*f_X ;
    y1 = Ycoords_minor[i]*f_Y; 
    x2 = Xmax*f_X;
    y2 = y1;
    wall(r_as, h_as,[x1,y1,0],[x2,y2,0]);
        };

 // Draw vertical axis (major ticks)
 for(i = [0: len(Xcoords_major)-1]){
    x1 = Xcoords_major[i]*f_X;
    y1 = Ymin*f_Y - s_uit;
    x2 = x1;
    y2 = Ymax*f_Y + s_uit;
    wall(r_as, h_as,[x1,y1,0],[x2,y2,0]);
        };        
 // Draw vertical axis (minor ticks)
 for(i = [0: len(Xcoords_minor)-1]){
    x1 = Xcoords_minor[i]*f_X;
    y1 = Ymin*f_Y;
    x2 = x1;
    y2 = Ymax*f_Y;
    wall(r_as, h_as,[x1,y1,0],[x2,y2,0]);
        };

// BRAILLES DIGITS

// Import BrailleDigits-function
// Call function using 'brailles_word_X(["l","e","t","t","e","r","s"])';
// In this function, X can be replaced for…
// L: left
// R: right
// T: top
// B: bottom
use <BrailleDigits.scad>;

// DRAW GRAPH TITLE

translate([f_X*Xcoords_major[0],f_Y*Ycoords_major[2]+5*s_uit])brailles_word_L(graph_title);     

// AXIS LABELS

// Axis labels at X axis
// This part could be refactored using the Major Ticks in a for loop

translate([f_X*Xcoords_major[0],f_Y*Ycoords_major[0]-3*s_uit])brailles_word_T(["#","-","1","0"]);
translate([f_X*Xcoords_major[1],f_Y*Ycoords_major[0]-3*s_uit])brailles_word_T(["0"]);
translate([f_X*Xcoords_major[2],f_Y*Ycoords_major[0]-3*s_uit])brailles_word_T(["1","0"]);
        
// Axis labels at Y axis
translate([f_X*Xcoords_major[0]-3*s_uit,f_Y*Ycoords_major[0]])brailles_word_R(["#","-","1","0"]);
translate([f_X*Xcoords_major[0]-3*s_uit,f_Y*Ycoords_major[1]])brailles_word_R(["#","0"]);
translate([f_X*Xcoords_major[0]-3*s_uit,f_Y*Ycoords_major[2]])brailles_word_R(["#","1","0"]);

// Graph names, combined with a small piece of graph (as a legend) starting at  Xmin
// Legend width
W_legend = 10;
// distance from legend to name
D_legend = 10;
// vertical distance between legend elements
H_legend = 10;
// first graph name
name_1 = ["-","1","/","4","x","^","2","+","4"];
name_1_Y = Ymin*f_Y - 30;
// second graph name
name_2 = ["1","/","2","x","+","2"];
name_2_Y = name_1_Y - H_legend;
// third graph name
name_3 = ["3"];
name_3_Y = name_2_Y - H_legend;


// GRAPH FUNCTIONS

module graph_point_origin(gh, gw){
    difference(){
    resize(newsize=[gw,gw,gh]) sphere(r=gh, center=true);
    translate([0,0,-(gh+gw)/2]){cube((gh+gw), center=true);}
    }
};

module graph_point(gh,gw, coords){
    translate([coords[0],coords[1],coords[2]]){
        graph_point_origin(gh, gw);
    }   
};

// ADD FRIST GRAPH

// Function_1
function f_1(x) = -0.25 * x * x - 2 * x - 2.5;
// X initial
X_i_1 = -10;
// X final
X_f_1 = 2;
// X step size
dX_1 = 0.1;
// Graph height
gh_1 = 3;
// Graph width
gw_1 = 2;

// I wish I could code below in a module, but unfortunately, the function can't be passed as a variable
// All X-coords, based on resolution and graph width W
Xcoords_1 = [ for (i = [X_i_1 : dX_1 : X_f_1+dX_1]) i ];
// All Y-coords, based on function and X-coords
Ycoords_1 = [for (i = [ 0 : len(Xcoords_1) - 1 ]) f_1(Xcoords_1[i]) ];
// Draw graph
for(i = [0 : len(Xcoords_1)-2]){
    hull(){
        graph_point(gh_1,gw_1, [Xcoords_1[i]*f_X,Ycoords_1[i]*f_Y,0]);
        graph_point(gh_1,gw_1, [Xcoords_1[i+1]*f_X,Ycoords_1[i+1]*f_Y,0]);
    }
 };
// Draw legend
 hull(){
        graph_point(gh_1,gw_1, [Xmin*f_X,name_1_Y,0]);
        graph_point(gh_1,gw_1, [Xmin*f_X+W_legend,name_1_Y,0]);
    };
translate([Xmin*f_X+W_legend+D_legend,name_1_Y])brailles_word_L(name_1);
 
 
// ADD SECOND GRAPH

// Function_2
function f_2(x) = 0.5 * x + 2;
// X initial
X_i_2 = -10;
// X final
X_f_2 = 10;
// X step size
dX_2 = 0.1;
// Graph height
gh_2 = 2.5;
// Graph width
gw_2 = 2.5;

// I wish I could code below in a module, but unfortunately, the function can't be passed as a variable
// All X-coords, based on resolution and graph width W
Xcoords_2 = [ for (i = [X_i_2 : dX_2 : X_f_2+dX_2]) i ];
// All Y-coords, based on function and X-coords
Ycoords_2 = [for (i = [ 0 : len(Xcoords_2) - 1 ]) f_2(Xcoords_2[i]) ];
// Draw graph
for(i = [0 : len(Xcoords_2)-2]){
    hull(){
        graph_point(gh_2,gw_2, [Xcoords_2[i]*f_X,Ycoords_2[i]*f_Y,0]);
        graph_point(gh_2,gw_2, [Xcoords_2[i+1]*f_X,Ycoords_2[i+1]*f_Y,0]);
    }
 };
 // Draw legend
 hull(){
        graph_point(gh_2,gw_2, [Xmin*f_X,name_2_Y,0]);
        graph_point(gh_2,gw_2, [Xmin*f_X+W_legend,name_2_Y,0]);
    };
translate([Xmin*f_X+W_legend+D_legend,name_2_Y])brailles_word_L(name_2);
 
 // ADD THIRD GRAPH


// Function_3
function f_3(x) = 3;
// X initial
X_i_3 = -10;
// X final
X_f_3 = 10;
// X step size
dX_3 = 0.1;
// Graph height
gh_3 = 1;
// Graph width
gw_3 = 3;

// I wish I could code below in a module, but unfortunately, the function can't be passed as a variable
// All X-coords, based on resolution and graph width W
Xcoords_3 = [ for (i = [X_i_3 : dX_3 : X_f_3+dX_3]) i ];
// All Y-coords, based on function and X-coords
Ycoords_3 = [for (i = [ 0 : len(Xcoords_3) - 1 ]) f_3(Xcoords_3[i]) ];
// Draw graph
for(i = [0 : len(Xcoords_3)-2]){
    hull(){
        graph_point(gh_3,gw_3, [Xcoords_3[i]*f_X,Ycoords_3[i]*f_Y,0]);
        graph_point(gh_3,gw_3, [Xcoords_3[i+1]*f_X,Ycoords_3[i+1]*f_Y,0]);
    }
 };
 // Draw legend
  hull(){
        graph_point(gh_3,gw_3, [Xmin*f_X,name_3_Y,0]);
        graph_point(gh_3,gw_3, [Xmin*f_X+W_legend,name_3_Y,0]);
    };
translate([Xmin*f_X+W_legend+D_legend,name_3_Y])brailles_word_L(name_3);