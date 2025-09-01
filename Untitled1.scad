// https://github.com/BelfrySCAD/BOSL2/wiki/


include <BOSL2/std.scad>


module hex(s,h,anchor=BOTTOM) {
    n = 6;
    rm = s / 2;
    r = rm / cos(180/n);
    cylinder(h=h, r=r,$fn=n,anchor=anchor);
}


module hex_rod(h) {
    r = 6;
    hex(18, 16, BOTTOM);
    hex(18, 16, CENTER);
    zcyl(h=h, r=r,anchor=BOTTOM);
    zcyl(h=h, r=r,anchor=CENTER);
}


module griddy() {
    spacing=60;
    h = 50;
    grid_copies(size=spacing, spacing=spacing)
        hex_rod(h);
    hex_rod(h);
}

difference() {
cuboid([100,100,40], edges=[[-1,-1,0],[1,-1,0],[-1,1,0],[1,1,0]], chamfer=4,anchor=BOTTOM);
griddy();
}

/*
difference() {
cuboid([100,100,40], edges=[[-1,-1,0],[1,-1,0],[-1,1,0],[1,1,0]], chamfer=4,anchor=BOTTOM);
hex(12, h);
}
*/