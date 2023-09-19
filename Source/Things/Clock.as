class DashboardClock : DashboardThing
{
	nvg::Font m_font;
	string m_fontPath;

	DashboardClock()
	{
		super("Clock");
		LoadFont();
	}

	bool IsVisible(bool whenHidden) override { return whenHidden ? Setting_General_ShowClockHidden : Setting_General_ShowClock; }
	void SetVisible(bool visible, bool visibleWhenHidden) override
	{
		Setting_General_ShowClock = visible;
		Setting_General_ShowClockHidden = visibleWhenHidden;
	}

	void UpdateProportions() override
	{
		m_pos = Setting_General_ClockPos;
		m_size = Setting_General_ClockSize;
	}

	void SetProportions(const vec2 &in pos, const vec2 &in size) override
	{
		Setting_General_ClockPos = pos;
		Setting_General_ClockSize = size;
	}

	void ResetProportions() override
	{
		auto plugin = Meta::ExecutingPlugin();
		plugin.GetSetting("Setting_General_ClockPos").Reset();
		plugin.GetSetting("Setting_General_ClockSize").Reset();
	}

	void LoadFont()
	{
		if (Setting_Clock_Font == m_fontPath) {
			return;
		}

		auto font = nvg::LoadFont(Setting_Clock_Font, true);
		if (font > 0) {
			m_fontPath = Setting_Clock_Font;
			m_font = font;
		}
	}

	void OnSettingsChanged() override
	{
		LoadFont();
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		string clockTime;

		switch (Setting_Clock_Mode){
			case ClockMode::LocalTime: clockTime = Time::FormatString(Setting_Clock_Format); break;
			case ClockMode::UTCTime: clockTime = Time::FormatStringUTC(Setting_Clock_Format); break;
		}

		switch (Setting_Clock_Icon) {
			case ClockIcon::Left: clockTime = Icons::ClockO + " " + clockTime; break;
			case ClockIcon::Right: clockTime = clockTime + " " + Icons::ClockO; break;
		}

		nvg::BeginPath();
		nvg::RoundedRect(0, 0, m_size.x, m_size.y, Setting_Clock_BorderRadius);

		nvg::FillColor(Setting_Clock_BackdropColor);
		nvg::Fill();

		nvg::StrokeColor(Setting_Clock_BorderColor);
		nvg::StrokeWidth(Setting_Clock_BorderWidth);
		nvg::Stroke();

		nvg::BeginPath();
		nvg::FontFace(m_font);
		nvg::FontSize(Setting_Clock_FontSize);
		nvg::FillColor(Setting_Clock_TextColor);

		nvg::TextAlign(nvg::Align::Middle | nvg::Align::Center);
		nvg::TextBox(0, m_size.y / 2, m_size.x, clockTime);
	}
}
