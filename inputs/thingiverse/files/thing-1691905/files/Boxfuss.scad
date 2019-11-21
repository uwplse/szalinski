//heighth
heighth=30;
//width at bottom
length_bottom=15;
//width at top
length_top=20;
//wall strength
wall=3;

hh=heighth/2;
dia = wall * 0.5 * sqrt(2);

difference(){
m_hull();
ausschnitt();
}

module ausschnitt()
{
  for(i=[0:90:270]){
    rotate([0,0,i])polyhedron(points = [
        [-length_bottom+wall,-length_bottom+wall+dia, -hh+wall], [-length_bottom+wall,length_bottom-wall-dia, -hh+wall], [-dia, 0, -hh+wall],
        [-length_top+wall,-length_top+wall+dia, hh], [-length_top+wall,length_top-wall-dia, hh], [-dia,0, hh]],
    faces=[[0,2,1], [3,4,5],[0,1,3],[1,4,3], [1,2,4], [2,5,4], [2,0,3], [2,3,5] ]);
  }
}

module m_hull()
{

polyhedron(points = [ [-length_bottom,-length_bottom, -hh],[length_bottom,-length_bottom, -hh],[length_bottom,length_bottom, -hh],[-length_bottom,length_bottom, -hh],
           [-length_top,-length_top, hh],[length_top,-length_top, hh],[length_top,length_top, hh],[-length_top,length_top, hh]],
faces=[[1,2,0],[2,3,0],[4,6,5],[4,7,6],
[0,5,1],[0,4,5], [1,5,2],[2,5,6], [6,7,2],[2,7,3],
[0,3,7],[0,7,4]]);

}
