
#ifdef GL_ES
precision highp float;
#endif

// Declare our modelViewProjection matrix that we'll compute
//  outside the shader and set each frame
uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

// Declare inputs and outputs
// inPosition : Position attributes from the VAO/VBOs
// inTexcoord : Texcoord attributes from the VAO/VBOs
// varTexcoord : TexCoord we'll pass to the rasterizer
// gl_Position : implicitly declared in all vertex shaders. Clip space position
//               passed to rasterizer used to build the triangles

#if __VERSION__ >= 140
in vec4  inPosition;  
in vec2  inTexcoord;
out vec2 varTexcoord;
#else
attribute vec3 inNormal;
attribute vec4 inPosition;  
attribute vec2 inTexcoord;
varying vec3  varNormal;
varying vec2 varTexcoord;
#endif

float getY(vec3 pos){
    return 0.0;
}

void main (void)
{
	// Transform the vertex by the model view projection matrix so
	// the polygon shows up in the right place
    
    vec3 normal = inNormal;
    
    float percent = 0.5;
    
 
    vec3 pos = inPosition.xyz;
   
    pos.xyz*=100.0;

    pos.y = getY(pos);
    
	gl_Position = (modelViewProjectionMatrix * vec4(pos,1.0));
    
    varNormal = normalize(normalMatrix * normal);
    
	// Pass the unmodified texture coordinate from the vertex buffer
	// directly down to the rasterizer.
    varTexcoord = inTexcoord;
}


