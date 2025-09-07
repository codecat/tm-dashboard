class DashboardPadKeyboard : IDashboardPad
{
	nvg::Font m_font;
	string m_fontPath;

	vec2 m_size;

	DashboardPadKeyboard()
	{
		LoadFont();
	}

	void LoadFont()
	{
		if (Setting_Keyboard_Font == m_fontPath) {
			return;
		}

		auto font = nvg::LoadFont(Setting_Keyboard_Font);
		if (font >= 0) {
			m_fontPath = Setting_Keyboard_Font;
			m_font = font;
		}
	}

	void OnSettingsChanged() override
	{
		LoadFont();
	}

	void Render(const vec2 &in size, CSceneVehicleVisState@ vis) override
	{
		m_size = size;

		float steerLeft = vis.InputSteer < 0 ? Math::Abs(vis.InputSteer) : 0.0f;
		float steerRight = vis.InputSteer > 0 ? vis.InputSteer : 0.0f;

		vec2 keySize = vec2((size.x - Setting_Keyboard_Spacing * 2) / 3, (size.y - Setting_Keyboard_Spacing) / 2);
		vec2 sideKeySize = keySize;

		vec2 upPos = vec2(keySize.x + Setting_Keyboard_Spacing, 0);
		vec2 downPos = vec2(keySize.x + Setting_Keyboard_Spacing, keySize.y + Setting_Keyboard_Spacing);
		vec2 leftPos = vec2(0, keySize.y + Setting_Keyboard_Spacing);
		vec2 rightPos = vec2(keySize.x * 2 + Setting_Keyboard_Spacing * 2, keySize.y + Setting_Keyboard_Spacing);

		if (Setting_Keyboard_Shape == KeyboardShape::Compact) {
			sideKeySize.y = size.y;
			leftPos.y = 0;
			rightPos.y = 0;
		}

		RenderKey(upPos, keySize, Icons::AngleUp, vis.InputGasPedal);
		RenderKey(downPos, keySize, Icons::AngleDown, vis.InputIsBraking ? 1.0f : vis.InputBrakePedal);

		RenderKey(leftPos, sideKeySize, Icons::AngleLeft, steerLeft, -1);
		RenderKey(rightPos, sideKeySize, Icons::AngleRight, steerRight, 1);
	}

	void RenderKey(const vec2 &in pos, const vec2 &in size, const string &in text, float value, int fillDir = 0)
	{
		nvg::BeginPath();
		nvg::StrokeWidth(Setting_Keyboard_BorderWidth);

		switch (Setting_Keyboard_Shape) {
			case KeyboardShape::Rectangle:
			case KeyboardShape::Compact:
				nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Keyboard_BorderRadius);
				break;
			case KeyboardShape::Ellipse:
				nvg::Ellipse(pos + size / 2, size.x / 2, size.y / 2);
				break;
		}

		nvg::FillColor(Setting_Keyboard_EmptyFillColor);
		nvg::Fill();

		if (fillDir == 0) {
			if (Math::Abs(value) > 0.1f) {
				if (Setting_Keyboard_UseFillGradient) {
					nvg::FillPaint(Setting_Keyboard_FillGradient.GetPaint(vec2(), m_size));
				} else {
					nvg::FillColor(Setting_Keyboard_FillColor);
				}
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
			if (Setting_Keyboard_UseFillGradient) {
				nvg::FillPaint(Setting_Keyboard_FillGradient.GetPaint(vec2(), m_size));
			} else {
				nvg::FillColor(Setting_Keyboard_FillColor);
			}
			nvg::Fill();
			nvg::ResetScissor();
		}

		float fillAlpha;
		if (fillDir == 0) {
			fillAlpha = Math::Abs(value) > 0.1f ? 1.0f : Setting_Keyboard_InactiveAlpha;
		} else {
			fillAlpha = Math::Lerp(Setting_Keyboard_InactiveAlpha, 1.0f, value);
		}

		vec4 borderColor = Setting_Keyboard_BorderColor;
		borderColor.w *= fillAlpha;

		if (Setting_Keyboard_UseBorderGradient) {
			nvg::StrokePaint(Setting_Keyboard_BorderGradient.GetPaint(vec2(), m_size, fillAlpha));
		} else {
			nvg::StrokeColor(borderColor);
		}
		nvg::Stroke();

		vec4 textColor = Setting_Keyboard_TextColor;
		textColor.w *= fillAlpha;

		nvg::BeginPath();
		nvg::FontFace(m_font);
		nvg::FillColor(textColor);
		nvg::TextAlign(nvg::Align::Middle | nvg::Align::Center);
		if (Setting_Keyboard_SteerPercentage && fillDir != 0) {
			if (value > 0.0f) {
				nvg::FontSize(Setting_Keyboard_FontSize);
				nvg::TextBox(
					pos.x,
					pos.y + size.y / 2,
					size.x,
					Text::Format("%.f" + (Setting_Keyboard_SteerPercentageSymbol ? "%%" : ""), value * 100.0f)
				);
			}
		} else if (Setting_Keyboard_ArrowSymbols) {
			nvg::FontSize(Setting_Keyboard_FontSize * 1.5f);
			nvg::TextBox(pos.x, pos.y + size.y / 2, size.x, text);
		}
	}
}
