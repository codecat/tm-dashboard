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
		float accWidth = (acc / Setting_Acceleration_MaxAcceleration) * size.x * Setting_Acceleration_ZoomFactor;
		// Backdrop
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Acceleration_BorderRadius);
		nvg::StrokeWidth(Setting_Acceleration_BorderWidth);

		nvg::StrokeColor(Setting_Acceleration_BorderColor);
		nvg::FillColor(Setting_Acceleration_BackdropColor);
		nvg::Fill();

		float multiplier = accWidth < 0 ? -1.0f : 1.0f;
		vec4 activeColor = accWidth < 0 ? Setting_Acceleration_Negative_Color : Setting_Acceleration_Positive_Color;
		
		nvg::Scissor(pos.x, pos.y, accWidth * multiplier, size.y);
		nvg::FillColor(activeColor);
		nvg::Fill();
		nvg::ResetScissor();

		// Border
		nvg::BeginPath();
		nvg::RoundedRect(pos.x, pos.y, size.x, size.y, Setting_Acceleration_BorderRadius);
		nvg::Stroke();
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
