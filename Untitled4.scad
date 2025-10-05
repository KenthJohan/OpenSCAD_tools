include <BOSL2/std.scad>

BOLT_M3_CLOSEFIT = 3.2;
lcd1602_pcb = [80, 36, 1.7];
lcd1602_mholes = [75, 31];
lcd1602_disp = [71, 24.2, 7];

lcd1602_case = [90, 40, 2];

module template_holes(h) {
    $fn = 10;
    grid_copies(size=lcd1602_mholes, spacing=lcd1602_mholes)
        translate([0,0,-lcd1602_pcb.z])
        zcyl(h=lcd1602_pcb.z*3, d=BOLT_M3_CLOSEFIT,anchor=[0,0,-1]);
}

module body_pcb() {
    color([0, 1, 0, 1])
    difference() {
        cuboid(lcd1602_pcb,anchor=[0,0,-1]);
        template_holes(lcd1602_pcb.z*2);
    }
    color([0.1, 0.1, 0.1, 1])
    translate([0, 0, lcd1602_pcb[2]])
        cuboid(lcd1602_disp,anchor=[0,0,-1]);
}

module body_case(h) {
    color([0, 1, 0, 1])
    difference() {
        cuboid([lcd1602_pcb.x, lcd1602_pcb.y, h*1],anchor=[0,0,-1]);
        {
            template_holes(lcd1602_pcb.z*2);
            cuboid(lcd1602_disp+[1,1,0],anchor=[0,0,0]);
        }
    }
}

nn = [1,4];
padding = 4;
wall = 3;

grid_copies(spacing=lcd1602_pcb.xy, n=nn)
body_pcb();

translate([0,0,5])
{
s = [lcd1602_pcb.x*nn.x, lcd1602_pcb.y*nn.y];
echo("case ", s.x, " ", s.y);
grid_copies(spacing=lcd1602_pcb.xy, n=nn) body_case(lcd1602_case.z-0.1);
color([1, 1, 1, 1])
rect_tube(isize=s, wall=padding, h=lcd1602_case.z);
translate([0,0,-30])
rect_tube(isize=[s.x+0.5, s.y+0.5], wall=wall, h=30);
}


/*
module body_rebar() {
    cuboid(lcd1602_pcb,anchor=[0,0,0]);
}
*/