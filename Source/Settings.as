enum ForcePadType
{
	None,
	Gamepad,
	Keyboard,
}

[Setting category="General" name="Force pad type"]
ForcePadType Setting_General_ForcePadType = ForcePadType::None;

[Setting category="General" name="Hide during Intro sequences"]
bool Setting_General_HideWhenNotPlaying = false;

[Setting hidden]
bool Setting_General_ShowPad = true;
[Setting hidden]
bool Setting_General_ShowPadHidden = true;
[Setting hidden]
vec2 Setting_General_PadPos = vec2(0.9f, 0.1f);
[Setting hidden]
vec2 Setting_General_PadSize = vec2(350, 200);

[Setting hidden]
bool Setting_General_ShowGearbox = true;
[Setting hidden]
bool Setting_General_ShowGearboxHidden = true;
[Setting hidden]
vec2 Setting_General_GearboxPos = vec2(0.9f, 0.32f);
[Setting hidden]
vec2 Setting_General_GearboxSize = vec2(350, 50);

[Setting hidden]
bool Setting_General_ShowWheels = false;
[Setting hidden]
bool Setting_General_ShowWheelsHidden = false;
[Setting hidden]
vec2 Setting_General_WheelsPos = vec2(0.909f, 0.9f);
[Setting hidden]
vec2 Setting_General_WheelsSize = vec2(230, 370);

[Setting hidden]
bool Setting_General_ShowAcceleration = false;
[Setting hidden]
bool Setting_General_ShowAccelerationHidden = false;
[Setting hidden]
vec2 Setting_General_AccelerationPos = vec2(0.720f, 0.120f);
[Setting hidden]
vec2 Setting_General_AccelerationSize = vec2(50, 350);

[Setting hidden]
bool Setting_General_ShowSpeed = true;
[Setting hidden]
bool Setting_General_ShowSpeedHidden = true;
[Setting hidden]
vec2 Setting_General_SpeedPos = vec2(0.909f, 0.4f);
[Setting hidden]
vec2 Setting_General_SpeedSize = vec2(230, 50);

[Setting hidden]
bool Setting_General_ShowClock = false;
[Setting hidden]
bool Setting_General_ShowClockHidden = false;
[Setting hidden]
vec2 Setting_General_ClockPos = vec2(0.906f, 0.48f);
[Setting hidden]
vec2 Setting_General_ClockSize = vec2(286, 50);



enum GamepadStyle
{
	Uniform,
	Classic,
	Cateye,
}

[Setting category="Gamepad" name="Style" description="Note: Not all styles use all customization options. Use Uniform for the best experience."]
GamepadStyle Setting_Gamepad_Style = GamepadStyle::Uniform;

[Setting category="Gamepad" name="Empty fill color" color if="!Setting_Gamepad_Style Classic"]
vec4 Setting_Gamepad_EmptyFillColor = vec4(0, 0, 0, 0.7f);

[Setting category="Gamepad" name="Fill gradient" description="Only applies to Uniform and Cateye styles"]
bool Setting_Gamepad_UseFillGradient = false;

[Setting category="Gamepad" name="Fill color" color if="!Setting_Gamepad_UseFillGradient"]
vec4 Setting_Gamepad_FillColor = vec4(1, 0.2f, 0.6f, 1);

[Setting category="Gamepad" name="Fill gradient" if="Setting_Gamepad_UseFillGradient"]
SettingsGradient Setting_Gamepad_FillGradient = SettingsGradient(vec4(1, 0.2f, 0.6f, 1), vec4(1, 0.6f, 0.9f, 1));

[Setting category="Gamepad" name="Border gradient" description="Only applies to Uniform and Cateye styles"]
bool Setting_Gamepad_UseBorderGradient = false;

[Setting category="Gamepad" name="Border color" color if="!Setting_Gamepad_UseBorderGradient"]
vec4 Setting_Gamepad_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Gamepad" name="Border gradient" if="Setting_Gamepad_UseBorderGradient"]
SettingsGradient Setting_Gamepad_BorderGradient = SettingsGradient(vec4(1, 0.6f, 0.9f, 1), vec4(1, 0.9f, 0.95f, 1), 300);

[Setting category="Gamepad" name="Border width" drag min=0 max=10 if="!Setting_Gamepad_Style Classic"]
float Setting_Gamepad_BorderWidth = 3.0f;

[Setting category="Gamepad" name="Spacing" drag min=0 max=100]
float Setting_Gamepad_Spacing = 10.0f;

[Setting category="Gamepad" name="Arrow padding" drag min=0 max=0.5 if="!Setting_Gamepad_Style Classic"]
float Setting_Gamepad_ArrowPadding = 0.15f;

[Setting category="Gamepad" name="Middle scale" drag min=0 max=1]
float Setting_Gamepad_MiddleScale = 0.2f;

[Setting category="Gamepad" name="Classic up color" color if="Setting_Gamepad_Style Classic"]
vec4 Setting_Gamepad_ClassicUpColor = vec4(0.2f, 1, 0.6f, 1);

[Setting category="Gamepad" name="Classic down color" color if="Setting_Gamepad_Style Classic"]
vec4 Setting_Gamepad_ClassicDownColor = vec4(1, 0.6f, 0.2f, 1);

[Setting category="Gamepad" name="Inactive alpha" min=0 max=1]
float Setting_Gamepad_OffAlpha = 0.33f;

[Setting category="Gamepad" name="Display up/down arrow symbols" if="Setting_Gamepad_Style Uniform"]
bool Setting_Gamepad_UpDownSymbols = true;

[Setting category="Gamepad" name="Cateye use simple steer" description="Does not yet show fill gradient correctly" if="Setting_Gamepad_Style Cateye"]
bool Setting_Gamepad_CateyeUseSimpleSteer = false;

[Setting category="Gamepad" name="Display steer percentage"]
bool Setting_Gamepad_SteerPercentage = false;

[Setting category="Gamepad" name="Display steer percentage symbol"]
bool Setting_Gamepad_SteerPercentageSymbol = true;

[Setting category="Gamepad" name="Steer percentage spacing" min=-100 max=100]
float Setting_Gamepad_SteerPercentageSpacing = 0.0f;

[Setting category="Gamepad" name="Font"]
string Setting_Gamepad_Font = "DroidSans.ttf";

[Setting
	category="Gamepad"
	name="Font size"
	min=2 max=40]
int Setting_Gamepad_FontSize = 16;

[Setting category="Gamepad" name="Font color" color]
vec4 Setting_Gamepad_FontColor = vec4(1, 1, 1, 1);



enum KeyboardShape
{
	Rectangle,
	Ellipse,
	Compact,
}

[Setting category="Keyboard" name="Shape"]
KeyboardShape Setting_Keyboard_Shape = KeyboardShape::Rectangle;

[Setting category="Keyboard" name="Empty fill color" color]
vec4 Setting_Keyboard_EmptyFillColor = vec4(0, 0, 0, 0.7f);

[Setting category="Keyboard" name="Fill gradient"]
bool Setting_Keyboard_UseFillGradient = false;

[Setting category="Keyboard" name="Fill color" color if="!Setting_Keyboard_UseFillGradient"]
vec4 Setting_Keyboard_FillColor = vec4(1, 0.2f, 0.6f, 1);

[Setting category="Keyboard" name="Fill gradient" if="Setting_Keyboard_UseFillGradient"]
SettingsGradient Setting_Keyboard_FillGradient = SettingsGradient(vec4(1, 0.2f, 0.6f, 1), vec4(1, 0.6f, 0.9f, 1));

[Setting category="Keyboard" name="Border gradient"]
bool Setting_Keyboard_UseBorderGradient = false;

[Setting category="Keyboard" name="Border color" color if="!Setting_Keyboard_UseBorderGradient"]
vec4 Setting_Keyboard_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Keyboard" name="Border gradient" if="Setting_Keyboard_UseBorderGradient"]
SettingsGradient Setting_Keyboard_BorderGradient = SettingsGradient(vec4(1, 0.6f, 0.9f, 1), vec4(1, 0.9f, 0.95f, 1), 300);

[Setting category="Keyboard" name="Border width" drag min=0 max=10]
float Setting_Keyboard_BorderWidth = 3.0f;

[Setting category="Keyboard" name="Border radius" drag min=0 max=50 if="!Setting_Keyboard_Shape Ellipse"]
float Setting_Keyboard_BorderRadius = 5.0f;

[Setting category="Keyboard" name="Spacing" drag min=0 max=100]
float Setting_Keyboard_Spacing = 10.0f;

[Setting category="Keyboard" name="Inactive alpha" drag min=0 max=1]
float Setting_Keyboard_InactiveAlpha = 1.0f;

[Setting category="Keyboard" name="Display arrow symbols"]
bool Setting_Keyboard_ArrowSymbols = true;

[Setting category="Keyboard" name="Display steer percentage" description="Overrides left/right arrows of setting above"]
bool Setting_Keyboard_SteerPercentage = false;

[Setting category="Keyboard" name="Display steer percentage symbol" if="Setting_Keyboard_SteerPercentage"]
bool Setting_Keyboard_SteerPercentageSymbol = true;

[Setting category="Keyboard" name="Font"]
string Setting_Keyboard_Font = "DroidSans.ttf";

[Setting
	category="Keyboard"
	name="Font size"
	min=2 max=40]
int Setting_Keyboard_FontSize = 16;

[Setting category="Keyboard" name="Font color" color]
vec4 Setting_Keyboard_FontColor = vec4(1, 1, 1, 1);



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

[Setting category="Gearbox" name="Tachometer style" if="Setting_Gearbox_ShowTachometer"]
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

[Setting category="Gearbox" name="Spacing" drag min=0 max=100 if="Setting_Gearbox_ShowText"]
float Setting_Gearbox_Spacing = 10.0f;

[Setting category="Gearbox" name="Low RPM color" color if="Setting_Gearbox_ShowTachometer"]
vec4 Setting_Gearbox_LowRPMColor = vec4(1, 0.7f, 0, 1);

[Setting category="Gearbox" name="Mid RPM color" color if="Setting_Gearbox_ShowTachometer"]
vec4 Setting_Gearbox_MidRPMColor = vec4(0, 0.9f, 0, 1);

[Setting category="Gearbox" name="High RPM color" color if="Setting_Gearbox_ShowTachometer"]
vec4 Setting_Gearbox_HighRPMColor = vec4(0.8f, 0, 0, 1);

[Setting category="Gearbox" name="Text color" color if="Setting_Gearbox_ShowText"]
vec4 Setting_Gearbox_TextColor = vec4(1, 1, 1, 1);

[Setting category="Gearbox" name="Font" if="Setting_Gearbox_ShowText"]
string Setting_Gearbox_Font = "DroidSans.ttf";

[Setting category="Gearbox" name="Font size" drag min=0 max=100 if="Setting_Gearbox_ShowText"]
float Setting_Gearbox_FontSize = 24.0f;

[Setting category="Gearbox" name="Use gear colors"]
bool Setting_Gearbox_UseGearColors = false;

[Setting category="Gearbox" name="Gear 0 (backwards) color" color if="Setting_Gearbox_UseGearColors"]
vec4 Setting_Gearbox_Gear0Color = vec4(1, 1, 1, 1);

[Setting category="Gearbox" name="Gear 1 color" color if="Setting_Gearbox_UseGearColors"]
vec4 Setting_Gearbox_Gear1Color = vec4(1, 1, 1, 1);

[Setting category="Gearbox" name="Gear 2 color" color if="Setting_Gearbox_UseGearColors"]
vec4 Setting_Gearbox_Gear2Color = vec4(1, 1, 1, 1);

[Setting category="Gearbox" name="Gear 3 color" color if="Setting_Gearbox_UseGearColors"]
vec4 Setting_Gearbox_Gear3Color = vec4(1, 1, 1, 1);

[Setting category="Gearbox" name="Gear 4 color" color if="Setting_Gearbox_UseGearColors"]
vec4 Setting_Gearbox_Gear4Color = vec4(1, 1, 1, 1);

[Setting category="Gearbox" name="Gear 5 color" color if="Setting_Gearbox_UseGearColors"]
vec4 Setting_Gearbox_Gear5Color = vec4(1, 1, 1, 1);

#if MP4 || TURBO
	[Setting category="Gearbox" name="Gear 6 color" color if="Setting_Gearbox_UseGearColors"]
	vec4 Setting_Gearbox_Gear6Color = vec4(1, 1, 1, 1);

	[Setting category="Gearbox" name="Gear 7 color" color if="Setting_Gearbox_UseGearColors"]
	vec4 Setting_Gearbox_Gear7Color = vec4(1, 1, 1, 1);
#endif

#if TURBO
	[Setting category="Gearbox" name="Gear 8 color" color if="Setting_Gearbox_UseGearColors"]
	vec4 Setting_Gearbox_Gear8Color = vec4(1, 1, 1, 1);

	[Setting category="Gearbox" name="Gear 9 color" color if="Setting_Gearbox_UseGearColors"]
	vec4 Setting_Gearbox_Gear9Color = vec4(1, 1, 1, 1);
#endif



enum AccelerationUnit
{
	MetersPerSecondPerSecond,
	KilometersPerHourPerSecond
}

[Setting category="Acceleration" name="Unit of measurement"]
AccelerationUnit Setting_Acceleration_Unit = AccelerationUnit::MetersPerSecondPerSecond;

[Setting category="Acceleration" name="Positive color" color]
vec4 Setting_Acceleration_Positive_Color = vec4(0, 0.9f, 0, 1);

[Setting category="Acceleration" name="Negative color" color]
vec4 Setting_Acceleration_Negative_Color = vec4(0.8f, 0, 0, 1);

[Setting category="Acceleration" name="Backdrop color" color]
vec4 Setting_Acceleration_BackdropColor = vec4(0, 0, 0, 0.7f);

[Setting category="Acceleration" name="Border color" color]
vec4 Setting_Acceleration_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Acceleration" name="Border width" drag min=0 max=10]
float Setting_Acceleration_BorderWidth = 3.0f;

[Setting category="Acceleration" name="Border radius" drag min=0 max=50]
float Setting_Acceleration_BorderRadius = 5.0f;

[Setting category="Acceleration" name="Maximum m/s/s" drag min=0 max=250 if="Setting_Acceleration_Unit MetersPerSecondPerSecond"]
float Setting_Acceleration_MaximumAccelerationMSS = 15.0f;

[Setting category="Acceleration" name="Maximum km/h/s" drag min=0 max=250 if="Setting_Acceleration_Unit KilometersPerHourPerSecond"]
float Setting_Acceleration_MaximumAccelerationKMHS = 54.0f;

[Setting category="Acceleration" name="Bar padding" drag min=0 max=100]
float Setting_Acceleration_BarPadding = 7.5f;

[Setting category="Acceleration" name="Enable smoothing"]
bool Setting_Acceleration_Smoothing = true;

[Setting category="Acceleration" name="Show text value"]
bool Setting_Acceleration_ShowTextValue = true;

[Setting category="Acceleration" name="Text padding" drag min=0 max=100 if="Setting_Acceleration_ShowTextValue"]
float Setting_Acceleration_TextPadding = 20.0f;

[Setting category="Acceleration" name="Text color" color if="Setting_Acceleration_ShowTextValue"]
vec4 Setting_Acceleration_TextColor = vec4(1, 1, 1, 1);

[Setting category="Acceleration" name="Font" if="Setting_Acceleration_ShowTextValue"]
string Setting_Acceleration_Font = "DroidSans.ttf";

[Setting category="Acceleration" name="Font size" drag min=0 max=100 if="Setting_Acceleration_ShowTextValue"]
float Setting_Acceleration_FontSize = 15.0f;



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
	Directional,
}

[Setting category="Speed" name="Style" description="Note: Double and directional only available in school and developer modes."]
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

[Setting category="Speed" name="Font size" drag min=0 max=100]
float Setting_Speed_FontSize = 24.0f;



enum WheelsStyle
{
	Detailed,
	Simple,
	Unified,
}

[Setting category="Wheels" name="Style"]
WheelsStyle Setting_Wheels_Style = WheelsStyle::Detailed;

[Setting category="Wheels" name="Show wheel motion"]
bool Setting_Wheels_WheelMotion = true;

[Setting category="Wheels" name="Wheel motion scale" drag min=0.1 max=10 if="Setting_Wheels_WheelMotion" if="!Setting_Wheels_Style Unified"]
float Setting_Wheels_MotionScale = 5.0f;

[Setting category="Wheels" name="Show wheel angle" if="!Setting_Wheels_Style Unified"]
bool Setting_Wheels_WheelAngle = true;

[Setting category="Wheels" name="Backdrop color" color]
vec4 Setting_Wheels_BackdropColor = vec4(0, 0, 0, 0.7f);

[Setting category="Wheels" name="Border color" color]
vec4 Setting_Wheels_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Wheels" name="Border width" drag min=0 max=10]
float Setting_Wheels_BorderWidth = 3.0f;

[Setting category="Wheels" name="Border radius" drag min=0 max=50]
float Setting_Wheels_BorderRadius = 5.0f;

[Setting category="Wheels" name="Wheel fill color" color if="!Setting_Wheels_Style Unified"]
vec3 Setting_Wheels_WheelFillColor = vec3(0, 0, 0);

[Setting category="Wheels" name="Wheel border color" color if="!Setting_Wheels_Style Unified"]
vec4 Setting_Wheels_WheelBorderColor = vec4(1, 1, 1, 1);

[Setting category="Wheels" name="Wheel border width" drag min=0 max=10 if="!Setting_Wheels_Style Unified"]
float Setting_Wheels_WheelBorderWidth = 3.0f;

[Setting category="Wheels" name="Wheel border radius" drag min=0 max=5 if="!Setting_Wheels_Style Unified"]
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

[Setting category="Wheels" name="Wheel width" drag min=0 max=100 if="!Setting_Wheels_Style Unified"]
float Setting_Wheels_WheelWidth = 32.0f;

[Setting category="Wheels" name="Wheel fill alpha" drag min=0 max=1 if="!Setting_Wheels_Style Unified"]
float Setting_Wheels_WheelFillAlpha = 0.7f;

[Setting category="Wheels" name="Wheel motion alpha" drag min=0 max=1 if="!Setting_Wheels_Style Unified"]
float Setting_Wheels_WheelMotionAlpha = 0.5f;

[Setting category="Wheels" name="Padding" drag min=0 max=100]
float Setting_Wheels_Padding = 25.0f;

[Setting category="Wheels" name="Row spacing" drag min=0 max=100]
float Setting_Wheels_RowSpacing = 10.0f;

[Setting category="Wheels" name="Details spacing" drag min=0 max=100]
float Setting_Wheels_DetailsSpacing = 20.0f;

[Setting category="Wheels" name="Details font"]
string Setting_Wheels_DetailsFont = "DroidSans.ttf";

[Setting category="Wheels" name="Details font size" drag min=0 max=100]
float Setting_Wheels_DetailsFontSize = 16.0f;

[Setting category="Wheels" name="Show wheel surface"]
bool Setting_Wheels_WheelSurface = false;

[Setting category="Wheels" name="Ice Surface Color" color if="Setting_Wheels_WheelSurface"]
vec3 Setting_Wheels_IceSurfaceColor = vec3(0.6f, 1, 0.95f);

[Setting category="Wheels" name="Grass Surface Color" color if="Setting_Wheels_WheelSurface"]
vec3 Setting_Wheels_GrassSurfaceColor = vec3(0, 1, 0);

[Setting category="Wheels" name="Dirt Surface Color" color if="Setting_Wheels_WheelSurface"]
vec3 Setting_Wheels_DirtSurfaceColor = vec3(0.8f, 0.5f, 0);

[Setting category="Wheels" name="Wood Surface Color" color if="Setting_Wheels_WheelSurface"]
vec3 Setting_Wheels_WoodSurfaceColor = vec3(0.3f, 0.1f, 0);

[Setting category="Wheels" name="Plastic Surface Color" color if="Setting_Wheels_WheelSurface"]
vec3 Setting_Wheels_PlasticSurfaceColor = vec3(0.5f, 0, 0);

[Setting category="Wheels" name="Snow Surface Color" color if="Setting_Wheels_WheelSurface"]
vec3 Setting_Wheels_SnowSurfaceColor = vec3(0.7f, 1, 1);

[Setting category="Wheels" name="Sand Surface Color" color if="Setting_Wheels_WheelSurface"]
vec3 Setting_Wheels_SandSurfaceColor = vec3(1, 1, 0);



enum ClockMode
{
	LocalTime,
	UTCTime,
}

enum ClockIcon
{
	None,
	Left,
	Right,
}

[Setting category="Clock" name="Mode"]
ClockMode Setting_Clock_Mode = ClockMode::LocalTime;

[Setting category="Clock" name="Format"]
string Setting_Clock_Format = "%F | %r";

[Setting category="Clock" name="Clock icon"]
ClockIcon Setting_Clock_Icon = ClockIcon::Right;

[Setting category="Clock" name="Backdrop color" color]
vec4 Setting_Clock_BackdropColor = vec4(0, 0, 0, 0.7f);

[Setting category="Clock" name="Border color" color]
vec4 Setting_Clock_BorderColor = vec4(1, 1, 1, 1);

[Setting category="Clock" name="Text color" color]
vec4 Setting_Clock_TextColor = vec4(1, 1, 1, 1);

[Setting category="Clock" name="Border width" drag min=0 max=10]
float Setting_Clock_BorderWidth = 3.0f;

[Setting category="Clock" name="Border radius" drag min=0 max=50]
float Setting_Clock_BorderRadius = 5.0f;

[Setting category="Clock" name="Font"]
string Setting_Clock_Font = "DroidSans.ttf";

[Setting category="Clock" name="Font size" drag min=0 max=100]
float Setting_Clock_FontSize = 20.0f;
