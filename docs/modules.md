## Mathbox Modules


### About Nodes

Mathbox is built around nodes with names like `<array>`, `<transpose>` and `<slice>`.  The nodes are passed properties such as the number of dimensions, or the definition of a function to call.

Nodes can be chained together.  You can write:

```javascript
    view.array({
      items: 3,
      channels: 3,
      expr: function(emit, x){
          emit(x,x,x);
      }
    })
    .point({
      // Multiply every color component in [0..1] by 255
      color: 0xffffff,
      size: 20,
    });
```

After this, the point node now follows on from the array node.  Nodes may accept data sources, and act as data sources.  If you don't specify the source for a node then the source is the most relevant node before.

You can think of data as flowing down through the sequence.  However it is actually 'pulled' by the drawing operations.  This can be subtly different.  For example fewer intermediate values may actually be calculated.  This is lazy evaluation.  If you look at the shader graph using `.debug()` you will see callback functions in there.  The callbacks are only called for the needed values.

#### Timer Updates

Mathbox typically calls your data generating functions, `expr:`, on a timer.  However any of the properties can be bound to the timer.  The nodes have a syntax where you can pass a second set of properties, and these ones will be re-evaluated on each timer event.

#### Selection

Subsets of nodes can be selected and operated on using javascript with JQuery like syntax.  To assist with this you can add custom classes to any node you create.


#### Base Nodes

You (probably) won't use these.  Other nodes are built on these.


#### Camera Nodes

If you want `THREE.js` (the 3D library Mathbox is built on) to control the camera position, then you need to set the `proxy: true,` property on the camera.

The `up:` property provides a way to set the direction of the coordinates.  


#### Data Nodes

Data are the sources of information for Mathbox.  These nodes typically call a javascript function attached to the expr: property, which `emit()`s data.  The data sources can be updated continuously (`live: true`) or retrieved just once and then reused without change (`live: false`).  The data sources differ in the number of dimensions, and in whether they are typically indexed by continuous or discrete variables.

The dimensions are `items`, `width`, `height` and `depth`  (in that order).  `Items` are filled by multiple calls to `emit()` from the one javascript function, effectively allowing one javscript function to have multiple return values.  The others dimensions are filled by repeated calls by mathbox to the expr: function.  

The data values are vectors of up to four floats.  The number of floats in the data values is set by the `channels:` property. 

The data dimensions and the wxyz dimensions in the 'vec4s' are completely different spaces.  It can be confusing at first.  That's partly because in some examples the programmer has decided to make some correspondence between them.  One easy way to see this is by using the data to drive a display of points.  Transposes which rearrange the data dimensions have no effect on the display, whereas swizzles which affect the wxyz in the vec4s do.  Transposes though are important when it comes to faces and surfaces, since the data order affects the order of visiting the points.

There are some restrictions on the sizes of the dimensions for data, that ultimately come from the limits on the dimensions of stored textures in WebGL.  The restrictions don't hold for non-data nodes, apart from `<rtt>` and `<memo>`, which also store their results in a texture.



#### Draw Nodes

The `<vector>` primitive does not draw its body correctly on some graphics cards, when `end: true,` is specified.
 

#### Operator Nodes

Operators take a stream of data and transform it to another stream of data.  Some 'reshape' the data stream.  Others operate on the data values.  

These operators change the data values:
 * `<grow>`, `<swizzle>`, `<spread>`.
It's worth looking at the transform operators too.  `<grow>` is a special case of transform.  The coordinate transform operators also affect the data values only.
 
These operators (only) reshape data:
 * `<join>`, `<repeat>`, `<split>`, `<slice>`, `<transpose>`.

`<resample>` changes the dimensions of the array, increases or decreases the number of elements and typically creating new values by interpolation.  You can provide a shader to specify exactly how.

`<lerp>` is a custom resampler that interpolates.
 
##### Examples: 
 * _example-with-points_ - Shows the difference between swizzle and transpose.  Swizzle moves the points, but transpose doesn't.
 * _example-with-surface_ - Shows how after transpose the surface operator connects different points from the data source to make its surfaces.
 * _example-with-spread_ - Shows how spread provides a route for feeding the shape (`width` x `height` x `depth` x `items` ) to actual coordinate data.
 * _example-with-join-and-split_ - Arbitrary reshaping of data using join and split.
 

#### Overlay Nodes



#### Present Nodes

The 'present' primitives are concerned with the slideshow features of Mathbox.  

#### RTT Nodes

Explain difference between `<rtt>` and `<memo>`.  What does `<compose>` do, and why is it in a different category to the transform passes, (`<vertex>`, `<fragment>` and `<mask>`)?


#### Shader Nodes

##### Examples:
 * _max shader_ - a custom shader that finds the max of runs of 16 consecutive values.
 * _protoypes_shader_ - a custom shader that selects a prototype based on an index value.


#### Text Nodes


#### Time Nodes


#### Transform Nodes

Guessing: `<layer>` is useful for a HUD style display?


#### View Nodes






