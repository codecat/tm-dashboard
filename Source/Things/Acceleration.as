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

	void RenderNegativeAccelerometer(const vec2 &in pos, const vec2 &in size, float acc)
	{
		vec2 psize = vec2(size.x, size.y/2);
		vec2 npos = vec2(pos.x, pos.y);
		float accHeight = (acc / Setting_Acceleration_MaximumAcceleration) * psize.y;

		nvg::Save();
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

		nvg::BeginPath();
		nvg::RoundedRect(npos.x, npos.y, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::Stroke();

		nvg::Restore();

		if (Setting_Acceleration_ShowTextValue) {
			float text_x_pos = pos.x + (psize.x / 2) - Setting_Acceleration_TextPadding*1.5;
			float text_y_pos_negative = npos.y + psize.y * 1.5;
			nvg::FontSize(Setting_Acceleration_FontSize);
			nvg::FillColor(Setting_Acceleration_TextColor);
			nvg::TextBox(text_x_pos, text_y_pos_negative, Setting_Acceleration_TextPadding * 3, Icons::AngleDoubleDown + "\n" + Text::Format("%.2f", acc < 0 ? Math::Abs(acc) : 0));
		}
		
	}

	void RenderPositiveAccelerometer(const vec2 &in pos, const vec2 &in size, float acc)
	{
		vec2 psize = vec2(size.x, size.y/2);
		float accHeight = (acc / Setting_Acceleration_MaximumAcceleration) * psize.y;

		nvg::Save();
		nvg::BeginPath();

		nvg::Translate(0, psize.y);
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

		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y + Setting_Acceleration_BarPadding, psize.x, psize.y, Setting_Acceleration_BorderRadius);
		nvg::Stroke();
		nvg::Restore();

		if (Setting_Acceleration_ShowTextValue) {
			float text_x_pos = pos.x + (psize.x / 2) - Setting_Acceleration_TextPadding*1.5;
			float text_y_pos_positive = pos.y + (psize.y / 2) - Setting_Acceleration_BarPadding;
			nvg::FontSize(Setting_Acceleration_FontSize);
			nvg::FillColor(Setting_Acceleration_TextColor);
			nvg::TextBox(text_x_pos, text_y_pos_positive, Setting_Acceleration_TextPadding * 3, Icons::AngleDoubleUp + "\n" + Text::Format("%.2f", acc > 0 ? acc : 0));
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
			float avg = sum / arr_size;
			RenderPositiveAccelerometer(offset, size, avg);
			RenderNegativeAccelerometer(offset, size, avg);
		}
		else
		{
			RenderPositiveAccelerometer(offset, size, curr_acc);
			RenderNegativeAccelerometer(offset, size, curr_acc);
		}
		
	}
}
#endif
