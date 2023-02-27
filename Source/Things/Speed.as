class DashboardSpeed : DashboardThing
{
	nvg::Font m_font;
	string m_fontPath;

	DashboardSpeed()
	{
		super("Speed");
		LoadFont();
	}

	bool IsVisible(bool whenHidden) override { return whenHidden ? Setting_General_ShowSpeedHidden : Setting_General_ShowSpeed; }
	void SetVisible(bool visible, bool visibleWhenHidden) override
	{
		Setting_General_ShowSpeed = visible;
		Setting_General_ShowSpeedHidden = visibleWhenHidden;
	}

	void UpdateProportions() override
	{
		m_pos = Setting_General_SpeedPos;
		m_size = Setting_General_SpeedSize;
	}

	void SetProportions(const vec2 &in pos, const vec2 &in size) override
	{
		Setting_General_SpeedPos = pos;
		Setting_General_SpeedSize = size;
	}

	void ResetProportions() override
	{
		auto plugin = Meta::ExecutingPlugin();
		plugin.GetSetting("Setting_General_SpeedPos").Reset();
		plugin.GetSetting("Setting_General_SpeedSize").Reset();
	}

	void LoadFont()
	{
		if (Setting_Speed_Font == m_fontPath) {
			return;
		}

		auto font = nvg::LoadFont(Setting_Speed_Font, true);
		if (font > 0) {
			m_fontPath = Setting_Speed_Font;
			m_font = font;
		}
	}

	void OnSettingsChanged() override
	{
		LoadFont();
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		float displaySpeed;
		switch (Setting_Speed_Value) {
			case SpeedValue::FrontSpeed: displaySpeed = vis.FrontSpeed * 3.6f; break;
			case SpeedValue::Velocity: displaySpeed = vis.WorldVel.Length() * 3.6f; break;
		}

		// Avoid flickering negative sign
		if (displaySpeed < 0 && displaySpeed > -0.99f) {
			displaySpeed = 0;
		}

		nvg::BeginPath();
		nvg::RoundedRect(0, 0, m_size.x, m_size.y, Setting_Speed_BorderRadius);

		nvg::FillColor(Setting_Speed_BackdropColor);
		nvg::Fill();

		nvg::StrokeColor(Setting_Speed_BorderColor);
		nvg::StrokeWidth(Setting_Speed_BorderWidth);
		nvg::Stroke();

		nvg::BeginPath();
		nvg::FontFace(m_font);
		nvg::FontSize(Setting_Speed_FontSize);
		nvg::FillColor(Setting_Speed_TextColor);

		switch (Setting_Speed_Style) {
			case SpeedStyle::Single: {
				nvg::TextAlign(nvg::Align::Middle | nvg::Align::Center);
				nvg::TextBox(Setting_Speed_Padding, m_size.y / 2, m_size.x - Setting_Speed_Padding * 2, Text::Format("%.0f", displaySpeed));
				break;
			}

			case SpeedStyle::Double: {
				float textSize = (m_size.x - Setting_Speed_Padding * 2) / 2;
				nvg::TextAlign(nvg::Align::Middle | nvg::Align::Left);
				nvg::TextBox(Setting_Speed_Padding, m_size.y / 2, textSize, Icons::AngleDoubleUp + " " + Text::Format("%.0f", displaySpeed));

				float sideSpeed = VehicleState::GetSideSpeed(vis) * 3.6f;
				// Avoid flickering negative sign
				if (sideSpeed < 0 && sideSpeed > -0.99f) {
					sideSpeed = 0;
				}
				nvg::TextBox(Setting_Speed_Padding + textSize, m_size.y / 2, textSize, Icons::AngleDoubleRight + " " + Text::Format("%.0f", sideSpeed));
				break;
			}

			case SpeedStyle::Directional: {
				float sideSpeed = VehicleState::GetSideSpeed(vis) * 3.6f;
				float absSpeed = Math::Sqrt(Math::Pow(sideSpeed, 2) + Math::Pow(vis.FrontSpeed * 3.6f, 2));

				float textSize = (m_size.x - Setting_Speed_Padding * 2) / 2;
				nvg::TextAlign(nvg::Align::Middle | nvg::Align::Left);
				nvg::TextBox(Setting_Speed_Padding, m_size.y / 2, textSize, Icons::ArrowUp + " " + Text::Format("%.0f", absSpeed));
				float carAngle = 0;
				if (absSpeed != 0) {
					carAngle = Math::Abs((Math::Asin(vis.FrontSpeed * 3.6f / absSpeed) * 57) - 90);
				}
				// Avoid flickering negative sign
				if (absSpeed < 0.99f && absSpeed > -0.99f) {
					carAngle = 0;
				}
				nvg::TextBox(Setting_Speed_Padding + textSize, m_size.y / 2, textSize, Icons::Repeat + " " + Text::Format("%.0f", carAngle));
				break;
			}
		}
	}
}
