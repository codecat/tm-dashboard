namespace SettingAccessor
{
	enum SettingType
	{
		BOOL
		, FLOAT
		, VEC2
		, VEC3
		, VEC4
		, STRING
#if !COMPETITION
		, FORCEPADTYPE
		, GAMEPADSTYLE
		, KEYBOARDSHAPE
		, GEARBOXTACHOMETERSTYLE
#endif
		, SPEEDVALUE
		, SPEEDSTYLE
#if !COMPETITION
		, WHEELSSTYLE
#endif
	};

	funcdef void SetBool(bool);
	funcdef bool GetBool();
	funcdef void SetFloat(float);
	funcdef float GetFloat();
	funcdef void SetVec2(vec2);
	funcdef vec2 GetVec2();
	funcdef void SetVec3(vec3);
	funcdef vec3 GetVec3();
	funcdef void SetVec4(vec4);
	funcdef vec4 GetVec4();
	funcdef void SetString(string);
	funcdef string GetString();
#if !COMPETITION
	funcdef void SetForcePadType(ForcePadType);
	funcdef ForcePadType GetForcePadType();
	funcdef void SetGamepadStyle(GamepadStyle);
	funcdef GamepadStyle GetGamepadStyle();
	funcdef void SetKeyboardShape(KeyboardShape);
	funcdef KeyboardShape GetKeyboardShape();
	funcdef void SetGearboxTachometerStyle(GearboxTachometerStyle);
	funcdef GearboxTachometerStyle GetGearboxTachometerStyle();
#endif
	funcdef void SetSpeedValue(SpeedValue);
	funcdef SpeedValue GetSpeedValue();
	funcdef void SetSpeedStyle(SpeedStyle);
	funcdef SpeedStyle GetSpeedStyle();
#if !COMPETITION
	funcdef void SetWheelsStyle(WheelsStyle);
	funcdef WheelsStyle GetWheelsStyle();
#endif

#if !COMPETITION
	void SetSetting_General_ForcePadType(ForcePadType value) { Setting_General_ForcePadType = value; }
	ForcePadType GetSetting_General_ForcePadType() { return Setting_General_ForcePadType; }
#endif
	void SetSetting_General_HideOnHiddenInterface(bool value) { Setting_General_HideOnHiddenInterface = value; }
	bool GetSetting_General_HideOnHiddenInterface() { return Setting_General_HideOnHiddenInterface; }
#if !COMPETITION
	void SetSetting_General_ShowPad(bool value) { Setting_General_ShowPad = value; }
	bool GetSetting_General_ShowPad() { return Setting_General_ShowPad; }
	void SetSetting_General_MovePad(bool value) { Setting_General_MovePad = value; }
	bool GetSetting_General_MovePad() { return Setting_General_MovePad; }
	void SetSetting_General_PadPos(vec2 value) { Setting_General_PadPos = value; }
	vec2 GetSetting_General_PadPos() { return Setting_General_PadPos; }
	void SetSetting_General_PadSize(vec2 value) { Setting_General_PadSize = value; }
	vec2 GetSetting_General_PadSize() { return Setting_General_PadSize; }
	void SetSetting_General_ShowGearbox(bool value) { Setting_General_ShowGearbox = value; }
	bool GetSetting_General_ShowGearbox() { return Setting_General_ShowGearbox; }
	void SetSetting_General_MoveGearbox(bool value) { Setting_General_MoveGearbox = value; }
	bool GetSetting_General_MoveGearbox() { return Setting_General_MoveGearbox; }
	void SetSetting_General_GearboxPos(vec2 value) { Setting_General_GearboxPos = value; }
	vec2 GetSetting_General_GearboxPos() { return Setting_General_GearboxPos; }
	void SetSetting_General_GearboxSize(vec2 value) { Setting_General_GearboxSize = value; }
	vec2 GetSetting_General_GearboxSize() { return Setting_General_GearboxSize; }
	void SetSetting_General_ShowWheels(bool value) { Setting_General_ShowWheels = value; }
	bool GetSetting_General_ShowWheels() { return Setting_General_ShowWheels; }
	void SetSetting_General_MoveWheels(bool value) { Setting_General_MoveWheels = value; }
	bool GetSetting_General_MoveWheels() { return Setting_General_MoveWheels; }
	void SetSetting_General_WheelsPos(vec2 value) { Setting_General_WheelsPos = value; }
	vec2 GetSetting_General_WheelsPos() { return Setting_General_WheelsPos; }
	void SetSetting_General_WheelsSize(vec2 value) { Setting_General_WheelsSize = value; }
	vec2 GetSetting_General_WheelsSize() { return Setting_General_WheelsSize; }
#endif
	void SetSetting_General_ShowSpeed(bool value) { Setting_General_ShowSpeed = value; }
	bool GetSetting_General_ShowSpeed() { return Setting_General_ShowSpeed; }
	void SetSetting_General_MoveSpeed(bool value) { Setting_General_MoveSpeed = value; }
	bool GetSetting_General_MoveSpeed() { return Setting_General_MoveSpeed; }
	void SetSetting_General_SpeedPos(vec2 value) { Setting_General_SpeedPos = value; }
	vec2 GetSetting_General_SpeedPos() { return Setting_General_SpeedPos; }
	void SetSetting_General_SpeedSize(vec2 value) { Setting_General_SpeedSize = value; }
	vec2 GetSetting_General_SpeedSize() { return Setting_General_SpeedSize; }
#if !COMPETITION
	void SetSetting_Gamepad_Style(GamepadStyle value) { Setting_Gamepad_Style = value; }
	GamepadStyle GetSetting_Gamepad_Style() { return Setting_Gamepad_Style; }
	void SetSetting_Gamepad_EmptyFillColor(vec4 value) { Setting_Gamepad_EmptyFillColor = value; }
	vec4 GetSetting_Gamepad_EmptyFillColor() { return Setting_Gamepad_EmptyFillColor; }
	void SetSetting_Gamepad_FillColor(vec4 value) { Setting_Gamepad_FillColor = value; }
	vec4 GetSetting_Gamepad_FillColor() { return Setting_Gamepad_FillColor; }
	void SetSetting_Gamepad_BorderColor(vec4 value) { Setting_Gamepad_BorderColor = value; }
	vec4 GetSetting_Gamepad_BorderColor() { return Setting_Gamepad_BorderColor; }
	void SetSetting_Gamepad_BorderWidth(float value) { Setting_Gamepad_BorderWidth = value; }
	float GetSetting_Gamepad_BorderWidth() { return Setting_Gamepad_BorderWidth; }
	void SetSetting_Gamepad_Spacing(float value) { Setting_Gamepad_Spacing = value; }
	float GetSetting_Gamepad_Spacing() { return Setting_Gamepad_Spacing; }
	void SetSetting_Gamepad_ArrowPadding(float value) { Setting_Gamepad_ArrowPadding = value; }
	float GetSetting_Gamepad_ArrowPadding() { return Setting_Gamepad_ArrowPadding; }
	void SetSetting_Gamepad_MiddleScale(float value) { Setting_Gamepad_MiddleScale = value; }
	float GetSetting_Gamepad_MiddleScale() { return Setting_Gamepad_MiddleScale; }
	void SetSetting_Gamepad_ClassicUpColor(vec4 value) { Setting_Gamepad_ClassicUpColor = value; }
	vec4 GetSetting_Gamepad_ClassicUpColor() { return Setting_Gamepad_ClassicUpColor; }
	void SetSetting_Gamepad_ClassicDownColor(vec4 value) { Setting_Gamepad_ClassicDownColor = value; }
	vec4 GetSetting_Gamepad_ClassicDownColor() { return Setting_Gamepad_ClassicDownColor; }
	void SetSetting_Gamepad_OffAlpha(float value) { Setting_Gamepad_OffAlpha = value; }
	float GetSetting_Gamepad_OffAlpha() { return Setting_Gamepad_OffAlpha; }
	void SetSetting_Gamepad_UpDownSymbols(bool value) { Setting_Gamepad_UpDownSymbols = value; }
	bool GetSetting_Gamepad_UpDownSymbols() { return Setting_Gamepad_UpDownSymbols; }
	void SetSetting_Keyboard_Shape(KeyboardShape value) { Setting_Keyboard_Shape = value; }
	KeyboardShape GetSetting_Keyboard_Shape() { return Setting_Keyboard_Shape; }
	void SetSetting_Keyboard_EmptyFillColor(vec4 value) { Setting_Keyboard_EmptyFillColor = value; }
	vec4 GetSetting_Keyboard_EmptyFillColor() { return Setting_Keyboard_EmptyFillColor; }
	void SetSetting_Keyboard_FillColor(vec4 value) { Setting_Keyboard_FillColor = value; }
	vec4 GetSetting_Keyboard_FillColor() { return Setting_Keyboard_FillColor; }
	void SetSetting_Keyboard_BorderColor(vec4 value) { Setting_Keyboard_BorderColor = value; }
	vec4 GetSetting_Keyboard_BorderColor() { return Setting_Keyboard_BorderColor; }
	void SetSetting_Keyboard_BorderWidth(float value) { Setting_Keyboard_BorderWidth = value; }
	float GetSetting_Keyboard_BorderWidth() { return Setting_Keyboard_BorderWidth; }
	void SetSetting_Keyboard_BorderRadius(float value) { Setting_Keyboard_BorderRadius = value; }
	float GetSetting_Keyboard_BorderRadius() { return Setting_Keyboard_BorderRadius; }
	void SetSetting_Keyboard_Spacing(float value) { Setting_Keyboard_Spacing = value; }
	float GetSetting_Keyboard_Spacing() { return Setting_Keyboard_Spacing; }
	void SetSetting_Keyboard_InactiveAlpha(float value) { Setting_Keyboard_InactiveAlpha = value; }
	float GetSetting_Keyboard_InactiveAlpha() { return Setting_Keyboard_InactiveAlpha; }
	void SetSetting_Gearbox_ShowText(bool value) { Setting_Gearbox_ShowText = value; }
	bool GetSetting_Gearbox_ShowText() { return Setting_Gearbox_ShowText; }
	void SetSetting_Gearbox_ShowRPMText(bool value) { Setting_Gearbox_ShowRPMText = value; }
	bool GetSetting_Gearbox_ShowRPMText() { return Setting_Gearbox_ShowRPMText; }
	void SetSetting_Gearbox_ShowTachometer(bool value) { Setting_Gearbox_ShowTachometer = value; }
	bool GetSetting_Gearbox_ShowTachometer() { return Setting_Gearbox_ShowTachometer; }
	void SetSetting_Gearbox_TachometerStyle(GearboxTachometerStyle value) { Setting_Gearbox_TachometerStyle = value; }
	GearboxTachometerStyle GetSetting_Gearbox_TachometerStyle() { return Setting_Gearbox_TachometerStyle; }
	void SetSetting_Gearbox_Downshift(float value) { Setting_Gearbox_Downshift = value; }
	float GetSetting_Gearbox_Downshift() { return Setting_Gearbox_Downshift; }
	void SetSetting_Gearbox_Upshift(float value) { Setting_Gearbox_Upshift = value; }
	float GetSetting_Gearbox_Upshift() { return Setting_Gearbox_Upshift; }
	void SetSetting_Gearbox_BackdropColor(vec4 value) { Setting_Gearbox_BackdropColor = value; }
	vec4 GetSetting_Gearbox_BackdropColor() { return Setting_Gearbox_BackdropColor; }
	void SetSetting_Gearbox_BorderColor(vec4 value) { Setting_Gearbox_BorderColor = value; }
	vec4 GetSetting_Gearbox_BorderColor() { return Setting_Gearbox_BorderColor; }
	void SetSetting_Gearbox_BorderWidth(float value) { Setting_Gearbox_BorderWidth = value; }
	float GetSetting_Gearbox_BorderWidth() { return Setting_Gearbox_BorderWidth; }
	void SetSetting_Gearbox_BorderRadius(float value) { Setting_Gearbox_BorderRadius = value; }
	float GetSetting_Gearbox_BorderRadius() { return Setting_Gearbox_BorderRadius; }
	void SetSetting_Gearbox_Spacing(float value) { Setting_Gearbox_Spacing = value; }
	float GetSetting_Gearbox_Spacing() { return Setting_Gearbox_Spacing; }
	void SetSetting_Gearbox_LowRPMColor(vec4 value) { Setting_Gearbox_LowRPMColor = value; }
	vec4 GetSetting_Gearbox_LowRPMColor() { return Setting_Gearbox_LowRPMColor; }
	void SetSetting_Gearbox_MidRPMColor(vec4 value) { Setting_Gearbox_MidRPMColor = value; }
	vec4 GetSetting_Gearbox_MidRPMColor() { return Setting_Gearbox_MidRPMColor; }
	void SetSetting_Gearbox_HighRPMColor(vec4 value) { Setting_Gearbox_HighRPMColor = value; }
	vec4 GetSetting_Gearbox_HighRPMColor() { return Setting_Gearbox_HighRPMColor; }
	void SetSetting_Gearbox_TextColor(vec4 value) { Setting_Gearbox_TextColor = value; }
	vec4 GetSetting_Gearbox_TextColor() { return Setting_Gearbox_TextColor; }
	void SetSetting_Gearbox_Font(string value) { Setting_Gearbox_Font = value; }
	string GetSetting_Gearbox_Font() { return Setting_Gearbox_Font; }
#endif
	void SetSetting_Speed_Value(SpeedValue value) { Setting_Speed_Value = value; }
	SpeedValue GetSetting_Speed_Value() { return Setting_Speed_Value; }
	void SetSetting_Speed_Style(SpeedStyle value) { Setting_Speed_Style = value; }
	SpeedStyle GetSetting_Speed_Style() { return Setting_Speed_Style; }
	void SetSetting_Speed_BackdropColor(vec4 value) { Setting_Speed_BackdropColor = value; }
	vec4 GetSetting_Speed_BackdropColor() { return Setting_Speed_BackdropColor; }
	void SetSetting_Speed_BorderColor(vec4 value) { Setting_Speed_BorderColor = value; }
	vec4 GetSetting_Speed_BorderColor() { return Setting_Speed_BorderColor; }
	void SetSetting_Speed_TextColor(vec4 value) { Setting_Speed_TextColor = value; }
	vec4 GetSetting_Speed_TextColor() { return Setting_Speed_TextColor; }
	void SetSetting_Speed_BorderWidth(float value) { Setting_Speed_BorderWidth = value; }
	float GetSetting_Speed_BorderWidth() { return Setting_Speed_BorderWidth; }
	void SetSetting_Speed_BorderRadius(float value) { Setting_Speed_BorderRadius = value; }
	float GetSetting_Speed_BorderRadius() { return Setting_Speed_BorderRadius; }
	void SetSetting_Speed_Padding(float value) { Setting_Speed_Padding = value; }
	float GetSetting_Speed_Padding() { return Setting_Speed_Padding; }
	void SetSetting_Speed_Font(string value) { Setting_Speed_Font = value; }
	string GetSetting_Speed_Font() { return Setting_Speed_Font; }
	void SetSetting_Speed_FontSize(float value) { Setting_Speed_FontSize = value; }
	float GetSetting_Speed_FontSize() { return Setting_Speed_FontSize; }
#if !COMPETITION
	void SetSetting_Wheels_Style(WheelsStyle value) { Setting_Wheels_Style = value; }
	WheelsStyle GetSetting_Wheels_Style() { return Setting_Wheels_Style; }
	void SetSetting_Wheels_WheelMotion(bool value) { Setting_Wheels_WheelMotion = value; }
	bool GetSetting_Wheels_WheelMotion() { return Setting_Wheels_WheelMotion; }
	void SetSetting_Wheels_MotionScale(float value) { Setting_Wheels_MotionScale = value; }
	float GetSetting_Wheels_MotionScale() { return Setting_Wheels_MotionScale; }
	void SetSetting_Wheels_WheelAngle(bool value) { Setting_Wheels_WheelAngle = value; }
	bool GetSetting_Wheels_WheelAngle() { return Setting_Wheels_WheelAngle; }
	void SetSetting_Wheels_BackdropColor(vec4 value) { Setting_Wheels_BackdropColor = value; }
	vec4 GetSetting_Wheels_BackdropColor() { return Setting_Wheels_BackdropColor; }
	void SetSetting_Wheels_BorderColor(vec4 value) { Setting_Wheels_BorderColor = value; }
	vec4 GetSetting_Wheels_BorderColor() { return Setting_Wheels_BorderColor; }
	void SetSetting_Wheels_BorderWidth(float value) { Setting_Wheels_BorderWidth = value; }
	float GetSetting_Wheels_BorderWidth() { return Setting_Wheels_BorderWidth; }
	void SetSetting_Wheels_BorderRadius(float value) { Setting_Wheels_BorderRadius = value; }
	float GetSetting_Wheels_BorderRadius() { return Setting_Wheels_BorderRadius; }
	void SetSetting_Wheels_WheelFillColor(vec3 value) { Setting_Wheels_WheelFillColor = value; }
	vec3 GetSetting_Wheels_WheelFillColor() { return Setting_Wheels_WheelFillColor; }
	void SetSetting_Wheels_WheelBorderColor(vec4 value) { Setting_Wheels_WheelBorderColor = value; }
	vec4 GetSetting_Wheels_WheelBorderColor() { return Setting_Wheels_WheelBorderColor; }
	void SetSetting_Wheels_WheelBorderWidth(float value) { Setting_Wheels_WheelBorderWidth = value; }
	float GetSetting_Wheels_WheelBorderWidth() { return Setting_Wheels_WheelBorderWidth; }
	void SetSetting_Wheels_WheelBorderRadius(float value) { Setting_Wheels_WheelBorderRadius = value; }
	float GetSetting_Wheels_WheelBorderRadius() { return Setting_Wheels_WheelBorderRadius; }
	void SetSetting_Wheels_SlipColor(vec3 value) { Setting_Wheels_SlipColor = value; }
	vec3 GetSetting_Wheels_SlipColor() { return Setting_Wheels_SlipColor; }
	void SetSetting_Wheels_IceColor(vec3 value) { Setting_Wheels_IceColor = value; }
	vec3 GetSetting_Wheels_IceColor() { return Setting_Wheels_IceColor; }
	void SetSetting_Wheels_DirtColor(vec3 value) { Setting_Wheels_DirtColor = value; }
	vec3 GetSetting_Wheels_DirtColor() { return Setting_Wheels_DirtColor; }
	void SetSetting_Wheels_BreakColor(vec3 value) { Setting_Wheels_BreakColor = value; }
	vec3 GetSetting_Wheels_BreakColor() { return Setting_Wheels_BreakColor; }
	void SetSetting_Wheels_WearColor(vec3 value) { Setting_Wheels_WearColor = value; }
	vec3 GetSetting_Wheels_WearColor() { return Setting_Wheels_WearColor; }
	void SetSetting_Wheels_WetColor(vec3 value) { Setting_Wheels_WetColor = value; }
	vec3 GetSetting_Wheels_WetColor() { return Setting_Wheels_WetColor; }
	void SetSetting_Wheels_WheelWidth(float value) { Setting_Wheels_WheelWidth = value; }
	float GetSetting_Wheels_WheelWidth() { return Setting_Wheels_WheelWidth; }
	void SetSetting_Wheels_WheelFillAlpha(float value) { Setting_Wheels_WheelFillAlpha = value; }
	float GetSetting_Wheels_WheelFillAlpha() { return Setting_Wheels_WheelFillAlpha; }
	void SetSetting_Wheels_WheelMotionAlpha(float value) { Setting_Wheels_WheelMotionAlpha = value; }
	float GetSetting_Wheels_WheelMotionAlpha() { return Setting_Wheels_WheelMotionAlpha; }
	void SetSetting_Wheels_Padding(float value) { Setting_Wheels_Padding = value; }
	float GetSetting_Wheels_Padding() { return Setting_Wheels_Padding; }
	void SetSetting_Wheels_RowSpacing(float value) { Setting_Wheels_RowSpacing = value; }
	float GetSetting_Wheels_RowSpacing() { return Setting_Wheels_RowSpacing; }
	void SetSetting_Wheels_DetailsSpacing(float value) { Setting_Wheels_DetailsSpacing = value; }
	float GetSetting_Wheels_DetailsSpacing() { return Setting_Wheels_DetailsSpacing; }
	void SetSetting_Wheels_DetailsFont(string value) { Setting_Wheels_DetailsFont = value; }
	string GetSetting_Wheels_DetailsFont() { return Setting_Wheels_DetailsFont; }
	void SetSetting_Wheels_DetailsFontSize(float value) { Setting_Wheels_DetailsFontSize = value; }
	float GetSetting_Wheels_DetailsFontSize() { return Setting_Wheels_DetailsFontSize; }
#endif
}

class Sharing
{
	dictionary m_settingsMap = 
	{
		// Re-order only this setting for comma compatibility with COMPETITION preprocessor
		  {"g.ohi", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_HideOnHiddenInterface}, {"Set", @SettingAccessor::SetSetting_General_HideOnHiddenInterface}}}
#if !COMPETITION
		, {"g.fpt", dictionary = {{"Type", SettingAccessor::SettingType::FORCEPADTYPE}, {"Get", @SettingAccessor::GetSetting_General_ForcePadType}, {"Set", @SettingAccessor::SetSetting_General_ForcePadType}}}
		, {"g.shp", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_ShowPad}, {"Set", @SettingAccessor::SetSetting_General_ShowPad}}}
		, {"g.mvp", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_MovePad}, {"Set", @SettingAccessor::SetSetting_General_MovePad}}}
		, {"g.pdp", dictionary = {{"Type", SettingAccessor::SettingType::VEC2}, {"Get", @SettingAccessor::GetSetting_General_PadPos}, {"Set", @SettingAccessor::SetSetting_General_PadPos}}}
		, {"g.pds", dictionary = {{"Type", SettingAccessor::SettingType::VEC2}, {"Get", @SettingAccessor::GetSetting_General_PadSize}, {"Set", @SettingAccessor::SetSetting_General_PadSize}}}
		, {"g.shg", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_ShowGearbox}, {"Set", @SettingAccessor::SetSetting_General_ShowGearbox}}}
		, {"g.mvg", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_MoveGearbox}, {"Set", @SettingAccessor::SetSetting_General_MoveGearbox}}}
		, {"g.gbp", dictionary = {{"Type", SettingAccessor::SettingType::VEC2}, {"Get", @SettingAccessor::GetSetting_General_GearboxPos}, {"Set", @SettingAccessor::SetSetting_General_GearboxPos}}}
		, {"g.gbs", dictionary = {{"Type", SettingAccessor::SettingType::VEC2}, {"Get", @SettingAccessor::GetSetting_General_GearboxSize}, {"Set", @SettingAccessor::SetSetting_General_GearboxSize}}}
		, {"g.shw", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_ShowWheels}, {"Set", @SettingAccessor::SetSetting_General_ShowWheels}}}
		, {"g.mvw", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_MoveWheels}, {"Set", @SettingAccessor::SetSetting_General_MoveWheels}}}
		, {"g.whp", dictionary = {{"Type", SettingAccessor::SettingType::VEC2}, {"Get", @SettingAccessor::GetSetting_General_WheelsPos}, {"Set", @SettingAccessor::SetSetting_General_WheelsPos}}}
		, {"g.whs", dictionary = {{"Type", SettingAccessor::SettingType::VEC2}, {"Get", @SettingAccessor::GetSetting_General_WheelsSize}, {"Set", @SettingAccessor::SetSetting_General_WheelsSize}}}
#endif
		, {"g.shs", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_ShowSpeed}, {"Set", @SettingAccessor::SetSetting_General_ShowSpeed}}}
		, {"g.mvs", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_General_MoveSpeed}, {"Set", @SettingAccessor::SetSetting_General_MoveSpeed}}}
		, {"g.spp", dictionary = {{"Type", SettingAccessor::SettingType::VEC2}, {"Get", @SettingAccessor::GetSetting_General_SpeedPos}, {"Set", @SettingAccessor::SetSetting_General_SpeedPos}}}
		, {"g.sps", dictionary = {{"Type", SettingAccessor::SettingType::VEC2}, {"Get", @SettingAccessor::GetSetting_General_SpeedSize}, {"Set", @SettingAccessor::SetSetting_General_SpeedSize}}}
#if !COMPETITION
		, {"p.stl", dictionary = {{"Type", SettingAccessor::SettingType::GAMEPADSTYLE}, {"Get", @SettingAccessor::GetSetting_Gamepad_Style}, {"Set", @SettingAccessor::SetSetting_Gamepad_Style}}}
		, {"p.efc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gamepad_EmptyFillColor}, {"Set", @SettingAccessor::SetSetting_Gamepad_EmptyFillColor}}}
		, {"p.flc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gamepad_FillColor}, {"Set", @SettingAccessor::SetSetting_Gamepad_FillColor}}}
		, {"p.bdc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gamepad_BorderColor}, {"Set", @SettingAccessor::SetSetting_Gamepad_BorderColor}}}
		, {"p.bdw", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gamepad_BorderWidth}, {"Set", @SettingAccessor::SetSetting_Gamepad_BorderWidth}}}
		, {"p.spc", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gamepad_Spacing}, {"Set", @SettingAccessor::SetSetting_Gamepad_Spacing}}}
		, {"p.arp", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gamepad_ArrowPadding}, {"Set", @SettingAccessor::SetSetting_Gamepad_ArrowPadding}}}
		, {"p.mds", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gamepad_MiddleScale}, {"Set", @SettingAccessor::SetSetting_Gamepad_MiddleScale}}}
		, {"p.cuc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gamepad_ClassicUpColor}, {"Set", @SettingAccessor::SetSetting_Gamepad_ClassicUpColor}}}
		, {"p.cdc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gamepad_ClassicDownColor}, {"Set", @SettingAccessor::SetSetting_Gamepad_ClassicDownColor}}}
		, {"p.ofa", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gamepad_OffAlpha}, {"Set", @SettingAccessor::SetSetting_Gamepad_OffAlpha}}}
		, {"p.uds", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_Gamepad_UpDownSymbols}, {"Set", @SettingAccessor::SetSetting_Gamepad_UpDownSymbols}}}
		, {"k.shp", dictionary = {{"Type", SettingAccessor::SettingType::KEYBOARDSHAPE}, {"Get", @SettingAccessor::GetSetting_Keyboard_Shape}, {"Set", @SettingAccessor::SetSetting_Keyboard_Shape}}}
		, {"k.efc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Keyboard_EmptyFillColor}, {"Set", @SettingAccessor::SetSetting_Keyboard_EmptyFillColor}}}
		, {"k.flc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Keyboard_FillColor}, {"Set", @SettingAccessor::SetSetting_Keyboard_FillColor}}}
		, {"k.bdc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Keyboard_BorderColor}, {"Set", @SettingAccessor::SetSetting_Keyboard_BorderColor}}}
		, {"k.bdw", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Keyboard_BorderWidth}, {"Set", @SettingAccessor::SetSetting_Keyboard_BorderWidth}}}
		, {"k.bdr", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Keyboard_BorderRadius}, {"Set", @SettingAccessor::SetSetting_Keyboard_BorderRadius}}}
		, {"k.spc", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Keyboard_Spacing}, {"Set", @SettingAccessor::SetSetting_Keyboard_Spacing}}}
		, {"k.ina", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Keyboard_InactiveAlpha}, {"Set", @SettingAccessor::SetSetting_Keyboard_InactiveAlpha}}}
		, {"b.sht", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_Gearbox_ShowText}, {"Set", @SettingAccessor::SetSetting_Gearbox_ShowText}}}
		, {"b.srt", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_Gearbox_ShowRPMText}, {"Set", @SettingAccessor::SetSetting_Gearbox_ShowRPMText}}}
		, {"b.stc", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_Gearbox_ShowTachometer}, {"Set", @SettingAccessor::SetSetting_Gearbox_ShowTachometer}}}
		, {"b.tcs", dictionary = {{"Type", SettingAccessor::SettingType::GEARBOXTACHOMETERSTYLE}, {"Get", @SettingAccessor::GetSetting_Gearbox_TachometerStyle}, {"Set", @SettingAccessor::SetSetting_Gearbox_TachometerStyle}}}
		, {"b.dns", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gearbox_Downshift}, {"Set", @SettingAccessor::SetSetting_Gearbox_Downshift}}}
		, {"b.ups", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gearbox_Upshift}, {"Set", @SettingAccessor::SetSetting_Gearbox_Upshift}}}
		, {"b.bdc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gearbox_BackdropColor}, {"Set", @SettingAccessor::SetSetting_Gearbox_BackdropColor}}}
		, {"b.brc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gearbox_BorderColor}, {"Set", @SettingAccessor::SetSetting_Gearbox_BorderColor}}}
		, {"b.brw", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gearbox_BorderWidth}, {"Set", @SettingAccessor::SetSetting_Gearbox_BorderWidth}}}
		, {"b.brr", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gearbox_BorderRadius}, {"Set", @SettingAccessor::SetSetting_Gearbox_BorderRadius}}}
		, {"b.spc", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Gearbox_Spacing}, {"Set", @SettingAccessor::SetSetting_Gearbox_Spacing}}}
		, {"b.lrc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gearbox_LowRPMColor}, {"Set", @SettingAccessor::SetSetting_Gearbox_LowRPMColor}}}
		, {"b.mrc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gearbox_MidRPMColor}, {"Set", @SettingAccessor::SetSetting_Gearbox_MidRPMColor}}}
		, {"b.hrc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gearbox_HighRPMColor}, {"Set", @SettingAccessor::SetSetting_Gearbox_HighRPMColor}}}
		, {"b.txc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Gearbox_TextColor}, {"Set", @SettingAccessor::SetSetting_Gearbox_TextColor}}}
		, {"b.fnt", dictionary = {{"Type", SettingAccessor::SettingType::STRING}, {"Get", @SettingAccessor::GetSetting_Gearbox_Font}, {"Set", @SettingAccessor::SetSetting_Gearbox_Font}}}
#endif
		, {"s.val", dictionary = {{"Type", SettingAccessor::SettingType::SPEEDVALUE}, {"Get", @SettingAccessor::GetSetting_Speed_Value}, {"Set", @SettingAccessor::SetSetting_Speed_Value}}}
		, {"s.stl", dictionary = {{"Type", SettingAccessor::SettingType::SPEEDSTYLE}, {"Get", @SettingAccessor::GetSetting_Speed_Style}, {"Set", @SettingAccessor::SetSetting_Speed_Style}}}
		, {"s.bdc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Speed_BackdropColor}, {"Set", @SettingAccessor::SetSetting_Speed_BackdropColor}}}
		, {"s.brc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Speed_BorderColor}, {"Set", @SettingAccessor::SetSetting_Speed_BorderColor}}}
		, {"s.txc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Speed_TextColor}, {"Set", @SettingAccessor::SetSetting_Speed_TextColor}}}
		, {"s.brw", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Speed_BorderWidth}, {"Set", @SettingAccessor::SetSetting_Speed_BorderWidth}}}
		, {"s.brr", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Speed_BorderRadius}, {"Set", @SettingAccessor::SetSetting_Speed_BorderRadius}}}
		, {"s.pad", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Speed_Padding}, {"Set", @SettingAccessor::SetSetting_Speed_Padding}}}
		, {"s.fnt", dictionary = {{"Type", SettingAccessor::SettingType::STRING}, {"Get", @SettingAccessor::GetSetting_Speed_Font}, {"Set", @SettingAccessor::SetSetting_Speed_Font}}}
		, {"s.fts", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Speed_FontSize}, {"Set", @SettingAccessor::SetSetting_Speed_FontSize}}}
#if !COMPETITION
		, {"w.stl", dictionary = {{"Type", SettingAccessor::SettingType::WHEELSSTYLE}, {"Get", @SettingAccessor::GetSetting_Wheels_Style}, {"Set", @SettingAccessor::SetSetting_Wheels_Style}}}
		, {"w.whm", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelMotion}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelMotion}}}
		, {"w.msc", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_MotionScale}, {"Set", @SettingAccessor::SetSetting_Wheels_MotionScale}}}
		, {"w.wha", dictionary = {{"Type", SettingAccessor::SettingType::BOOL}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelAngle}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelAngle}}}
		, {"w.bdc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Wheels_BackdropColor}, {"Set", @SettingAccessor::SetSetting_Wheels_BackdropColor}}}
		, {"w.brc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Wheels_BorderColor}, {"Set", @SettingAccessor::SetSetting_Wheels_BorderColor}}}
		, {"w.brw", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_BorderWidth}, {"Set", @SettingAccessor::SetSetting_Wheels_BorderWidth}}}
		, {"w.brr", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_BorderRadius}, {"Set", @SettingAccessor::SetSetting_Wheels_BorderRadius}}}
		, {"w.wfc", dictionary = {{"Type", SettingAccessor::SettingType::VEC3}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelFillColor}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelFillColor}}}
		, {"w.wbc", dictionary = {{"Type", SettingAccessor::SettingType::VEC4}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelBorderColor}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelBorderColor}}}
		, {"w.wbw", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelBorderWidth}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelBorderWidth}}}
		, {"w.wbr", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelBorderRadius}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelBorderRadius}}}
		, {"w.slc", dictionary = {{"Type", SettingAccessor::SettingType::VEC3}, {"Get", @SettingAccessor::GetSetting_Wheels_SlipColor}, {"Set", @SettingAccessor::SetSetting_Wheels_SlipColor}}}
		, {"w.icc", dictionary = {{"Type", SettingAccessor::SettingType::VEC3}, {"Get", @SettingAccessor::GetSetting_Wheels_IceColor}, {"Set", @SettingAccessor::SetSetting_Wheels_IceColor}}}
		, {"w.dtc", dictionary = {{"Type", SettingAccessor::SettingType::VEC3}, {"Get", @SettingAccessor::GetSetting_Wheels_DirtColor}, {"Set", @SettingAccessor::SetSetting_Wheels_DirtColor}}}
		, {"w.bkc", dictionary = {{"Type", SettingAccessor::SettingType::VEC3}, {"Get", @SettingAccessor::GetSetting_Wheels_BreakColor}, {"Set", @SettingAccessor::SetSetting_Wheels_BreakColor}}}
		, {"w.wrc", dictionary = {{"Type", SettingAccessor::SettingType::VEC3}, {"Get", @SettingAccessor::GetSetting_Wheels_WearColor}, {"Set", @SettingAccessor::SetSetting_Wheels_WearColor}}}
		, {"w.wtc", dictionary = {{"Type", SettingAccessor::SettingType::VEC3}, {"Get", @SettingAccessor::GetSetting_Wheels_WetColor}, {"Set", @SettingAccessor::SetSetting_Wheels_WetColor}}}
		, {"w.whw", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelWidth}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelWidth}}}
		, {"w.wfa", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelFillAlpha}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelFillAlpha}}}
		, {"w.wma", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_WheelMotionAlpha}, {"Set", @SettingAccessor::SetSetting_Wheels_WheelMotionAlpha}}}
		, {"w.pad", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_Padding}, {"Set", @SettingAccessor::SetSetting_Wheels_Padding}}}
		, {"w.rws", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_RowSpacing}, {"Set", @SettingAccessor::SetSetting_Wheels_RowSpacing}}}
		, {"w.dts", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_DetailsSpacing}, {"Set", @SettingAccessor::SetSetting_Wheels_DetailsSpacing}}}
		, {"w.dtf", dictionary = {{"Type", SettingAccessor::SettingType::STRING}, {"Get", @SettingAccessor::GetSetting_Wheels_DetailsFont}, {"Set", @SettingAccessor::SetSetting_Wheels_DetailsFont}}}
		, {"w.dfs", dictionary = {{"Type", SettingAccessor::SettingType::FLOAT}, {"Get", @SettingAccessor::GetSetting_Wheels_DetailsFontSize}, {"Set", @SettingAccessor::SetSetting_Wheels_DetailsFontSize}}}
#endif
	};
	string m_serializedSettings;
	Json::Value m_jsonSettings;

	void RenderSettings()
	{
		m_serializedSettings = UI::InputText("Configuration String", m_serializedSettings);
		UI::TextDisabled("Copy-paste this text to share your dashboard configuration.");
		if (UI::Button("Generate Configuration Text"))
		{
			m_serializedSettings = SerializeSettings();
		}
		UI::SameLine();
		if (UI::Button("Load Configuration from Text"))
		{
			DeserializeSettings(m_serializedSettings);
		}
	}

	private string SerializeSettings()
	{
		m_jsonSettings = Json::Object();
		auto settingKeys = m_settingsMap.GetKeys();
		for (uint keyIndex = 0; keyIndex < settingKeys.Length; keyIndex++)
		{
			string currentKey = settingKeys[keyIndex];
			SetJsonFromDictionary(currentKey);
		}
		return Json::Write(m_jsonSettings);
	}

	private bool DeserializeSettings(const string &in settingsString)
	{
		m_jsonSettings = Json::Parse(settingsString);
		if (m_jsonSettings.GetType() == Json::Type::Null) { return false; }
		auto settingKeys = m_settingsMap.GetKeys();

		// Verify the integrity of the json
		for (uint keyIndex = 0; keyIndex < settingKeys.Length; keyIndex++)
		{
			string currentKey = settingKeys[keyIndex];
			if (m_jsonSettings.HasKey(currentKey))
			{
				continue;
			}
			else
			{
				SettingAccessor::SettingType valueType = SettingAccessor::SettingType(cast<dictionary>(m_settingsMap[currentKey])["Type"]);
				if (valueType == SettingAccessor::SettingType::VEC2
					&& m_jsonSettings.HasKey(currentKey + ".x")
					&& m_jsonSettings.HasKey(currentKey + ".y"))
				{
					continue;
				}
				else if (valueType == SettingAccessor::SettingType::VEC3
					&& m_jsonSettings.HasKey(currentKey + ".x")
					&& m_jsonSettings.HasKey(currentKey + ".y")
					&& m_jsonSettings.HasKey(currentKey + ".z"))
				{
					continue;
				}
				else if (valueType == SettingAccessor::SettingType::VEC4
					&& m_jsonSettings.HasKey(currentKey + ".x")
					&& m_jsonSettings.HasKey(currentKey + ".y")
					&& m_jsonSettings.HasKey(currentKey + ".z")
					&& m_jsonSettings.HasKey(currentKey + ".w"))
				{
					continue;
				}
				else
				{
					return false;
				}
			}
		}

		for (uint keyIndex = 0; keyIndex < settingKeys.Length; keyIndex++)
		{
			string currentKey = settingKeys[keyIndex];
			SetDictionaryFromJson(currentKey);
		}
		return true;
	}

	private void SetDictionaryFromJson(string keyName)
	{
		auto value = cast<dictionary>(m_settingsMap[keyName]);
		SettingAccessor::SettingType valueType = SettingAccessor::SettingType(value["Type"]);
		if (valueType == SettingAccessor::SettingType::BOOL)
		{
			bool tmpBool = m_jsonSettings[keyName];
			cast<SettingAccessor::SetBool@>(value["Set"])(tmpBool);
		}
		else if (valueType == SettingAccessor::SettingType::FLOAT)
		{
			float tmpFloat = m_jsonSettings[keyName];
			cast<SettingAccessor::SetFloat@>(value["Set"])(tmpFloat);
		}
		else if (valueType == SettingAccessor::SettingType::VEC2)
		{
			vec2 tmpVec2;
			tmpVec2.x = m_jsonSettings[keyName + ".x"];
			tmpVec2.y = m_jsonSettings[keyName + ".y"];
			cast<SettingAccessor::SetVec2@>(value["Set"])(tmpVec2);
		}
		else if (valueType == SettingAccessor::SettingType::VEC3)
		{
			vec3 tmpVec3;
			tmpVec3.x = m_jsonSettings[keyName + ".x"];
			tmpVec3.y = m_jsonSettings[keyName + ".y"];
			tmpVec3.z = m_jsonSettings[keyName + ".z"];
			cast<SettingAccessor::SetVec3@>(value["Set"])(tmpVec3);
		}
		else if (valueType == SettingAccessor::SettingType::VEC4)
		{
			vec4 tmpVec4;
			tmpVec4.x = m_jsonSettings[keyName + ".x"];
			tmpVec4.y = m_jsonSettings[keyName + ".y"];
			tmpVec4.z = m_jsonSettings[keyName + ".z"];
			tmpVec4.w = m_jsonSettings[keyName + ".w"];
			cast<SettingAccessor::SetVec4@>(value["Set"])(tmpVec4);
		}
		else if (valueType == SettingAccessor::SettingType::STRING)
		{
			string tmpString = m_jsonSettings[keyName];
			cast<SettingAccessor::SetString@>(value["Set"])(tmpString);
		}
#if !COMPETITION
		else if (valueType == SettingAccessor::SettingType::FORCEPADTYPE)
		{
			ForcePadType tmpEnum = ForcePadType(int(m_jsonSettings[keyName]));
			cast<SettingAccessor::SetForcePadType@>(value["Set"])(tmpEnum);
		}
		else if (valueType == SettingAccessor::SettingType::GAMEPADSTYLE)
		{
			GamepadStyle tmpEnum = GamepadStyle(int(m_jsonSettings[keyName]));
			cast<SettingAccessor::SetGamepadStyle@>(value["Set"])(tmpEnum);
		}
		else if (valueType == SettingAccessor::SettingType::KEYBOARDSHAPE)
		{
			KeyboardShape tmpEnum = KeyboardShape(int(m_jsonSettings[keyName]));
			cast<SettingAccessor::SetKeyboardShape@>(value["Set"])(tmpEnum);
		}
		else if (valueType == SettingAccessor::SettingType::GEARBOXTACHOMETERSTYLE)
		{
			GearboxTachometerStyle tmpEnum = GearboxTachometerStyle(int(m_jsonSettings[keyName]));
			cast<SettingAccessor::SetGearboxTachometerStyle@>(value["Set"])(tmpEnum);
		}
#endif
		else if (valueType == SettingAccessor::SettingType::SPEEDVALUE)
		{
			SpeedValue tmpEnum = SpeedValue(int(m_jsonSettings[keyName]));
			cast<SettingAccessor::SetSpeedValue@>(value["Set"])(tmpEnum);
		}
		else if (valueType == SettingAccessor::SettingType::SPEEDSTYLE)
		{
			SpeedStyle tmpEnum = SpeedStyle(int(m_jsonSettings[keyName]));
			cast<SettingAccessor::SetSpeedStyle@>(value["Set"])(tmpEnum);
		}
#if !COMPETITION
		else if (valueType == SettingAccessor::SettingType::WHEELSSTYLE)
		{
			WheelsStyle tmpEnum = WheelsStyle(int(m_jsonSettings[keyName]));
			cast<SettingAccessor::SetWheelsStyle@>(value["Set"])(tmpEnum);
		}
#endif
	}

	private void SetJsonFromDictionary(string keyName)
	{
		auto value = cast<dictionary>(m_settingsMap[keyName]);
		SettingAccessor::SettingType valueType = SettingAccessor::SettingType(value["Type"]);
		if (valueType == SettingAccessor::SettingType::BOOL)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetBool@>(value["Get"])();
		}
		else if (valueType == SettingAccessor::SettingType::FLOAT)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetFloat@>(value["Get"])();
		}
		else if (valueType == SettingAccessor::SettingType::VEC2)
		{
			auto tmpVec2 = cast<SettingAccessor::GetVec2@>(value["Get"])();
			m_jsonSettings[keyName + ".x"] = tmpVec2.x;
			m_jsonSettings[keyName + ".y"] = tmpVec2.y;
		}
		else if (valueType == SettingAccessor::SettingType::VEC3)
		{
			auto tmpVec3 = cast<SettingAccessor::GetVec3@>(value["Get"])();
			m_jsonSettings[keyName + ".x"] = tmpVec3.x;
			m_jsonSettings[keyName + ".y"] = tmpVec3.y;
			m_jsonSettings[keyName + ".z"] = tmpVec3.z;
		}
		else if (valueType == SettingAccessor::SettingType::VEC4)
		{
			auto tmpVec4 = cast<SettingAccessor::GetVec4@>(value["Get"])();
			m_jsonSettings[keyName + ".x"] = tmpVec4.x;
			m_jsonSettings[keyName + ".y"] = tmpVec4.y;
			m_jsonSettings[keyName + ".z"] = tmpVec4.z;
			m_jsonSettings[keyName + ".w"] = tmpVec4.w;
		}
		else if (valueType == SettingAccessor::SettingType::STRING)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetString@>(value["Get"])();
		}
#if !COMPETITION
		else if (valueType == SettingAccessor::SettingType::FORCEPADTYPE)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetForcePadType@>(value["Get"])();
		}
		else if (valueType == SettingAccessor::SettingType::GAMEPADSTYLE)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetGamepadStyle@>(value["Get"])();
		}
		else if (valueType == SettingAccessor::SettingType::KEYBOARDSHAPE)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetKeyboardShape@>(value["Get"])();
		}
		else if (valueType == SettingAccessor::SettingType::GEARBOXTACHOMETERSTYLE)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetGearboxTachometerStyle@>(value["Get"])();
		}
#endif
		else if (valueType == SettingAccessor::SettingType::SPEEDVALUE)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetSpeedValue@>(value["Get"])();
		}
		else if (valueType == SettingAccessor::SettingType::SPEEDSTYLE)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetSpeedStyle@>(value["Get"])();
		}
#if !COMPETITION
		else if (valueType == SettingAccessor::SettingType::WHEELSSTYLE)
		{
			m_jsonSettings[keyName] = cast<SettingAccessor::GetWheelsStyle@>(value["Get"])();
		}
#endif
	}
}
