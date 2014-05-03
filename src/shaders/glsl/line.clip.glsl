uniform float clipRange;
uniform vec2  clipStyle;
uniform float clipSpace;

attribute vec2 strip;
//attribute vec2 position4;

varying vec2 vClip;

// External
vec3 getPosition(vec4 xyzi);

vec3 clipPosition(vec3 pos) {

  // Sample end of line strip
  vec4 xyziE = vec4(position4.xyz, strip.y);
  vec3 end = getPosition(xyziE);

  // Sample start of line strip
  vec4 xyziS   = vec4(position4.xyz, strip.x);
  vec3 start = getPosition(xyziS);

  // Measure length and adjust clip range
  vec3 diff = end - start;
  float l = length(diff) * clipSpace;
  float mini = clamp((3.0 - l / clipRange) * .333, 0.0, 1.0);
  float scale = 1.0 - mini * mini * mini;
  float range = clipRange * scale;
  
  vClip = vec2(1.0);
  
  if (clipStyle.y > 0.0) {
    // Clip end
    float d = length(pos - end);
    vClip.x = d / range - 1.0;
  }

  if (clipStyle.x > 0.0) {
    // Clip start 
    float d = length(pos - start);
    vClip.y = d / range - 1.0;
  }

  // Passthrough position
  return pos;
}