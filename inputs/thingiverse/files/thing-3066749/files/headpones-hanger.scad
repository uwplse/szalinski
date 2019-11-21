modelThickness=0.9; // толщина стенок 1.6
modelDecline=35; // высота полки от уровня крепления
modelWidth=50; // ширина вырезки полученного объекта вращения

wallThickness=23+modelThickness; // расстояние для крепления на стенке

headphonesRadius=100; // радиус закругления
headphonesDeep = 15; // глубина кривой держателя
headphonesWidth = 45+modelThickness; // ширина держателя
headphonesSoftness = 5; // резкость закругления держателя

function bezier_calc_points(pts,delta=0.05) = [
    for (t=[0:delta:1+delta])
        pow(1-t,2)*pts[0]
            + 2*(1-t)*t*pts[1]
            + pow(t,2)*pts[2]
];

module line(p1, p2, w, $fn=16) {
    hull() {
        translate(p1) circle(r=w, $fn=$fn);
        translate(p2) circle(r=w, $fn=$fn);
    }
}

module bezier(xpoints, w=1.6, show=false) {
    points = bezier_calc_points(xpoints);
    if (show) {
        color("red") {
            for (p=xpoints) {
                translate(p) circle(r=w*1.5, $fn=20);
            }
            for (idp = [1:len(xpoints)-1])
                line(xpoints[idp-1], xpoints[idp], w);
        }
    }
    color("blue")
    for (idp = [1:len(points)-1])
        line(points[idp-1], points[idp], w);
}

translate([0,-headphonesRadius,25])
rotate([0,90,0])
intersection() {
    translate([-modelWidth/2, 0, -(200+wallThickness)/2]) // кусок модели
        cube([modelWidth, 200+wallThickness, 200]);
    rotate_extrude(convexity=10, $fn=100) {
        translate([headphonesRadius,0,0])
        union() rotate([0,180,90]) {
            translate([0,modelDecline,0]) {
                doshow=false;
                x1 = [[0,0],[headphonesSoftness,headphonesDeep],[headphonesWidth/2,headphonesDeep]];
                x2 = [  [headphonesWidth/2,headphonesDeep],
                        [headphonesWidth-headphonesSoftness,headphonesDeep],
                        [headphonesWidth,0]];
                bezier(x1, w=modelThickness, show=doshow);
                bezier(x2, w=modelThickness, show=doshow);
            }
            line([0,0],[0,modelDecline],w=modelThickness);
            line([0,0],[-wallThickness,0],w=modelThickness);
            line([-wallThickness,0],[-wallThickness,modelDecline/2],w=modelThickness);
        }
    }

}
