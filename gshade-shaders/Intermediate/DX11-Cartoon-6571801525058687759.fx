#line 1 "unknown"

#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Cartoon.fx"
#line 7
uniform float Power <
ui_type = "slider";
ui_min = 0.1; ui_max = 10.0;
ui_tooltip = "Amount of effect you want.";
> = 1.5;
uniform float EdgeSlope <
ui_type = "slider";
ui_min = 0.1; ui_max = 6.0;
ui_label = "Edge Slope";
ui_tooltip = "Raise this to filter out fainter edges. You might need to increase the power to compensate. Whole numbers are faster.";
> = 1.5;
#line 1 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\ReShade.fxh"
#line 50
namespace ReShade
{
float GetAspectRatio() { return 3440 * (1.0 / 1440); }
float2 GetPixelSize() { return float2((1.0 / 3440), (1.0 / 1440)); }
float2 GetScreenSize() { return float2(3440, 1440); }
#line 60
texture BackBufferTex : COLOR;
texture DepthBufferTex : DEPTH;
#line 63
sampler BackBuffer { Texture = BackBufferTex; };
sampler DepthBuffer { Texture = DepthBufferTex; };
#line 67
float GetLinearizedDepth(float2 texcoord)
{
#line 72
texcoord.x /=  1;
texcoord.y /=  1;
#line 77
texcoord.x -=  0 / 2.000000001;
#line 82
texcoord.y +=  0 / 2.000000001;
#line 84
float depth = tex2Dlod(DepthBuffer, float4(texcoord, 0, 0)).x *  1;
#line 93
const float N = 1.0;
depth /= 1000.0 - depth * (1000.0 - N);
#line 96
return depth;
}
}
#line 101
void PostProcessVS(in uint id : SV_VertexID, out float4 position : SV_Position, out float2 texcoord : TEXCOORD)
{
if (id == 2)
texcoord.x = 2.0;
else
texcoord.x = 0.0;
#line 108
if (id == 1)
texcoord.y = 2.0;
else
texcoord.y = 0.0;
#line 113
position = float4(texcoord * float2(2.0, -2.0) + float2(-1.0, 1.0), 0.0, 1.0);
}
#line 19 "I:\Games\SquareEnix\FINAL FANTASY XIV - A Realm Reborn\game\gshade-shaders\Shaders\Cartoon.fx"
#line 25
float3 CartoonPass(float4 position : SV_Position, float2 texcoord : TEXCOORD) : SV_Target
{
const float3 color = tex2D(ReShade::BackBuffer, texcoord).rgb;
const float3 coefLuma = float3(0.2126, 0.7152, 0.0722);
#line 30
float diff1 = dot(coefLuma, tex2D(ReShade::BackBuffer, texcoord +  float2((1.0 / 3440), (1.0 / 1440))).rgb);
diff1 = dot(float4(coefLuma, -1.0), float4(tex2D(ReShade::BackBuffer, texcoord -  float2((1.0 / 3440), (1.0 / 1440))).rgb , diff1));
float diff2 = dot(coefLuma, tex2D(ReShade::BackBuffer, texcoord +  float2((1.0 / 3440), (1.0 / 1440)) * float2(1, -1)).rgb);
diff2 = dot(float4(coefLuma, -1.0), float4(tex2D(ReShade::BackBuffer, texcoord +  float2((1.0 / 3440), (1.0 / 1440)) * float2(-1, 1)).rgb , diff2));
#line 35
const float edge = dot(float2(diff1, diff2), float2(diff1, diff2));
#line 41
return saturate(pow(abs(edge), EdgeSlope) * -Power + color);
#line 43
}
#line 45
technique Cartoon
{
pass
{
VertexShader = PostProcessVS;
PixelShader = CartoonPass;
}
}

