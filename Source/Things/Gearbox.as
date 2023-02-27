class DashboardGearbox : DashboardThing
{
	float m_minRpm = 200.0f; // Minimal RPM to avoid flickering at engine idle
	float m_maxRpm = 11000.0f;

	nvg::Font m_font;
	string m_fontPath;

	DashboardGearbox()
	{
		super("Gearbox");
		LoadFont();
	}

	bool IsVisible(bool whenHidden) override { return whenHidden ? Setting_General_ShowGearboxHidden : Setting_General_ShowGearbox; }
	void SetVisible(bool visible, bool visibleWhenHidden) override
	{
		Setting_General_ShowGearbox = visible;
		Setting_General_ShowGearboxHidden = visibleWhenHidden;
	}

	void UpdateProportions() override
	{
		m_pos = Setting_General_GearboxPos;
		m_size = Setting_General_GearboxSize;
	}

	void SetProportions(const vec2 &in pos, const vec2 &in size) override
	{
		Setting_General_GearboxPos = pos;
		Setting_General_GearboxSize = size;
	}

	void ResetProportions() override
	{
		auto plugin = Meta::ExecutingPlugin();
		plugin.GetSetting("Setting_General_GearboxPos").Reset();
		plugin.GetSetting("Setting_General_GearboxSize").Reset();
	}

	void LoadFont()
	{
		if (Setting_Gearbox_Font == m_fontPath) {
			return;
		}

		auto font = nvg::LoadFont(Setting_Gearbox_Font);
		if (font > 0) {
			m_fontPath = Setting_Gearbox_Font;
			m_font = font;
		}
	}

	void OnSettingsChanged() override
	{
		LoadFont();
	}

	void RenderNumbers(const vec2 &in pos, const vec2 &in size, uint gear, float rpm)
	{
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Gearbox_BorderRadius);
		nvg::StrokeWidth(Setting_Gearbox_BorderWidth);

		nvg::StrokeColor(Setting_Gearbox_BorderColor);
		nvg::FillColor(Setting_Gearbox_BackdropColor);

		nvg::Fill();
		nvg::Stroke();

		vec4 textColor = Setting_Gearbox_TextColor;
		if (Setting_Gearbox_UseGearColors) {

			switch (gear) {
				case 0: textColor = Setting_Gearbox_Gear0Color; break;
				case 1: textColor = Setting_Gearbox_Gear1Color; break;
				case 2: textColor = Setting_Gearbox_Gear2Color; break;
				case 3: textColor = Setting_Gearbox_Gear3Color; break;
				case 4: textColor = Setting_Gearbox_Gear4Color; break;
				case 5: textColor = Setting_Gearbox_Gear5Color; break;
				#if TM4 || TURBO
					case 6: textColor = Setting_Gearbox_Gear6Color; break;
					case 7: textColor = Setting_Gearbox_Gear7Color; break;
				#endif
				#if TURBO
					case 8: textColor = Setting_Gearbox_Gear8Color; break;
					case 9: textColor = Setting_Gearbox_Gear9Color; break;
				#endif
			}
		}
		nvg::FontFace(m_font);
		nvg::FillColor(textColor);
		nvg::TextAlign(nvg::Align::Middle | nvg::Align::Center);

		float gearY = 0.37f;
		float rpmY = 0.75f;
		if (!Setting_Gearbox_ShowRPMText) {
			gearY = 0.5f;
		}

		nvg::BeginPath();
		nvg::FontSize(24);
		nvg::TextBox(0, size.y * gearY, size.x, "" + gear);

		if (Setting_Gearbox_ShowRPMText) {
			nvg::BeginPath();
			nvg::FontSize(16);
			nvg::TextBox(0, size.y * rpmY, size.x, Text::Format("%.01f", rpm / 1000.0f) + "k");
		}
	}

	void RenderTachometer(const vec2 &in pos, const vec2 &in size, float rpm)
	{
		float rpmWidth = rpm / m_maxRpm * size.x;
		float downWidth = Setting_Gearbox_Downshift / m_maxRpm * size.x;
		float upWidth = (m_maxRpm - Setting_Gearbox_Upshift) / m_maxRpm * size.x;
		float midWidth = size.x - downWidth - upWidth;

		// Backdrop
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Gearbox_BorderRadius);
		nvg::StrokeWidth(Setting_Gearbox_BorderWidth);

		nvg::StrokeColor(Setting_Gearbox_BorderColor);
		nvg::FillColor(Setting_Gearbox_BackdropColor);

		nvg::Fill();

		switch (Setting_Gearbox_TachometerStyle) {
			case GearboxTachometerStyle::Bar: {
				// Low RPM
				if (rpm > m_minRpm) {
					nvg::Scissor(pos.x, pos.y, Math::Min(rpmWidth, downWidth), size.y);
					nvg::FillColor(Setting_Gearbox_LowRPMColor);
					nvg::Fill();
					nvg::ResetScissor();
				}

				// Mid RPM
				if (rpm > Setting_Gearbox_Downshift) {
					nvg::Scissor(pos.x + downWidth, pos.y, Math::Min(rpmWidth - downWidth, midWidth), size.y);
					nvg::FillColor(Setting_Gearbox_MidRPMColor);
					nvg::Fill();
					nvg::ResetScissor();
				}

				// High RPM
				if (rpm > Setting_Gearbox_Upshift) {
					nvg::Scissor(pos.x + downWidth + midWidth, pos.y, Math::Min(rpmWidth - downWidth - midWidth, upWidth), size.y);
					nvg::FillColor(Setting_Gearbox_HighRPMColor);
					nvg::Fill();
					nvg::ResetScissor();
				}
				break;
			}

			case GearboxTachometerStyle::Dots: {
				const vec2 dotSpacing = vec2(12.0f, 20.0f);
				float dotSize = size.y - dotSpacing.y * 2;
				float dotSpace = dotSize + dotSpacing.x;
				int numDots = int((size.x - dotSpacing.x) / dotSpace);

				for (int i = 0; i < numDots; i++) {
					float scaledRpm = i / float(numDots) * m_maxRpm;

					nvg::BeginPath();
					nvg::Circle(vec2(pos.x + (i + 0.5f) * dotSpace + dotSpacing.x, size.y / 2), dotSize / 2);
					if (rpm > m_minRpm && rpm >= scaledRpm) {
						if (scaledRpm <= Setting_Gearbox_Downshift) {
							nvg::FillColor(Setting_Gearbox_LowRPMColor);
						} else if (scaledRpm <= Setting_Gearbox_Upshift) {
							nvg::FillColor(Setting_Gearbox_MidRPMColor);
						} else {
							nvg::FillColor(Setting_Gearbox_HighRPMColor);
						}
					} else {
						nvg::FillColor(Setting_Gearbox_BackdropColor);
					}
					nvg::Fill();
				}
				break;
			}

			case GearboxTachometerStyle::Blocks: {
				const float blockPadding = 8.0f;
				const float blockSpacing = 4.0f;
				vec2 blockSize = vec2(6, size.y - blockPadding * 2);
				float blockSpace = blockSize.x + blockSpacing;
				int numDots = int((size.x - blockPadding) / blockSpace);

				for (int i = 0; i < numDots; i++) {
					float scaledRpm = i / float(numDots) * m_maxRpm;

					nvg::BeginPath();
					nvg::RoundedRect(pos.x + i * blockSpace + blockPadding, pos.y + blockPadding, blockSize.x, blockSize.y, 4);
					if (rpm > m_minRpm && rpm >= scaledRpm) {
						if (scaledRpm <= Setting_Gearbox_Downshift) {
							nvg::FillColor(Setting_Gearbox_LowRPMColor);
						} else if (scaledRpm <= Setting_Gearbox_Upshift) {
							nvg::FillColor(Setting_Gearbox_MidRPMColor);
						} else {
							nvg::FillColor(Setting_Gearbox_HighRPMColor);
						}
					} else {
						nvg::FillColor(Setting_Gearbox_BackdropColor);
					}
					nvg::Fill();
				}
				break;
			}
		}

		// Border
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Gearbox_BorderRadius);
		nvg::Stroke();
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		uint gear = vis.CurGear;
		float rpm = VehicleState::GetRPM(vis);

		vec2 offset;
		vec2 size = m_size;

		if (Setting_Gearbox_ShowText) {
			vec2 numbersSize(size.y, size.y);
			if (!Setting_Gearbox_ShowTachometer) {
				numbersSize.x = size.x;
			}

			RenderNumbers(offset, numbersSize, gear, rpm);

			offset.x += size.y + Setting_Gearbox_Spacing;
			size.x -= size.y + Setting_Gearbox_Spacing;
		}

		if (Setting_Gearbox_ShowTachometer) {
			RenderTachometer(offset, size, rpm);
		}
	}
}
