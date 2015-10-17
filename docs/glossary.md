# Glossary

## DOM
* Attribute - (trait? props?) An individual value set on a node.
* DOM - Document Object Model. In general, refers to the HTML on the page. In MathBox, refers to the virtual DOM of nodes and their hierarchical structure.
* Node - an instance of a primitive, inserted into the MathBox DOM.
* Primitive - one of the basic building blocks of MathBox.
* RTT - Render To Texture. Rather than drawing directly to the screen, renders to an image that can be processed further.
* Selection - A subset of the DOM. Can be the entire DOM or all nodes matching a selector.
* Shader - A program written in GLSL that runs on the GPU.
* ShaderGraph - A component/dependency of MathBox that dynamically compiles small GLSL functions (snippets) into a single shader to be run.

## Functions on Selections
* `bind("attributeName", function(t, d){ ... })` - A function on selectors to invoke the function every frame and set the attribute to its return value. The function's arguments are the time since page load (always?) and the time delta since the last frame, both in seconds.
* `debug()` - Display a visual representation of all shader snippets, how they are wired, with the GLSL available on mouseover.
* `end()` - Indicate that subsequent nodes are siblings rather than children of the current node. Also used to return the current selection to be assigned to a variable (??).
* `get("attributeName")` - Get the current value of an attribute.
* `inspect()` - Print (in the console) the DOM nodes they contain.
* `select("selector")` - A function on `mathbox` that returns a selection of all the nodes matching the selector. Like CSS, the selector may be the name of a primitive (e.g. `"camera"`), an id (e.g. `"#colors"`), or a class (e.g. `".points"`).
* `set("attributeName", value)` - Set an attribute to the value provided.

## Data
* `emit` - A function passed as the first argument to function given to the `expr` attribute of data primitives. When called, its arguments become data.
* Length or Width - The size of the data in the *x* direction, i.e. the number of rows. (`array` and `interval` use length; others use width.)
* Height - The size of the data in the *y* direction, i.e. the number of columns.
* Depth - The size of the data in the *z* direction, i.e. the number of stacks.
* Items - The size of the data in the *w* direction, i.e. the number of data points per spatial position. The number of times you call `emit` in the `expr` function.
* Channels - How many numbers are associated with with data point. The number of arguments passed to `emit`.
* History - The process of storing previous 1D or 2D data in an unused dimension.
