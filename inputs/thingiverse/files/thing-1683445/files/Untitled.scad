//height of cup
hi=110;
//diameter of cup head
du=55;
//diameter of cup bottom
dd=80;
//quality
q=100;
//thickness of cup
th=4;

du1=du-th*2;
dd2=dd-th*2;
hi2=hi-th*2.3;
zh=th*2.5;

difference()
{
cylinder (d1=du, d2=dd, h=hi,$fn=q);
    translate([0,0,+zh])
cylinder (d1=du1, d2=dd2, h=hi2,$fn=q);
}