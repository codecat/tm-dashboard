class DashboardPadGamepad : DashboardThing
{
	DashboardPadGamepad()
	{
		super();
	}

	void RenderUniform(CSceneVehicleVisState@ vis)
	{
		const float offAlpha = 0.33f;

		vec4 strokeColor = Setting_Gamepad_BorderColor;
		vec4 fillColor = Setting_Gamepad_FillColor;

		float leftSize = m_size.x * (0.5f - Setting_Gamepad_MiddleScale / 2) - Setting_Gamepad_Spacing;
		float midX = leftSize + Setting_Gamepad_Spacing;
		float midSize = m_size.x * Setting_Gamepad_MiddleScale;
		float rightX = midX + midSize + Setting_Gamepad_Spacing;
		float rightSize = m_size.x - rightX;
		float topSize = m_size.y / 2 - (Setting_Gamepad_Spacing / 2);
		float bottomY = m_size.y / 2 + (Setting_Gamepad_Spacing / 2);
		float bottomSize = m_size.y - bottomY;

		nvg::StrokeWidth(Setting_Gamepad_BorderWidth);
		nvg::StrokeColor(strokeColor);
		nvg::LineJoin(nvg::LineCapType::Round);

		// Steering scales
		float steerLeft = vis.InputSteer < 0 ? Math::Abs(vis.InputSteer) : 0.0f;
		float steerRight = vis.InputSteer > 0 ? vis.InputSteer : 0.0f;
		float pedalGas = vis.InputGasPedal;
		float pedalBrake = vis.InputBrakePedal;

		// It's possible that the brake pedal value is not set (eg. during replay playback), but we do
		// have a binary value whether we're currently braking or not, so we use that to force the
		// pedal value.
		if (vis.InputIsBraking) {
			pedalBrake = 1.0f;
		}

		// Left
		nvg::BeginPath();
		nvg::MoveTo(vec2(0, m_size.y / 2));
		nvg::LineTo(vec2(leftSize, m_size.y * Setting_Gamepad_ArrowPadding));
		nvg::LineTo(vec2(leftSize, m_size.y - m_size.y * Setting_Gamepad_ArrowPadding));
		nvg::ClosePath();
		nvg::FillColor(Setting_Gamepad_EmptyFillColor);
		nvg::Fill();
		if (steerLeft > 0) {
			float valueWidth = steerLeft * leftSize;
			nvg::Scissor(leftSize - valueWidth, 0, valueWidth, m_size.y);
			nvg::FillColor(fillColor);
			nvg::Fill();
			nvg::ResetScissor();
		}
		nvg::Stroke();

		// Right
		nvg::BeginPath();
		nvg::MoveTo(vec2(rightX + rightSize, m_size.y / 2));
		nvg::LineTo(vec2(rightX, m_size.y * Setting_Gamepad_ArrowPadding));
		nvg::LineTo(vec2(rightX, m_size.y - m_size.y * Setting_Gamepad_ArrowPadding));
		nvg::ClosePath();
		nvg::FillColor(Setting_Gamepad_EmptyFillColor);
		nvg::Fill();
		if (steerRight > 0) {
			float valueWidth = steerRight * rightSize;
			nvg::Scissor(rightX, 0, valueWidth, m_size.y);
			nvg::FillColor(fillColor);
			nvg::Fill();
			nvg::ResetScissor();
		}
		nvg::Stroke();

		// Up
		nvg::BeginPath();
		nvg::RoundedRect(midX, 0, midSize, topSize, 5);
		nvg::FillColor(Setting_Gamepad_EmptyFillColor);
		nvg::Fill();
		if (pedalGas > 0) {
			float valueHeight = pedalGas * topSize;
			nvg::Scissor(midX, topSize - valueHeight, midSize, valueHeight);
			nvg::FillColor(fillColor);
			nvg::Fill();
			nvg::ResetScissor();
		}
		nvg::Stroke();

		// Down
		nvg::BeginPath();
		nvg::RoundedRect(midX, bottomY, midSize, bottomSize, 5);
		nvg::FillColor(Setting_Gamepad_EmptyFillColor);
		nvg::Fill();
		if (pedalBrake > 0) {
			float valueHeight = pedalBrake * bottomSize;
			nvg::Scissor(midX, bottomY, midSize, valueHeight);
			nvg::FillColor(fillColor);
			nvg::Fill();
			nvg::ResetScissor();
		}
		nvg::Stroke();

		// Up & Down texts
		nvg::BeginPath();
		nvg::FontFace(g_font);
		nvg::FontSize(midSize / 2);
		nvg::FillColor(strokeColor);
		nvg::TextAlign(nvg::Align::Middle | nvg::Align::Center);
		nvg::TextBox(midX, topSize / 2, midSize, Icons::AngleUp);
		nvg::TextBox(midX, bottomY + bottomSize / 2, midSize, Icons::AngleDown);
	}

	void RenderClassic(CSceneVehicleVisState@ vis)
	{
		const float offAlpha = 0.33f;

		const vec4 colorDown = vec4(1, 0.6f, 0.2f, 1);

		const vec4 colorSteeringOn = vec4(1, 0.2f, 0.6f, 1);
		const vec4 colorSteeringOff = vec4(1, 0.2f, 0.6f, offAlpha);

		auto posLeft = vec2(0, m_size.y / 2);
		auto posRight = vec2(m_size.x, m_size.y / 2);
		auto posTop = vec2(m_size.x / 2, 0);
		auto posBottom = vec2(m_size.x / 2, m_size.y);

		float leftSize = m_size.x * (0.5f - Setting_Gamepad_MiddleScale / 2) - Setting_Gamepad_Spacing;
		float midX = leftSize + Setting_Gamepad_Spacing;
		float midSize = m_size.x * Setting_Gamepad_MiddleScale;
		float rightX = midX + midSize + Setting_Gamepad_Spacing;
		float rightSize = m_size.x - rightX;

		nvg::BeginPath();
		nvg::MoveTo(posLeft);
		nvg::LineTo(posTop);
		nvg::LineTo(posRight);
		nvg::LineTo(posBottom);
		nvg::ClosePath();

		// Steering scales
		float steerLeft = vis.InputSteer < 0 ? Math::Abs(vis.InputSteer) : 0.0f;
		float steerRight = vis.InputSteer > 0 ? vis.InputSteer : 0.0f;

		// Left
		nvg::Scissor(0, 0, leftSize, m_size.y);
		if (steerLeft > 0) {
			auto v = vec2(leftSize - steerLeft * leftSize, 0);
			nvg::FillPaint(nvg::LinearGradient(v - vec2(1, 0), v, colorSteeringOff, colorSteeringOn));
		} else {
			nvg::FillColor(colorSteeringOff);
		}
		nvg::Fill();
		nvg::ResetScissor();

		// Right
		nvg::Scissor(rightX, 0, rightSize, m_size.y);
		if (steerRight > 0) {
			auto v = vec2(rightX + steerRight * rightSize, 0);
			nvg::FillPaint(nvg::LinearGradient(v, v + vec2(1, 0), colorSteeringOn, colorSteeringOff));
		} else {
			nvg::FillColor(colorSteeringOff);
		}
		nvg::Fill();
		nvg::ResetScissor();

		// Up
		nvg::Scissor(midX, 0, midSize, m_size.y / 2 - Setting_Gamepad_Spacing / 2);
		nvg::FillColor(WithAlpha(Setting_Gamepad_ClassicUpColor, vis.InputGasPedal > 0.1f ? 1.0f : offAlpha));
		nvg::Fill();
		nvg::ResetScissor();

		// Down
		nvg::Scissor(midX, m_size.y / 2 + Setting_Gamepad_Spacing / 2, midSize, m_size.y / 2 - Setting_Gamepad_Spacing / 2);
		nvg::FillColor(WithAlpha(Setting_Gamepad_ClassicDownColor, vis.InputBrakePedal > 0.1f ? 1.0f : offAlpha));
		nvg::Fill();
		nvg::ResetScissor();
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		switch (Setting_Gamepad_Style) {
			case GamepadStyle::Uniform: RenderUniform(vis); break;
			case GamepadStyle::Classic: RenderClassic(vis); break;
		}
	}

	vec4 WithAlpha(vec4 color, float alpha)
	{
		return vec4(
			color.x,
			color.y,
			color.z,
			color.w * alpha
		);
	}
}
