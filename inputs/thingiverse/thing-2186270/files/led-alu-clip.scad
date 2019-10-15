profile_width = 16.7; // [10:0.1:50]
profile_height = 7; // [1:0.1:30]
mount_distance = 2.5; // [2.5:0.1:15]
clip_size = 10; // [5:0.5:30]
arm = 1; // [0.5:0.1:3]

module test()
{
}


profile_h=profile_width;
profile_d=profile_height;;

holder_l=clip_size;;
holder_d=4;
wall=1.5;
delta=0.05;

screwh=8;
screwh2=4.5;
screwd=1.6;
screwholderw=12;
screwholderd=mount_distance;
swall=1;

difference()
{
  cube([holder_l,profile_d+wall,profile_h+wall*2]);
  translate([-delta,-delta,wall]) cube([holder_l+2*delta,profile_d,profile_h]);
}
translate([0,-wall+delta,delta]) cube([holder_l,wall,wall+arm]);
translate([0,-wall+delta,profile_h-delta-arm+wall]) cube([holder_l,wall,wall+arm]);


difference()
{
    translate([0,profile_d+wall-delta,(profile_h+2*wall-screwholderw)/2]) cube([holder_l,screwholderd,screwholderw]);
    translate([-delta,profile_d+wall-swall+screwholderd+delta,(profile_h+3*wall-screwh2)/2]) cube([holder_l+2*delta, swall, screwh2-swall]);
    translate([-delta,profile_d+screwholderd+wall-screwd-swall+2*delta,(profile_h+3*wall-screwh)/2]) cube([holder_l+2*delta, screwd, screwh-swall]);
}
