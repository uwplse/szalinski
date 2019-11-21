
$PathDetail=2;
$SphereDetail=16;

union(){ 
$fn = $SphereDetail;

 color("DarkOrange")    DrawSmoothLine(FrillsAndUpperBeak );  
 color("Orange")        DrawSmoothLine(BodyBulk ); 

 color("DarkOrange"){
                        DrawSmoothLine(BeakDetalAndFlank );
               mirror() DrawSmoothLine(BeakDetalAndFlank );
    }
}

//ListOf [X,Y,Z[ScaleX,ScaleY,ScaleZ]]
 
FrillsAndUpperBeak=  [   
 [0, 16, 10, [5, 5, 5]],
 [0, -2, 13, [10, 10, 10]],
 [0, -21, 8, [15, 13, 15]], 
 [0, -10, 28, [5, 5, 5]], 
 [0, -6, 53, [6, 8, 5]],
 [0, -13, 52, [6, 4, 6.5]], 
 [0, -16, 46, [5, 5, 5]], 
 [0, -23.5, 41.5, [11, 5, 4.7]],
 [0, -26.9, 41.9, [9.9, 3, 4]],
 [0, -31.9, 45.3, [5, 3, 2]]

];
BodyBulk= [
[0, 31, 25, [3.5, 3.5, 3.5]],
 [0, 27, 12, [10, 10, 10]],
 [0, 16, 0, [15, 18, 16]],
 [0, 6, 0, [21, 20, 20]],
 [0, -10, 3, [28, 25, 22]],
 [0, -10, 16-1, [9, 9, 12]],
 [0, -10, 30-1, [8, 10, 8]],
 [0, -7, 42-1, [15, 17, 17]], 
[0, -20, 38.5-1, [13, 10, 4]], 
[0, -28, 39-1, [8, 6, 2]]];

 
BeakDetalAndFlank=
[[0, -33, 46.5, [1.5, 2.5, 2.5]], 
[3, -32.5, 46, [1.5, 2.5, 2.5]], 
[6, -30.5, 43, [1.5, 2.5, 2]],
 [7.7, -28, 41.6, [2.5, 2.5, 1.5]],
 [9, -23, 42, [3, 2, 2]], 
[8, -19, 43, [3, 3, 3]], 
[8, -16, 46, [2, 2, 2]],
 [5, -18, 48, [4, 4, 4]], 
[8, -16, 46, [2, 2, 2]],
 [0, -6, 46, [2, 2, 2]], 
[0, -10, 8, [10, 10, 10]], 
[9, -10, 4, [20, 20, 17]], 
[7, 0, 3, [19, 20, 18]], 
[3, 10, 3, [18, 20, 15]]];


module DrawSmoothLine(ListOfPoints)
{
SmoothedLine=SmoothLine (ListOfPoints);
DrawPolyline( SmoothedLine   ) ;
}

function SmoothLine (ListOfPoints)=
let(Steps=(100/$PathDetail))
[for(t=[0:Steps]) (PiecewiseQuadraticBezierCurve(t/Steps, ListOfPoints) )];

function PiecewiseQuadraticBezierCurve(PositionAlongPath,ListOfPoints)=
let( 
    ListLenght=len(ListOfPoints)-1,        
    PaddedListOfPoints=PadList(ListOfPoints)        ,
    IndexCenterPoint=round((ListLenght)*PositionAlongPath)+1, // +One to offset padding
    IndexPreviousPoint=IndexCenterPoint-1,
    IndexfollowingPoint=IndexCenterPoint+1,
     
    PositionAlongSegment=(((ListLenght)*PositionAlongPath)+0.5)%1 ,
    
    FirstHandle = FindMidpoint(PaddedListOfPoints,IndexPreviousPoint,IndexCenterPoint ),
    CenterPoint = PaddedListOfPoints[IndexCenterPoint], 
    LastHandle  = FindMidpoint( PaddedListOfPoints, IndexCenterPoint,IndexfollowingPoint) 
) 

QuadraticBezierSegment (FirstHandle,CenterPoint, LastHandle,PositionAlongSegment ) ;


function PadList(ListOfPoints)=
    concat(ExtendOnePointBefore(ListOfPoints),
            ListOfPoints,
            ExtendOnePointAfter(ListOfPoints) );

function ExtendOnePointBefore(ListOfPoints)=
    [ListOfPoints[0]-(ListOfPoints[1]-ListOfPoints[0])];

function ExtendOnePointAfter(ListOfPoints)=
let( ll=len(ListOfPoints)-1   )
    [ListOfPoints[ll]-(ListOfPoints[ll-1]-ListOfPoints[ll])];

function FindMidpoint(v,ia,ib)=lerp(v[ia],v[ib],0.5);


function lerp( v1, v2, bias) = (1-bias)*v1 + bias*v2;

function QuadraticBezierSegment
        (FirstHandle,CenterPoint, LastHandle,PositionAlongSegment)=
lerp(
    lerp( FirstHandle,CenterPoint,PositionAlongSegment),
    lerp(CenterPoint,LastHandle,PositionAlongSegment),
PositionAlongSegment)
;

module DrawPolyline(PointList ) 
{
for(i=[0:len(PointList)-2])
     DrawLineSegment(PointList[i],PointList[i+1]);
}

module DrawLineSegment(p1, p2 ) 
{
 color(p1[4])   
hull() {
        translate(vec3(p1)) scale(p1[3])sphere(1 );
        translate(vec3(p2)) scale(p2[3])sphere(1);
       }
}


function vec3(v) = [ v.x, v.y, v.z ];

 
