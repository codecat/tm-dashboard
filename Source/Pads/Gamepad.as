class DashboardPadGamepad : DashboardThing
{
	DashboardPadGamepad()
	{
		super();
	}

	void RenderUniform(CSceneVehicleVisState@ vis)
	{
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
		if (Setting_Gamepad_UpDownSymbols) {
			nvg::BeginPath();
			nvg::FontFace(g_font);
			nvg::FontSize(midSize / 2);
			nvg::FillColor(strokeColor);
			nvg::TextAlign(nvg::Align::Middle | nvg::Align::Center);
			nvg::TextBox(midX, topSize / 2, midSize, Icons::AngleUp);
			nvg::TextBox(midX, bottomY + bottomSize / 2, midSize, Icons::AngleDown);
		}
	}

	void RenderClassic(CSceneVehicleVisState@ vis)
	{
		const vec4 colorSteeringOn = Setting_Gamepad_FillColor;
		const vec4 colorSteeringOff = WithAlpha(Setting_Gamepad_FillColor, Setting_Gamepad_OffAlpha);

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
		float pedalGas = vis.InputGasPedal;
		float pedalBrake = vis.InputBrakePedal;

		// It's possible that the brake pedal value is not set (eg. during replay playback), but we do
		// have a binary value whether we're currently braking or not, so we use that to force the
		// pedal value.
		if (vis.InputIsBraking) {
			pedalBrake = 1.0f;
		}

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
		nvg::FillColor(WithAlpha(Setting_Gamepad_ClassicUpColor, pedalGas > 0.1f ? 1.0f : Setting_Gamepad_OffAlpha));
		nvg::Fill();
		nvg::ResetScissor();

		// Down
		nvg::Scissor(midX, m_size.y / 2 + Setting_Gamepad_Spacing / 2, midSize, m_size.y / 2 - Setting_Gamepad_Spacing / 2);
		nvg::FillColor(WithAlpha(Setting_Gamepad_ClassicDownColor, pedalBrake > 0.1f ? 1.0f : Setting_Gamepad_OffAlpha));
		nvg::Fill();
		nvg::ResetScissor();
	}

	void RenderCateye(CSceneVehicleVisState@ vis)
	{
		nvg::StrokeWidth(Setting_Gamepad_BorderWidth);
		nvg::StrokeColor(Setting_Gamepad_BorderColor);
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

		auto posLeft = vec2(0, m_size.y / 2);
		auto posRight = vec2(m_size.x, m_size.y / 2);
		auto posTop = vec2(m_size.x / 2, 0);
		auto posBottom = vec2(m_size.x / 2, m_size.y);

		float leftInflectionX = (m_size.x / 2) - (m_size.x / 2 * Setting_Gamepad_MiddleScale);
		float leftSteerX = (1.0 - steerLeft) * leftInflectionX;
		float midX_Left = (m_size.x / 2) - (m_size.x / 2 * Setting_Gamepad_MiddleScale * ((100.0f - Setting_Gamepad_Spacing) / 100.0f));
		float midX_Right = (m_size.x / 2) + (m_size.x / 2 * Setting_Gamepad_MiddleScale * ((100.0f - Setting_Gamepad_Spacing) / 100.0f));
		float rightInflectionX = (m_size.x / 2) + (m_size.x / 2 * Setting_Gamepad_MiddleScale);
		float rightSteerX = rightInflectionX + (steerRight * (m_size.x - rightInflectionX));
		float midY_Top = Setting_Gamepad_Spacing / 100.0f * m_size.y / 2;
		float midY_Bot = m_size.y - midY_Top;
		float midY_TopInflection = (m_size.y / 2) - ((((m_size.y / 2) - midY_Top) * 2) * Setting_Gamepad_ArrowPadding);
		float midY_BotInflection = (m_size.y / 2) + ((((m_size.y / 2) - midY_Top) * 2) * Setting_Gamepad_ArrowPadding);

		vec2 posLeftInflection = vec2(leftInflectionX, m_size.y / 2);
		vec2 posRightInflection = vec2(rightInflectionX, m_size.y / 2);
		vec2 posLeftSteer = vec2(leftSteerX, m_size.y / 2);
		vec2 posRightSteer = vec2(rightSteerX, m_size.y / 2);
		vec2 posMidLeft = vec2(midX_Left, m_size.y / 2);
		vec2 posMidRight = vec2(midX_Right, m_size.y / 2);
		vec2 posMidTop = vec2(m_size.x / 2, midY_Top);
		vec2 posMidBot = vec2(m_size.x / 2, midY_Bot);
		vec2 posTopInflection = vec2(m_size.x / 2, midY_TopInflection);
		vec2 posBotInflection = vec2(m_size.x / 2, midY_BotInflection);

		// Left
		if (Setting_Gamepad_CateyeUseSimpleSteer && steerLeft > 0) {
			auto v = vec2((m_size.x / 2) - steerLeft * (m_size.x / 2), 0);
			nvg::FillPaint(nvg::LinearGradient(v - vec2(1, 0), v, Setting_Gamepad_EmptyFillColor, Setting_Gamepad_FillColor));
		} else {
			nvg::FillColor(Setting_Gamepad_EmptyFillColor);
		}
		FillInflectedTriangle(posLeft, posLeftInflection, posTop, posBottom);
		if (!Setting_Gamepad_CateyeUseSimpleSteer) {
			nvg::FillColor(Setting_Gamepad_FillColor);
			FillInflectedTriangle(posLeftSteer, posLeftInflection, posTop, posBottom);
		}
		StrokeInflectedTriangle(posLeft, posLeftInflection, posTop, posBottom);

		// Right
		if (Setting_Gamepad_CateyeUseSimpleSteer && steerRight > 0) {
			auto v = vec2((m_size.x / 2) + steerRight * (m_size.x / 2), 0);
			nvg::FillPaint(nvg::LinearGradient(v, v + vec2(1, 0), Setting_Gamepad_FillColor, Setting_Gamepad_EmptyFillColor));
		} else {
			nvg::FillColor(Setting_Gamepad_EmptyFillColor);
		}
		FillInflectedTriangle(posRight, posRightInflection, posTop, posBottom);
		if (!Setting_Gamepad_CateyeUseSimpleSteer) {
			nvg::FillColor(Setting_Gamepad_FillColor);
			FillInflectedTriangle(posRightSteer, posRightInflection, posTop, posBottom);
		}
		StrokeInflectedTriangle(posRight, posRightInflection, posTop, posBottom);

		// Up
		nvg::FillColor(pedalGas > 0.1f ? Setting_Gamepad_FillColor : Setting_Gamepad_EmptyFillColor);
		FillInflectedTriangle(posMidTop, posTopInflection, posMidLeft, posMidRight);
		StrokeInflectedTriangle(posMidTop, posTopInflection, posMidLeft, posMidRight);

		// Down
		nvg::FillColor(pedalBrake > 0.1f ? Setting_Gamepad_FillColor : Setting_Gamepad_EmptyFillColor);
		FillInflectedTriangle(posMidBot, posBotInflection, posMidLeft, posMidRight);
		StrokeInflectedTriangle(posMidBot, posBotInflection, posMidLeft, posMidRight);
	}

	private void FillInflectedTriangle(vec2 posApex, vec2 posInflection, vec2 posSide1, vec2 posSide2)
	{
		if (Math::Abs(posApex.x - posInflection.x) < 0.01f && Math::Abs(posApex.y - posInflection.y) < 0.01f) return;
		nvg::BeginPath();
		nvg::MoveTo(posApex);
		nvg::LineTo(posSide1);
		nvg::LineTo(posInflection);
		nvg::ClosePath();
		nvg::Fill();
		nvg::BeginPath();
		nvg::MoveTo(posApex);
		nvg::LineTo(posSide2);
		nvg::LineTo(posInflection);
		nvg::ClosePath();
		nvg::Fill();
	}

	private void StrokeInflectedTriangle(vec2 posApex, vec2 posInflection, vec2 posSide1, vec2 posSide2)
	{
		nvg::BeginPath();
		nvg::MoveTo(posApex);
		nvg::LineTo(posSide1);
		nvg::LineTo(posInflection);
		nvg::LineTo(posSide2);
		nvg::ClosePath();
		nvg::Stroke();
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		switch (Setting_Gamepad_Style) {
			case GamepadStyle::Uniform: RenderUniform(vis); break;
			case GamepadStyle::Classic: RenderClassic(vis); break;
			case GamepadStyle::Cateye: RenderCateye(vis); break;
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
