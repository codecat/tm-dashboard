interface IDashboardPad
{
	void Render(const vec2 &in size, CSceneVehicleVisState@ vis);
}

class DashboardPadHost : DashboardThing
{
	CInputScriptPad::EPadType m_currentPadType = CInputScriptPad::EPadType(-1);

	IDashboardPad@ m_pad = null;

	DashboardPadHost()
	{
		super("Controller/pad");
	}

	bool IsVisible(bool whenHidden) override { return whenHidden ? Setting_General_ShowPadHidden : Setting_General_ShowPad; }
	void SetVisible(bool visible, bool visibleWhenHidden) override
	{
		Setting_General_ShowPad = visible;
		Setting_General_ShowPadHidden = visibleWhenHidden;
	}

	void UpdateProportions() override
	{
		m_pos = Setting_General_PadPos;
		m_size = Setting_General_PadSize;
	}

	void SetProportions(const vec2 &in pos, const vec2 &in size) override
	{
		Setting_General_PadPos = pos;
		Setting_General_PadSize = size;
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		if (m_pad !is null) {
			m_pad.Render(m_size, vis);
		}
	}

	void UpdateAsync() override
	{
		// Find the most recently used pad
		CInputScriptPad@ mostRecentPad;

		auto inputPort = GetApp().InputPort;

		for (uint i = 0; i < inputPort.Script_Pads.Length; i++) {
			auto pad = inputPort.Script_Pads[i];
			if (mostRecentPad is null || pad.IdleDuration < mostRecentPad.IdleDuration) {
				@mostRecentPad = pad;
				if (pad.IdleDuration == 0) {
					break;
				}
			}
		}

		if (mostRecentPad is null) {
			// Clear pad if there is none found
			ClearPad();
		} else {
			// Force a pad type if the settings demand it
			auto padType = mostRecentPad.Type;
			switch (Setting_General_ForcePadType) {
				case ForcePadType::Gamepad: padType = CInputScriptPad::EPadType::XBox; break;
				case ForcePadType::Keyboard: padType = CInputScriptPad::EPadType::Keyboard; break;
			}

			SetPad(padType);
		}
	}

	void ClearPad()
	{
		m_currentPadType = CInputScriptPad::EPadType(-1);
		@m_pad = null;
	}

	void SetPad(CInputScriptPad::EPadType type)
	{
		if (m_currentPadType == type) {
			return;
		}
		m_currentPadType = type;

		switch (type) {
			case CInputScriptPad::EPadType::Keyboard:
				@m_pad = DashboardPadKeyboard();
				break;

			case CInputScriptPad::EPadType::XBox:
			case CInputScriptPad::EPadType::PlayStation:
				@m_pad = DashboardPadGamepad();
				break;
		}
	}
}
