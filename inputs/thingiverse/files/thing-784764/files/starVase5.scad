// How many sides there are
sides = 10; // [3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
// The distance of the points outside
outerStarSize = 80; // [10:100]
// The distance of the points inside
innerStarSize = 60; // [5:90]
// Percent of interior space
hollowArea = 90; // [10:90]
// Height
h = 150; // [10:300]
// Thickness of the bottom
bottomHeight = 10; //[5:40]
// Twist of model
t = 90; // [-360:360]
// Scale of model (%)
s = 80; // [20:200]

/* [Hidden] */
sa = s/100;
ha = hollowArea/100;
slice = 200;
function r(p, deg) = [(cos(deg)*p[0]) + (-sin(deg)*p[1]),(sin(deg)*p[0]) + (cos(deg)*p[1])];
function sc(p, factor) = [p[0]*factor,p[1]*factor];

//generate outer side points here
outer = [ for(i = [1:sides]) sc(r([1,1],i * 360/sides), outerStarSize) ];


//generate inner side points here
inner = [ for(i = [1:sides]) sc(r([1,1],i * 360/sides + 180/sides), innerStarSize) ];


//generate points list
point = concat(outer,inner);


//Generate paths
path = [ for (i = [1:2*sides]) (i%2)==0 ? ceil(i/2) + sides -1 : ceil(i/2) -1 ];

//Generate the points for the inner star
point2 = [ for (i = [1:2*sides]) sc(point[i-1], ha) ];
    
point3 = [ for (i = [1:2*sides]) sc(point[i-1], (1-ha)/2 +ha ) ];
    
union(){
    linear_extrude(height = h, twist = t, scale = sa, slices = slice)
        difference(){
            polygon(points=point, paths=[path]);
            polygon(points=point2, paths = [path]);
        }
        
    linear_extrude(height = bottomHeight, twist = (bottomHeight/h) * t)
            polygon(points=point3, paths=[path]);
    }




