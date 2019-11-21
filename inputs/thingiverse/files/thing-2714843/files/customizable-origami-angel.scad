/*
 * Customizable Origami - Angel - https://www.thingiverse.com/thing:2714843
 * by Dennis Hofmann - https://www.thingiverse.com/mightynozzle/about
 * created 2017-12-14
 * version v1.0
 *
 * Changelog
 * --------------
 * v1.0:
 *      - final design
 * --------------
 * 
 * This work is licensed under the Creative Commons - Attribution - NonCommercial - ShareAlike license.
 * https://creativecommons.org/licenses/by-nc-sa/3.0/
 */


 // Parameter Section //
//-------------------//

// preview[view:north, tilt:top]

// The maximum size of the longest side. The shorter side will be automatically resized in same ratio.
max_size_in_millimeter = 120; //[20:300]

// The height of the model.
model_height_in_millimeter = 5; //[0.2:0.2:100]

// Thickness of the outer outline.
outline_size_in_millimeter = 1.6; //[0.5:0.1:20]

// Thickness of the inner outline.
inline_size_in_millimeter = 0.75; //[0.5:0.1:20]

// Roundiness of the ends of the inner outlines.
inline_edge_radius_in_millimeter = 0.1; //[0.0:0.1:5]

// Flip model
flip_model = "no"; //[yes,no]

/*[hidden]*/
max_size = max_size_in_millimeter;
model_height = model_height_in_millimeter;
$fn=32;

// Outer Points
A1 = [1218, 1274];
A2 = [1665, 1379];
A3 = [1848, 1536];
A4 = [1829, 1499];
A5 = [1984, 1297];
A6 = [2114, 1515];
A7 = [2082, 1576];
A8 = [2153, 1544];
A9 = [2379, 1400];
A10 = [2869, 1371];
A11 = [2748, 1554];
A12 = [2637, 1698];
A13 = [2499, 1833];
A14 = [2392, 1896];
A15 = [2357, 1904];
A16 = [2326, 1934];
A17 = [2208, 1924];
A18 = [2170, 1973];
A19 = [2189, 2288];
A20 = [2171, 2428];
A21 = [2148, 2456];
A22 = [2149, 2587];
A23 = [2094, 2630];
A24 = [2084, 2679];
A25 = [2018, 2706];
A26 = [2007, 2753];
A27 = [1924, 2757];
A28 = [1854, 2724];
A29 = [1863, 2696];
A30 = [1789, 2631];
A31 = [1794, 2619];
A32 = [1732, 2527];
A33 = [1734, 2465];
A34 = [1682, 2374];
A35 = [1720, 2239];
A36 = [1698, 2190];
A37 = [1767, 1924];
A38 = [1747, 1902];
A39 = [1679, 1912];
A40 = [1613, 1863];
A41 = [1590, 1860];
A42 = [1498, 1780];
A43 = [1392, 1646];
A44 = [1292, 1460];

outline = [A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15, A16, A17, A18, A19, A20, A21, A22, A23, A24, A25, A26, A27, A28, A29, A30, A31, A32, A33, A34, A35, A36, A37, A38, A39, A40, A41, A42, A43, A44];

// Inner Points
B1 = [1947, 1419];
B2 = [1959, 1602];
B3 = [1855, 1594];
B4 = [2048, 1600];
B5 = [1960, 1719];
B6 = [1697, 1471];
B7 = [1736, 1567];
B8 = [1772, 1613];
B9 = [1831, 1606];
B10 = [2131, 1614];
B11 = [2299, 1503];
B12 = [2240, 1591];
B13 = [2200, 1660];
B14 = [2181, 1719];
B15 = [2196, 1763];
B16 = [1931, 1870];
B17 = [1894, 1710];
B18 = [1881, 1867];
B19 = [1738, 1750];
B20 = [1948, 2042];
B21 = [2049, 2157];
B22 = [2058, 2343];
B23 = [2009, 2539];
B24 = [1990, 2094];
B25 = [1983, 2663];
B26 = [1952, 2722];
B27 = [1814, 2527];
B28 = [1802, 2303];
B29 = [1767, 2277];
B30 = [1874, 2045];
B31 = [1777, 2518];
B32 = [1847, 2636];
B33 = [1895, 2702];
B34 = [1828, 2103];
B35 = [1907, 1603];
B36 = [2015, 1597];
B37 = [1868, 1505];
B38 = [2076, 1510];
B39 = [1952, 1442];
B40 = [1973, 1766];
B41 = [1856, 1751];
B42 = [2148, 1806];
B43 = [1820, 2628];

// Polygons
C1 = [A4, A5, B1];
C2 = [A5, A6, B1];
C3 = [A4, B1, A6, B38, B39, B37];
C4 = [A4, A3, B3, B35, B37];
C5 = [B2, B39, B37, B35];
C6 = [B39, B2, B36, B38];
C7 = [B36, B4, A7, A6, B38];
C8 = [B4, A7, A8, A9, B11, B10];
C9 = [B10, B11, B12, B13, B14];
C10 = [B40, B5, B4, B10];
C11 = [B5, B35, B3, B9, B41, B17, B40];
C12 = [B5, B35, B2, B36, B4];
C13 = [B10, B14, B15, B16, B40];
C14 = [B40, B17, B16];
C15 = [B17, B41, B18];
C16 = [B19, B8, B41, B18];
C17 = [B18, B17, B16];
C18 = [A9, A10, A11, B11];
C19 = [A11, A12, B12, B11];
C20 = [A12, A13, B13, B12];
C21 = [A13, A14, B13];
C22 = [A14, B13, B14, A16, A15];
C23 = [B14, A16, A17, A18, B15];
C24 = [B15, B42, A18];
C25 = [B16, B20, B42, B15];
C26 = [B42, A18, A19, B21, B24, B20];
C27 = [B21, B22, A19];
C28 = [B22, A19, A20];
C29 = [A20, A21, B23, B24, B21, B22];
C30 = [A21, A22, B23];
C31 = [A22, A23, B25, B24, B23];
C32 = [A23, A24, B25];
C33 = [A24, A25, B26, B24, B25];
C34 = [A25, A26, B26];
C35 = [A26, A27, B24, B26];
C36 = [B19, B30, B18];
C37 = [B30, B34, A36, A37, B19];
C38 = [A2, B6, B7, B8, B41, B9];
C39 = [A2, B9, B3, A3];
C40 = [A1, A2, B6, A44];
C41 = [B6, B7, A43, A44];
C42 = [B7, B8, A42, A43];
C43 = [B8, A41, A42];
C44 = [B8, B19, A39, A40, A41];
C45 = [B19, A39, A38, A37];
C46 = [B34, A36, A35, B29];
C47 = [A35, A34, B29];
C48 = [A34, B28, B34, B29];
C49 = [A34, A33, B31, B30, B34, B28];
C50 = [A33, A32, B31];
C51 = [A32, B27, B30, B31];
C52 = [A32, A31, B43, B30, B27];
C53 = [A30, B32, B30, B43, A31];
C54 = [A30, A29, B30, B32];
C55 = [B18, B30, A29, A28, B33];
C56 = [A28, B33, B18, B16, B20, B24, A27];

cut_polygons = [C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C38, C39, C40, C41, C42, C43, C44, C45, C46, C47, C48, C49, C50, C51, C52, C53, C54, C55, C56];

min_x = A1[0];
min_y = A1[1];
max_x = A10[0];
max_y = A27[1];

x_size = max_x - min_x;
y_size = max_y - min_y;

x_factor = max_size / x_size;
y_factor = max_size / y_size;

inline_size = x_size > y_size ? inline_size_in_millimeter / x_factor / 2: inline_size_in_millimeter / y_factor / 2;
inline_edge_radius = x_size > y_size ? inline_edge_radius_in_millimeter / x_factor: inline_edge_radius_in_millimeter / y_factor;
outline_size = x_size > y_size ? outline_size_in_millimeter / x_factor - inline_size: outline_size_in_millimeter / y_factor - inline_size;


 // Program Section //
//-----------------//

if(x_size > y_size) {
    resize(newsize=[max_size, x_factor * y_size, model_height]){
        if(flip_model == "yes") {
            mirror([0,1,0]) {
                rotate([180,180,0]) {    
                    create(outline, cut_polygons);
                }
            }
        } else {
            create(outline, cut_polygons);
        }
    }
} else {
    resize(newsize=[y_factor * x_size, max_size, model_height]){
        if(flip_model == "yes") {
            mirror([0,1,0]) {
                rotate([180,180,0]) {    
                    create(outline, cut_polygons);
                }
            }
        } else {
            create(outline, cut_polygons);
        }
    }
}


 // Module Section //
//----------------//

module create() {
    linear_extrude(height=1) {
        difference() {
            offset(r = -0) {
                offset(r = +outline_size) {
                    polygon(points = outline, convexity = 10);
                }
            }
            
            for(cut_polygon = [0:len(cut_polygons)]) {
                offset(r = +inline_edge_radius) {
                    offset(r = -inline_size - inline_edge_radius) {
                        polygon(points = cut_polygons[cut_polygon], convexity = 10);
                    }
                }
            }
        }
    }
}
