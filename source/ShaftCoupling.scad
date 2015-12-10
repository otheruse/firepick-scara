include <shapes.scad>

include <configuration.scad>

module tube(id = 5, od = 10, h) {
    difference() {
        cylinder(d = od, h = h);
        cylinder(d = id, h = h);
    }
}

module nutSlot(nutHeight, nutDia, slotDepth) {
    translate([0,0,slotDepth])rotate([0,90,0])hull() {
        cylinder(d=nutDia, h = nutHeight, $fn=6);
        translate([slotDepth, 0,0])cylinder(d=nutDia, h = nutHeight, $fn=6);
    }
}

module ShaftCoupling(axis1_dia = 8, axis2_dia = 5) {
    height = 20;
    partHeight = (height-2)/2;
    screwHeight = 4.5;
    wall = 14;
    
    module fastener(axis_dia) {
        // screw
        translate([0,0,screwHeight])rotate([0,90,0])cylinder(d=m3_dia, h=axis_dia + wall);
        // nut slot
        translate([axis_dia/2+1,0,0])nutSlot(nutHeight = m3_nut_height, nutDia = m3_nut_dia, slotDepth = screwHeight);
    }
    
    difference() {
        union() {
            // part1
            tube(id = axis1_dia, od = axis1_dia + wall, h = partHeight);
            // between
            translate([0,0,partHeight])cylinder(d1 = axis1_dia + wall, d2=axis2_dia + wall, h=2);
            // part2
            translate([0,0,partHeight + 2])tube(id = axis2_dia, od = axis2_dia + wall, h = partHeight);
        }
        for (a=[0:120:240]) {
            rotate([0,0,a]) {
                // bottom nut slots
                fastener(axis1_dia);
                // top nut slots
                translate([0,0,height])mirror([0,0,1])fastener(axis2_dia);
            }
        }
    }
}

ShaftCoupling();

//nutSlot(nutHeight = m3_nut_height, nutSlotDia = m3_nut_slot, slotDepth = 9);
//$fs=0.3;
//$fa = 3;