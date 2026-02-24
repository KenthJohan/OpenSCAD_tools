// BOSL2-based OpenSCAD script
// Shape: A base cylinder with (1) a smaller cylinder subtracted from the top
// and (2) an even smaller extruded hexagon also subtracted from the top.
//
// Requires BOSL2 in your OpenSCAD include path.
// Repo reference: https://github.com/BelfrySCAD/BOSL2

include <BOSL2/std.scad>;


epsilon = 0.01;

/* [Quality] */
$fn = 128;

bearing608_do = 22;
bearing608_di = 8;
bearing608_h = 7;

module bearing(do,di,h) {
    difference() {
        cyl(d=do, h=h, anchor=BOTTOM);
        up(-epsilon) cyl(d=di, h=h + epsilon*2, anchor=BOTTOM);
    }
}

module bearing608() bearing(bearing608_do, bearing608_di, bearing608_h);


module spool_spinner_half(base_d,base_h,pocket_d,pocket_h, id) {
    difference() {
        // Base cylinder, anchored at bottom for easy positioning
        cyl(d=base_d, h=base_h, anchor=BOTTOM);
        // Subtract smaller cylinder from the top
        // Position so its top is flush with the base top, and it cuts downward
        up(base_h - pocket_h)
            cyl(d=pocket_d, h=pocket_h + epsilon, anchor=BOTTOM);
        // Subtract even smaller extruded hexagon from the top
        // BOSL2 regular polygon extrusion via linear_extrude + regular_ngon()
        // Place it so it also cuts downward from the top face.
        up(-epsilon)
            linear_extrude(height=base_h + epsilon)
                regular_ngon(n=6, id=id);
    }
}

module spool_spinner(
    base_d,
    base_h,
    pocket_d,
    pocket_h,
    id
) {
    // Decenter z axis
    translate([0,0,base_h/2]) {
        spool_spinner_half(base_d=base_d, base_h=base_h/2, pocket_d=pocket_d, pocket_h=pocket_h, id=id);
        mirror([0,0,1]) spool_spinner_half(base_d=base_d, base_h=base_h/2, pocket_d=pocket_d, pocket_h=pocket_h, id=id);
    }
}


module spool_static(
    base_d,
    base_h,
    axis_d,
    axis_h,
    hole_d,
    hex_flat_d
) {
    difference() {
        // Base cylinder, anchored at bottom for easy positioning
        union() {
            translate([0,0,0])      cyl(d=base_d, h=base_h, anchor=BOTTOM);
            translate([0,0,base_h]) cyl(d=axis_d, h=axis_h, anchor=BOTTOM);
            translate([0,0,base_h]) cyl(d=axis_d+4, h=0.4, anchor=BOTTOM);
        }
        up(-epsilon) cyl(d=hole_d, h=axis_h + axis_h + epsilon*2, anchor=BOTTOM);
    }
}


j = 38.5;

module banana() {
    spinner_side_thickness = 1.6;
    spinner_h = 25;
    spinner_d = 65;
    hex_id = 5.0 + 0.5; //0.2
    bearing_od = bearing608_do + 0.2;
    
    
    color([0.8, 0.5, 0.5, 1])
    translate([0,0,0])
    spool_static(
    base_d=spinner_d, 
    base_h=spinner_side_thickness, 
    axis_d=bearing608_di + 0.3, 
    axis_h=bearing608_h - epsilon, 
    hole_d=bearing608_di - 2
    );

    
    /*
    color([1, 1, 0, 1])
    translate([0,0,spinner_side_thickness + 0.5])
    bearing608();
    
    color([1, 1, 0, 1])
    translate([0,0,spinner_side_thickness + spinner_h - bearing608_h])
    bearing608();
    
    translate([0,0,spinner_side_thickness + 0.5])
    color([0.6, 0, 0.6, 1])
    spool_spinner(base_d=26, base_h=j-(bearing608_h-+spinner_side_thickness*2), pocket_d=bearing_od, pocket_h=bearing608_h, id=hex_id);
    
    */
}


view_cross_section = false;


if (view_cross_section) {
    difference() {
    banana();
    translate([-100,0,-100])
    cube([200,100,200]);
    }
} else {
    banana();
}

//cube([j,j,j]);
//translate([-100,0,-100])
//cube([200,100,200]);






















