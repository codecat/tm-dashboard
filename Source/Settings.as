#if !COMPETITION
enum ForcePadType
{
	None,
	Gamepad,
	Keyboard,
}

[Setting category="General" name="Force pad type"]
ForcePadType Setting_General_ForcePadType = ForcePadType::None;
#endif

[Setting category="General" name="Hide on hidden interface"]
bool Setting_General_HideOnHiddenInterface = false;

#if !COMPETITION
[Setting category="General" name="Show controller/pad"]
bool Setting_General_ShowPad = true;

[Setting category="General" name="Move controller/pad" description="Use this to easily move the pad position."]
bool Setting_General_MovePad = false;

[Setting category="General" name="Controller/pad position"]
vec2 Setting_General_PadPos = vec2(0.9f, 0.1f);

[Setting category="General" name="Controller/pad size"]
vec2 Setting_General_PadSize = vec2(350, 200);

[Setting category="General" name="Show gearbox"]
bool Setting_General_ShowGearbox = true;

[Setting category="General" name="Move gearbox" description="Use this to easily move the gearbox position."]
bool Setting_General_MoveGearbox = false;

[Setting category="General" name="Gearbox position"]
vec2 Setting_General_GearboxPos = vec2(0.9f, 0.32f);

[Setting category="General" name="Gearbox size"]
vec2 Setting_General_GearboxSize = vec2(350, 50);

[Setting category="General" name="Show wheels"]
bool Setting_General_ShowWheels = false;

[Setting category="General" name="Move wheels" description="Use this to easily move the pad position."]
bool Setting_General_MoveWheels = false;

[Setting category="General" name="Wheels position"]
vec2 Setting_General_WheelsPos = vec2(0.909f, 0.9f);

[Setting category="General" name="Wheels size"]
vec2 Setting_General_WheelsSize = vec2(230, 370);

[Setting category="General" name="Show acceleration"]
bool Setting_General_ShowAcceleration = false;

[Setting category="General" name="Move acceleration" description="Use this to easily move the acceleration position."]
bool Setting_General_MoveAcceleration = false;

[Setting category="General" name="Acceleration position"]
vec2 Setting_General_AccelerationPos = vec2(0.720f, 0.120f);

[Setting category="General" name="Acceleration size"]
vec2 Setting_General_AccelerationSize = vec2(50, 350);
#endif

[Setting category="General" name="Show speed"]
bool Setting_General_ShowSpeed = true;

[Setting category="General" name="Move speed" description="Use this to easily move the speed position."]
bool Setting_General_MoveSpeed = false;

[Setting category="General" name="Speed position"]
vec2 Setting_General_SpeedPos = vec2(0.909f, 0.4f);

[Setting category="General" name="Speed size"]
vec2 Setting_General_SpeedSize = vec2(230, 50);



#if !COMPETITION
enum GamepadStyle
{
	Uniform,
	Classic,
}

[Setting category="Gamepad" name="Style" description="Note: Not all styles use all customization options. Use Uniform for the best experience."]
GamepadStyle Setting_Gamepad_Style = GamepadStyle::Uniform;

[Setting category="Gamepad" name="Empty fill color" color]
vec4 Setting_Gamepad_EmptyFillColor = vec4(0, 0, 0, 0.7f);

[Setting category="Gamepad" name="Fill color" color]
vec4 Setting_Gamepad_FillColor = vec4(1, 0.2f, 0.6f, 1);

[Setting category="Gamepad" name="Border color" color]
vec4 Setting_Gamepad_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Gamepad" name="Border width" drag min=0 max=10]
float Setting_Gamepad_BorderWidth = 3.0f;

[Setting category="Gamepad" name="Spacing" drag min=0 max=100]
float Setting_Gamepad_Spacing = 10.0f;

[Setting category="Gamepad" name="Arrow padding" drag min=0 max=0.5]
float Setting_Gamepad_ArrowPadding = 0.15f;

[Setting category="Gamepad" name="Middle scale" drag min=0 max=1]
float Setting_Gamepad_MiddleScale = 0.2f;

[Setting category="Gamepad" name="Classic up color" color]
vec4 Setting_Gamepad_ClassicUpColor = vec4(0.2f, 1, 0.6f, 1);

[Setting category="Gamepad" name="Classic down color" color]
vec4 Setting_Gamepad_ClassicDownColor = vec4(1, 0.6f, 0.2f, 1);

[Setting category="Gamepad" name="Classic off alpha" drag min=0 max=1]
float Setting_Gamepad_OffAlpha = 0.33f;

[Setting category="Gamepad" name="Display up/down arrow symbols"]
bool Setting_Gamepad_UpDownSymbols = true;



enum KeyboardShape
{
	Rectangle,
	Ellipse,
}

[Setting category="Keyboard" name="Shape"]
KeyboardShape Setting_Keyboard_Shape = KeyboardShape::Rectangle;

[Setting category="Keyboard" name="Empty fill color" color]
vec4 Setting_Keyboard_EmptyFillColor = vec4(0, 0, 0, 0.7f);

[Setting category="Keyboard" name="Fill color" color]
vec4 Setting_Keyboard_FillColor = vec4(1, 0.2f, 0.6f, 1);

[Setting category="Keyboard" name="Border color" color]
vec4 Setting_Keyboard_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Keyboard" name="Border width" drag min=0 max=10]
float Setting_Keyboard_BorderWidth = 3.0f;

[Setting category="Keyboard" name="Border radius" drag min=0 max=50]
float Setting_Keyboard_BorderRadius = 5.0f;

[Setting category="Keyboard" name="Spacing" drag min=0 max=100]
float Setting_Keyboard_Spacing = 10.0f;

[Setting category="Keyboard" name="Inactive alpha" drag min=0 max=1]
float Setting_Keyboard_InactiveAlpha = 0.4f;



[Setting category="Gearbox" name="Show text"]
bool Setting_Gearbox_ShowText = true;

[Setting category="Gearbox" name="Show RPM text"]
bool Setting_Gearbox_ShowRPMText = false;

[Setting category="Gearbox" name="Show tachometer"]
bool Setting_Gearbox_ShowTachometer = true;

enum GearboxTachometerStyle
{
	Bar,
	Dots,
	Blocks,
}

[Setting category="Gearbox" name="Tachometer style"]
GearboxTachometerStyle Setting_Gearbox_TachometerStyle = GearboxTachometerStyle::Blocks;

[Setting category="Gearbox" name="Downshift threshold" drag min=0 max=11000]
float Setting_Gearbox_Downshift = 6500;

[Setting category="Gearbox" name="Upshift threshold" drag min=0 max=11000]
float Setting_Gearbox_Upshift = 10000;

[Setting category="Gearbox" name="Backdrop color" color]
vec4 Setting_Gearbox_BackdropColor = vec4(0, 0, 0, 0.7f);

[Setting category="Gearbox" name="Border color" color]
vec4 Setting_Gearbox_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Gearbox" name="Border width" drag min=0 max=10]
float Setting_Gearbox_BorderWidth = 3.0f;

[Setting category="Gearbox" name="Border radius" drag min=0 max=50]
float Setting_Gearbox_BorderRadius = 5.0f;

[Setting category="Gearbox" name="Spacing" drag min=0 max=100]
float Setting_Gearbox_Spacing = 10.0f;

[Setting category="Gearbox" name="Low RPM color" color]
vec4 Setting_Gearbox_LowRPMColor = vec4(1, 0.7f, 0, 1);

[Setting category="Gearbox" name="Mid RPM color" color]
vec4 Setting_Gearbox_MidRPMColor = vec4(0, 0.9f, 0, 1);

[Setting category="Gearbox" name="High RPM color" color]
vec4 Setting_Gearbox_HighRPMColor = vec4(0.8f, 0, 0, 1);

[Setting category="Gearbox" name="Text color" color]
vec4 Setting_Gearbox_TextColor = vec4(1, 1, 1, 1);

[Setting category="Gearbox" name="Font"]
string Setting_Gearbox_Font = "DroidSans.ttf";


[Setting category="Acceleration" name="Positive acceleration color" color]
vec4 Setting_Acceleration_Positive_Color = vec4(0, 0.9f, 0, 1);

[Setting category="Acceleration" name="Negative acceleration color" color]
vec4 Setting_Acceleration_Negative_Color = vec4(0.8f, 0, 0, 1);

[Setting category="Acceleration" name="Backdrop color" color]
vec4 Setting_Acceleration_BackdropColor = vec4(0, 0, 0, 0.7f);

[Setting category="Acceleration" name="Border color" color]
vec4 Setting_Acceleration_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Acceleration" name="Border width" drag min=0 max=10]
float Setting_Acceleration_BorderWidth = 3.0f;

[Setting category="Acceleration" name="Border radius" drag min=0 max=50]
float Setting_Acceleration_BorderRadius = 5.0f;

[Setting category="Acceleration" name="Maximum acceleration value" drag min=0 max=200]
float Setting_Acceleration_MaximumAcceleration = 15.0f;

[Setting category="Acceleration" name="Show text value"]
bool Setting_Acceleration_ShowTextValue = true;

[Setting category="Acceleration" name="Text padding" drag min=0 max=100]
float Setting_Acceleration_TextPadding = 20.0f;

[Setting category="Acceleration" name="Padding between negative and position bars" drag min=0 max=100]
float Setting_Acceleration_BarPadding = 7.5f;

[Setting category="Acceleration" name="Text color" color]
vec4 Setting_Acceleration_TextColor = vec4(1, 1, 1, 1);

[Setting category="Acceleration" name="Font size" drag min=0 max=50]
float Setting_Acceleration_FontSize = 15.0f;

[Setting category="Acceleration" name="Enable smoothing"]
bool Setting_Acceleration_Smoothing = true;

[Setting category="Acceleration" name="Font"]
string Setting_Acceleration_Font = "DroidSans.ttf";

#endif



enum SpeedValue
{
	FrontSpeed,
	Velocity,
}

[Setting category="Speed" name="Value"]
SpeedValue Setting_Speed_Value = SpeedValue::FrontSpeed;

enum SpeedStyle
{
	Single,
	Double,
}

[Setting category="Speed" name="Style"]
SpeedStyle Setting_Speed_Style = SpeedStyle::Double;

[Setting category="Speed" name="Backdrop color" color]
vec4 Setting_Speed_BackdropColor = vec4(0, 0, 0, 0.7f);

[Setting category="Speed" name="Border color" color]
vec4 Setting_Speed_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Speed" name="Text color" color]
vec4 Setting_Speed_TextColor = vec4(1, 1, 1, 1);

[Setting category="Speed" name="Border width" drag min=0 max=10]
float Setting_Speed_BorderWidth = 3.0f;

[Setting category="Speed" name="Border radius" drag min=0 max=50]
float Setting_Speed_BorderRadius = 5.0f;

[Setting category="Speed" name="Padding" drag min=0 max=50]
float Setting_Speed_Padding = 20.0f;

[Setting category="Speed" name="Font"]
string Setting_Speed_Font = "DroidSans.ttf";

[Setting category="Speed" name="Font size" drag min=0 max=50]
float Setting_Speed_FontSize = 24.0f;



#if !COMPETITION
enum WheelsStyle
{
	Detailed,
	Simple,
}

[Setting category="Wheels" name="Style"]
WheelsStyle Setting_Wheels_Style = WheelsStyle::Detailed;

[Setting category="Wheels" name="Show wheel motion"]
bool Setting_Wheels_WheelMotion = true;

[Setting category="Wheels" name="Wheel motion scale" drag min=0.1 max=10]
float Setting_Wheels_MotionScale = 5.0f;

[Setting category="Wheels" name="Show wheel angle"]
bool Setting_Wheels_WheelAngle = true;

[Setting category="Wheels" name="Backdrop color" color]
vec4 Setting_Wheels_BackdropColor = vec4(0, 0, 0, 0.7f);

[Setting category="Wheels" name="Border color" color]
vec4 Setting_Wheels_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Wheels" name="Border width" drag min=0 max=10]
float Setting_Wheels_BorderWidth = 3.0f;

[Setting category="Wheels" name="Border radius" drag min=0 max=50]
float Setting_Wheels_BorderRadius = 5.0f;

[Setting category="Wheels" name="Wheel fill color" color]
vec3 Setting_Wheels_WheelFillColor = vec3(0, 0, 0);

[Setting category="Wheels" name="Wheel border color" color]
vec4 Setting_Wheels_WheelBorderColor = vec4(1, 1, 1, 1);

[Setting category="Wheels" name="Wheel border width" drag min=0 max=10]
float Setting_Wheels_WheelBorderWidth = 3.0f;

[Setting category="Wheels" name="Wheel border radius" drag min=0 max=5]
float Setting_Wheels_WheelBorderRadius = 5.0f;

[Setting category="Wheels" name="Slip color" color]
vec3 Setting_Wheels_SlipColor = vec3(1, 1, 0);

[Setting category="Wheels" name="Ice color" color]
vec3 Setting_Wheels_IceColor = vec3(0.6f, 1, 0.95f);

[Setting category="Wheels" name="Dirt color" color]
vec3 Setting_Wheels_DirtColor = vec3(0.8f, 0.5f, 0);

[Setting category="Wheels" name="Damaged color" color]
vec3 Setting_Wheels_BreakColor = vec3(1, 0, 0);

[Setting category="Wheels" name="Wear color" color]
vec3 Setting_Wheels_WearColor = vec3(1, 1, 0);

[Setting category="Wheels" name="Wet color" color]
vec3 Setting_Wheels_WetColor = vec3(0, 0.5f, 1);

[Setting category="Wheels" name="Wheel width" drag min=0 max=100]
float Setting_Wheels_WheelWidth = 32.0f;

[Setting category="Wheels" name="Wheel fill alpha" drag min=0 max=1]
float Setting_Wheels_WheelFillAlpha = 0.7f;

[Setting category="Wheels" name="Wheel motion alpha" drag min=0 max=1]
float Setting_Wheels_WheelMotionAlpha = 0.5f;

[Setting category="Wheels" name="Padding" drag min=0 max=100]
float Setting_Wheels_Padding = 25.0f;

[Setting category="Wheels" name="Row spacing" drag min=0 max=100]
float Setting_Wheels_RowSpacing = 10.0f;

[Setting category="Wheels" name="Details spacing" drag min=0 max=100]
float Setting_Wheels_DetailsSpacing = 20.0f;

[Setting category="Wheels" name="Details font"]
string Setting_Wheels_DetailsFont = "DroidSans.ttf";

[Setting category="Wheels" name="Details font size" drag min=0 max=50]
float Setting_Wheels_DetailsFontSize = 16.0f;
#endif
