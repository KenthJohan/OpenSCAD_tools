// https://github.com/BelfrySCAD/BOSL2/wiki/


include <BOSL2/std.scad>

BOLT_M8_SIDESIDE = 13; // 13mm
BOLT_M8_CLOSEFIT = 8.4; // 8.4mm
BOLT_M8_HEAD = 5; // 5mm


module hex_rod(h) {
    r = 6;
    linear_extrude(height = BOLT_M8_HEAD + 5, center = false, convexity = 10, twist = 0,anchor=BOTTOM)
    hexagon(id=BOLT_M8_SIDESIDE,anchor=CENTER);
    zcyl(h=h, d=BOLT_M8_CLOSEFIT,anchor=BOTTOM);
    zcyl(h=h, d=BOLT_M8_CLOSEFIT,anchor=CENTER);
}


module griddy() {
    spacing=60;
    h = 50;
    grid_copies(size=spacing, spacing=spacing)
        hex_rod(h);
    hex_rod(h);
}

difference() {
cuboid([100,100,40], edges=[[-1,-1,0],[1,-1,0],[-1,1,0],[1,1,0]], chamfer=8,anchor=BOTTOM);
griddy();
}

/*
difference() {
cuboid([100,100,40], edges=[[-1,-1,0],[1,-1,0],[-1,1,0],[1,1,0]], chamfer=4,anchor=BOTTOM);
hex(12, h);
}
*/