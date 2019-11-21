SizeOfThePumpkinSpheres = 20;//[3:500] 
NumberOfLobes = 15;//[3:50]
HeightIfTheCircles = 1; //[.1:6]
scaleOfThePumpkin = 1.5; //[.5:6]

module make_ring_of(radius, count)
{
    for (a = [0 : count - 1]) {
        angle = a * 360 / count;
        translate(radius * [sin(angle), -cos(angle), 0])
            rotate([0, 0, angle])
                children();
    }
}

module makePumpkin(size,count, heightMultiplier = 1,scaleBase = 1.5){
    // this is the pumpkin part
    make_ring_of (size,count) scale([1, scaleBase, scaleBase * heightMultiplier]) sphere(r=size);
    // this is the stem part
    rotate([180,0,0])
        translate ([0,0,- size * heightMultiplier * scaleBase ])
        make_ring_of(0,5)
            linear_extrude(height = size* 1.25, center = true, twist = 70,scale = [1,3], slices = 20)
            circle(size *.25,$fn=3);
}

makePumpkin(SizeOfThePumpkinSpheres,NumberOfLobes,HeightIfTheCircles,scaleOfThePumpkin);


