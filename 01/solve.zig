const std = @import("std");

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    var depths = std.ArrayList(i32).init(&arena.allocator);
    var buffer: [4]u8 = undefined;
    while (try stdin.readUntilDelimiterOrEof(&buffer, '\n')) |line|
        try depths.append(try std.fmt.parseInt(i32, line, 10));

    try stdout.print(
        "Part 1: {}\nPart 2: {}\n",
        .{ part1(depths.items), part2(depths.items) },
    );
}
fn part1(depths: []i32) i32 {
    var s: i32 = 0;
    for (depths[1..]) |b, i| {
        if (b > depths[i]) {
            s = s + 1;
        }
    }
    return s;
}

fn part2(depths: []i32) i32 {
    var s: i32 = 0;
    for (depths[3..]) |b, i| {
        var prev: i32 = depths[i] + depths[i + 1] + depths[i + 2];
        var curr: i32 = depths[i + 1] + depths[i + 2] + b;
        if (curr > prev) {
            s = s + 1;
        }
    }
    return s;
}
