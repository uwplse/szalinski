rd=6;
s=5;

t=136;
b=127;
c=99-s;

tt=t-2*rd;
bb=b-2*rd;
cc=c-2*rd;

ss=(c+s)/c;

//polygon(points=[
//    [-b/2,-c/2],
//    [b/2,-c/2],
//    [t/2,c/2],
//    [-t/2,c/2]]);

linear_extrude(height = 50, twist = 0, scale=[1,ss],$fn=50) 
{
   difference() {
     offset(r = rd) {
      //square(20, center = true);
          polygon(points=[
            [-bb/2,-cc/2],
            [bb/2,-cc/2],
            [tt/2,cc/2],
            [-tt/2,cc/2]]);
     }
     offset(r = rd/2) {
       //square(20, center = true);
         polygon(points=[
            [-bb/2,-cc/2],
            [bb/2,-cc/2],
            [tt/2,cc/2],
            [-tt/2,cc/2]]);
     }
   }
 };

 translate([0,0,-2])
 linear_extrude(height = 3, twist = 0, scale=1,$fn=50) 
{
   
     offset(r = rd) {
      //square(20, center = true);
          polygon(points=[
            [-bb/2,-cc/2],
            [bb/2,-cc/2],
            [tt/2,cc/2],
            [-tt/2,cc/2]]);
     }
 };