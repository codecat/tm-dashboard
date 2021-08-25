#if !COMPETITION
class DashboardAcceleration : DashboardThing
{
	DashboardAcceleration()
	{
	}

	void OnSettingsChanged() override
	{
	}

	void RenderAcceleratorMeter(const vec2 &in pos, const vec2 &in size, float acc)
	{
		vec2 psize = vec2(size.x, size.y/2);
		vec2 npos = vec2(pos.x, pos.y);
		float displayAcc = acc * 3.6f;
		float accHeight = (acc / Setting_Acceleration_MaxAcceleration) * psize.y * Setting_Acceleration_ZoomFactor;
		
		nvg::Save();
		// Negative acc backdrop
		nvg::BeginPath();
		nvg::Translate(0, psize.y);
		nvg::RoundedRect(npos.x, npos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::StrokeWidth(Setting_Acceleration_BorderWidth);
		nvg::StrokeColor(Setting_Acceleration_BorderColor);
		nvg::FillColor(Setting_Acceleration_BackdropColor);
		nvg::Fill();
		
		if (accHeight < 0) {
			nvg::Scissor(npos.x, npos.y, psize.x, accHeight * -1.0f);
			nvg::FillColor(Setting_Acceleration_Negative_Color);
			nvg::Fill();
			nvg::ResetScissor();
		}
		
		// Negative acc border
		nvg::BeginPath();
		nvg::RoundedRect(npos.x, npos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::Stroke();

		// Positive acc backdrop
		nvg::BeginPath();
		nvg::Scale(1,-1);
		nvg::RoundedRect(pos.x, pos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::StrokeWidth(Setting_Acceleration_BorderWidth);
		nvg::StrokeColor(Setting_Acceleration_BorderColor);
		nvg::FillColor(Setting_Acceleration_BackdropColor);
		nvg::Fill();
		
		if (accHeight >= 0) {
			nvg::Scissor(pos.x, pos.y, psize.x, accHeight * 1.0f);
			nvg::FillColor(Setting_Acceleration_Positive_Color);
			nvg::Fill();
			nvg::ResetScissor();
		}
		
		// Positive acc border
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::Stroke();
		
		nvg::Restore();

		if (Setting_Acceleration_ShowTextValue) {
			float textSize = (m_size.x - Setting_Acceleration_Padding * 2) / 2;
			nvg::FontSize(Setting_Acceleration_FontSize);
			nvg::FillColor(Setting_Acceleration_TextColor);
			nvg::TextBox(textSize, m_size.y / 4, Setting_Acceleration_Padding * 2, Icons::AngleDoubleUp + " " + Text::Format("%.2f", displayAcc > 0 ? displayAcc : 0));
			nvg::TextBox(textSize, m_size.y / 1.33, Setting_Acceleration_Padding * 2, Icons::AngleDoubleDown + " " + Text::Format("%.2f", displayAcc < 0 ? Math::Abs(displayAcc) : 0));
		}
	}

	void RenderAcceleratorMeterHorizontal(const vec2 &in pos, const vec2 &in size, float acc)
	{
		vec2 psize = vec2(size.x/2, size.y);
		vec2 npos = vec2(pos.x, pos.y);
		float displayAcc = acc * 3.6f;
		float accWidth = (acc / Setting_Acceleration_MaxAcceleration) * psize.x * Setting_Acceleration_ZoomFactor;
		
		nvg::Save();
		// Positive acc backdrop
		nvg::BeginPath();
		nvg::Translate(psize.x, 0);
		nvg::RoundedRect(npos.x, npos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::StrokeWidth(Setting_Acceleration_BorderWidth);
		nvg::StrokeColor(Setting_Acceleration_BorderColor);
		nvg::FillColor(Setting_Acceleration_BackdropColor);
		nvg::Fill();
		
		if (accWidth >= 0) {
			nvg::Scissor(npos.x, npos.y, accWidth * 1.0f, psize.y);
			nvg::FillColor(Setting_Acceleration_Positive_Color);
			nvg::Fill();
			nvg::ResetScissor();
		}
		
		// Positive acc border
		nvg::BeginPath();
		nvg::RoundedRect(npos.x, npos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::Stroke();

		// Negative acc backdrop
		nvg::BeginPath();
		nvg::Scale(-1, 1);
		nvg::RoundedRect(pos.x, pos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::StrokeWidth(Setting_Acceleration_BorderWidth);
		nvg::StrokeColor(Setting_Acceleration_BorderColor);
		nvg::FillColor(Setting_Acceleration_BackdropColor);
		nvg::Fill();
		
		if (accWidth < 0) {
			nvg::Scissor(pos.x, pos.y, accWidth * -1.0f, psize.y);
			nvg::FillColor(Setting_Acceleration_Negative_Color);
			nvg::Fill();
			nvg::ResetScissor();
		}
		
		// Negative acc border
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::Stroke();
		
		nvg::Restore();

        if (Setting_Acceleration_ShowTextValue) {
			float textSize = (m_size.x - Setting_Acceleration_Padding * 2) / 2;
			nvg::FontSize(Setting_Acceleration_FontSize);
			nvg::FillColor(Setting_Acceleration_TextColor);
			nvg::TextBox(Setting_Acceleration_Padding+textSize, m_size.y / 2, textSize, Icons::AngleDoubleUp + " " + Text::Format("%.2f", displayAcc > 0 ? displayAcc : 0));
			nvg::TextBox(Setting_Acceleration_Padding, m_size.y / 2, textSize, Icons::AngleDoubleDown + " " + Text::Format("%.2f", displayAcc < 0 ? Math::Abs(displayAcc) : 0));
		}
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		float speed = vis.FrontSpeed;
		float curr_acc = speed - g_prev_speed;
		g_prev_speed = speed;

		vec2 offset = vec2(0.0f, 0.0f);
		vec2 size = m_size;

		RenderAcceleratorMeter(offset, size, curr_acc);
	}
}
#endif
