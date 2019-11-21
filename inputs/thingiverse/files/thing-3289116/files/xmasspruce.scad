$fn=60;
for(i=[0:3])
    rotate(95*i,[0,0,1])
    translate([0,1,0])
        rotate(90,[1,0,0])
        difference()
        {
            linear_extrude(2)
                polygon([
                        [0,0],
                        [25,0],
                        [25,1],
                        [0,tan(30)*25]
                ]);
            linear_extrude(2)
                polygon([
                        [0,1],
                        [25-1/sin(30),1],
                        [0,25*tan(30)-1/cos(30)]
                ]);
        }

linear_extrude(h=100, scale=0.1)
    circle(d=10);

for(b=[0:12])
for(a=[20:2:100])
    color([(a-20)/80,1-(a-20)/80,1])
    translate([0,0,a])
    rotate(a*21+b/12*360, [0,0,1])
        cube([(1-pow(a/130,2))*60,0.4,0.4]);

for(b=[0:12])
for(a=[20:60])
    color([(a-20)/40,1-(a-20)/40,0])
    translate([0,0,a])
    rotate(a*21+b/12*360+1/24*360, [0,0,1])
        cube([(1-pow(a/130,2))*70,0.4,0.4]);
