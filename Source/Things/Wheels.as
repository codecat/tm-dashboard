enum WheelType
{
	FL, FR,
	RL, RR,
}

class WheelState
{
	bool m_right;
	EPlugSurfaceMaterialId m_surface;
	float m_steerAngle;
	float m_rot;
	float m_slipCoef;
	float m_dirt;
	float m_icing;
	float m_breakCoef;
	float m_tireWear;
}

class DashboardWheels : DashboardThing
{
	Resources::Font@ m_font;
	string m_fontPath;

	DashboardWheels()
	{
		LoadFont();
	}

	void LoadFont()
	{
		if (Setting_Wheels_DetailsFont == m_fontPath) {
			return;
		}

		auto font = Resources::GetFont(Setting_Wheels_DetailsFont);
		if (font !is null) {
			m_fontPath = Setting_Wheels_DetailsFont;
			@m_font = font;
			nvg::AddFallbackFont(m_font, g_fontIcons);
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
				ret.m_surface = vis.FLGroundContactMaterial;
				ret.m_steerAngle = vis.FLSteerAngle;
				ret.m_rot = vis.FLWheelRot;
				ret.m_slipCoef = vis.FLSlipCoef;
				ret.m_dirt = Vehicle::GetWheelDirt(vis, int(type));
				ret.m_icing = vis.FLIcing01;
				ret.m_breakCoef = vis.FLBreakNormedCoef;
				ret.m_tireWear = vis.FLTireWear01;
				break;
			case WheelType::FR:
				ret.m_right = true;
				ret.m_surface = vis.FRGroundContactMaterial;
				ret.m_steerAngle = vis.FRSteerAngle;
				ret.m_rot = vis.FRWheelRot;
				ret.m_slipCoef = vis.FRSlipCoef;
				ret.m_dirt = Vehicle::GetWheelDirt(vis, int(type));
				ret.m_icing = vis.FRIcing01;
				ret.m_breakCoef = vis.FRBreakNormedCoef;
				ret.m_tireWear = vis.FRTireWear01;
				break;
			case WheelType::RL:
				ret.m_right = false;
				ret.m_surface = vis.RLGroundContactMaterial;
				ret.m_steerAngle = vis.RLSteerAngle;
				ret.m_rot = vis.RLWheelRot;
				ret.m_slipCoef = vis.RLSlipCoef;
				ret.m_dirt = Vehicle::GetWheelDirt(vis, int(type));
				ret.m_icing = vis.RLIcing01;
				ret.m_breakCoef = vis.RLBreakNormedCoef;
				ret.m_tireWear = vis.RLTireWear01;
				break;
			case WheelType::RR:
				ret.m_right = true;
				ret.m_surface = vis.RRGroundContactMaterial;
				ret.m_steerAngle = vis.RRSteerAngle;
				ret.m_rot = vis.RRWheelRot;
				ret.m_slipCoef = vis.RRSlipCoef;
				ret.m_dirt = Vehicle::GetWheelDirt(vis, int(type));
				ret.m_icing = vis.RRIcing01;
				ret.m_breakCoef = vis.RRBreakNormedCoef;
				ret.m_tireWear = vis.RRTireWear01;
				break;
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
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, 5);

		vec3 fillColor = Setting_Wheels_WheelFillColor;
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
		nvg::FillColor(vec4(fillColor.x, fillColor.y, fillColor.z, Setting_Wheels_WheelFillAlpha));
		nvg::Fill();

		// Lines on the wheel
		if (Setting_Wheels_WheelMotion) {
			const float lineHeight = 7;
			const float lineSpacing = 5;
			int numLines = int(size.y / (lineHeight + lineSpacing)) + 1;

			nvg::Scissor(pos.x, pos.y, size.x, size.y);
			nvg::FillColor(vec4(0, 0, 0, Setting_Wheels_WheelMotionAlpha));
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
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, 5);
		nvg::StrokeWidth(3);
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

		if (state.m_icing > 0) {
			RenderWheelLine(state, Setting_Wheels_IceColor, size.x, Icons::Snowflake, Text::Format("%.0f%%", state.m_icing * 100));
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

	void Render(CSceneVehicleVisState@ vis) override
	{
		// Backdrop
		nvg::BeginPath();
		nvg::RoundedRect(0, 0, m_size.x, m_size.y, 5);
		nvg::FillColor(Setting_Wheels_BackdropColor);
		nvg::Fill();

		// Wheels
		array<WheelState> wheels;
		wheels.InsertLast(GetWheelState(vis, WheelType::FL));
		wheels.InsertLast(GetWheelState(vis, WheelType::FR));
		wheels.InsertLast(GetWheelState(vis, WheelType::RL));
		wheels.InsertLast(GetWheelState(vis, WheelType::RR));

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

		// Border around everything
		nvg::BeginPath();
		nvg::RoundedRect(0, 0, m_size.x, m_size.y, 5);
		nvg::StrokeWidth(3);
		nvg::StrokeColor(Setting_Wheels_BorderColor);
		nvg::Stroke();
	}
}
