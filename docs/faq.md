## Mathbox FAQ

Q: **What's the difference between `<transpose>` and `<swizzle>`?**

A: The difference between `<transpose>` and `<swizzle>` is that `<transpose>` permutes the dimensions of an array, while `<swizzle>` permutes the values of an array. So `<transpose yx>` swaps the width and height, swizzle doesn't, it applies a transposition to the data in the xy plane.

----

Q: **How does history work?**

A: Setting e.g. history: 3 on an array of length: 10 creates a 10x3 matrix that is filled one row at a time. The data will be pushed down the matrix.

Setting e.g. history: 3 on a matrix of width: 5, height: 2 creates 5x2x3 voxels that are filled one slice at a time. The data will be pushed to the back.

Internally this is very fast because the data is not actually being copied/moved.

----

Q: **How can I set an animation to start at a particular point in response to an event?**

A: The intended solution is not to insert .play() to trigger animations, but to define them. MathBox2 is really meant to be used as a declarative animation model.

.play() works off the local or global clock, and can be triggered by slides. There is also .step()

Option 1 is to wrap it inside a .clock() and control its 'seek' property directly, or set its 'speed' to 0 initially, then wind it up at some later point and wind it down again.
Option 2 is to wrap .play() inside .slide(). Then wrap a .present() around it to activate/deactivate the slide. You step forward and backward with the "index" property.
Option 3 is to use .step() which is like .play() but with a movable playhead. It is designed to be triggered by slides. It can stop independent of keyframes and can fast forward through multiple stops. That is, you define a track, and then you can animate to arbitrary points on that track, in any order.

You wrap it inside a .present() block to get a way to control it, by setting the active slide index. You can have as many present blocks as needed. Think of it in terms of data vs shape like when drawing things. Only in this case it's element vs script vs trigger vs controller.

The trifecta of .slide() .play() and .clock() drives 90% of my Pixel Factory presentation. You really should try using them. I've managed animation states manually in Mathbox 1, it was a pain, the declarative way is more productive and more robust. It lets you skip between arbitrary states with automatic continuity, even as live expressions are going. That is, the same way you bind expressions with node.bind()... you can use this on keyframes too, with e.g. script: [{expr: {time: function (t) { return t / 4; }}, ...]. An animation can animate between arbitrary time-derived expressions.

There's also the ability to interpolate emitter expressions too, which means you can animate between multiple live data sets wholesale.

-----


Q: **What is the limit on the number of items?**

A: Running with 40K objects can be fast and responsive.  Data you create using emit is stored in a (items x width) x (height x depth) texture, and both (items x width) and (height x depth) need to be 4096 or below.  Once created, you can transpose it to items * width and it's fine. You can even create a texture like 1024x1024 and then .join() it into a virtual 1048576x1. As long as you don't memoize, it doesn't matter.


