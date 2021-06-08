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

		RenderKey(vec2(keySize.x + Setting_Keyboard_Spacing, 0), keySize, Icons::AngleUp, vis.InputGasPedal > 0.1f);
		RenderKey(vec2(0, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleLeft, vis.InputSteer < -0.1f);
		RenderKey(vec2(keySize.x + Setting_Keyboard_Spacing, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleDown, vis.InputBrakePedal > 0.1f);
		RenderKey(vec2(keySize.x * 2 + Setting_Keyboard_Spacing * 2, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleRight, vis.InputSteer > 0.1f);
	}

	void RenderKey(const vec2 &in pos, const vec2 &in size, const string &in text, bool on)
	{
		vec4 borderColor = Setting_Keyboard_BorderColor;
		borderColor.w *= on ? 1.0f : Setting_Keyboard_InactiveAlpha;

		nvg::BeginPath();
		nvg::StrokeWidth(Setting_Keyboard_BorderWidth);

		switch (Setting_Keyboard_Shape) {
			case KeyboardShape::Rectangle: nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Keyboard_BorderRadius); break;
			case KeyboardShape::Ellipse: nvg::Ellipse(pos + size / 2, size.x / 2, size.y / 2); break;
		}

		if (on) {
			nvg::FillColor(Setting_Keyboard_FillColor);
		} else {
			nvg::FillColor(Setting_Keyboard_EmptyFillColor);
		}
		nvg::Fill();

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
