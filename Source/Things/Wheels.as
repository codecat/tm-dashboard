enum WheelType
{
	FL, FR,
	RL, RR,
}

class WheelState
{
	bool m_right;
	float m_steerAngle;
	float m_rot;
	float m_slipCoef;
	float m_dirt;
#if TMNEXT
	float m_breakCoef;
	float m_tireWear;
	float m_icing;
	float m_wetness;
	EPlugSurfaceMaterialId m_groundMaterial;
#endif
}

class DashboardWheels : DashboardThing
{
	nvg::Font m_font;
	string m_fontPath;

	DashboardWheels()
	{
		super("Wheels");
		LoadFont();
	}

	bool IsVisible(bool whenHidden) override { return whenHidden ? Setting_General_ShowWheelsHidden : Setting_General_ShowWheels; }
	void SetVisible(bool visible, bool visibleWhenHidden) override
	{
		Setting_General_ShowWheels = visible;
		Setting_General_ShowWheelsHidden = visibleWhenHidden;
	}

	void UpdateProportions() override
	{
		m_pos = Setting_General_WheelsPos;
		m_size = Setting_General_WheelsSize;
	}

	void SetProportions(const vec2 &in pos, const vec2 &in size) override
	{
		Setting_General_WheelsPos = pos;
		Setting_General_WheelsSize = size;
	}

	void ResetProportions() override
	{
		auto plugin = Meta::ExecutingPlugin();
		plugin.GetSetting("Setting_General_WheelsPos").Reset();
		plugin.GetSetting("Setting_General_WheelsSize").Reset();
	}

	void LoadFont()
	{
		if (Setting_Wheels_DetailsFont == m_fontPath) {
			return;
		}

		auto font = nvg::LoadFont(Setting_Wheels_DetailsFont);
		if (font > 0) {
			m_fontPath = Setting_Wheels_DetailsFont;
			m_font = font;
		}
	}

	void OnSettingsChanged() override
	{
		LoadFont();
	}

	WheelState GetWheelState(CSceneVehicleVisState@ vis, WheelType type)
	{
		WheelState ret;
		switch (type) {
			case WheelType::FL:
				ret.m_right = false;
				ret.m_steerAngle = vis.FLSteerAngle;
				ret.m_rot = vis.FLWheelRot;
				ret.m_slipCoef = vis.FLSlipCoef;
#if TMNEXT
				ret.m_dirt = VehicleState::GetWheelDirt(vis, int(type));
				ret.m_breakCoef = vis.FLBreakNormedCoef;
				ret.m_tireWear = vis.FLTireWear01;
				ret.m_icing = vis.FLIcing01;
				ret.m_groundMaterial = vis.FLGroundContactMaterial;
#endif
				break;
			case WheelType::FR:
				ret.m_right = true;
				ret.m_steerAngle = vis.FRSteerAngle;
				ret.m_rot = vis.FRWheelRot;
				ret.m_slipCoef = vis.FRSlipCoef;
#if TMNEXT
				ret.m_dirt = VehicleState::GetWheelDirt(vis, int(type));
				ret.m_breakCoef = vis.FRBreakNormedCoef;
				ret.m_tireWear = vis.FRTireWear01;
				ret.m_icing = vis.FRIcing01;
				ret.m_groundMaterial = vis.FRGroundContactMaterial;
#endif
				break;
			case WheelType::RL:
				ret.m_right = false;
				ret.m_steerAngle = vis.RLSteerAngle;
				ret.m_rot = vis.RLWheelRot;
				ret.m_slipCoef = vis.RLSlipCoef;
#if TMNEXT
				ret.m_dirt = VehicleState::GetWheelDirt(vis, int(type));
				ret.m_breakCoef = vis.RLBreakNormedCoef;
				ret.m_tireWear = vis.RLTireWear01;
				ret.m_icing = vis.RLIcing01;
				ret.m_groundMaterial = vis.RLGroundContactMaterial;
#endif
				break;
			case WheelType::RR:
				ret.m_right = true;
				ret.m_steerAngle = vis.RRSteerAngle;
				ret.m_rot = vis.RRWheelRot;
				ret.m_slipCoef = vis.RRSlipCoef;
#if TMNEXT
				ret.m_dirt = VehicleState::GetWheelDirt(vis, int(type));
				ret.m_breakCoef = vis.RRBreakNormedCoef;
				ret.m_tireWear = vis.RRTireWear01;
				ret.m_icing = vis.RRIcing01;
				ret.m_groundMaterial = vis.RRGroundContactMaterial;
#endif
				break;
		}

#if TMNEXT
		// Wetness is applied on all wheels at the same time, so just duplicate it
		ret.m_wetness = vis.WetnessValue01;
#endif

		return ret;
	}

	vec3 GetWheelSurfaceColor(const WheelState& state)
	{
		vec3 ret(0,0,0);

		switch (state.m_groundMaterial) {
			case EPlugSurfaceMaterialId::Ice:
			case EPlugSurfaceMaterialId::RoadIce:
				ret = Setting_Wheels_IceSurfaceColor;
				break;
			case EPlugSurfaceMaterialId::Grass:
			case EPlugSurfaceMaterialId::Green:
				ret = Setting_Wheels_GrassSurfaceColor;
				break;
			case EPlugSurfaceMaterialId::Dirt:
				ret = Setting_Wheels_DirtSurfaceColor;
				break;
			case EPlugSurfaceMaterialId::Wood:
				ret = Setting_Wheels_WoodSurfaceColor;
				break;
			case EPlugSurfaceMaterialId::Plastic:
				ret = Setting_Wheels_PlasticSurfaceColor;
				break;
			case EPlugSurfaceMaterialId::Snow:
				ret = Setting_Wheels_SnowSurfaceColor;
				break;
			case EPlugSurfaceMaterialId::Sand:
				ret = Setting_Wheels_SandSurfaceColor;
		}

		return ret;
	}

	void RenderWheelVisual(const WheelState &in state, const vec2 &in pos, const vec2 &in size)
	{
		const float spacing = 10;

		auto tx = nvg::CurrentTransform();

		// Handle wheel angle transformation
		if (Setting_Wheels_WheelAngle) {
			vec2 rotateOrigin = pos + size / 2;
			nvg::Translate(rotateOrigin.x, rotateOrigin.y);
			nvg::Rotate(state.m_steerAngle * -1);
			nvg::Translate(-rotateOrigin.x, -rotateOrigin.y);
		}

		// Wheel fill
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Wheels_WheelBorderRadius);

		vec3 fillColor = Setting_Wheels_WheelFillColor;

#if TMNEXT
		if (state.m_icing > 0) {
			fillColor = Math::Lerp(fillColor, Setting_Wheels_IceColor, state.m_icing);
		}
		if (state.m_dirt > 0) {
			fillColor = Math::Lerp(fillColor, Setting_Wheels_DirtColor, state.m_dirt);
		}
		if (state.m_breakCoef > 0) {
			fillColor = Math::Lerp(fillColor, Setting_Wheels_BreakColor, state.m_breakCoef);
		}
		if (state.m_tireWear > 0) {
			fillColor = Math::Lerp(fillColor, Setting_Wheels_WearColor, state.m_tireWear);
		}
		if (state.m_wetness > 0) {
			fillColor = Math::Lerp(fillColor, Setting_Wheels_WetColor, state.m_wetness);
		}
#endif

		nvg::FillColor(vec4(fillColor.x, fillColor.y, fillColor.z, Setting_Wheels_WheelFillAlpha));
		nvg::Fill();

		// Lines on the wheel
		if (Setting_Wheels_WheelMotion) {
			const float lineHeight = 7;
			const float lineSpacing = 5;
			int numLines = int(size.y / (lineHeight + lineSpacing)) + 1;
			nvg::Scissor(pos.x, pos.y, size.x, size.y);
#if TMNEXT
			vec3 surfaceColor = Setting_Wheels_WheelSurface ? GetWheelSurfaceColor(state) : vec3(0,0,0);
#else
			vec3 surfaceColor(0,0,0);
#endif
			nvg::FillColor(vec4(surfaceColor.x, surfaceColor.y, surfaceColor.z, Setting_Wheels_WheelMotionAlpha));
			for (int i = -1; i < numLines; i++) {
				float offset = i * (lineHeight + lineSpacing);
				offset = Math::Round(offset + ((state.m_rot * Setting_Wheels_MotionScale) % (lineHeight + lineSpacing)));
				nvg::BeginPath();
				nvg::Rect(pos.x, pos.y + offset, size.x, lineHeight);
				nvg::Fill();
			}
			nvg::ResetScissor();
		}

		// Wheel border
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Wheels_WheelBorderRadius);
		nvg::StrokeWidth(Setting_Wheels_WheelBorderWidth);
		nvg::StrokeColor(Setting_Wheels_WheelBorderColor);
		nvg::Stroke();

		nvg::SetTransform(tx);
	}

	void RenderWheelLine(const WheelState &in state, const vec3 &in color, float width, const string &in icon, const string &in text)
	{
		float iconSize = Setting_Wheels_DetailsFontSize + 4;

		nvg::FillColor(vec4(color.x, color.y, color.z, 1.0f));

		nvg::TextAlign(nvg::Align::Center | nvg::Align::Top);

		if (state.m_right) {
			nvg::TextBox(width - iconSize, 0, iconSize, icon);
			nvg::TextAlign(nvg::Align::Right | nvg::Align::Top);
			nvg::TextBox(0, 0, width - iconSize, text);
		} else {
			nvg::TextBox(0, 0, iconSize, icon);
			nvg::TextAlign(nvg::Align::Left | nvg::Align::Top);
			nvg::TextBox(iconSize, 0, width - iconSize, text);
		}

		nvg::Translate(0, Setting_Wheels_DetailsFontSize + 4);
	}

	void RenderWheelDetails(const WheelState &in state, const vec2 &in pos, const vec2 &in size)
	{
		nvg::BeginPath();
		nvg::FontFace(m_font);
		nvg::FontSize(Setting_Wheels_DetailsFontSize);

		auto tx = nvg::CurrentTransform();
		nvg::Translate(pos.x, pos.y);

		if (state.m_slipCoef > 0) {
			RenderWheelLine(state, Setting_Wheels_SlipColor, size.x, Icons::Exclamation, "Slip");
		}

#if TMNEXT
		if (state.m_icing > 0) {
			RenderWheelLine(state, Setting_Wheels_IceColor, size.x, Icons::SnowflakeO, Text::Format("%.0f%%", state.m_icing * 100));
		}

		if (state.m_breakCoef > 0) {
			RenderWheelLine(state, Setting_Wheels_BreakColor, size.x, Icons::ExclamationTriangle, Text::Format("%.0f%%", state.m_breakCoef * 100));
		}

		if (state.m_tireWear > 0) {
			RenderWheelLine(state, Setting_Wheels_WearColor, size.x, Icons::ExclamationTriangle, Text::Format("%.0f%%", state.m_tireWear * 100));
		}

		if (state.m_dirt > 0) {
			RenderWheelLine(state, Setting_Wheels_DirtColor, size.x, Icons::Road, Text::Format("%.0f%%", state.m_dirt * 100));
		}

		if (state.m_wetness > 0) {
			RenderWheelLine(state, Setting_Wheels_WetColor, size.x, Icons::Tint, Text::Format("%.0f%%", state.m_wetness * 100));
		}
#endif

		nvg::SetTransform(tx);
	}

	void RenderWheel(const WheelState &in state, const vec2 &in pos, const vec2 &in size)
	{
		if (state.m_right) {
			RenderWheelVisual(state, pos + vec2(size.x - Setting_Wheels_WheelWidth, 0), vec2(Setting_Wheels_WheelWidth, size.y));
			RenderWheelDetails(state, pos, vec2(size.x - Setting_Wheels_WheelWidth - Setting_Wheels_DetailsSpacing, size.y));
		} else {
			RenderWheelVisual(state, pos, vec2(Setting_Wheels_WheelWidth, size.y));
			RenderWheelDetails(state, pos + vec2(Setting_Wheels_WheelWidth + Setting_Wheels_DetailsSpacing, 0), vec2(size.x - Setting_Wheels_WheelWidth - Setting_Wheels_DetailsSpacing, size.y));
		}
	}

	void RenderUnifiedWheels(const array<WheelState> &in wheels)
	{
		WheelState state;

		for (uint i = 0; i < wheels.Length; i++) {
			auto@ w = wheels[i];

			state.m_slipCoef = Math::Max(state.m_slipCoef, w.m_slipCoef);
			state.m_dirt = Math::Max(state.m_dirt, w.m_dirt);
#if TMNEXT
			state.m_breakCoef = Math::Max(state.m_breakCoef, w.m_breakCoef);
			state.m_tireWear = Math::Max(state.m_tireWear, w.m_tireWear);
			state.m_icing = Math::Max(state.m_icing, w.m_icing);
			state.m_wetness = Math::Max(state.m_wetness, w.m_wetness);
#endif
		}

		vec2 pos(
			Setting_Wheels_Padding,
			Setting_Wheels_Padding
		);

		vec2 size(
			m_size.x - Setting_Wheels_Padding * 2,
			(m_size.y - Setting_Wheels_Padding * 2 - Setting_Wheels_RowSpacing * 3) / 4
		);

		RenderWheelDetails(state, pos, size);
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		// Backdrop
		nvg::BeginPath();
		nvg::RoundedRect(0, 0, m_size.x, m_size.y, Setting_Wheels_BorderRadius);
		nvg::FillColor(Setting_Wheels_BackdropColor);
		nvg::Fill();

		// Wheels
		array<WheelState> wheels;
		wheels.InsertLast(GetWheelState(vis, WheelType::FL));
		wheels.InsertLast(GetWheelState(vis, WheelType::FR));
		wheels.InsertLast(GetWheelState(vis, WheelType::RL));
		wheels.InsertLast(GetWheelState(vis, WheelType::RR));

		if (Setting_Wheels_Style == WheelsStyle::Unified) {
			RenderUnifiedWheels(wheels);
		} else {
			switch (Setting_Wheels_Style) {
				case WheelsStyle::Detailed: {
					vec2 wheelSize(
						m_size.x - Setting_Wheels_Padding * 2,
						(m_size.y - Setting_Wheels_Padding * 2 - Setting_Wheels_RowSpacing * 3) / 4
					);

					for (uint i = 0; i < wheels.Length; i++) {
						RenderWheel(wheels[i], vec2(
							Setting_Wheels_Padding,
							Setting_Wheels_Padding + i * (wheelSize.y + Setting_Wheels_RowSpacing)
						), wheelSize);
					}
					break;
				}

				case WheelsStyle::Simple: {
					vec2 wheelSize(
						Setting_Wheels_WheelWidth,
						(m_size.y - Setting_Wheels_Padding * 2 - Setting_Wheels_RowSpacing) / 2
					);

					for (uint i = 0; i < wheels.Length; i++) {
						vec2 pos;
						if (i % 2 == 0) {
							pos = vec2(
								m_size.x - Setting_Wheels_Padding - Setting_Wheels_WheelWidth,
								Setting_Wheels_Padding + i / 2 * (wheelSize.y + Setting_Wheels_RowSpacing)
							);
						} else {
							pos = vec2(
								Setting_Wheels_Padding,
								Setting_Wheels_Padding + i / 2 * (wheelSize.y + Setting_Wheels_RowSpacing)
							);
						}

						RenderWheelVisual(wheels[i], pos, wheelSize);
					}
					break;
				}
			}
		}

		// Border around everything
		nvg::BeginPath();
		nvg::RoundedRect(0, 0, m_size.x, m_size.y, Setting_Wheels_BorderRadius);
		nvg::StrokeWidth(Setting_Wheels_BorderWidth);
		nvg::StrokeColor(Setting_Wheels_BorderColor);
		nvg::Stroke();
	}
}
