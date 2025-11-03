interface IDashboardPad
{
	void Render(const vec2 &in size, CSceneVehicleVisState@ vis);
}

class DashboardPadHost : DashboardThing
{
	PadType m_currentPadType = PadType::None;

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

	void ResetProportions() override
	{
		auto plugin = Meta::ExecutingPlugin();
		plugin.GetSetting("Setting_General_PadPos").Reset();
		plugin.GetSetting("Setting_General_PadSize").Reset();
	}

	void Render(CSceneVehicleVisState@ vis) override
	{
		if (m_pad !is null) {
			m_pad.Render(m_size, vis);
		}
	}

	void UpdateAsync() override
	{
		// Force a pad type if the settings demand it
		if (Setting_General_ForcePadType != PadType::None) {
			SetPad(Setting_General_ForcePadType);
			return;
		}

#if FOREVER
		// Use the most recently used pad from the hook
		auto lastDevice = ForeverLastInputHook::g_device;
		if (cast<CInputDeviceDx8Pad>(lastDevice) !is null) {
			SetPad(PadType::Gamepad);
		} else {
			SetPad(PadType::Keyboard);
		}
#else
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

		// Clear pad if there is none found
		if (mostRecentPad is null) {
			ClearPad();
			return;
		}

		switch (mostRecentPad.Type) {
			case CInputScriptPad::EPadType::Keyboard:
				SetPad(PadType::Keyboard);
				break;

			case CInputScriptPad::EPadType::XBox:
			case CInputScriptPad::EPadType::PlayStation:
				SetPad(PadType::Gamepad);
				break;
		}
#endif
	}

	void ClearPad()
	{
		m_currentPadType = PadType::None;
		@m_pad = null;
	}

	void SetPad(PadType type)
	{
		if (m_currentPadType == type) {
			return;
		}
		m_currentPadType = type;

		switch (type) {
			case PadType::Keyboard: @m_pad = DashboardPadKeyboard(); break;
			case PadType::Gamepad: @m_pad = DashboardPadGamepad(); break;
		}
	}
}
