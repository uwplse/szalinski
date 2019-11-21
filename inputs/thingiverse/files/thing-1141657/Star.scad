Outer_Radius = 130;
Inner_Radius = 60;
Inner_Heighth=20;
Outer_Heighth=10;

Number_of_Rays=7;

union(){
    for(i= [1:Number_of_Rays])
    {
        rotate([0,0,i*(360/Number_of_Rays)]) zacken();
    }
}

module zacken()
{
    polyhedron(
        points = [  [ 0, 0, 0], [0,0,Inner_Heighth], [0, Outer_Radius, Outer_Heighth], [0, Outer_Radius, 0],
                    [Inner_Radius*sin(360/(2*Number_of_Rays)), Inner_Radius*cos(360/(2*Number_of_Rays)),Outer_Heighth],[-Inner_Radius*sin(360/(2*Number_of_Rays)), Inner_Radius*cos(360/(2*Number_of_Rays)),Outer_Heighth],
                    [Inner_Radius*sin(360/(2*Number_of_Rays)), Inner_Radius*cos(360/(2*Number_of_Rays)),0],[-Inner_Radius*sin(360/(2*Number_of_Rays)), Inner_Radius*cos(360/(2*Number_of_Rays)),0]],
        faces = [[1,2,4],[1,5,2],[0,6,3],[0,3,7],[6,4,3],[4,2,3],[7,3,5],[5,3,2],
                    [0,1,4],[0,5,1],[0,7,5],[0,4,6]]
    
    );
}