---
layout: post
title:  "Zig in Action"
date:   2025-09-09 12:00:00 +0800
categories: Zig
tags:
  - Zig

---

* Do not remove this line (it will not be displayed)
{:toc}

`Zig` is a general-purpose programming language and toolchain for maintaining robust, optimal and reusable software.

> A Simple Language

Focus on debugging your application rather than debugging your programming language knowledge.

* No hidden control flow.
* No hidden memory allocations.
* No preprocessor, no macros.

> Comptime

A fresh approach to metaprogramming based on compile-time code execution and lazy evaluation.

* Call any function at compile-time.
* Manipulate types as values without runtime overhead.
* Comptime emulates the target architecture.

> Maintain it with Zig

Incrementally improve your C/C++/Zig codebase.

* Use Zig as a zero-dependency, drop-in C/C++ compiler that supports cross-compilation out-of-the-box.
* Leverage zig build to create a consistent development environment across all platforms.
* Add a Zig compilation unit to C/C++ projects, exposing the rich standard library to your C/C++ code.

# Example

## Hello World

A minimal example printing `hello world`.

```zig
// hello-world.zig

const std = @import("std");

pub fn main() !void {
    try std.fs.File.stdout().writeAll("hello world!\n");
}
```

```
$ zig build-exe hello-world.zig
$ ./hello-world
hello world!
```

## Calling external library functions (调用外部库函数)

All system API functions can be invoked this way, you do not need library bindings to interface them.

```zig
// windows-msgbox.zig

const win = @import("std").os.windows;

extern "user32" fn MessageBoxA(?win.HWND, [*:0]const u8, [*:0]const u8, u32) callconv(win.WINAPI) i32;

pub fn main() !void {
    _ = MessageBoxA(null, "world!", "Hello", 0);
}
```

```
$ zig test windows-msgbox.zig
All 0 tests passed.
```

## Memory leak detection (内存泄露检测)

Using `std.heap.GeneralPurposeAllocator` you can track double frees and memory leaks.

```zig
// memory-leak.zig

const std = @import("std");

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    defer std.debug.assert(general_purpose_allocator.deinit() == .ok);

    const gpa = general_purpose_allocator.allocator();

    const u32_ptr = try gpa.create(u32);
    _ = u32_ptr; // silences unused variable error

    // oops I forgot to free!
}
```


```
$ zig build-exe memory-leak.zig
$ ./memory-leak
error(gpa): memory address 0x7f5d08ea0000 leaked:
/home/ci/actions-runner-website/_work/www.ziglang.org/www.ziglang.org/zig-code/samples/memory-leak.zig:9:35: 0x113d457 in main (memory-leak.zig)
    const u32_ptr = try gpa.create(u32);
                                  ^
/home/ci/deps/zig-x86_64-linux-0.15.1/lib/std/start.zig:627:37: 0x113dd49 in posixCallMainAndExit (std.zig)
...
```

## C interoperability (C 互操作性)

Example of importing a `C` header file and linking to both `libc` and `raylib`.

```zig
// c-interop.zig

// build with `zig build-exe c-interop.zig -lc -lraylib`
const ray = @cImport({
    @cInclude("raylib.h");
});

pub fn main() void {
    const screenWidth = 800;
    const screenHeight = 450;

    ray.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window");
    defer ray.CloseWindow();

    ray.SetTargetFPS(60);

    while (!ray.WindowShouldClose()) {
        ray.BeginDrawing();
        defer ray.EndDrawing();

        ray.ClearBackground(ray.RAYWHITE);
        ray.DrawText("Hello, World!", 190, 200, 20, ray.LIGHTGRAY);
    }
}
```



## Test

```zig
// index.zig

const std = @import("std");
const parseInt = std.fmt.parseInt;

test "parse integers" {
    const input = "123 67 89,99";
    const gpa = std.testing.allocator;

    var list: std.ArrayList(u32) = .empty;
    // Ensure the list is freed at scope exit.
    // Try commenting out this line!
    defer list.deinit(gpa);

    var it = std.mem.tokenizeAny(u8, input, " ,");
    while (it.next()) |num| {
        const n = try parseInt(u32, num, 10);
        try list.append(gpa, n);
    }

    const expected = [_]u32{ 123, 67, 89, 99 };

    for (expected, list.items) |exp, actual| {
        try std.testing.expectEqual(exp, actual);
    }
}
```

```
$ zig test index.zig
1/1 index.test.parse integers...OK
All 1 tests passed.
```

## Zigg Zagg

`Zig` is optimized for coding interviews (not really).

```zig
// ziggzagg.zig

const std = @import("std");

pub fn main() !void {
    var i: usize = 1;
    while (i <= 16) : (i += 1) {
        if (i % 15 == 0) {
            std.log.info("ZiggZagg", .{});
        } else if (i % 3 == 0) {
            std.log.info("Zigg", .{});
        } else if (i % 5 == 0) {
            std.log.info("Zagg", .{});
        } else {
            std.log.info("{d}", .{i});
        }
    }
}
```

```
$ zig build-exe ziggzagg.zig
$ ./ziggzagg
info: 1
info: 2
info: Zigg
info: 4
info: Zagg
info: Zigg
info: 7
info: 8
info: Zigg
info: Zagg
info: 11
info: Zigg
info: 13
info: 14
info: ZiggZagg
info: 16
```


## Generic Types (泛型)

In `Zig` types are comptime values and we use functions that return a type to implement generic algorithms and data structures. In this example we implement a simple generic queue and test its behaviour.


```zig
// generic-type.zig

const std = @import("std");

pub fn Queue(comptime Child: type) type {
    return struct {
        const Self = @This();
        const Node = struct {
            data: Child,
            next: ?*Node,
        };
        gpa: std.mem.Allocator,
        start: ?*Node,
        end: ?*Node,

        pub fn init(gpa: std.mem.Allocator) Self {
            return Self{
                .gpa = gpa,
                .start = null,
                .end = null,
            };
        }
        pub fn enqueue(self: *Self, value: Child) !void {
            const node = try self.gpa.create(Node);
            node.* = .{ .data = value, .next = null };
            if (self.end) |end| end.next = node //
            else self.start = node;
            self.end = node;
        }
        pub fn dequeue(self: *Self) ?Child {
            const start = self.start orelse return null;
            defer self.gpa.destroy(start);
            if (start.next) |next|
                self.start = next
            else {
                self.start = null;
                self.end = null;
            }
            return start.data;
        }
    };
}

test "queue" {
    var int_queue = Queue(i32).init(std.testing.allocator);

    try int_queue.enqueue(25);
    try int_queue.enqueue(50);
    try int_queue.enqueue(75);
    try int_queue.enqueue(100);

    try std.testing.expectEqual(int_queue.dequeue(), 25);
    try std.testing.expectEqual(int_queue.dequeue(), 50);
    try std.testing.expectEqual(int_queue.dequeue(), 75);
    try std.testing.expectEqual(int_queue.dequeue(), 100);
    try std.testing.expectEqual(int_queue.dequeue(), null);

    try int_queue.enqueue(5);
    try std.testing.expectEqual(int_queue.dequeue(), 5);
    try std.testing.expectEqual(int_queue.dequeue(), null);
}
```

```
$ zig test generic-type.zig
1/1 generic-type.test.queue...OK
All 1 tests passed.
```

## Using cURL from Zig (在 Zig 中使用 cURL)

```zig
// curl.zig

// compile with `zig build-exe zig-curl-test.zig --library curl --library c $(pkg-config --cflags libcurl)`
const std = @import("std");
const cURL = @cImport({
    @cInclude("curl/curl.h");
});

pub fn main() !void {
    var arena_state = std.heap.ArenaAllocator.init(std.heap.c_allocator);
    defer arena_state.deinit();

    const allocator = arena_state.allocator();

    // global curl init, or fail
    if (cURL.curl_global_init(cURL.CURL_GLOBAL_ALL) != cURL.CURLE_OK)
        return error.CURLGlobalInitFailed;
    defer cURL.curl_global_cleanup();

    // curl easy handle init, or fail
    const handle = cURL.curl_easy_init() orelse return error.CURLHandleInitFailed;
    defer cURL.curl_easy_cleanup(handle);

    var response_buffer = std.ArrayList(u8).init(allocator);

    // superfluous when using an arena allocator, but
    // important if the allocator implementation changes
    defer response_buffer.deinit();

    // setup curl options
    if (cURL.curl_easy_setopt(handle, cURL.CURLOPT_URL, "https://ziglang.org") != cURL.CURLE_OK)
        return error.CouldNotSetURL;

    // set write function callbacks
    if (cURL.curl_easy_setopt(handle, cURL.CURLOPT_WRITEFUNCTION, writeToArrayListCallback) != cURL.CURLE_OK)
        return error.CouldNotSetWriteCallback;
    if (cURL.curl_easy_setopt(handle, cURL.CURLOPT_WRITEDATA, &response_buffer) != cURL.CURLE_OK)
        return error.CouldNotSetWriteCallback;

    // perform
    if (cURL.curl_easy_perform(handle) != cURL.CURLE_OK)
        return error.FailedToPerformRequest;

    std.log.info("Got response of {d} bytes", .{response_buffer.items.len});
    std.debug.print("{s}\n", .{response_buffer.items});
}

fn writeToArrayListCallback(data: *anyopaque, size: c_uint, nmemb: c_uint, user_data: *anyopaque) callconv(.C) c_uint {
    var buffer: *std.ArrayList(u8) = @alignCast(@ptrCast(user_data));
    var typed_data: [*]u8 = @ptrCast(data);
    buffer.appendSlice(typed_data[0 .. nmemb * size]) catch return 0;
    return nmemb * size;
}
```


## Example Project

https://github.com/zfl9/chinadns-ng


# Refer

* https://ziglang.org/
* https://ziglang.org/learn/overview/
* https://ziglang.org/learn/samples/












