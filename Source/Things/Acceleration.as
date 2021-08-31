#if !COMPETITION
class DashboardAcceleration : DashboardThing
{
	float prev_speed = 0;
	int arr_size = 4;
	array<float> acc = {0, 0, 0, 0};
	int idx = 0;

	DashboardAcceleration()
	{
	}

	void OnSettingsChanged() override
	{
	}

	void RenderAccelerometer(const vec2 &in pos, const vec2 &in size, float acc)
	{
		vec2 psize = vec2(size.x, size.y/2);
		vec2 npos = vec2(pos.x, pos.y);
		float accHeight = (acc / Setting_Acceleration_MaximumAcceleration) * psize.y;
		
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
		nvg::RoundedRect(pos.x, pos.y + Setting_Acceleration_BarPadding, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::StrokeWidth(Setting_Acceleration_BorderWidth);
		nvg::StrokeColor(Setting_Acceleration_BorderColor);
		nvg::FillColor(Setting_Acceleration_BackdropColor);
		nvg::Fill();
		
		if (accHeight >= 0) {
			nvg::Scissor(pos.x, pos.y + Setting_Acceleration_BarPadding, psize.x, accHeight * 1.0f);
			nvg::FillColor(Setting_Acceleration_Positive_Color);
			nvg::Fill();
			nvg::ResetScissor();
		}
		
		// Positive acc border
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y + Setting_Acceleration_BarPadding, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::Stroke();
		
		nvg::Restore();

		if (Setting_Acceleration_ShowTextValue) {
			float textSize = (size.x - Setting_Acceleration_TextPadding * 3) / 3;
			nvg::FontSize(Setting_Acceleration_FontSize);
			nvg::FillColor(Setting_Acceleration_TextColor);
			nvg::TextBox(textSize, (size.y / 4) - Setting_Acceleration_BarPadding, Setting_Acceleration_TextPadding * 3, Icons::AngleDoubleUp + "\n" + Text::Format("%.2f", acc > 0 ? acc : 0));
			nvg::TextBox(textSize, (size.y / 1.33), Setting_Acceleration_TextPadding * 3, Icons::AngleDoubleDown + "\n" + Text::Format("%.2f", acc < 0 ? Math::Abs(acc) : 0));
		}
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		float speed = vis.FrontSpeed;
		float curr_acc = ((speed - prev_speed) / (g_dt/1000));
		prev_speed = speed;

		vec2 offset = vec2(0.0f, 0.0f);
		vec2 size = m_size;

		if (Setting_Acceleration_Smoothing)
		{
			acc[idx] = curr_acc;
			idx = (idx + 1) % arr_size;
			float sum = 0;
			for(int n = 0; n < arr_size; n++)
				sum += acc[n];

			RenderAccelerometer(offset, size, sum / arr_size);
		}
		else
		{
			RenderAccelerometer(offset, size, curr_acc);
		}
		
	}
}
#endif
