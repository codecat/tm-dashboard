#if !COMPETITION
class DashboardPadKeyboard : DashboardThing
{
	float m_keyLeftAnimFactor;
	float m_keyRightAnimFactor;
	float m_keyUpAnimFactor;
	float m_keyDownAnimFactor;
	float m_lastSteerValueLeft;
	float m_lastSteerValueRight;

	DashboardPadKeyboard()
	{
		super();
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		auto keySize = vec2(
			(m_size.x - Setting_Keyboard_Spacing * 2) / 3,
			(m_size.y - Setting_Keyboard_Spacing) / 2
		);

		float steerLeft = vis.InputSteer < 0 ? Math::Abs(vis.InputSteer) : 0.0f;
		float steerRight = vis.InputSteer > 0 ? vis.InputSteer : 0.0f;
		float inputUp = vis.InputGasPedal;
		float inputDown = vis.InputIsBraking ? 1.0f : vis.InputBrakePedal;

		if (Math::Abs(steerLeft) > 0.0f) {
			m_keyLeftAnimFactor = 1.0f;
			m_lastSteerValueLeft = steerLeft;
		}
		if (Math::Abs(steerRight) > 0.0f) {
			m_keyRightAnimFactor = 1.0f;
			m_lastSteerValueRight = steerRight;
		}
		if (Math::Abs(inputUp) > 0.1f) {
			m_keyUpAnimFactor = 1.0f;
		}
		if (Math::Abs(inputDown) > 0.1f) {
			m_keyDownAnimFactor = 1.0f;
		}

		RenderKey(vec2(keySize.x + Setting_Keyboard_Spacing, 0), keySize, Icons::AngleUp, inputUp, m_keyUpAnimFactor);
		RenderKey(vec2(keySize.x + Setting_Keyboard_Spacing, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleDown, inputDown, m_keyDownAnimFactor);

		RenderKey(vec2(0, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleLeft, steerLeft, m_keyLeftAnimFactor, -1, m_lastSteerValueLeft);
		RenderKey(vec2(keySize.x * 2 + Setting_Keyboard_Spacing * 2, keySize.y + Setting_Keyboard_Spacing), keySize, Icons::AngleRight, steerRight, m_keyRightAnimFactor, 1, m_lastSteerValueRight);
	}

	void RenderKey(const vec2 &in pos, const vec2 &in size, const string &in text, float currValue, float animFactor, int fillDir = 0, float lastActiveValue = 0.0f)
	{
		float animFactorShrink = 1.0f;
		float animFactorFade = 1.0f;
		switch (Setting_Keyboard_ReleaseAnimation) {
			case KeyboardAnimation::Shrink:
				animFactorShrink = animFactor;
				break;
			case KeyboardAnimation::Fade:
				animFactorFade = animFactor;
				break;
			case KeyboardAnimation::ShrinkAndFade:
				animFactorShrink = animFactor;
				animFactorFade = animFactor;
				break;
		}

		vec4 borderColor = Setting_Keyboard_BorderColor;
		if (fillDir == 0) {
			borderColor.w *= Math::Abs(currValue) > 0.1f ? 1.0f : Setting_Keyboard_InactiveAlpha;
		} else {
			borderColor.w *= Math::Lerp(Setting_Keyboard_InactiveAlpha, 1.0f, currValue);
		}

		nvg::BeginPath();
		SetNextShape(pos, size);
		nvg::FillColor(Setting_Keyboard_EmptyFillColor);
		nvg::Fill();

		nvg::BeginPath();
		SetNextShape(pos, size, animFactorShrink);

		vec4 fillColor = Setting_Keyboard_FillColor;
		fillColor.w *= animFactorFade;

		if ((Setting_Keyboard_ReleaseAnimation == KeyboardAnimation::None && currValue > 0.0f)
			|| (Setting_Keyboard_ReleaseAnimation != KeyboardAnimation::None && animFactor > 0.0f)) {
			if (fillDir == 0) {
				nvg::FillColor(fillColor);
				nvg::Fill();
			} else {
				float valueWidth = size.x * animFactorShrink * lastActiveValue;
				float posOffset = fillDir == 1 ? 0.0f : (size.x * animFactorShrink) - valueWidth;
				nvg::Scissor(
					pos.x + (0.5f * size.x * (1.0f - animFactorShrink)) + posOffset,
					pos.y + (0.5f * size.y * (1.0f - animFactorShrink)),
					valueWidth,
					size.y * animFactorShrink);
				nvg::FillColor(fillColor);
				nvg::Fill();
				nvg::ResetScissor();
			}
		}

		nvg::BeginPath();
		SetNextShape(pos, size);
		nvg::StrokeWidth(Setting_Keyboard_BorderWidth);
		nvg::StrokeColor(borderColor);
		nvg::Stroke();

		nvg::BeginPath();
		nvg::FontFace(g_font);
		nvg::FontSize(size.x / 2);
		nvg::FillColor(borderColor);
		nvg::TextAlign(nvg::Align::Middle | nvg::Align::Center);
		nvg::TextBox(pos.x, pos.y + size.y / 2, size.x, text);
	}

	void Update(float dt)
	{
		m_keyLeftAnimFactor = Math::Max(m_keyLeftAnimFactor - (dt / Setting_Keyboard_ReleaseAnimationLength), 0.0f);
		m_keyRightAnimFactor = Math::Max(m_keyRightAnimFactor - (dt / Setting_Keyboard_ReleaseAnimationLength), 0.0f);
		m_keyUpAnimFactor = Math::Max(m_keyUpAnimFactor - (dt / Setting_Keyboard_ReleaseAnimationLength), 0.0f);
		m_keyDownAnimFactor = Math::Max(m_keyDownAnimFactor - (dt / Setting_Keyboard_ReleaseAnimationLength), 0.0f);
	}

	void SetNextShape(const vec2 &in pos, const vec2 &in size, float scaleFactor = 1.0f)
	{
		switch (Setting_Keyboard_Shape) {
			case KeyboardShape::Rectangle:
				nvg::RoundedRect(
					pos.x + (0.5f * size.x * (1.0f - scaleFactor)),
					pos.y + (0.5f * size.y * (1.0f - scaleFactor)),
					size.x * scaleFactor,
					size.y * scaleFactor,
					Setting_Keyboard_BorderRadius);
				break;
			case KeyboardShape::Ellipse:
				nvg::Ellipse(pos + size / 2.0f, size.x / 2 * scaleFactor, size.y / 2.0f * scaleFactor);
				break;
		}
	}
}
#endif
