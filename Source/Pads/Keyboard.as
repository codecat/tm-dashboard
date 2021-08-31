#if !COMPETITION
class DashboardPadKeyboard : DashboardThing
{
	DashboardPadKeyboard()
	{
		super();
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		auto keySize = vec2(
			(m_size.x - Setting_Keyboard_Spacing * 2) / 3,
			(m_size.y - Setting_Keyboard_Spacing) / 2
		);

		float steerLeft = vis.InputSteer < 0 ? Math::Abs(vis.InputSteer) : 0.0f;
		float steerRight = vis.InputSteer > 0 ? vis.InputSteer : 0.0f;

		RenderKey(vec2(keySize.x + Setting_Keyboard_Spacing, 0), keySize, Icons::AngleUp, vis.InputGasPedal);
		RenderKey(vec2(keySize.x + Setting_Keyboard_Spacing, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleDown, vis.InputIsBraking ? 1.0f : vis.InputBrakePedal);

		RenderKey(vec2(0, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleLeft, steerLeft, -1);
		RenderKey(vec2(keySize.x * 2 + Setting_Keyboard_Spacing * 2, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleRight, steerRight, 1);
	}

	void RenderKey(const vec2 &in pos, const vec2 &in size, const string &in text, float value, int fillDir = 0)
	{
		vec4 borderColor = Setting_Keyboard_BorderColor;
		if (fillDir == 0) {
			borderColor.w *= Math::Abs(value) > 0.1f ? 1.0f : Setting_Keyboard_InactiveAlpha;
		} else {
			borderColor.w *= Math::Lerp(Setting_Keyboard_InactiveAlpha, 1.0f, value);
		}

		nvg::BeginPath();
		nvg::StrokeWidth(Setting_Keyboard_BorderWidth);

		switch (Setting_Keyboard_Shape) {
			case KeyboardShape::Rectangle: nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Keyboard_BorderRadius); break;
			case KeyboardShape::Ellipse: nvg::Ellipse(pos + size / 2, size.x / 2, size.y / 2); break;
		}

		nvg::FillColor(Setting_Keyboard_EmptyFillColor);
		nvg::Fill();

		if (fillDir == 0) {
			if (Math::Abs(value) > 0.1f) {
				nvg::FillColor(Setting_Keyboard_FillColor);
				nvg::Fill();
			}
		} else if (value > 0) {
			if (fillDir == -1) {
				float valueWidth = value * size.x;
				nvg::Scissor(size.x - valueWidth, pos.y, valueWidth, size.y);
			} else if (fillDir == 1) {
				float valueWidth = value * size.x;
				nvg::Scissor(pos.x, pos.y, valueWidth, size.y);
			}
			nvg::FillColor(Setting_Keyboard_FillColor);
			nvg::Fill();
			nvg::ResetScissor();
		}

		nvg::StrokeColor(borderColor);
		nvg::Stroke();

		nvg::BeginPath();
		nvg::FontFace(g_font);
		nvg::FontSize(size.x / 2);
		nvg::FillColor(borderColor);
		nvg::TextAlign(nvg::Align::Middle | nvg::Align::Center);
		nvg::TextBox(pos.x, pos.y + size.y / 2, size.x, text);
	}
}
#endif
