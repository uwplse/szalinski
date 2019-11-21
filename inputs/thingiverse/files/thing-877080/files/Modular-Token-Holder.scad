//Token Type definitions
t_cb=0;//Cicle Big
t_cs=1;//Circle Small
t_sq=2;//Square (Crate)
t_hex=3;//Hex
t_oct=4;//Oct
t_ts3=5;//Tri Star (Terminal)
t_qs5=6;//Quad Star (Health5)
t_qs=7;//Quad Star (Health)

/* Tweakables */
p=1.5;//Padding. Extra wiggle room
wt=1.5;//Wall Thickness
bt=2;//Base Thickness
thh=30;//Token Holder Height (Default. Can be overridden)
bw=20;//Base Support Width
ths=-wt;//Token Holder Spacing [-wt:3] (Default. Can be overridden)
$fn=256;//Roundness of circles

/* Debug/Preview */
showTokens=true;
th=2;//Single Token Height (For preview only)

/* Token Sizes (Diameter) */
s_cb=25.5;//Cicle Big
s_cs=19.2;//Circle Small
s_sq=19;//Square (side width)
s_hex=20;//Hex (edges defined in makeTokenHolders)
s_oct=20;//Oct (edges defined in makeTokenHolders)

s_ts3_sizes=[//Tripoint Star (Terminal)
    3,//Points
    14,//Inner circle diameter
    8.8,//Point tip width
    12.5,//Point base width
    4 //Point overlap (tweak manually)
    ];
s_ts3=s_ts3_sizes[1]+2*p+2*wt;//Tripoint Star diameter (Terminal)
s_qs5_sizes=[//Quad Star (Health5)
    4,//Points
    17.5,//Inner circle diameter
    6,//Point tip width
    8.2,//Point base width
    1.4 //Point overlap (tweak manually)
    ];
s_qs5=s_qs5_sizes[1]+2*p+2*wt;//Quad Star diameter (Health5)
s_qs_sizes=[//Quad Star (Health)
    4,//Points
    14.6,//Inner circle diameter
    5.2,//Point tip width
    6.6,//Point base width
    1.1 //Point overlap (tweak manually)
    ];
s_qs=s_qs_sizes[1]+2*p+2*wt;//Quad Star diameter (Health)

//Note these must be in the order as specified for "Token Type definitions" 
tokenNames = [
        "Circle Big",
        "Circle Small",
        "Square",
        "Hex",
        "Oct",
        "Tripoint Star",
        "Quad Star5",
        "Quad Star"
    ];
tokenSizes = [
        s_cb+2*wt+2*p,
        s_cs+2*wt+2*p,
        sqrt((s_sq+2*p)*(s_sq+2*p)+(s_sq+2*p)*(s_sq+2*p))+2*wt,
        s_hex+2*wt+2*p,
        s_oct+2*wt+2*p,
        s_ts3,
        s_qs5,
        s_qs,
    ];

/* Select Tokens to make here */
tokens = [t_qs5,t_qs,t_qs,t_hex,t_hex];//Tokens to make
tokenSpacingOffset =[0,6,6,6,0];//Custom spacing offset
makeTokenHolders(tokens,tokenSpacingOffset,thh=50);

tokens2 = [t_ts3,t_sq,t_sq,t_cb,t_cb,t_cb];//Tokens to make
tokenSpacingOffset2 =[0,0.3,0,0,0,0];//Custom spacing offset
translate([0,40,0])makeTokenHolders(tokens=tokens2,tokenSpacingOffset=tokenSpacingOffset2);

tokens3 = [t_cs,t_cs,t_oct,t_oct];//Tokens to make
tokenSpacingOffset3 =[0,0,0,0];//Custom spacing offset
translate([0,80,0])makeTokenHolders(tokens3,tokenSpacingOffset3);

/* Module Definitions */
module makeTokenHolders(tokens=tokens,tokenSpacingOffset=tokenSpacingOffset,thh=thh){
    for (x=[0:len(tokens)-1]){
        //Base Support
        lengthTotal=sumSize(tokens,x)+sumOffset(tokenSpacingOffset,x)+ths*x;
        lengthStart=lengthTotal-tokenSizes[tokens[x]];
        
        color("green")translate([tokenSizes[tokens[0]]/2,-bw/2,0])cube([lengthTotal-tokenSizes[tokens[0]]/2-tokenSizes[tokens[len(tokens)-1]]/2,bw,bt])
        
        //Token Holders
        echo();//First echo gets lost - OpenSCAD bug?
        echo(tokenNames[tokens[x]],Token_Width=tokenSizes[tokens[x]]-2*wt,Holder_Width=tokenSizes[tokens[x]]);
        if (tokens[x]==t_cb){
                translate([lengthStart,0,0])tokenHolderCircle(d=s_cb,h=thh);
        }
        if (tokens[x]==t_cs){
                translate([lengthStart,0,0])tokenHolderCircle(d=s_cs,h=thh);
        }
        if (tokens[x]==t_sq){
                translate([lengthStart,0,0])tokenHolderSquare(h=thh);
        }
        if (tokens[x]==t_hex){
                translate([lengthStart,0,0])tokenHolderCircle(d=s_hex,edges=6,h=thh);
        }
        if (tokens[x]==t_oct){
                translate([lengthStart,0,0])tokenHolderCircle(d=s_oct,edges=8,h=thh);
        }
        if (tokens[x]==t_ts3){
                //Tripoint Star (Terminal)
                translate([lengthStart,0,0])tokenHolderStar(h=thh,
                    d=s_ts3,
                    points=s_ts3_sizes[0],
                    inner_dia=s_ts3_sizes[1],
                    tip_w=s_ts3_sizes[2],
                    base_w=s_ts3_sizes[3],
                    pointOverlap=s_ts3_sizes[4]
                );
        }
        if (tokens[x]==t_qs5){
                //Quad Star (Health5)
                translate([lengthStart,0,0])tokenHolderStar(h=thh,
                    d=s_qs5,
                    points=s_qs5_sizes[0],
                    inner_dia=s_qs5_sizes[1],
                    tip_w=s_qs5_sizes[2],
                    base_w=s_qs5_sizes[3],
                    pointOverlap=s_qs5_sizes[4]
                );
        }
        if (tokens[x]==t_qs){
                //Quad Star (Health)
                translate([lengthStart,0,0])tokenHolderStar(h=thh,
                    d=s_qs,
                    points=s_qs_sizes[0],
                    inner_dia=s_qs_sizes[1],
                    tip_w=s_qs_sizes[2],
                    base_w=s_qs_sizes[3],
                    pointOverlap=s_qs_sizes[4]
                );
        }
    }
}

function sumSize(t=tokens,i,s=0) = (i==s ? tokenSizes[t[i]] : tokenSizes[t[i]] + sumSize(t,i-1,s));
function sumOffset(t=tokenSpacingOffset,i,s=0) = (i==s ? t[i] : t[i] + sumOffset(t,i-1,s));

module tokenHolderCircle(d=10,edges=$fn,h=thh){
    translate([d/2+wt+p,0,0])difference(){
        cylinder(d=d+2*wt+2*p,h=bt+h);
        color("red")translate([0,0,bt])cylinder(d=d+2*p,h=bt+h,$fn=edges);
        color("red")rotate([0,0,45])translate([0,0,bt])cube([d*2,d*2,bt+h]);
        color("red")rotate([0,0,225])translate([0,0,bt])cube([d*2,d*2,bt+h]);
    }
    if (showTokens) {color("orange")translate([d/2+wt+p,0,bt])cylinder(d=d,h=th,$fn=edges);}
}

module tokenHolderSquare(width=s_sq,h=thh){
    hw=sqrt((width+2*p)*(width+2*p)+(width+2*p)*(width+2*p));//Horizontal Width
    
    translate([hw/2+wt,0,0])difference(){
        cylinder(d=hw+2*wt,h=bt+h);
        color("red")translate([0,0,bt])rotate([0,0,45])translate([-(width+2*p)/2,-(width+2*p)/2,0])cube([width+2*p,width+2*p,bt+h]);
        color("red")rotate([0,0,45])translate([0,0,bt])cube([hw*2,hw*2,bt+h]);
        color("red")rotate([0,0,225])translate([0,0,bt])cube([hw*2,hw*2,bt+h]);
    }
    
    if (showTokens) {color("orange")translate([hw/2+wt,0,bt])rotate([0,0,45])translate([-width/2,-width/2,0])cube([width,width,th]);}
}

module tokenHolderStar(d=s_ts3,h=thh,points=3,inner_dia=14,tip_w=8.8,base_w=12.5,pointOverlap=3.6){
    translate([d/2,0,0])rotate([0,0,180])difference(){
        cylinder(d=d,h=bt+h);
        translate([0,0,bt])color("red")tokenStar(
            h=h+1,
            inner_dia=inner_dia+2*p,
            d=d+p,
            points=points,
            tip_w=tip_w+p,
            base_w=base_w+p,
            pointOverlap=pointOverlap);
    }
    if (showTokens) {color("orange")translate([d/2,0,bt])
        rotate([0,0,180])tokenStar(
            inner_dia=inner_dia,
            d=d,
            points=points,
            tip_w=tip_w,
            base_w=base_w,
            pointOverlap=pointOverlap);
    }
    
}

module tokenStar(inner_dia=14,d=24.6,points=3,h=th,tip_w=8.8,base_w=12.5,pointOverlap=3.6){
    tip_w=tip_w;
    base_w=base_w;
    width=d;
    le=(width-inner_dia)/2;//Point length
    union(){
        for (x=[1:points]){
            //point
            rotate([0,0,(360/points)*x])
            hull(){
                translate([inner_dia/2+le,tip_w/2,0])rotate([0,-90,0])trangle(h,(base_w-tip_w)/2,le+pointOverlap);
                translate([inner_dia/2+le,-tip_w/2,h])rotate([0,-90,0])rotate([0,0,180])trangle(h,(base_w-tip_w)/2,le+pointOverlap);
            }
        }
        cylinder(d=inner_dia,h=h);
    }
}

module trangle(x,y,z){
	polyhedron(
		points = [[0,0,0], [0,0,z], [x,0,z], [x,0,0],[0,y,z], [x,y,z]],
		faces = [[0,1,2],[0,2,3],[1,0,4],[3,2,5],[1,4,5],[2,1,5],[5,0,3],[5,4,0]]
	);
}



